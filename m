Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19D583454
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiG0U7e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG0U7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 16:59:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572E52FC8
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:59:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pw15so960554pjb.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZoxpMl7G6bYoZ5m7Tt1SczLa19+AUeboacUrN+JX56s=;
        b=Dmd+fgPFe7LybuV735GcZ80MltZODuHKCRLnw319fFXevygSthcHRNw6WYbbyFZhwe
         KtnpCskVDwZylktbUWBLZG1fZJimFrLAYER3R9XhQJ+ywX4rp9wdZD8tHdSpwO76HV2v
         iPFMbakgWSKnkw71OMgOkxrA4yvxndYN6Di5PCgox6o3S4z+D9WxeHLRw2g7ESWeEV/u
         Fkjz3HAdjuWad8P2V798qk7ZcfxobTltNSsxxEco8JWjVQpq+AYU8diYzb6p9ckoszhT
         A4SuHGo8JbxJGepNa94I5mG94A/5qRAgiuX4d6a1PDMj1y3v5jfVQx2iZypmUaVN37o6
         ParQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZoxpMl7G6bYoZ5m7Tt1SczLa19+AUeboacUrN+JX56s=;
        b=Mw6KZKUAsJtW8C5IP7EszqVCrGJ/oq74c6afpHNZgAVbN7nepqonEVJS3NUL1zIB+x
         xFg8M9qpecGho1KYa+8qXRSDS/FvMzwbJPedEUleoJpmwXMAYNSgOD3XpSF49laprajK
         lnEzCRyXjCOShJYRORq9o3LYhiUtdcA4/2GhisAfbPkLq07oNO1TAsXJci2EP+3xPeu1
         Zyr5365nhU/wJYu+nzlLj8FIDmW8kUfIMELzW+YcZ4RmvFL8bLrS3c7DSVuMPuHfmiOp
         hGvZ2MQKcDVBFBNC98QWKG0ESrjuwLgMJl4xivGtGsD8iCqjNjXUfOt4ZsbG4hYQ7cEr
         XKxA==
X-Gm-Message-State: AJIora/BT7fsHHlyFlHy7/lzYUD4QZOeZWtWeqHC0a7i40bQIMQCSTtw
        V+8zMMzbp/buRXL2ctpEzNDqLg==
X-Google-Smtp-Source: AGRyM1vIdjlpcPMbI/ld9uwmAspAqTQR4ULQdBaJ1qQJriY1r2lOgSkjl/oheW1dascj9s6oNDhesw==
X-Received: by 2002:a17:902:8605:b0:16b:e755:3c6e with SMTP id f5-20020a170902860500b0016be7553c6emr22818025plo.42.1658955572290;
        Wed, 27 Jul 2022 13:59:32 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0? ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b0016d93be285asm5119198plf.173.2022.07.27.13.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 13:59:31 -0700 (PDT)
Message-ID: <ce2a90f9-0ba8-3152-5f85-679d1ebd16b5@linaro.org>
Date:   Thu, 28 Jul 2022 02:29:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <bec61bd7-f547-5254-50a5-6f16c221051e@linaro.org>
 <CAA8EJpoa-E1=t1JAWNPzueY95Y_DEsJZqzW3PajcjSrNDVoAVg@mail.gmail.com>
 <efdaa411-8f3b-6a1b-643a-7ed1597c661c@linaro.org>
 <CAA8EJpof10zsFmgqXZK7QVjTS-J7hGDdZGjBaegpo6eQp_0TPw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <CAA8EJpof10zsFmgqXZK7QVjTS-J7hGDdZGjBaegpo6eQp_0TPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/28/22 2:26 AM, Dmitry Baryshkov wrote:
