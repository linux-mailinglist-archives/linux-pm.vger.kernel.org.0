Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73333F120E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKFJWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 04:22:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKFJWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 04:22:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C58460112; Wed,  6 Nov 2019 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573032142;
        bh=nan8YJSS30Wg4kKf42tQFft2ZsekK/4+xstvXeltX9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HemEkQ4R6vPd3qqSyqxcIF2brnbgPslj02F4hJTkzY4hTYmskESwK9clOkjabVsn7
         961S4uWFcLvMG8+cByQLHcPT9WVnbW2At13zY2y3xkZhkOX4d9vl4avSlymjkz+Pqq
         wBM5vMfPXMet8n6iEokEwDGFAcroaz+cUNDVX7mA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 153306019D;
        Wed,  6 Nov 2019 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573032140;
        bh=nan8YJSS30Wg4kKf42tQFft2ZsekK/4+xstvXeltX9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iDtgVQ42yuG7ts8H7M+Czvgt15utAYP5jyI0IFZzDjVxr/N5LBGZz0YuCWOwi68EW
         SRn6CCCdSr29zcnhECvZLVYSu9RbpKKpsE7KDnwaOzjLzN7JsLk+Wbf+m4pG7/0EhX
         63ewBYIwJHoLGUekKwboz84UkOvKV2pp/yF8nCtA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 153306019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v2] soc: qcom: Introduce subsystem sleep stats driver
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org
References: <20190905091707.14420-1-mkshah@codeaurora.org>
 <5d7155f2.1c69fb81.61bf.f862@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <507d1769-41ba-749a-cafa-d178128bbb8b@codeaurora.org>
Date:   Wed, 6 Nov 2019 14:52:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5d7155f2.1c69fb81.61bf.f862@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/6/2019 12:07 AM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-09-05 02:17:07)
>> Multiple subsystems like modem, spss, adsp, cdsp present on
>> Qualcomm Technologies Inc's (QTI) SoCs maintains low power mode
>> statistics in shared memory (SMEM). Lets add a driver to read
>> and display this information using sysfs.
>>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>> Changes in v2:
>>          - Correct Makefile to use QCOM_SS_SLEEP_STATS config
>> ---
>>   Documentation/ABI/testing/sysfs-power    |  10 ++
>>   drivers/soc/qcom/Kconfig                 |   9 ++
>>   drivers/soc/qcom/Makefile                |   1 +
>>   drivers/soc/qcom/subsystem_sleep_stats.c | 146 +++++++++++++++++++++++
>>   4 files changed, 166 insertions(+)
>>   create mode 100644 drivers/soc/qcom/subsystem_sleep_stats.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index 18b7dc929234..1f8bb201246a 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -288,6 +288,16 @@ Description:
>>                  writing a "0" (default) to it disables them.  Reads from
>>                  this file return the current value.
>>   
>> +What:          /sys/power/subsystem_sleep/stats
>> +Date:          December 2017
> It isn't December 2017.

Hi Stephen,

Keeping it 2017 since driver is present from 2017 (driver copyright is 
also from 2017-2019)

>
>> +Contact:       Maulik Shah <mkshah@codeaurora.org>
>> +Description:
>> +               The /sys/power/subsystem_sleep/stats file prints the subsystem
>> +               sleep information on Qualcomm Technologies, Inc. (QTI) SoCs.
>> +
>> +               Reading from this file will display subsystem level low power
>> +               mode statistics.
>> +
> This directory doesn't make any sense to me. It's in the top-level power
> directory and it is specific to qcom. Is this debugging information? Why
> does userspace care about understanding the sleep stats information?
> Please Cc Rafael on anything touching /sys/power/

Stats can be used by userspace for the purpose of computing battery 
utilization.

Sure i will include Rafael in next revision.

