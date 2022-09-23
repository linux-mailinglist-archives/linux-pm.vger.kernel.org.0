Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FA5E78DE
	for <lists+linux-pm@lfdr.de>; Fri, 23 Sep 2022 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiIWK44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Sep 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIWK4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 06:56:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB2DF067
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 03:55:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b75so12049088pfb.7
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date;
        bh=/40D11sTGBqxQ3T0htyIxT/7MS1k2znQcbc1Zb17/k8=;
        b=4eax6Pge2DmiLZRQm4qb2nBq2xkb5JBoeP+DlilNmuEHsvidQGWYX31O54gDnnv7ox
         hr3tk6dgHG3YHW3gl8hr4K9BarDzq7NfS+0ZngZu+MXPIi25ZKUffWJZoIJA3PcILe95
         LCnV8uuzOVRUUZxj2ixnurBOS+zbqBv1DP8v+WkAUfU9pFYHSvna9NHgWBeCx1ot3piY
         kmszE132EtS3yKkYx+LNqVynN95uLZInSn5bVNL4jxyrripICl5x6Gfp4pG51aUzUQjs
         oLISfVuoffDl/otgefCQtLSz8ecrLNhWu1aE57sYSY1IDqsj1uiGJwgTdvfi98IXMZik
         kAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/40D11sTGBqxQ3T0htyIxT/7MS1k2znQcbc1Zb17/k8=;
        b=stZlbQdd+NTuAL5TM6DSu+7xw00s5tIF8v6i0vD3QsfdrOAmXHOrWg9uVK0da07YPV
         5C7cHIvWDUHEALTJkXbvCvU3Jcp4nKns8+PYvvwGX9307NGuv3XFk8dnry173QQ57Yzi
         AGy3iLkN19k/8dFs7uhi38BleRkm4u7/NFZYkIxDaoP1JS7B7K/oKmnvoKOKGjzblSgy
         QWqTe4laCKVIHS9+VWAiJDDphN+hHT19xliyY20t8MtFSrw4WpsU7ed6amY2fcg9xjDd
         A775lzN4SU1Iae3jLSVKjT1Fn4gKyw8x0a9XCK796RsqY0gjs+xU0rRJER+PdcIfOgd5
         vLQQ==
X-Gm-Message-State: ACrzQf0+32iOdwiHVmRCQP4h0V1mTzopdekvBUrRTUugM3UEGrEi/fRR
        bBZTiJnaOXE9dxdB64tGNGn8IQ==
X-Google-Smtp-Source: AMsMyM7PM5wJVtceDG9+BjpWnprgj6MOFDNhea+dtARa3SREXRJzN8TjqThK1p7LVSp0DpcKYR/oXg==
X-Received: by 2002:a05:6a00:27a1:b0:548:ea2e:885c with SMTP id bd33-20020a056a0027a100b00548ea2e885cmr8786790pfb.55.1663930546039;
        Fri, 23 Sep 2022 03:55:46 -0700 (PDT)
Received: from localhost ([88.128.88.52])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b00176b66954a6sm5747934plg.121.2022.09.23.03.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:55:45 -0700 (PDT)
Date:   Fri, 23 Sep 2022 03:55:45 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Sep 2022 03:55:41 PDT (-0700)
Subject:     Re: [PATCH] cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz() macro usage
In-Reply-To: <mhng-0486175c-f1e8-4879-9545-2ccbbc427de9@palmer-ri-x1c9>
CC:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        ulf.hansson@linaro.org, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-3a58df40-d19a-41ee-8b51-bbde9ba8d00c@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 22 Sep 2022 10:07:46 PDT (-0700), Palmer Dabbelt wrote:
> On Sun, 28 Aug 2022 19:59:45 PDT (-0700), anup@brainfault.org wrote:
>> Hi Palmer,
>>
>> On Mon, Jul 18, 2022 at 2:16 PM Anup Patel <apatel@ventanamicro.com> wrote:
>>>
>>> Currently, we are using CPU_PM_CPU_IDLE_ENTER_PARAM() for all SBI HSM
>>> suspend types so retentive suspend types are also treated non-retentive
>>> and kernel will do redundant additional work for these states.
>>>
>>> The BIT[31] of SBI HSM suspend types allows us to differentiate between
>>> retentive and non-retentive suspend types so we should use this BIT
>>> to call appropriate CPU_PM_CPU_IDLE_ENTER_xyz() macro.
>>>
>>> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>
>> Can you please take this patch through the RISC-V tree ?
>
> Sorry I missed this, I didn't realize you wanted me to merge it.  It's
> on fixes.

Actually from reading this again, it's not really a fix: the kernel is 
correct without this change, it's just going to save/restore when it 
doesn't need to.  So I'm queuing this into for-next instead.

>
>>
>> Regards,
>> Anup
>>
>>> ---
>>>  drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> index 1151e5e2ba82..33c92fec4365 100644
>>> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> @@ -97,8 +97,13 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>>>                                    struct cpuidle_driver *drv, int idx)
>>>  {
>>>         u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
>>> +       u32 state = states[idx];
>>>
>>> -       return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
>>> +       if (state & SBI_HSM_SUSP_NON_RET_BIT)
>>> +               return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
>>> +       else
>>> +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
>>> +                                                            idx, state);
>>>  }
>>>
>>>  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
>>> --
>>> 2.34.1
>>>
