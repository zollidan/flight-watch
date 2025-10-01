# Makefile для проекта flight-watch
# Калькулятор топлива для Fokker F28

# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -Werror -std=c99 -pedantic -g
LDFLAGS = 
LDLIBS = -lm

# Директории
SRCDIR = src
OBJDIR = obj
BINDIR = .

# Исполняемый файл
TARGET = flight-watch
EXECUTABLE = $(BINDIR)/$(TARGET).exe

# Исходные файлы
SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
HEADERS = $(wildcard $(SRCDIR)/*.h)

# Цвета для вывода
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Основная цель
.PHONY: all
all: $(EXECUTABLE)

# Сборка исполняемого файла
$(EXECUTABLE): $(OBJECTS) | $(BINDIR)
	@echo "$(GREEN)Линковка $(TARGET)...$(NC)"
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
	@echo "$(GREEN)✓ Сборка завершена: $@$(NC)"

# Компиляция объектных файлов
$(OBJDIR)/%.o: $(SRCDIR)/%.c $(HEADERS) | $(OBJDIR)
	@echo "$(YELLOW)Компиляция $<...$(NC)"
	$(CC) $(CFLAGS) -c $< -o $@

# Создание директорий
$(OBJDIR):
	@echo "$(YELLOW)Создание директории $(OBJDIR)...$(NC)"
	mkdir -p $(OBJDIR)

$(BINDIR):
	@echo "$(YELLOW)Создание директории $(BINDIR)...$(NC)"
	mkdir -p $(BINDIR)

# Запуск программы
.PHONY: run
run: $(EXECUTABLE)
	@echo "$(GREEN)Запуск $(TARGET)...$(NC)"
	@./$(EXECUTABLE)

# Отладочная сборка
.PHONY: debug
debug: CFLAGS += -DDEBUG -O0
debug: $(EXECUTABLE)
	@echo "$(GREEN)✓ Отладочная сборка готова$(NC)"

# Релизная сборка
.PHONY: release
release: CFLAGS += -O2 -DNDEBUG
release: CFLAGS := $(filter-out -g,$(CFLAGS))
release: clean $(EXECUTABLE)
	@echo "$(GREEN)✓ Релизная сборка готова$(NC)"

# Статический анализ (если есть cppcheck)
.PHONY: check
check:
	@echo "$(YELLOW)Статический анализ...$(NC)"
	@if command -v cppcheck >/dev/null 2>&1; then \
		cppcheck --enable=all --std=c99 $(SRCDIR)/; \
	else \
		echo "$(RED)cppcheck не найден, пропускаем статический анализ$(NC)"; \
	fi

# Форматирование кода (если есть clang-format)
.PHONY: format
format:
	@echo "$(YELLOW)Форматирование кода...$(NC)"
	@if command -v clang-format >/dev/null 2>&1; then \
		find $(SRCDIR) -name "*.c" -o -name "*.h" | xargs clang-format -i; \
		echo "$(GREEN)✓ Форматирование завершено$(NC)"; \
	else \
		echo "$(RED)clang-format не найден, пропускаем форматирование$(NC)"; \
	fi

# Очистка объектных файлов
.PHONY: clean
clean:
	@echo "$(YELLOW)Очистка объектных файлов...$(NC)"
	@if exist $(OBJDIR) rmdir /s /q $(OBJDIR)
	@echo "$(GREEN)✓ Объектные файлы удалены$(NC)"

# Полная очистка
.PHONY: distclean
distclean: clean
	@echo "$(YELLOW)Полная очистка...$(NC)"
	@if exist $(EXECUTABLE) del $(EXECUTABLE)
	@if exist a.exe del a.exe
	@echo "$(GREEN)✓ Полная очистка завершена$(NC)"

# Пересборка
.PHONY: rebuild
rebuild: clean all

# Установка (копирование в системную директорию)
.PHONY: install
install: $(EXECUTABLE)
	@echo "$(YELLOW)Установка в C:\\Program Files\\FlightWatch...$(NC)"
	@mkdir "C:\Program Files\FlightWatch" 2>nul || echo ""
	@copy $(EXECUTABLE) "C:\Program Files\FlightWatch\" >nul
	@echo "$(GREEN)✓ Установка завершена$(NC)"

# Показать информацию о сборке
.PHONY: info
info:
	@echo "$(GREEN)=== Информация о проекте ===$(NC)"
	@echo "Проект:     flight-watch (Калькулятор топлива Fokker F28)"
	@echo "Компилятор: $(CC)"
	@echo "Флаги:      $(CFLAGS)"
	@echo "Исходники:  $(SOURCES)"
	@echo "Объекты:    $(OBJECTS)"
	@echo "Цель:       $(EXECUTABLE)"
	@echo ""
	@echo "$(YELLOW)Доступные команды:$(NC)"
	@echo "  make          - сборка проекта"
	@echo "  make run      - сборка и запуск"
	@echo "  make debug    - отладочная сборка"
	@echo "  make release  - релизная сборка"
	@echo "  make clean    - очистка объектных файлов"
	@echo "  make distclean- полная очистка"
	@echo "  make rebuild  - пересборка"
	@echo "  make check    - статический анализ"
	@echo "  make format   - форматирование кода"
	@echo "  make install  - установка"
	@echo "  make info     - эта справка"

# Помощь
.PHONY: help
help: info

# Зависимости для автоматической пересборки при изменении заголовков
$(OBJDIR)/index.o: $(SRCDIR)/fokker_f28_constants.h $(SRCDIR)/fuel_calculate.h
$(OBJDIR)/fuel_calculate.o: $(SRCDIR)/fokker_f28_constants.h

# Предотвращение удаления промежуточных файлов
.PRECIOUS: $(OBJDIR)/%.o

# Определение файлов, которые не являются целями
.SUFFIXES: