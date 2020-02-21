Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46631679B3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgBUJri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:47:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29444 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbgBUJri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 04:47:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582278457; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0Y3jNt1vNMZa0kmEMEcR2PDj6LTjkMjoYD3v/NckgOg=; b=He8gCgTFDKt1lwIdMedeOofV6A+r+iAXretRBo/gK8qw60Hu5NKLLTSOjDvw7wDkDyYuAcCN
 VrIjsmEhBBeh6PFy84glLukE20ef5/ZKjyO8Z6Ywd2iXae8Ereie1iltMhZXEtT2PN5yaxIB
 vg3ypscebf112/WMJqiNzQuPZU0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4fa733.7fc054e83928-smtp-out-n01;
 Fri, 21 Feb 2020 09:47:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8429DC447A0; Fri, 21 Feb 2020 09:47:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EE5CC43383;
        Fri, 21 Feb 2020 09:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EE5CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [v3] soc: qcom: Introduce subsystem sleep stats driver
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        david.brown@linaro.org, rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
References: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
 <5dcf0e86.1c69fb81.a126f.5beb@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <1daea14a-9873-c0aa-9e2e-12b65828cfcc@codeaurora.org>
Date:   Fri, 21 Feb 2020 15:17:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5dcf0e86.1c69fb81.a126f.5beb@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/16/2019 2:15 AM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-11-06 03:19:25)
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index 6f87b9d..e095eae 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -288,6 +288,16 @@ Description:
>>                  writing a "0" (default) to it disables them.  Reads from
>>                  this file return the current value.
>>   
>> +What:          /sys/power/subsystem_sleep/stats
>> +Date:          December 2017
>> +Contact:       Maulik Shah <mkshah@codeaurora.org>
>> +Description:
>> +               The /sys/power/subsystem_sleep/stats file prints the subsystem
>> +               sleep information on Qualcomm Technologies, Inc. (QTI) SoCs.
>> +
>> +               Reading from this file will display subsystem level low power
>> +               mode statistics.
> I still don't understand what this has to do with the kernel's power
> management support.

Using debugfs in v2 in single stats driver.

https://lore.kernel.org/patchwork/project/lkml/list/?series=430622

>
>> +
>>   What:          /sys/power/resume_offset
>>   Date:          April 2018
>>   Contact:       Mario Limonciello <mario.limonciello@dell.com>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 79d8265..bed0704 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -185,6 +185,15 @@ config QCOM_SOCINFO
>>           Say yes here to support the Qualcomm socinfo driver, providing
>>           information about the SoC to user space.
>>   
>> +config QCOM_SS_SLEEP_STATS
>> +       tristate "Qualcomm Technologies Inc. Subsystem Sleep Stats driver"
>> +       depends on QCOM_SMEM
>> +       help
>> +         Say y here to enable support for the Qualcomm Technologies Inc (QTI)
> This 'Inc' is missing the full stop like in the summary above. Please be
> consistent.
corrected.
>
>> +         SS sleep stats driver to read the sleep stats of various subsystems
> what is 'SS'?
corrected.
>
>> +         from SMEM. The stats are exported to sysfs. The driver also maintains
>> +         application processor sleep stats.
>> +
>>   config QCOM_WCNSS_CTRL
>>          tristate "Qualcomm WCNSS control driver"
>>          depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/subsystem_sleep_stats.c
>> new file mode 100644
>> index 00000000..724b213
>> --- /dev/null
>> +++ b/drivers/soc/qcom/subsystem_sleep_stats.c
>> @@ -0,0 +1,143 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "%s: " fmt, KBUILD_MODNAME
>> +
>> +#include <linux/errno.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
> I think we need to include linux/kernel.h for scnprintf() too.
done.
>> +
>> +#include <linux/soc/qcom/smem.h>
>> +
>> +enum subsystem_item_id {
>> +       MODEM = 605,
>> +       ADSP,
>> +       CDSP,
>> +       SLPI,
>> +       GPU,
>> +       DISPLAY,
>> +};
>> +
>> +enum subsystem_pid {
>> +       PID_APSS = 0,
>> +       PID_MODEM = 1,
>> +       PID_ADSP = 2,
>> +       PID_SLPI = 3,
>> +       PID_CDSP = 5,
>> +       PID_GPU = PID_APSS,
>> +       PID_DISPLAY = PID_APSS,
>> +};
> Can these just be defines? There seems to be no value in enum because
> we're not testing these in switch statements and they're randomly
> assigned values.

this is inline with subsystem_item_id enum which uses 605 to 610 item 
ids in enum.

keeping it same for better readbility.

>
>> +
>> +struct subsystem_data {
>> +       char *name;
>> +       enum subsystem_item_id item_id;
>> +       enum subsystem_pid pid;
>> +};
>> +
>> +static const struct subsystem_data subsystems[] = {
>> +       { "MODEM", MODEM, PID_MODEM },
>> +       { "ADSP", ADSP, PID_ADSP },
>> +       { "CDSP", CDSP, PID_CDSP },
>> +       { "SLPI", SLPI, PID_SLPI },
>> +       { "GPU", GPU, PID_GPU },
>> +       { "DISPLAY", DISPLAY, PID_DISPLAY },
>> +};
>> +
>> +struct subsystem_stats {
>> +       uint32_t version_id;
>> +       uint32_t count;
>> +       uint64_t last_entered;
>> +       uint64_t last_exited;
>> +       uint64_t accumulated_duration;
> We use u32 and u64 in kernel code. Also, is this the value in shared
> memory? Probably it's little endian so needs to be __le32 an __le64.
corrected.
>> +};
>> +
>> +struct subsystem_stats_prv_data {
>> +       struct kobj_attribute ka;
>> +       struct kobject *kobj;
>> +};
>> +
>> +static struct subsystem_stats_prv_data *prvdata;
>> +
>> +static inline ssize_t subsystem_stats_print(char *prvbuf, ssize_t length,
>> +                                           struct subsystem_stats *record,
>> +                                           const char *name)
>> +{
>> +       return scnprintf(prvbuf, length, "%s\n\tVersion:0x%x\n"
>> +                       "\tSleep Count:0x%x\n"
>> +                       "\tSleep Last Entered At:0x%llx\n"
>> +                       "\tSleep Last Exited At:0x%llx\n"
>> +                       "\tSleep Accumulated Duration:0x%llx\n\n",
>> +                       name, record->version_id, record->count,
>> +                       record->last_entered, record->last_exited,
>> +                       record->accumulated_duration);
> This isn't one value per file as per sysfs rules. Why can't this go to
> debugfs? Otherwise, it would be better to split it up into multiple
> files.
>
> And it still looks like something that should be plumbed into the remote
> proc subsystem so we can see from userspace what remote processors are
> 1) present in the system and 2) how long they've been in a sleep state.
Using debugfs.
>
>> +}
>> +
>> +static ssize_t subsystem_stats_show(struct kobject *kobj,
>> +                                   struct kobj_attribute *attr, char *buf)
>> +{
>> +       ssize_t length = 0;
>> +       int i = 0;
> Drop assignment to i here.
done.
>
>> +       size_t size = 0;
> Why assign size to 0? It looks unused in this function besides to store
> the size in qcom_smem_get(). It looks like we can pass NULL for that
> argument if we don't care to actually look at the size of what is
> returned.
done.
>> +       struct subsystem_stats *record = NULL;
> Please don't assign to NULL and then overwrite it without testing in
> between.
done.
>
>> +
>> +       /* Read SMEM data written by other subsystems */
>> +       for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
>> +               record = (struct subsystem_stats *) qcom_smem_get(
> The cast is unnecessary, it returns a void * already.
done.
>> +                         subsystems[i].pid, subsystems[i].item_id, &size);
>> +
>> +               if (!IS_ERR(record) && (PAGE_SIZE - length > 0))
>> +                       length += subsystem_stats_print(buf + length,
>> +                                                       PAGE_SIZE - length,
>> +                                                       record,
>> +                                                       subsystems[i].name);
>> +       }
>> +
>> +       return length;
>> +}
>> +
>> +static int __init subsystem_sleep_stats_init(void)
>> +{
>> +       struct kobject *ss_stats_kobj;
>> +       int ret;
>> +
>> +       prvdata = kzalloc(sizeof(*prvdata), GFP_KERNEL);
>> +       if (!prvdata)
>> +               return -ENOMEM;
>> +
>> +       ss_stats_kobj = kobject_create_and_add("subsystem_sleep",
>> +                                              power_kobj);
> If this module is loaded on non-qcom platforms we'll create
> subsystem_sleep directory still. Please don't do that. If this was
> connected to remote proc it would be easier to avoid this problem.
This is clubbed in single stats driver for both sleep stats in v2 link 
pasted above.
>
>> +       if (!ss_stats_kobj)
>> +               return -ENOMEM;
>> +
>> +       prvdata->kobj = ss_stats_kobj;
>> +
>> +       sysfs_attr_init(&prvdata->ka.attr);
>> +       prvdata->ka.attr.mode = 0444;
>> +       prvdata->ka.attr.name = "stats";
>> +       prvdata->ka.show = subsystem_stats_show;
>> +
>> +       ret = sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
>> +       if (ret) {
>> +               kobject_put(prvdata->kobj);
>> +               kfree(prvdata);
>> +       }
>> +
>> +       return ret;
>> +}
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
