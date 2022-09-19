Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722EE5BCB5D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiISMAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiISMAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 08:00:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23264D3
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 05:00:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a14so31420084ljj.8
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ThhPWmLM/kXrGgDwJDkBTQB/92joMH/8GzAjSV1w1O0=;
        b=BP9KugLow208PDioaPvG03S6uDk5Ty92C/hXrKGaiTCZcxHywgTjIQcwX0fK8iGSh1
         OCToW6mMlD5E0IKn89AN/QuL1p0ZTJVryncv/3K/LDUIUG963+Je88Uj5+rwHBbHWYV/
         9nIGltj1voT13Ymb8dEVeDkuiuI37iZeOaypyAJEOHATZAl0+NxbC0k2bxv1rRr0ACk0
         4s08QcZGFxavyBmTMVfIdMsa+F5iVpO3mRtgT1GnbC0dbtMhtPpT/PpwhepcjsDYI9yK
         yAMxxgs/b9gqe/o63mIGIctQyl5KTkFqCPtMOVa5RDBpHzlPeH+HgOh9VlU4jp+CAWU5
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ThhPWmLM/kXrGgDwJDkBTQB/92joMH/8GzAjSV1w1O0=;
        b=NlxuzvL3X0L5/nUUMkgMExANGeBkGrPfmmrwcWqsJE8ycFNf/LJ84GYgyHHUHAILHx
         9qoVmI6ZUpfaKi25u2iTLrM/+bJhx6Ws1YBl4o9YSjuK6XwF1OmTMHqhxVRdALiAAZ/O
         ntzvyRCO36DZqlnf1zgoUoP0ERIXLgaw/q9GXbh3+mEYtZcomeuv57aE1vWCWhOoT1bO
         ks1e9XhDYQUbBEFqkxTO6/eljNX7wxIziVTqwvqfW/VW3PK1C08ppA7ZBvWnTCi5ITnu
         i4HxFi+ZefPsoElQJZLaCZ2pEuMhgoLNq90kuvd/KmalSWiFtMFdBNSwLZ5Kj9FZ0mA3
         0KGw==
X-Gm-Message-State: ACrzQf2wN8c5059N2PoF0QL38HNO5unNKsWvSRSsE9zY5aZmmWwjA6su
        JoezqzJqyA3BpzBs6isfVHShHj/jYyekoQ==
X-Google-Smtp-Source: AMsMyM7z/NTKIbRPgLjYWMsJpoCLTeI71xCi/jJQDDFzjjke06AecGeYzGGUKO+/DCP41xyBaRcPFw==
X-Received: by 2002:a2e:96d0:0:b0:26a:8a3c:861e with SMTP id d16-20020a2e96d0000000b0026a8a3c861emr4963491ljj.54.1663588846898;
        Mon, 19 Sep 2022 05:00:46 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r13-20020a2eb60d000000b0026c4374a2a4sm1009205ljn.139.2022.09.19.05.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:00:46 -0700 (PDT)
Message-ID: <7ebe5ac9-7a00-4f7d-5b0e-f8f96b834733@linaro.org>
Date:   Mon, 19 Sep 2022 15:00:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] firmware/psci: Add debugfs support to ease debugging
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>
References: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
 <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
 <CAA8EJppqWTwXxKX3pxTc=P5kGWMuibKA54UNhq1Yoca+RHvm2w@mail.gmail.com>
In-Reply-To: <CAA8EJppqWTwXxKX3pxTc=P5kGWMuibKA54UNhq1Yoca+RHvm2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/08/2022 18:26, Dmitry Baryshkov wrote:
> On Thu, 4 Aug 2022 at 17:49, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Thu, Aug 04, 2022 at 04:15:07PM +0300, Dmitry Baryshkov wrote:
>>> To ease debugging of PSCI supported features, add debugfs file called
>>> 'psci' describing PSCI and SMC CC versions, enabled features and
>>> options.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>> Changes since v1:
>>> - Extended the table to include MEM_PROTECT functions (noted by Mark
>>>    Brown)
>>> - Switched to seq_puts where possible
>>> - Changed S_IRUGO to 0444
>>> ---
>>>   drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
>>>   include/uapi/linux/psci.h    |  14 +++++
>>>   2 files changed, 129 insertions(+), 1 deletion(-)
>>
>> TBH I am really not keen on exposing this to userspace. AFAICT this is his is
>> incredibly niche, and is going to be very painful to maintain.
>>
>> Without a strong rationale, I do not thing we should do this.
>>
>> Who is going to use this, and when?
> 
> I sketched this while trying to narrow down the particular issue on
> the Qualcomm platform (which started as an attempt to implement PSCI
> domains, but then led to understanding that while the platform claims
> supports OSI, it doesn't support SET_SUSPEND). We were going to use
> this to help to narrow down issues with the PSCI support on other
> platforms as well.
> Moreover during v1 review I saw at least a subtle request to include
> other information as well (e.g. the output from STAT_*),
> 
>>
>> I'd be much happier logging stuff as it's probed into dmesg; I'm happy to add
>> more information there (and/or a command line parameter to be more verbose).
> 
> Collecting logs is a nice thing, but asking the user to send the
> debugfs file is much easier compared to rebooting the kernel with
> different cmdline args (which in the Qualcomm case involves rebuilding
> the boot image).

Gentle ping for this patch for the review. It would be a really nice to 
be able to ask users to provide a debugfs file rather than collecting 
necessary data through the dmesg & other means.

> 
>>
>> Thanks,
>> Mark.
>>
>>>
>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>> index 1628f1edef4a..42cae0ba10e2 100644
>>> --- a/drivers/firmware/psci/psci.c
>>> +++ b/drivers/firmware/psci/psci.c
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/acpi.h>
>>>   #include <linux/arm-smccc.h>
>>>   #include <linux/cpuidle.h>
>>> +#include <linux/debugfs.h>
>>>   #include <linux/errno.h>
>>>   #include <linux/linkage.h>
>>>   #include <linux/of.h>
>>> @@ -326,12 +327,125 @@ static void psci_sys_poweroff(void)
>>>        invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
>>>   }
>>>
>>> -static int __init psci_features(u32 psci_func_id)
>>> +static int psci_features(u32 psci_func_id)
>>>   {
>>>        return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
>>>                              psci_func_id, 0, 0);
>>>   }
>>>
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +#define PSCI_ID(ver, _name) \
>>> +     { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
>>> +#define PSCI_ID_NATIVE(ver, _name) \
>>> +     { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
>>> +
>>> +/* A table of all optional functions */
>>> +static const struct {
>>> +     u32 fn;
>>> +     const char *name;
>>> +} psci_fn_ids[] = {
>>> +     PSCI_ID_NATIVE(0_2, MIGRATE),
>>> +     PSCI_ID(0_2, MIGRATE_INFO_TYPE),
>>> +     PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
>>> +     PSCI_ID(1_0, CPU_FREEZE),
>>> +     PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
>>> +     PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
>>> +     PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
>>> +     PSCI_ID(1_0, SET_SUSPEND_MODE),
>>> +     PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
>>> +     PSCI_ID_NATIVE(1_0, STAT_COUNT),
>>> +     PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
>>> +     PSCI_ID(1_1, MEM_PROTECT),
>>> +     PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
>>> +};
>>> +
>>> +static int psci_debugfs_read(struct seq_file *s, void *data)
>>> +{
>>> +     int feature, type, i;
>>> +     u32 ver;
>>> +
>>> +     ver = psci_ops.get_version();
>>> +     seq_printf(s, "PSCIv%d.%d\n",
>>> +                PSCI_VERSION_MAJOR(ver),
>>> +                PSCI_VERSION_MINOR(ver));
>>> +
>>> +     /* PSCI_FEATURES is available only starting from 1.0 */
>>> +     if (PSCI_VERSION_MAJOR(ver) < 1)
>>> +             return 0;
>>> +
>>> +     feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
>>> +     if (feature != PSCI_RET_NOT_SUPPORTED) {
>>> +             ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
>>> +             seq_printf(s, "SMC Calling Convention v%d.%d\n",
>>> +                        PSCI_VERSION_MAJOR(ver),
>>> +                        PSCI_VERSION_MINOR(ver));
>>> +     } else {
>>> +             seq_puts(s, "SMC Calling Convention v1.0 is assumed\n");
>>> +     }
>>> +
>>> +     feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
>>> +     if (feature < 0) {
>>> +             seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
>>> +     } else {
>>> +             seq_printf(s, "OSI is %ssupported\n",
>>> +                        (feature & BIT(0)) ? "" : "not ");
>>> +             seq_printf(s, "%s StateID format is used\n",
>>> +                        (feature & BIT(1)) ? "Extended" : "Original");
>>> +     }
>>> +
>>> +     type = psci_ops.migrate_info_type();
>>> +     if (type == PSCI_0_2_TOS_UP_MIGRATE ||
>>> +         type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
>>> +             unsigned long cpuid;
>>> +
>>> +             seq_printf(s, "Trusted OS %smigrate capable\n",
>>> +                        type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
>>> +             cpuid = psci_migrate_info_up_cpu();
>>> +             seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n",
>>> +                        cpuid, resident_cpu);
>>> +     } else if (type == PSCI_0_2_TOS_MP) {
>>> +             seq_puts(s, "Trusted OS migration not required\n");
>>> +     } else {
>>> +             if (type != PSCI_RET_NOT_SUPPORTED)
>>> +                     seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
>>> +     }
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
>>> +             feature = psci_features(psci_fn_ids[i].fn);
>>> +             if (feature == PSCI_RET_NOT_SUPPORTED)
>>> +                     continue;
>>> +             if (feature < 0)
>>> +                     seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n",
>>> +                                psci_fn_ids[i].name, feature);
>>> +             else
>>> +                     seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int psci_debugfs_open(struct inode *inode, struct file *f)
>>> +{
>>> +     return single_open(f, psci_debugfs_read, NULL);
>>> +}
>>> +
>>> +static const struct file_operations psci_debugfs_ops = {
>>> +     .owner = THIS_MODULE,
>>> +     .open = psci_debugfs_open,
>>> +     .release = single_release,
>>> +     .read = seq_read,
>>> +     .llseek = seq_lseek
>>> +};
>>> +
>>> +static int __init psci_debugfs_init(void)
>>> +{
>>> +     return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
>>> +                                                &psci_debugfs_ops));
>>> +}
>>> +late_initcall(psci_debugfs_init)
>>> +#endif
>>> +
>>>   #ifdef CONFIG_CPU_IDLE
>>>   static int psci_suspend_finisher(unsigned long state)
>>>   {
>>> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
>>> index 2bf93c0d6354..3511095c2702 100644
>>> --- a/include/uapi/linux/psci.h
>>> +++ b/include/uapi/linux/psci.h
>>> @@ -48,12 +48,26 @@
>>>   #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU    PSCI_0_2_FN64(7)
>>>
>>>   #define PSCI_1_0_FN_PSCI_FEATURES            PSCI_0_2_FN(10)
>>> +#define PSCI_1_0_FN_CPU_FREEZE                       PSCI_0_2_FN(11)
>>> +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND              PSCI_0_2_FN(12)
>>> +#define PSCI_1_0_FN_NODE_HW_STATE            PSCI_0_2_FN(13)
>>>   #define PSCI_1_0_FN_SYSTEM_SUSPEND           PSCI_0_2_FN(14)
>>>   #define PSCI_1_0_FN_SET_SUSPEND_MODE         PSCI_0_2_FN(15)
>>> +#define PSCI_1_0_FN_STAT_RESIDENCY           PSCI_0_2_FN(16)
>>> +#define PSCI_1_0_FN_STAT_COUNT                       PSCI_0_2_FN(17)
>>> +
>>>   #define PSCI_1_1_FN_SYSTEM_RESET2            PSCI_0_2_FN(18)
>>> +#define PSCI_1_1_FN_MEM_PROTECT                      PSCI_0_2_FN(19)
>>> +#define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE  PSCI_0_2_FN(19)
>>>
>>> +#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND    PSCI_0_2_FN64(12)
>>> +#define PSCI_1_0_FN64_NODE_HW_STATE          PSCI_0_2_FN64(13)
>>>   #define PSCI_1_0_FN64_SYSTEM_SUSPEND         PSCI_0_2_FN64(14)
>>> +#define PSCI_1_0_FN64_STAT_RESIDENCY         PSCI_0_2_FN64(16)
>>> +#define PSCI_1_0_FN64_STAT_COUNT             PSCI_0_2_FN64(17)
>>> +
>>>   #define PSCI_1_1_FN64_SYSTEM_RESET2          PSCI_0_2_FN64(18)
>>> +#define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE        PSCI_0_2_FN64(19)
>>>
>>>   /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
>>>   #define PSCI_0_2_POWER_STATE_ID_MASK         0xffff
>>> --
>>> 2.35.1
>>>
> 
> 
> 

-- 
With best wishes
Dmitry

