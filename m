Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB45067F8
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 11:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiDSJrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 05:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348217AbiDSJrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 05:47:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07142459C
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 02:44:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so28381381lfg.7
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=S6SwtMyamGm5Ffl8g5MVWYNboFaSx3voVA3XnwzhbP4=;
        b=JZ/lAUmHeDKDP8QMYAKbmgTseEXOfQTt7W48OjQBIhaIlZXadDYWTrJk9KM6IiIcX8
         381KN2rkb3lgOGi798xTVlE9ojlUR7TuS3QpvPLdbPFd/YcD0Lt1RX6O1NJ/smAbXVYI
         cMwI7hiklC/wArKjwSuo4z/N37X/h3PPxn4qRw9oGzx+JIEyekCAGwyFiPR94vmdfYlL
         dxB9VANZBUCOYeZI46uFT+5djsM0VP/2TGDTLa6EieG1dE0Jr2ds7rkaliYYa6qpzq1z
         uFf6OV82as+Lhak38mLyCZyJVWD8hIxaBDA9BrVpd1dTq2TXw2AhsvS/nh1qAp7jKf6E
         pOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=S6SwtMyamGm5Ffl8g5MVWYNboFaSx3voVA3XnwzhbP4=;
        b=fpwbaNirw3z1/YcpPjl4az/J6bj2pUuS0diMHBcmHB2m/ONFjLdiJlQ3j0kCsMqTnh
         zPdwmHZvZl4OUSwzWZ7d7EEKZvUxGJu3KR1fjkB3yR6WY6U1wUZwSEgU0ezSCED2tBSB
         BDRkqyxqA6Da4T4xIhka1/u72DSAm3ovgKk0y5GpJ8PMIRgob3VYRQ/+g4ir2dHZTkHQ
         7wFnRbot0Z6NUZFEP0Ar5NChcpAQUgJAl9ucXoL6PVmgpiNkkw3aNm2tD6uiR+/Lor70
         ZLftTL80fuYeFeJ4kxnwj/yMWu4nCD8Ue6Z5I1KdJEcU+H4a7ZnShyQzHFd7iggV74Gk
         uyFg==
X-Gm-Message-State: AOAM5305dq1nE0VikhQ5KNKMwfdskwMVVWcXV1TuznxjJY16BMwC86P7
        53rfjjq2mLIFqYAuJ5x6s469lB6G/z0=
X-Google-Smtp-Source: ABdhPJyVE9UCtjNfkC+7Lv6N4uHpKGNHgjKBC/yQycSDib+jOi8QUX1k1B5pu1b2W1oqjy2KoAVY8Q==
X-Received: by 2002:a05:6512:2821:b0:46f:c59c:6c7a with SMTP id cf33-20020a056512282100b0046fc59c6c7amr10508822lfb.311.1650361477113;
        Tue, 19 Apr 2022 02:44:37 -0700 (PDT)
Received: from [172.16.187.191] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z24-20020a19e218000000b0046bbc65356bsm1460303lfg.183.2022.04.19.02.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:44:36 -0700 (PDT)
Message-ID: <c57fa9fd-0cdf-4392-50e8-f02671032365@gmail.com>
Date:   Tue, 19 Apr 2022 12:44:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] power: supply: ab8500: Exit maintenance if too low
 voltage
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <20220415203638.361074-2-linus.walleij@linaro.org>
 <36001b47-99fc-1b49-49e7-018f81b717c4@gmail.com>
In-Reply-To: <36001b47-99fc-1b49-49e7-018f81b717c4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/19/22 12:26, Matti Vaittinen wrote:

>> --- a/drivers/power/supply/ab8500_chargalg.c
>> +++ b/drivers/power/supply/ab8500_chargalg.c
>> @@ -1514,6 +1514,14 @@ static void ab8500_chargalg_algorithm(struct 
>> ab8500_chargalg *di)
>>               ab8500_chargalg_stop_maintenance_timer(di);
>>               ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
>>           }
>> +        /*
>> +         * This happens if the voltage drops too quickly during
>> +         * maintenance charging, especially in older batteries.
>> +         */
>> +        if (ab8500_chargalg_time_to_restart(di)) {
>> +            ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>> +            dev_info(di->dev, "restarted charging from maintenance 
>> state A - battery getting old?\n");
>> +        }
>>           break;
>>       case STATE_MAINTENANCE_B_INIT:
>> @@ -1538,6 +1546,14 @@ static void ab8500_chargalg_algorithm(struct 
>> ab8500_chargalg *di)
>>               ab8500_chargalg_stop_maintenance_timer(di);
>>               ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>>           }
>> +        /*
>> +         * This happens if the voltage drops too quickly during
>> +         * maintenance charging, especially in older batteries.
>> +         */
>> +        if (ab8500_chargalg_time_to_restart(di)) {
>> +            ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>> +            dev_info(di->dev, "restarted charging from maintenance 
>> state B - battery getting old?\n");
>> +        }
>>           break;
>>       case STATE_TEMP_LOWHIGH_INIT:
> 
> 
> Probably just a matter of taste (like underscores in private function 
> names ;] ) - I would prefer combining the cases for INITs to something 
> like:
> 
>      case STATE_MAINTENANCE_A_INIT:
>      case STATE_MAINTENANCE_B_INIT:
> 
>          mt = power_supply_get_maintenance_charging_setting(bi,
>              (di->charge_state == STATE_MAINTENANCE_B_INIT));
> 
> ...
>          ab8500_chargalg_state_to(di, di->charge_state + 1);
> 
>      break;
> 
> That would slightly reduce the code although at the cost of additional 
> arithmetics. I'm leaving this to you though.

Oh. I was misreading the code. There is fallthrough and not break as the 
actual 'maintenance states' are handled directly after the 'maintenance 
init states'. Well, it seems to me also the actual maintenance states 
could be combined into one case though. But as I wrote - your decision :)

Best Regards
	-- Matti
