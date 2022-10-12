--lua

-- Параметры работы скрипта
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
    imagemouse = {"Bearded_mouse", "Yuong_mouse", "Elder_mouse"}    --  ники мобов на экране для мышки
    imagetarget = {"Bearded_target", "Yuong_target", "Elder_target"} -- ники мобов для таргета
    My, Name = 747, 828  -- Координата ника, выбирает сам себя что-бы убрать залаг после взаимодействия с чаром.
    attack = hw.f1     -- Attack
    pickup = hw.f4     -- Pick up
    nexttarget = hw.f5 -- Next target
    





::start::
    for i = 5, 1, -1 do -- Старт через 5 секунд
    wait (1000)
    log ("Start in " .. i .. " seconds")
    end
    goto poisk

::camera::
    log ("Нету мобов на экране, кручу камеру вправо")
    wait (100)
    hw.mouse.right_down (957, 200)
    hw.mouse.right_up (1150, 200)
    goto poisk -- начать с начала

::fight::

    if arr then  -- Пытаюсь взять в таргет
        hw.key_down (hw.left_shift) 
        hw.mouse.left (arr[1][1], arr[1][2])  -- клик левой кнопкой мыши в координатах arr
        hw.key_up (hw.left_shift)
        wait (100)
    end  

    for i=1, #imagetarget do
        local arr, a = findimage (964, 814, 1118, 851, {folder .. "\\" .. imagetarget[i] .. ".bmp"}, 2, 80, 1, 50)
        if arr then  -- Проверка имени в таргете
            log ("В таргете ник моба: " .. imagetarget[i])
            goto check100hp
        end
    end        
    goto poisk

    ::check100hp:: -- Чекнуть 100 ХР
    if color (1109, 838) == 7550183  then  -- (HP 100%)
        log ("HP в таргете 100%")
        goto lfhp
        else
        goto poisk 
    end

    ::lfhp:: -- (Цикл поиска маленького HP)
    if color (983, 838) == 1573004   then  -- (HP < 1%)
        log ("HP в таргете <1%, пикапаю дроп")
        hw.key (pickup)
        wait (200)
        for i=1, 4 do
            wait (100)
            hw.key (pickup)    -- Подобрать дроп
        end
        hw.key (hw.esc)    -- Сбросить таргет
        else
        hw.key (attack)    -- Атаковать
        wait (500)
        log ("HP еще много")
        goto lfhp -- ждем когда хп моба упадет
    end
    hw.mouse.left (My, Name) -- Клик на свое имя
    
::poisk::

    ------- Поиск некст таргетом
    for i=1, 2 do
        hw.key (nexttarget)    -- нажать 'F5'
        wait (200)
        for i=1, #imagetarget do
            local arr, a = findimage (964, 814, 1118, 851, {folder .. "\\" .. imagetarget[i] .. ".bmp"}, 2, 80, 1, 50)
            if arr then  -- Проверка имени в таргете
                log ("Next target: " .. imagetarget[i])
                goto check100hp
            end            
        end   
    end  

    for i=1, #imagemouse do -- кол-во картинок для квадрата 1 садовое "верх"  
        arr, a = findimage (405, 195, 1515, 390, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 1ый квадрат (центр)
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 1, нашел: " .. imagemouse[i])
            wait (100)
            goto fight
        end
    end    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 2 садовое "левый"      
        arr, a = findimage (405, 390, 810, 690, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 2ой квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 2, нашел: " .. imagemouse[i])
            wait (100)
            goto fight    
        end
    end    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 3 садовое "правое"   
        arr, a = findimage (1100, 390, 1515 ,690, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 3ий квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 3, нашел: " .. imagemouse[i])
            wait (100) 
        goto fight                                    
        end
    end 

    for i=1, #imagemouse do -- кол-во картинок для квадрата 4 садовое "нижний"
        arr, a = findimage (405, 690, 1515, 885, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 4ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 4, нашел: " .. imagemouse[i])
            wait (100)
            goto fight             
        end
    end    

    for i=1, #imagemouse do -- кол-во картинок для квадрата 5 мкад "левый"
        arr, a = findimage (0, 195, 405, 885, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 5ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 5, нашел: " .. imagemouse[i])
            wait (100) 
            goto fight                    
        end
    end 

    for i=1, #imagemouse do -- кол-во картинок для квадрата 6 мкад "правое"
        arr, a = findimage (1515, 195, 1920, 885, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 5ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 6, нашел: " .. imagemouse[i])
            wait (100) 
            goto fight                    
        end
    end

    for i=1, #imagemouse do -- кол-во картинок для квадрата 7 мкад "верх"
        arr, a = findimage (0, 0, 1920, 195, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 90, 1, 5) -- 5ый квадрат
        if arr then  -- Если нашел моба на экране
            log ("Квадрат 7, нашел: " .. imagemouse[i])
            wait (100) 
            goto fight                    
        end
    end

    --for i=1, #imagemouse do -- кол-во картинок для квадрата 8 мкад "нижний"
    --    arr, a = findimage (0, 885, 1920, 1040, {folder .. "\\" .. imagemouse[i] .. ".bmp"}, 2, 80, 1, 10) -- 5ый квадрат
    --    if arr then  -- Если нашел моба на экране
    --        log ("Квадрат 8, нашел: " .. imagemouse[i])
    --        wait (100) 
    --        goto fight                    
    --    end
    --end 

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