> On Wed, 27 Jul 2022 at 23:55, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>
>>
>>
>> On 7/28/22 2:23 AM, Dmitry Baryshkov wrote:
>>> On Wed, 27 Jul 2022 at 23:15, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>>>
>>>> Hi Dmitry,
>>>>
>>>> On 7/28/22 1:39 AM, Dmitry Baryshkov wrote:
>>>>> To ease debugging of PSCI supported features, add debugfs file called
>>>>> 'psci' describing PSCI and SMC CC versions, enabled features and
>>>>> options.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>     drivers/firmware/psci/psci.c | 112 ++++++++++++++++++++++++++++++++++-
>>>>>     include/uapi/linux/psci.h    |   9 +++
>>>>>     2 files changed, 120 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>>>> index b907768eea01..6595cc964635 100644
>>>>> --- a/drivers/firmware/psci/psci.c
>>>>> +++ b/drivers/firmware/psci/psci.c
>>>>> @@ -9,6 +9,7 @@
>>>>>     #include <linux/acpi.h>
>>>>>     #include <linux/arm-smccc.h>
>>>>>     #include <linux/cpuidle.h>
>>>>> +#include <linux/debugfs.h>
>>>>>     #include <linux/errno.h>
>>>>>     #include <linux/linkage.h>
>>>>>     #include <linux/of.h>
>>>>> @@ -324,12 +325,121 @@ static void psci_sys_poweroff(void)
>>>>>         invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
>>>>>     }
>>>>>
>>>>> -static int __init psci_features(u32 psci_func_id)
>>>>> +static int psci_features(u32 psci_func_id)
>>>>
>>>> This change doesn't seem related to the patch $SUBJECT.
>>>> Also is it really needed? If yes, probably this should be a separate patch.
>>>
>>> It is related and I don't think it should be moved to a separate
>>> patch. Removing the __init annotation from psci_features() is
>>> necessary to allow using psci_features() from psci_debufs_read(),
>>> which is definitely not an __init code. Otherwise reading from
>>> debugfs/psci would cause null pointer exceptions.
>>
>> Ok, and what is the behavior with CONFIG_DEBUG_FS = n?
>> Does your patch work well in that case?
> 
> Yes. Any particular reasons for the question?

Your debugfs changes in this patch are protected with CONFIG_DEBUG_FS,
while the  __init code change is not.

So, IMO its not really needed if CONFIG_DEBUG_FS is set to =n (hence
probably needs to be a separate patch).

Thanks.

