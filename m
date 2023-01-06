Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DD660113
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjAFNTT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjAFNTN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 08:19:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264D6B5F4
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 05:19:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s9so1224615wru.13
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJpplfB5GZvqmTDPEaVor2GQBiZtx6Fmx8M4N/qSZEA=;
        b=L/vblB4a0M4F/C2rNy4x4Ddrm8AwkJlwA5QZf764OwGDyQaVaRdzvzqdh6re8HfEwH
         zP2cbCGSidi730ZkGEGJLeojgoOQq7YFcXjioPvm/Wa6j+3y62wse/IcY7L7eq3Eua49
         wJZCDlF6SGBQuHXx7rgd0i4d+00JZ7dNJfyaS5eD3DfG5KZxFdkrC3kDghNXENJ2rkxW
         qDuAK1D/jV1xJrrXfwr4EjM2RxpyidD73N2s8B+XDtqkI67SOSIipArZsQA0DMfNaGoQ
         MEmzRxI8oAgVHy5qim74XN/0hIJI5Fd++owsfjBeenurnxcw/R3Sf8/d21dUF2m1EXuD
         3M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJpplfB5GZvqmTDPEaVor2GQBiZtx6Fmx8M4N/qSZEA=;
        b=hE2ScftpZzEiA50/AHjLT+Cmm22GwRa6VisueuI6Wxp/0sMEILpi+iTDxLVyCdnP0b
         jkrzsAPIkJ3H09gU9f/3QmNkhOvfWLtaHF8HvnEp54JyLXNpzz+q+tAiG2gEIAgwTjd/
         NmGRITAFrosQNlW8fiDf9n61a7hhbiyLZZuylw80T0pI0HCnbUjPiOX817QUGftuQ9ia
         SX7UMt4LNm4e8iedSXxO4n+UlUnLwAwHVJplcPRJ9qPyYA796+q7WgADakPvjdX8sjlw
         ZjFemYq/Lg3qZIpnPvMABhHqj58ADkr/+/m7CR9ifcDO0DBhqg+qNprLHuJ59cy/m7P1
         4pEA==
X-Gm-Message-State: AFqh2koEyHNB4RT+PSevmxBUHvwlHDJKGbA9fICGRqoLhit1lnLi3fbn
        GJcc8wlcnoTYDaDEhkKJWhOyRA==
X-Google-Smtp-Source: AMrXdXsK9zd1f6w44VhV8Jc17GLbeev2R+BC9yDTntZebOuq7YzekZknrSuTiVGZs2ykWMNhSmYfjg==
X-Received: by 2002:a5d:6981:0:b0:295:6a4f:4183 with SMTP id g1-20020a5d6981000000b002956a4f4183mr12629387wru.5.1673011150846;
        Fri, 06 Jan 2023 05:19:10 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e7-20020a056000120700b00241dd5de644sm1167074wrx.97.2023.01.06.05.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 05:19:09 -0800 (PST)
Message-ID: <9d141edb-c72c-8889-112b-71ce5699dc35@linaro.org>
Date:   Fri, 6 Jan 2023 14:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] thermal/drivers/intel: Use generic trip points for
 intel_pch
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
 <20230104222127.2364396-3-daniel.lezcano@kernel.org>
 <ff0b001a0b7c7beb17e007219414a39ba6d953ef.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ff0b001a0b7c7beb17e007219414a39ba6d953ef.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rui,

On 06/01/2023 09:32, Zhang, Rui wrote:
> On Wed, 2023-01-04 at 23:21 +0100, Daniel Lezcano wrote:
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops
>> are
>> needed and they can be removed.
>>
>> Convert the ops content logic into generic trip points and register
>> them with the thermal zone.
>>
>> In order to consolidate the code, use the ACPI thermal framework API
>> to fill the generic trip point from the ACPI tables.
>>
>> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
>> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
>> ---
>>      V3:
>>        - The driver Kconfig option selects CONFIG_THERMAL_ACPI
>> ---
>>   drivers/thermal/intel/Kconfig             |  1 +
>>   drivers/thermal/intel/intel_pch_thermal.c | 88 +++++--------------
>> ----
>>   2 files changed, 20 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/thermal/intel/Kconfig
>> b/drivers/thermal/intel/Kconfig
>> index f0c845679250..738b88b290f4 100644
>> --- a/drivers/thermal/intel/Kconfig
>> +++ b/drivers/thermal/intel/Kconfig
>> @@ -75,6 +75,7 @@ config INTEL_BXT_PMIC_THERMAL
>>   config INTEL_PCH_THERMAL
>>   	tristate "Intel PCH Thermal Reporting Driver"
>>   	depends on X86 && PCI
>> +	select THERMAL_ACPI
> 
> THERMAL_ACPI depends on ACPI but the PCH thermal driver does not.
> So we will run into "unmet dependencies" issue when CONFIG_ACPI is
> cleared like below
> 
> WARNING: unmet direct dependencies detected for THERMAL_ACPI
>    Depends on [n]: THERMAL [=y] && ACPI [=n]
>    Selected by [m]:
>    - INTEL_PCH_THERMAL [=m] && THERMAL [=y] && (X86 [=y] ||
> X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && PCI [=y]
> 

Ah yes, indeed. Thanks for spotting this.

Given the code, I think we should do:

	select THERMAL_ACPI if ACPI

it is from my POV semantically correct.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