>
>>   What:          /sys/power/resume_offset
>>   Date:          April 2018
>>   Contact:       Mario Limonciello <mario.limonciello@dell.com>
>> diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/subsystem_sleep_stats.c
>> new file mode 100644
>> index 000000000000..5379714b6ba4
>> --- /dev/null
>> +++ b/drivers/soc/qcom/subsystem_sleep_stats.c
>> @@ -0,0 +1,146 @@
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
>> +
>> +struct subsystem_data {
>> +       char *name;
>> +       enum subsystem_item_id item_id;
>> +       enum subsystem_pid pid;
>> +};
>> +
>> +static const struct subsystem_data subsystems[] = {
>> +       {"MODEM", MODEM, PID_MODEM},
>> +       {"ADSP", ADSP, PID_ADSP},
>> +       {"CDSP", CDSP, PID_CDSP},
>> +       {"SLPI", SLPI, PID_SLPI},
>> +       {"GPU", GPU, PID_GPU},
>> +       {"DISPLAY", DISPLAY, PID_DISPLAY},
> Please put spaces around braces.
Sure.
>> +};
>> +
>> +struct subsystem_stats {
>> +       uint32_t version_id;
>> +       uint32_t count;
>> +       uint64_t last_entered;
>> +       uint64_t last_exited;
>> +       uint64_t accumulated_duration;
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
> Information in sysfs is supposed to be one value per file. This is a
> bunch of different values and it includes a version field. Looks almost
> like something we would put into /proc, but of course that doesn't make
> any sense to put in /proc either.
>
> Please rethink the whole approach here. Can this be placed under the
> remoteproc nodes for each remote processor that's in the system? That
> would make it more discoverable by userspace looking at the remoteproc
> devices. I suppose GPU and DISPLAY aren't "remoteproc"s though so maybe
> this should be a new 'class' for devices that have an RPMh RSC? Maybe
> make a qcom_rpmh_rsc class and then have these be stats in there.

since stats can be used by userspace for the purpose of computing 
battery utilization /sys/power seems to be good place to keep it to me.

Adding it under class may require it  to be device. we are using it only 
as module.

>> +}
>> +
>> +static ssize_t subsystem_stats_show(struct kobject *kobj,
>> +                                   struct kobj_attribute *attr, char *buf)
>> +{
>> +       ssize_t length = 0;
>> +       int i = 0;
>> +       size_t size = 0;
>> +       struct subsystem_stats *record = NULL;
>> +
>> +       /* Read SMEM data written by other subsystems */
>> +       for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
>> +               record = (struct subsystem_stats *) qcom_smem_get(
>> +                         subsystems[i].pid, subsystems[i].item_id, &size);
>> +
>> +               if (!IS_ERR_OR_NULL(record) && (PAGE_SIZE - length > 0))
> It can return ERR pointer or NULL? Why?

Updated to check only IS_ERR.

Thanks for pointing.

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
>> +       prvdata = kmalloc(sizeof(*prvdata), GFP_KERNEL);
>> +       if (!prvdata)
>> +               return -ENOMEM;
>> +
>> +       ss_stats_kobj = kobject_create_and_add("subsystem_sleep",
>> +                                              power_kobj);
>> +       if (!ss_stats_kobj)
>> +               return -ENOMEM;
>> +
>> +       prvdata->kobj = ss_stats_kobj;
>> +
>> +       sysfs_attr_init(&prvdata->ka.attr);
>> +       prvdata->ka.attr.mode = 0444;
>> +       prvdata->ka.attr.name = "stats";
>> +       prvdata->ka.show = subsystem_stats_show;
>> +       prvdata->ka.store = NULL;
> Does it need to be set to NULL explicitly? Why not kzalloc() prvdata
> above?
Fixed.
>> +
>> +       ret = sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
>> +       if (ret) {
>> +               pr_err("sysfs_create_file failed\n");
> Seems useless. Presumably sysfs_create_file() can complain itself.
Fixed.
>> +               kobject_put(prvdata->kobj);
>> +               kfree(prvdata);
>> +               return ret;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void __exit subsystem_sleep_stats_exit(void)
>> +{
>> +       sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
>> +       kobject_put(prvdata->kobj);
>> +       kfree(prvdata);
>> +}
>> +
>> +module_init(subsystem_sleep_stats_init);
> So if this is compiled into an arm/arm64 image that doesn't include qcom
> platform support it will create this directory? That's just nonsensical.

Kconfig depends on QCOM_SMEM which inturn depends on ARCH_QCOM to get 
compiled into.

It won't get compiled for other than qcom platforms.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

