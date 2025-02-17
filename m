Return-Path: <linux-pm+bounces-22182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA4A37BF0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69BB16AD61
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839B193084;
	Mon, 17 Feb 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TLWOv/Ae"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FE18C33B
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776730; cv=none; b=gcr7FKNFhn5riRWbPtxjJsncUf3zyH/9vH4bygRDm9Xm9+B+1J1ZbvlnlxPVkEHz/xEHDSa+fPoKBRZHt5zyWTwbez4CjEDOUYcKJP9wrn5w+TttpMpv566krOv7gv4+rbP5ttohXk4RmkFeHZt2pNF4L1fG9eAuD4PL5gQtMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776730; c=relaxed/simple;
	bh=ZERFbvlcliKUz//n2IXk+/urawfGylEo3zt0m1W5F/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ge9I1GH9NuOT3Tg2hW96pl1zI+eqxM4zFvSOFm1gkc2W7rCHMvC60hGevqbWZmhgy3HrpkddV1BsVU2oeDvq0mMOBRd+thZ6N85clxUf3Jt4JzMKrKuSVCUpD3okHx0wt2FsxQqDeKCmsxr3ekGLdnEdHLvGukCqw9w3hpBtWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TLWOv/Ae; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso6337325a12.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739776726; x=1740381526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v25VmnSqYqj8M3Jcj4xEeFG2OqH96nULrB9jJ3rOS7k=;
        b=TLWOv/AehjzXt3y2K2fhchf0A8JnSIgvOw4OAvQ/PrFjcQ6mzGzYCy1ZO25ecG24mu
         cQelsHHXLZIDbMREjWsOoCV81qBg5UE34xtAcRANZQUHqyxSW7Ub3P7YsY4m3vWXHmGZ
         K/dLBCMVFeChtf8CZ5UO088ANceJPkEV/BDmdMi5cO6AhAL1lJBV1AKXKcMFOlQUFLXc
         jzTEuH1mNCm3Wk3ChYR+gPFlsR1K+0jkh7JCdSRKxDT5tWtvRC3G+dPsFj60TJQn0kdb
         s61hN1hkBI4GfrujSKsXwKW8y5X8BzdMrXlP9dl9Kjc4zvTh/C39J0NlkEeX4Z6cyCox
         qZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776726; x=1740381526;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v25VmnSqYqj8M3Jcj4xEeFG2OqH96nULrB9jJ3rOS7k=;
        b=GhdHIGymZr7rZVyCnhCnn+07iVUfiMDGm674jrtwxPpg3y4+wv/KpfgSZwT59XZHjT
         s4hah+LyPPTh815rPgCWP6V6P89IWb7faMfuKsIF4Wx6/TQKsnsDVkycp0gPsc/Ubzfi
         Lidm0GFUEebqg72DgL3mrhVR3sNCR7tmgpZaikMgn9jUp9GauSjfFFA5jtOoPPr5EHMM
         hFfOl+zJcVHZAiCZsPHCLY1ku7+SVkkLlXT/qSsI5unsq/qpUT3WoJ0ZCj5uEQC4Kil3
         480qk2srwpd24sbuEKGaAg+uLlUdyGoollitvf4T853uGgqB9hKtyTfTjRPVIif6Z17n
         yjyA==
X-Forwarded-Encrypted: i=1; AJvYcCWyk0lLiSPnTLnclHcpdRZtLJsFFbGXDluraaqnSizPOts2LAssgc8Rka+2bg4PmPYqyIUg/zyXuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmTkBCyWTD5jYXI3vET5Y1YPUoQm3DteStt93n+7oy53RjDMb
	D4S9rX+MG/vekBntnbJXtRXASsnfQMYbnLYO8TIKwSsd7ai2bW+L/vYENhxLmowJpCczAVejvHm
	w
X-Gm-Gg: ASbGncv0mhXJ9FK1F86ydZU9ZyD/EjX7M47mmU533UmzOSlh4tUqhYmAHsQk5AeldIP
	PWs3BpQPnpyd+SMh56RSXyIzW28E0A3Dw9mqwyTcg1eqA4X+4aE52EufoZqnBk2E0k6nldwuA7M
	KpzqykToaT4Sz6gfQyX4/j3lD+Fnkrijxfj17dkPCHF8XPXbosbox8M7+/2VCYXiP+tjF4FcaGT
	3YVe8Z4rY3QBOWZpf2ip5oJCKFUAUaHh1j/k7YaLQaq59oNEwxxHLk5IcrB6eG283trqgZEye4d
	mlwW7qaE9nWT7ZAI4ZXr1o8=