>>>>>     {
>>>>>         return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
>>>>>                               psci_func_id, 0, 0);
>>>>>     }
>>>>>
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>> +
>>>>> +#define PSCI_ID(ver, _name) \
>>>>> +     { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
>>>>> +#define PSCI_ID_NATIVE(ver, _name) \
>>>>> +     { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
>>>>> +
>>>>> +/* A table of all optional functions */
>>>>> +static const struct {
>>>>> +     u32 fn;
>>>>> +     const char *name;
>>>>> +} psci_fn_ids[] = {
>>>>> +     PSCI_ID_NATIVE(0_2, MIGRATE),
>>>>> +     PSCI_ID(0_2, MIGRATE_INFO_TYPE),
>>>>> +     PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
>>>>> +     PSCI_ID(1_0, CPU_FREEZE),
>>>>> +     PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
>>>>> +     PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
>>>>> +     PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
>>>>> +     PSCI_ID(1_0, SET_SUSPEND_MODE),
>>>>> +     PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
>>>>> +     PSCI_ID_NATIVE(1_0, STAT_COUNT),
>>>>> +     PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
>>>>> +};
>>>>> +
>>>>> +static int psci_debugfs_read(struct seq_file *s, void *data)
>>>>> +{
>>>>> +     int feature, type, i;
>>>>> +     u32 ver;
>>>>> +
>>>>> +     ver = psci_ops.get_version();
>>>>> +     seq_printf(s, "PSCIv%d.%d\n",
>>>>> +                PSCI_VERSION_MAJOR(ver),
>>>>> +                PSCI_VERSION_MINOR(ver));
>>>>> +
>>>>> +     /* PSCI_FEATURES is available only starting from 1.0 */
>>>>> +     if (PSCI_VERSION_MAJOR(ver) < 1)
>>>>> +             return 0;
>>>>> +
>>>>> +     feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
>>>>> +     if (feature != PSCI_RET_NOT_SUPPORTED) {
>>>>> +             ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
>>>>> +             seq_printf(s, "SMC Calling Convention v%d.%d\n",
>>>>> +                        PSCI_VERSION_MAJOR(ver),
>>>>> +                        PSCI_VERSION_MINOR(ver));
>>>>> +     } else {
>>>>> +             seq_printf(s, "SMC Calling Convention v1.0 is assumed\n");
>>>>> +     }
>>>>> +
>>>>> +     feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
>>>>> +     if (feature < 0) {
>>>>> +             seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
>>>>> +     } else {
>>>>> +             seq_printf(s, "OSI is %ssupported\n",
>>>>> +                        (feature & BIT(0)) ? "" : "not ");
>>>>> +             seq_printf(s, "%s StateID format is used\n",
>>>>> +                        (feature & BIT(1)) ? "Extended" : "Original");
>>>>> +     }
>>>>> +
>>>>> +     type = psci_ops.migrate_info_type();
>>>>> +     if (type == PSCI_0_2_TOS_UP_MIGRATE ||
>>>>> +         type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
>>>>> +             unsigned long cpuid;
>>>>> +
>>>>> +             seq_printf(s, "Trusted OS %smigrate capable\n",
>>>>> +                        type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
>>>>> +             cpuid = psci_migrate_info_up_cpu();
>>>>> +             seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n", cpuid, resident_cpu);
>>>>> +     } else if (type == PSCI_0_2_TOS_MP) {
>>>>> +             seq_printf(s, "Trusted OS migration not required\n");
>>>>> +     } else {
>>>>> +             if (type != PSCI_RET_NOT_SUPPORTED)
>>>>> +                     seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
>>>>> +     }
>>>>> +
>>>>> +     for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
>>>>> +             feature = psci_features(psci_fn_ids[i].fn);
>>>>> +             if (feature == PSCI_RET_NOT_SUPPORTED)
>>>>> +                     continue;
>>>>> +             if (feature < 0)
>>>>> +                     seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n", psci_fn_ids[i].name, feature);
>>>>> +             else
>>>>> +                     seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int psci_debugfs_open(struct inode *inode, struct file *f)
>>>>> +{
>>>>> +     return single_open(f, psci_debugfs_read, NULL);
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations psci_debugfs_ops = {
>>>>> +     .owner = THIS_MODULE,
>>>>> +     .open = psci_debugfs_open,
>>>>> +     .release = single_release,
>>>>> +     .read = seq_read,
>>>>> +     .llseek = seq_lseek
>>>>> +};
>>>>> +
>>>>> +static int __init psci_debugfs_init(void)
>>>>> +{
>>>>> +     return PTR_ERR_OR_ZERO(debugfs_create_file("psci", S_IRUGO, NULL, NULL,
>>>>> +                                                &psci_debugfs_ops));
>>>>> +}
>>>>> +late_initcall(psci_debugfs_init)
>>>>> +#endif
>>>>> +
>>>>>     #ifdef CONFIG_CPU_IDLE
>>>>>     static int psci_suspend_finisher(unsigned long state)
>>>>>     {
>>>>> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
>>>>> index 2bf93c0d6354..f6f0bad5858b 100644
>>>>> --- a/include/uapi/linux/psci.h
>>>>> +++ b/include/uapi/linux/psci.h
>>>>> @@ -48,11 +48,20 @@
>>>>>     #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU   PSCI_0_2_FN64(7)
>>>>>
>>>>>     #define PSCI_1_0_FN_PSCI_FEATURES           PSCI_0_2_FN(10)
>>>>> +#define PSCI_1_0_FN_CPU_FREEZE                       PSCI_0_2_FN(11)
>>>>> +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND              PSCI_0_2_FN(12)
>>>>> +#define PSCI_1_0_FN_NODE_HW_STATE            PSCI_0_2_FN(13)
>>>>>     #define PSCI_1_0_FN_SYSTEM_SUSPEND          PSCI_0_2_FN(14)
>>>>>     #define PSCI_1_0_FN_SET_SUSPEND_MODE                PSCI_0_2_FN(15)
>>>>> +#define PSCI_1_0_FN_STAT_RESIDENCY           PSCI_0_2_FN(16)
>>>>> +#define PSCI_1_0_FN_STAT_COUNT                       PSCI_0_2_FN(17)
>>>>>     #define PSCI_1_1_FN_SYSTEM_RESET2           PSCI_0_2_FN(18)
>>>>>
>>>>> +#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND    PSCI_0_2_FN64(12)
>>>>> +#define PSCI_1_0_FN64_NODE_HW_STATE          PSCI_0_2_FN64(13)
>>>>>     #define PSCI_1_0_FN64_SYSTEM_SUSPEND                PSCI_0_2_FN64(14)
>>>>> +#define PSCI_1_0_FN64_STAT_RESIDENCY         PSCI_0_2_FN64(16)
>>>>> +#define PSCI_1_0_FN64_STAT_COUNT             PSCI_0_2_FN64(17)
>>>>>     #define PSCI_1_1_FN64_SYSTEM_RESET2         PSCI_0_2_FN64(18)
>>>>>
>>>>>     /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
>>>
>>>
>>>
> 
> 
> 
