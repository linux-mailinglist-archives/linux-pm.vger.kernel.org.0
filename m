Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803B783D15
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjHVJka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjHVJk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 05:40:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E20CCB
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 02:40:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso42257525e9.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692697220; x=1693302020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XxbZRN4jmL3a0nc2ifDPcCmugot7f1jM/8M26QHFg0=;
        b=vmDaXar3+AB6GJ6EAzW9apvRLL/smgHgLSOyl5bT/KZdA4BWL7EwjK/DSlRFrZ8BiI
         rIkLio7BmldXqk6tachx0jLQTB7m/E+BebIzZmbPw1NqeENMgha1dG9Cnspp9vaJV80n
         LNJ3jLeRS3huhB1jiX/2m9GKTHrIcJp2pEZ24emU5l9YGy/NyMN3/3K/91gQXuDiS425
         KH7c/vJkIwdhLlNeXpLe4M18KfVJ+BTdkdDLG1PIXEx3bDq+v2E8K4PiXCopuokNFSdb
         pPd18QvL+PfzFIa1IbSbHdRgV4k7AX/RE/2MaXCajl3z8/jQRZGCwlX406U4RjEj8Bt5
         jQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697220; x=1693302020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XxbZRN4jmL3a0nc2ifDPcCmugot7f1jM/8M26QHFg0=;
        b=WOF8BDb3hzbKU1+i8d+5htygMnkEjn/tVmvMd5ZmOCWwcVs25K5t7VURJpS8r81a8I
         W76JkCoLpp9Cw50Ix6TYoXKAxMZ+VjsnDFi7Ca2MYmJ313RN8b9iWO1uGWd88AgRb+aE
         OCoGRlegIE9PF3zAXTp3nHL9jA5VRRa9OBp+0PyqU7HTlAT/e6CFWwCblRSC0XMl+yrM
         lKDRI90uEcoZ2sVfTpRi6iTk/ieziZhTX3KuK8rtCVtMKaO+JPCqJijbvn+CCkH6ULTv
         45QksPlV6/LfIcXrE+ILi2UP4H7yZo8ZVZpMxvIcrofpA5IbrIgA3GbG8U9YE5/gokLw
         cpFg==
X-Gm-Message-State: AOJu0YyvsJ2CYkSo6eYRjDBFQHA0tA0L9Yq4/IrFdA6nlEwbU+gcEOKz
        hLbrzyiXjET65ty5fQXv58owfw==
X-Google-Smtp-Source: AGHT+IEd8TSiFhSI6XUuAO1eeONR/Hp0YIDvNgJRQDSrlnBN1IvmuVPwCOn6bKwKbO/U9p5nlx6/bw==
X-Received: by 2002:a7b:c7c3:0:b0:3fd:2e1d:eca1 with SMTP id z3-20020a7bc7c3000000b003fd2e1deca1mr6904271wmk.4.1692697219827;
        Tue, 22 Aug 2023 02:40:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a22-20020a05600c225600b003fed8e12d62sm13126474wmm.27.2023.08.22.02.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 02:40:19 -0700 (PDT)
Message-ID: <ffa78419-4944-b777-3ff5-58651363a17d@linaro.org>
Date:   Tue, 22 Aug 2023 11:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: imx8mm: Forcing a reboot when critical temp is reached
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <CAOMZO5ByXdEK6Zsa3ObNinnROn=qsde_xvn3WcR2RLioMKk0JQ@mail.gmail.com>
 <CAOMZO5AR5AP_bBJxn8GE6sZXQq6wgzU-qDda43567fs=m7eoRA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAOMZO5AR5AP_bBJxn8GE6sZXQq6wgzU-qDda43567fs=m7eoRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Fabio,

On 22/08/2023 04:21, Fabio Estevam wrote:
> On Mon, Aug 21, 2023 at 2:27 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi,
>>
>> I am working with an i.MX8MM-based board and I do see that the system shuts down
>> when the critical trip point is reached, as expected.
>>
>> As the board is unattended, it would be more appropriate if the board
>> could reboot itself instead of shutting down when the critical
>> temperature is reached.
>>
>> The bootloader has a mechanism to only allow to boot the kernel when
>> the temperature is below a certain temperature.
>>
>> Is there a mechanism in place to force a reboot instead of shutdown
>> when the critical temperature is reached?
> 
> I did an ugly hack like this:
> 
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -315,16 +315,10 @@ static void handle_non_critical_trips(struct
> thermal_zone_device *tz, int trip)
> 
>   void thermal_zone_device_critical(struct thermal_zone_device *tz)
>   {
> - /*
> - * poweroff_delay_ms must be a carefully profiled positive value.
> - * Its a must for forced_emergency_poweroff_work to be scheduled.
> - */
> - int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
> -
>    dev_emerg(&tz->device, "%s: critical temperature reached, "
> -   "shutting down\n", tz->type);
> +   "rebooting\n", tz->type);
> 
> - hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
> + kernel_restart("w");
>   }
>   EXPORT_SYMBOL(thermal_zone_device_critical);
> 
> and this causes a reboot after the critical temperature is reached.
> 
> Would it be OK to add a devicetree property that when present would
> call kernel_restart()?
> 
> Any suggestions?

Yes, you can override the function by defining your own critical ops in 
the thermal zone device ops like [1]. If the critical ops is not 
defined, then it defaults to thermal_zone_device_critical().

Hope that helps

   -- Daniel

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/intel/intel_pch_thermal.c?h=thermal/bleeding-edge#n136


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

