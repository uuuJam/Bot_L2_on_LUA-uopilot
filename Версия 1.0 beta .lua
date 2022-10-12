--lua
local hw = require'arduino'
hw.com = 5    -- Номер порта
     if hw.com < 1 then   -- если номер порта меньше 1
         log ('error = ' .. tostring(hw.com))    -- код ошибки, если 0 значит устройство с указанными vip и pid не найдено
         end_script ()
     end
hw.set_delay_key (20)     -- установить паузу между нажатиями клавиш клавиатуры
hw.set_random_delay_key(10)  -- установить рандом между нажатием и отпускание клавиш
-- т. е. между нажатием и отпусканием клавиши будет пауза от 20 до 29 мсек
hw.set_delay_mouse (20)   -- установить паузу между нажатиями клавиш мыши
hw.set_offset_mousemove(4)  -- шаг перемещения курсора
hw.set_random_delay_mouse(10)  -- установить рандом между нажатиями клавиш мыши
-- т. е. между нажатием и отпусканием кнопки мыши будет пауза от 20 до 29 мсек.
findoffsetx (46)    -- смещение вправо на 50 пикселей для arr
findoffsety (23)    -- смещение вниз на 30 пикселей для arr

    
     folder = [[C:\ya_ne_pil\image]] -- Указать папску с картинками
 imagemouse = {"Bearded_mouse", "Yuong_mouse", "Elder_mouse"}  --  ники мобов на экране для мышки
imagetarget = {"Bearded_target", "Yuong_target", "Elder_target"} -- ники мобов для таргета



::start::
    log ("Старт через 5 секунд")
    for i = 1, 5 do -- Старт через 5 секунд
    wait (1000)
    log (i)
    end
    goto poisk

::camera::
    log ("Нету мобов на экране, кручу камеру вправо")
    wait (100)
    hw.mouse.right_down (957, 446)
    hw.mouse.right_up (1300, 446)
    goto poisk -- начать с начала

::fight::
    if arr then  -- Если нашел моба на экране
        log ("Пытаюсь взять таргет")
        hw.key_down (hw.left_shift) 
        hw.mouse.left (arr[1][1], arr[1][2])  -- клик левой кнопкой мыши в координатах arr
        hw.key_up (hw.left_shift)
        wait (100)
        for i=1, #imagetarget do -- кол-во картинок для квадрата 2
            local arr, a = findimage (964, 814, 1118, 851, {folder .. "\\" .. imagetarget[i] .. ".bmp"}, 2, 80, 1, 50)
            if arr then  -- Проверка имени в таргете
                log ("В таргете ник моба корректный")
                goto check100hp
            end
        end     
    end
    goto poisk

    ::check100hp:: -- Чекнуть 100 ХР
    if color (1109, 838) == 7550183  then  -- (HP 100%)
        log ("HP в таргете 100%")
        hw.key (hw.f1)    -- нажать 'F1'
        wait (100)
        goto lfhp
        else
        goto poisk 
    end

    ::lfhp:: -- (Цикл поиска маленького HP)
    if color (983, 838) == 1573004   then  -- (HP < 1%)
        log ("HP в таргете <1%, пикапаю дроп")
        for i=1, 6 do
            wait (200)
            hw.key (hw.f4)    -- нажать 'F4'
        end
        wait (100) -- Жду пока моб исчезнет
        hw.key (hw.esc)    -- Сбросить таргет
        else
        hw.key (hw.f1)    -- нажать 'F1'
        wait (1500)
        log ("HP еще много")
        goto lfhp -- ждем когда хп моба упадет
    end

::poisk::
    for i=1, #imagemouse do
        arr, a = findimage (753, 408, 1173, 668, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 1ый квадрат (центр)
        if arr then  -- Если нашел моба на экране
            log ("Моб найден в квадрате 1")
            wait (100)
            goto fight
        end -- закрытие Моб найден в квадрате 1
    end -- кол-во картинок для квадрата 1    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 2       
        arr, a = findimage (624, 309, 1303, 768, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 2ой квадрат
        if arr then  -- Если нашел моба на экране
            log ("Моб найден в квадрате 2")
            wait (100)
            goto fight    
        end -- закрытие Моб найден в квадрате 2
    end -- кол-во картинок для квадрата 2    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 3    
        arr, a = findimage (492, 209, 1434, 869, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 3ий квадрат
        if arr then  -- Если нашел моба на экране
            log ("Моб найден в квадрате 3")
            wait (100) 
        goto fight                                    
        end -- закрытие Моб найден в квадрате 3
    end -- кол-во картинок для квадрата 3 

    for i=1, #imagemouse do -- кол-во картинок для квадрата 4 
        arr, a = findimage (363, 109, 1563, 968, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 4ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Моб найден в квадрате 4")
            wait (100)
            goto fight             
        end -- закрытие Моб найден в квадрате 4
    end -- кол-во картинок для квадрата 4    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 5 
        arr, a = findimage (0, 0, 1920, 1080, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 5ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Моб найден в квадрате 5")
            wait (100) 
            goto fight                    
        end -- закрытие Моб найден в квадрате 5
    end -- кол-во картинок для квадрата 5 
    goto camera














log ("Скрипт закончен")

-- a = {}  - обнулить переменную

-- (1109, 838) == 7550183  (фул хп моба)
-- (983, 838)  ==  1573004 (лоу хп моба)

-- for (можно использовать как repeat)

-- hw.key (hw.backspace)    -- нажать 'backspace'
-- hw.text ('JAMWIN')           -- напечатать текст
-- hw.key (hw.enter)   -- нажать 'Enter'

--hw.mouse.left (944, 516)      -- клик левой кнопкой мыши
--hw.mouse.right (462, 478)     -- клик правой кнопкой мыши
--hw.mouse.left_dbl (35, 35)    -- двойной клик левой кнопкой мыши
--hw.mouse.left_down (200, 200) -- зажать левую кнопку мыши
--hw.mouse.left_up (900, 300)   -- отпустить левую кнопку мыши