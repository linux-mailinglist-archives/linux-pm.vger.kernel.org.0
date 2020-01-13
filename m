Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3913907E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgAML6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 06:58:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39499 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAML6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:58:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so8258400wrt.6
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jmeZS4anFcQaXMcpaNE6Oqncxq6vLa6b4erMWpqoNlI=;
        b=v1MdmCCZShwVf8XkQd0I62htZin/oncbFvqYcgjWV8EHT17Nv0rL1Pjdut3iChBaar
         wlIBT2aZ+wqW0iXKSa7H7Om5GQGsYbGtE+je3T7k5nKxWLACaREjg/BAEvOuyVPDCgZm
         QogHvWEMuV0BtxgMaR6Sv1tqZUuM97gwfrhb3Em7MFDdpCk5bdYMH8+A8eJGaqXZ5Kkh
         DwzoE2JGcPA93Chvo1ou8ximYqYcev4dFAnQtE4LIJxQpz2rWlSAIKGuXVx3cGkikogA
         2HXRkqCbJkukfo//GzqrOSqrjb/wk5opPbhNFB8nvzvPZVJYlT3ZdPm7SDHVgW7yd9UZ
         uUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jmeZS4anFcQaXMcpaNE6Oqncxq6vLa6b4erMWpqoNlI=;
        b=Lv97pEf57C2UyV9TT6n6q8CjKgnYc5WROoArcpxQDhJS/kZvAzVVw36i+fEavSiNzj
         vM26nAiulc8qKQsVIEgV2Xfbl/tOjh5HZ+w0EWTeuXc17Wi0QeXTLEJSh9TyxXxGtC/5
         ZgXXwr5cIZqhi6xy0wWQqpPXhviAoT5gyIqtEb11HioPZl3gjz5D8uvdz2CpmllNm2qk
         2Q6XXdGNQpt3WlU3gbvE4AUB4QPpXuRk4c4MY9l/+g4tlJ9wZ1uq6uoLa7cgF5fptA9i
         ycJ6rmzT8W68E4lSg18w26mlhwWhncAbepDV2smI6cpUMfPIobiDr1wgCLBQPDhjjwfI
         Sxig==
X-Gm-Message-State: APjAAAUh60IocQewR1M3wtLpzEZq4wMDc0AsP18suJJ6HamTudvsS5nK
        1d3zbad3sH0tTQKUM8ZdCtbUsw==
X-Google-Smtp-Source: APXvYqwTXmN/wzfsZzI5pdRXvNVjyM/rpo1JnbdBrPEIiYXjfTKCgLaCpQAQgHV2lYTiCu7P/1IB4Q==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr17300798wrn.28.1578916699533;
        Mon, 13 Jan 2020 03:58:19 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:257b:a7b6:7749:8057? ([2a01:e34:ed2f:f020:257b:a7b6:7749:8057])
        by smtp.googlemail.com with ESMTPSA id y139sm14557785wmd.24.2020.01.13.03.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:58:19 -0800 (PST)
Subject: Re: [PATCH] cpuidle: arm: Enable compile testing for some of drivers
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20191229180912.17100-1-krzk@kernel.org>
 <20191229180912.17100-2-krzk@kernel.org> <112783298.KOQPr5xTch@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a4fa3f89-e792-aeee-b9ea-9af244ace04a@linaro.org>
Date:   Mon, 13 Jan 2020 12:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <112783298.KOQPr5xTch@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/01/2020 12:51, Rafael J. Wysocki wrote:
> On Sunday, December 29, 2019 7:09:12 PM CET Krzysztof Kozlowski wrote:
>> Some of cpuidle drivers for ARMv7 can be compile tested on this
>> architecture because they do not depend on mach-specific bits.  Enable
>> compile testing for big.LITTLE, Kirkwood, Zynq, AT91, Exynos and mvebu
>> cpuidle drivers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/cpuidle/Kconfig.arm | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index a224d33dda7f..62272ecfa771 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -25,7 +25,7 @@ config ARM_PSCI_CPUIDLE
>>  
>>  config ARM_BIG_LITTLE_CPUIDLE
>>  	bool "Support for ARM big.LITTLE processors"
>> -	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
>> +	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || COMPILE_TEST
>>  	depends on MCPM && !ARM64
>>  	select ARM_CPU_SUSPEND
>>  	select CPU_IDLE_MULTIPLE_DRIVERS
>> @@ -51,13 +51,13 @@ config ARM_HIGHBANK_CPUIDLE
>>  
>>  config ARM_KIRKWOOD_CPUIDLE
>>  	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
>> -	depends on MACH_KIRKWOOD && !ARM64
>> +	depends on (MACH_KIRKWOOD || COMPILE_TEST) && !ARM64
>>  	help
>>  	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>>  
>>  config ARM_ZYNQ_CPUIDLE
>>  	bool "CPU Idle Driver for Xilinx Zynq processors"
>> -	depends on ARCH_ZYNQ && !ARM64
>> +	depends on (ARCH_ZYNQ || COMPILE_TEST) && !ARM64
>>  	help
>>  	  Select this to enable cpuidle on Xilinx Zynq processors.
>>  
>> @@ -70,19 +70,19 @@ config ARM_U8500_CPUIDLE
>>  config ARM_AT91_CPUIDLE
>>  	bool "Cpu Idle Driver for the AT91 processors"
>>  	default y
>> -	depends on ARCH_AT91 && !ARM64
>> +	depends on (ARCH_AT91 || COMPILE_TEST) && !ARM64
>>  	help
>>  	  Select this to enable cpuidle for AT91 processors.
>>  
>>  config ARM_EXYNOS_CPUIDLE
>>  	bool "Cpu Idle Driver for the Exynos processors"
>> -	depends on ARCH_EXYNOS && !ARM64
>> +	depends on (ARCH_EXYNOS || COMPILE_TEST) && !ARM64
>>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>  	help
>>  	  Select this to enable cpuidle for Exynos processors.
>>  
>>  config ARM_MVEBU_V7_CPUIDLE
>>  	bool "CPU Idle Driver for mvebu v7 family processors"
>> -	depends on ARCH_MVEBU && !ARM64
>> +	depends on (ARCH_MVEBU || COMPILE_TEST) && !ARM64
>>  	help
>>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
>>
> 
> Daniel, any concerns regarding this one?

Yes, I have a doubt about this patch. I'll double check before commenting.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