X-Google-Smtp-Source: AGHT+IF1/c910bLyP5ZGsW8SMD1Us/Tiqwk8Gd/bi0zx7ghNldlF31bI+7fijFr2TMBGRt4mEJHTzg==
X-Received: by 2002:a05:6402:430b:b0:5db:f423:19c5 with SMTP id 4fb4d7f45d1cf-5e036055c4cmr8283539a12.5.1739776725480;
        Sun, 16 Feb 2025 23:18:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d00d9sm6777672a12.32.2025.02.16.23.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:18:44 -0800 (PST)
Message-ID: <b3de47a4-614c-4650-a866-5718b2e2b50a@tuxon.dev>
Date: Mon, 17 Feb 2025 09:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] ARM: at91: pm: Enable ULP0 for SAMA7D65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <a00b193df9e0cb95d144a249b12f1b13188d1ab7.1739221064.git.Ryan.Wanner@microchip.com>
 <32ad3a1a-c6b6-4db1-8e80-8b5f951055a8@tuxon.dev>
 <5c6910ce-b0e4-47e6-9c9b-f0093d34f4a6@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <5c6910ce-b0e4-47e6-9c9b-f0093d34f4a6@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 14.02.2025 20:09, Ryan.Wanner@microchip.com wrote:
> On 2/13/25 01:20, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Ryan,
>>
>>
>> On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>
>>> New clocks are saved to enable ULP0 for SAMA7D65 because this SoC has a
>>> total of 10 main clocks that need to be saved for ULP0 mode.
>>
>> Isn't 9 the total number of MCKs that are handled in the last/first phase
>> of suspend/resume?
> Yes I was including 10 to match the indexing in the mck_count variable.
> Since bgt instruction was suggested I will correct this to reflect the
> true behavior of the change.
>>
>> Also, the state of MCKs are saved/restored for ULP0 and ULP1 as well.
>>
>>>
>>> Add mck_count member to at91_pm_data, this will be used to determine
>>> how many mcks need to be saved. In the mck_count member will also make
>>> sure that no unnecessary clock settings are written during
>>> mck_ps_restore.
>>>
>>> Add SHDWC to ULP0 mapping to clear the SHDWC status after exiting low
>>> power modes.
>>
>> Can you explain why this clear need to be done? The commit message should
>> answer to the "what?" and "why?" questions.
>>
>>>
>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> ---
>>>  arch/arm/mach-at91/pm.c              | 19 +++++-
>>>  arch/arm/mach-at91/pm.h              |  1 +
>>>  arch/arm/mach-at91/pm_data-offsets.c |  2 +
>>>  arch/arm/mach-at91/pm_suspend.S      | 97 ++++++++++++++++++++++++++--
>>>  4 files changed, 110 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>> index 55cab31ce1ecb..50bada544eede 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -1337,6 +1337,7 @@ struct pmc_info {
>>>       unsigned long uhp_udp_mask;
>>>       unsigned long mckr;
>>>       unsigned long version;
>>> +     unsigned long mck_count;>  };
>>>
>>>  static const struct pmc_info pmc_infos[] __initconst = {
>>> @@ -1344,30 +1345,42 @@ static const struct pmc_info pmc_infos[] __initconst = {
>>>               .uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP,
>>>               .mckr = 0x30,
>>>               .version = AT91_PMC_V1,
>>> +             .mck_count = 1,
>>
>> As this member is used only for SAMA7 SoCs I would drop it here and above
>> (where initialized with 1).
>>
>>>       },
>>>
>>>       {
>>>               .uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
>>>               .mckr = 0x30,
>>>               .version = AT91_PMC_V1,
>>> +             .mck_count = 1,
>>>       },
>>>       {
>>>               .uhp_udp_mask = AT91SAM926x_PMC_UHP,
>>>               .mckr = 0x30,
>>>               .version = AT91_PMC_V1,
>>> +             .mck_count = 1,
>>>       },
>>>       {       .uhp_udp_mask = 0,
>>>               .mckr = 0x30,
>>>               .version = AT91_PMC_V1,
>>> +             .mck_count = 1,
>>>       },
>>>       {
>>>               .uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
>>>               .mckr = 0x28,
>>>               .version = AT91_PMC_V2,
>>> +             .mck_count = 1,
>>>       },
>>>       {
>>>               .mckr = 0x28,
>>>               .version = AT91_PMC_V2,
>>> +             .mck_count = 5,
>>
>> I'm not sure mck_count is a good name when used like proposed in this
>> patch. We know that only 4 MCKs need to be handled for SAMA7G5 and 9 for
>> SAMA7D65.
>>
>> Maybe, better change it here to 4 (.mck_count = 4) and to 9 above
>> (.mck_count = 9) and adjust properly the assembly macros (see below)? What
>> do you think?
> 
> Yes I think this is better and cleaner to read. Should this mck_count
> match the pmc_mck_count variable name? Or should this be more
> descriptive or would mcks be sufficient.

mck_count/mcks should be enough. These will be anyway in the context of
pmc_info.

>>
>>> +     },
>>> +     {
>>> +             .uhp_udp_mask = AT91SAM926x_PMC_UHP,
>>> +             .mckr = 0x28,
>>> +             .version = AT91_PMC_V2,
>>> +             .mck_count = 10,
>>>       },
>>>
>>>  };
>>> @@ -1386,7 +1399,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
>>>       { .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
>>>       { .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
>>>       { .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
>>> -     { .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[4] },
>>> +     { .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[6] },
>>>       { .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
>>>       { /* sentinel */ },
>>>  };
>>> @@ -1457,6 +1470,7 @@ static void __init at91_pm_init(void (*pm_idle)(void))
>>>       soc_pm.data.uhp_udp_mask = pmc->uhp_udp_mask;
>>>       soc_pm.data.pmc_mckr_offset = pmc->mckr;
>>>       soc_pm.data.pmc_version = pmc->version;
>>> +     soc_pm.data.pmc_mck_count = pmc->mck_count;
>>>
>>>       if (pm_idle)
>>>               arm_pm_idle = pm_idle;
>>> @@ -1659,7 +1673,8 @@ void __init sama7_pm_init(void)
>>>               AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP1, AT91_PM_BACKUP,
>>>       };
>>>       static const u32 iomaps[] __initconst = {
>>> -             [AT91_PM_ULP0]          = AT91_PM_IOMAP(SFRBU),
>>> +             [AT91_PM_ULP0]          = AT91_PM_IOMAP(SFRBU) |
>>> +                                       AT91_PM_IOMAP(SHDWC),
>>
>> In theory, as the wakeup sources can also resumes the system from standby
>> (WFI), the shdwc should be mapped for standby, too. Unless I'm wrong and
>> the wakeup sources covered by the SHDWC_SR register don't apply to standby
>> (WFI).
> The device can wake up from an RTT or RTC alarm event on both the
> standby power mode and the ULP0 power mode, since the RTT/RTC are
> included in the SHDWC_SR I think it is safe to have this.
> If I understand what you are asking correctly.

I was asking if the SHDWC should also be mapped for standby like:

        static const u32 iomaps[] __initconst = {

                [AT91_PM_STANDBY]       = AT91_PM_IOMAP(SHDWC) |

                [AT91_PM_ULP0]          = AT91_PM_IOMAP(SFRBU) |

                                          AT91_PM_IOMAP(SHDWC),

                [AT91_PM_ULP1]          = AT91_PM_IOMAP(SFRBU) |

                                          AT91_PM_IOMAP(SHDWC) |

                                          AT91_PM_IOMAP(ETHC),

                [AT91_PM_BACKUP]        = AT91_PM_IOMAP(SFRBU) |

                                          AT91_PM_IOMAP(SHDWC),

        };



>>
>>
>>>               [AT91_PM_ULP1]          = AT91_PM_IOMAP(SFRBU) |
>>>                                         AT91_PM_IOMAP(SHDWC) |
>>>                                         AT91_PM_IOMAP(ETHC),
>>> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
>>> index 53bdc9000e447..ccde9c8728c27 100644
>>> --- a/arch/arm/mach-at91/pm.h
>>> +++ b/arch/arm/mach-at91/pm.h
>>> @@ -39,6 +39,7 @@ struct at91_pm_data {
>>>       unsigned int suspend_mode;
>>>       unsigned int pmc_mckr_offset;
>>>       unsigned int pmc_version;
>>> +     unsigned int pmc_mck_count;
>>>  };
>>>  #endif
>>>
>>> diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
>>> index 40bd4e8fe40a5..59a4838038381 100644
>>> --- a/arch/arm/mach-at91/pm_data-offsets.c
>>> +++ b/arch/arm/mach-at91/pm_data-offsets.c
>>> @@ -18,6 +18,8 @@ int main(void)
>>>                                                pmc_mckr_offset));
>>>       DEFINE(PM_DATA_PMC_VERSION,     offsetof(struct at91_pm_data,
>>>                                                pmc_version));
>>> +     DEFINE(PM_DATA_PMC_MCK_COUNT,   offsetof(struct at91_pm_data,
>>> +                                              pmc_mck_count));
>>>
>>>       return 0;
>>>  }
>>> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
>>> index e5869cca5e791..2bbcbb26adb28 100644
>>> --- a/arch/arm/mach-at91/pm_suspend.S
>>> +++ b/arch/arm/mach-at91/pm_suspend.S
>>> @@ -814,17 +814,19 @@ sr_dis_exit:
>>>  .endm
>>>
>>>  /**
>>> - * at91_mckx_ps_enable:      save MCK1..4 settings and switch it to main clock
>>> + * at91_mckx_ps_enable:      save MCK settings and switch it to main clock
>>>   *
>>> - * Side effects: overwrites tmp1, tmp2
>>> + * Side effects: overwrites tmp1, tmp2, tmp3
>>>   */
>>>  .macro at91_mckx_ps_enable
>>>  #ifdef CONFIG_SOC_SAMA7
>>>       ldr     pmc, .pmc_base
>>> +     ldr     tmp3, .mck_count
>>>
>>> -     /* There are 4 MCKs we need to handle: MCK1..4 */
>>> +     /* Start at MCK1 and go until MCK_count */
>>
>> s/MCK_count/mck_count to align with the mck_count above.
>>
>>>       mov     tmp1, #1
>>> -e_loop:      cmp     tmp1, #5
>>> +e_loop:
>>> +     cmp     tmp1, tmp3
>>>       beq     e_done
>>
>> If providing mck_count = 4 (for SAMA7G5) and mck_count = 9 (for SAMA7D65)
>> you can change this to:
>>
>>         bqt     e_done
>>
>>>
>>>       /* Write MCK ID to retrieve the settings. */
>>> @@ -850,7 +852,37 @@ e_save_mck3:
>>>       b       e_ps
>>>
>>>  e_save_mck4:
>>> +     cmp     tmp1, #4
>>> +     bne     e_save_mck5
>>>       str     tmp2, .saved_mck4
>>> +     b       e_ps
>>> +
>>> +e_save_mck5:
>>> +     cmp     tmp1, #5
>>> +     bne     e_save_mck6
>>> +     str     tmp2, .saved_mck5
>>> +     b       e_ps
>>> +
>>> +e_save_mck6:
>>> +     cmp     tmp1, #6
>>> +     bne     e_save_mck7
>>> +     str     tmp2, .saved_mck6
>>> +     b       e_ps
>>> +
>>> +e_save_mck7:
>>> +     cmp     tmp1, #7
>>> +     bne     e_save_mck8
>>> +     str     tmp2, .saved_mck7
>>> +     b       e_ps
>>> +
>>> +e_save_mck8:
>>> +     cmp     tmp1, #8
>>> +     bne     e_save_mck9
>>> +     str     tmp2, .saved_mck8
>>> +     b       e_ps
>>> +
>>> +e_save_mck9:
>>> +     str     tmp2, .saved_mck9
>>>
>>>  e_ps:
>>>       /* Use CSS=MAINCK and DIV=1. */
>>> @@ -870,17 +902,19 @@ e_done:
>>>  .endm
>>>
>>>  /**
>>> - * at91_mckx_ps_restore: restore MCK1..4 settings
>>> + * at91_mckx_ps_restore: restore MCKx settings
>>
>> s/MCKx/MCK to align with the description from at91_mckx_ps_enable
>>
>>>   *
>>>   * Side effects: overwrites tmp1, tmp2
>>>   */
>>>  .macro at91_mckx_ps_restore
>>>  #ifdef CONFIG_SOC_SAMA7
>>>       ldr     pmc, .pmc_base
>>> +     ldr     tmp2, .mck_count
>>>
>>> -     /* There are 4 MCKs we need to handle: MCK1..4 */
>>> +     /* Start from MCK1 and go up to MCK_count */
>>>       mov     tmp1, #1
>>> -r_loop:      cmp     tmp1, #5
>>> +r_loop:
>>> +     cmp     tmp1, tmp2
>>>       beq     r_done
>>
>> Same here:
>>         bgt     r_done
>>
>> should be enough if providing mck_count = 4 or 9
>>
>>>
>>>  r_save_mck1:
>>> @@ -902,7 +936,37 @@ r_save_mck3:
>>>       b       r_ps
>>>
>>>  r_save_mck4:
>>> +     cmp     tmp1, #4
>>> +     bne     r_save_mck5
>>>       ldr     tmp2, .saved_mck4
>>> +     b       r_ps
>>> +
>>> +r_save_mck5:
>>> +     cmp     tmp1, #5
>>> +     bne     r_save_mck6
>>> +     ldr     tmp2, .saved_mck5
>>> +     b       r_ps
>>> +
>>> +r_save_mck6:
>>> +     cmp     tmp1, #6
>>> +     bne     r_save_mck7
>>> +     ldr     tmp2, .saved_mck6
>>> +     b       r_ps
>>> +
>>> +r_save_mck7:
>>> +     cmp     tmp1, #7
>>> +     bne     r_save_mck8
>>> +     ldr     tmp2, .saved_mck7
>>> +     b       r_ps
>>> +
>>> +r_save_mck8:
>>> +     cmp     tmp1, #8
>>> +     bne     r_save_mck9
>>> +     ldr     tmp2, .saved_mck8
>>> +     b       r_ps
>>> +
>>> +r_save_mck9:
>>> +     ldr     tmp2, .saved_mck9
>>>
>>>  r_ps:
>>>       /* Write MCK ID to retrieve the settings. */
>>> @@ -921,6 +985,7 @@ r_ps:
>>>       wait_mckrdy tmp1
>>>
>>>       add     tmp1, tmp1, #1
>>> +     ldr     tmp2, .mck_count
>>
>> Or you can add tmp4 for this
>>
>>>       b       r_loop
>>>  r_done:
>>>  #endif
>>> @@ -1045,6 +1110,10 @@ ENTRY(at91_pm_suspend_in_sram)
>>>       str     tmp1, .memtype
>>>       ldr     tmp1, [r0, #PM_DATA_MODE]
>>>       str     tmp1, .pm_mode
>>> +#ifdef CONFIG_SOC_SAMA7
>>> +     ldr     tmp1, [r0, #PM_DATA_PMC_MCK_COUNT]
>>> +     str     tmp1, .mck_count
>>> +#endif
>>>
>>>       /*
>>>        * ldrne below are here to preload their address in the TLB as access
>>> @@ -1132,6 +1201,10 @@ ENDPROC(at91_pm_suspend_in_sram)
>>>       .word 0
>>>  .pmc_version:
>>>       .word 0
>>> +#ifdef CONFIG_SOC_SAMA7
>>> +.mck_count:
>>> +     .word 0
>>> +#endif
>>>  .saved_mckr:
>>>       .word 0
>>>  .saved_pllar:
>>> @@ -1155,6 +1228,16 @@ ENDPROC(at91_pm_suspend_in_sram)
>>>       .word 0
>>>  .saved_mck4:
>>>       .word 0
>>> +.saved_mck5:
>>> +     .word 0
>>> +.saved_mck6:
>>> +     .word 0
>>> +.saved_mck7:
>>> +     .word 0
>>> +.saved_mck8:
>>> +     .word 0
>>> +.saved_mck9:
>>> +     .word 0
>>>  #endif
>>>
>>>  ENTRY(at91_pm_suspend_in_sram_sz)
>>
> 


