Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B15E692A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiIVRHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVRHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 13:07:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE5F3FB4
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 10:07:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w13so9391523plp.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=YGdLhOJeWnP3ca9LNB+W2QEKOPugBX7rmEhz4mGpjas=;
        b=wv+VgBM0Yf/zCrrpBZZ8BFKRdVmmrSTsOdXwyIoqGil5AW+Z+ijHmB/EpcHkJ2aYOF
         +KO8jsO6OL3nvjyTnNTQFnR0T0WNO3GgCf5XRM862nncqkCCfHX/BsPmH6D8BFH0OOsv
         BRYhjkNxamT6msLfsf+XasyvAGORtTe06Yb9QYNxZRI8h8jSrqZ72R9zI2dUBOIl2EVW
         pvemQLSPDqB1RUfooyJYrXckcyjkOYoPqW/bzKVroI4Clj97gecc/OSd/5X6RS+gUp5O
         eISz85U69O4HBzXhcgM47g1gbaYZm4sqtlOmVk+xCNqNAHe6fQYw7/DENLxVM3wfkN1J
         FbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YGdLhOJeWnP3ca9LNB+W2QEKOPugBX7rmEhz4mGpjas=;
        b=PmU+Jj0Jj0guKxDVo43p5slQaS+/rIijfiq9UjX7hbQba9T1SPpiuCsVjS9ueU5KVZ
         8AdFNvj6BJvvLyfdIAQfhHImohLODScs/pVCsI+7Y2AUeJ3BayFyQLDvt2sqNuqm9X+D
         ClMpNk105WRfDrASAuau5cs0iUgJT7Q/+vV/bXSWAORWxOYR+98a3t6IaLSK2JbaAsJE
         eXQXZZh9MWQmmbCMtF28hNrYe5aRsrlr4OCcWsuEBjDvjp4jPq6X7CetLP7quggu1fX7
         JiawK+EwG0VlyfoO/6yHQtzaprJqDoJpV8lVbJZcOVtdVG8ydTehmrfclHwoKTEeYwAl
         MuAQ==
X-Gm-Message-State: ACrzQf2B9Lz51zEgrIIzvcKGGs7nV04ktEFbzM4nLsCATPJJ+IXoSEcF
        5HOiN2I6nSX3S0+zao0rY/5icQ==
X-Google-Smtp-Source: AMsMyM4vhRqEnmQ8xHzUPGKlA95Jt5MPFA9TK9QiaB9sG0UssenMQ0dpTvm3FWZ/ppTGZ50+tYcpkA==
X-Received: by 2002:a17:90a:2b0c:b0:203:b7b1:2ba2 with SMTP id x12-20020a17090a2b0c00b00203b7b12ba2mr4806032pjc.34.1663866466643;
        Thu, 22 Sep 2022 10:07:46 -0700 (PDT)
Received: from localhost (pop.92-184-98-183.mobile.abo.orange.fr. [92.184.98.183])
        by smtp.gmail.com with ESMTPSA id p63-20020a625b42000000b0053e80618a23sm4699299pfb.34.2022.09.22.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:07:46 -0700 (PDT)
Date:   Thu, 22 Sep 2022 10:07:46 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Sep 2022 10:07:28 PDT (-0700)
Subject:     Re: [PATCH] cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz() macro usage
In-Reply-To: <CAAhSdy0zGaZXoJHVAN+2n1sP4+2rsfo+G874NeBMgrhBeEW2ZA@mail.gmail.com>
CC:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        ulf.hansson@linaro.org, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-0486175c-f1e8-4879-9545-2ccbbc427de9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 28 Aug 2022 19:59:45 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Mon, Jul 18, 2022 at 2:16 PM Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> Currently, we are using CPU_PM_CPU_IDLE_ENTER_PARAM() for all SBI HSM
>> suspend types so retentive suspend types are also treated non-retentive
>> and kernel will do redundant additional work for these states.
>>
>> The BIT[31] of SBI HSM suspend types allows us to differentiate between
>> retentive and non-retentive suspend types so we should use this BIT
>> to call appropriate CPU_PM_CPU_IDLE_ENTER_xyz() macro.
>>
>> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Can you please take this patch through the RISC-V tree ?

Sorry I missed this, I didn't realize you wanted me to merge it.  It's 
on fixes.

>
> Regards,
> Anup
>
>> ---
>>  drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> index 1151e5e2ba82..33c92fec4365 100644
>> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>> @@ -97,8 +97,13 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>>                                    struct cpuidle_driver *drv, int idx)
>>  {
>>         u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
>> +       u32 state = states[idx];
>>
>> -       return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
>> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
>> +               return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
>> +       else
>> +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
>> +                                                            idx, state);
>>  }
>>
>>  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
>> --
>> 2.34.1
>>
