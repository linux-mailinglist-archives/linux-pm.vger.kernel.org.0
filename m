Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E5166F69
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 07:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgBUGFO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 01:05:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:62067 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgBUGFO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 01:05:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582265113; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=AmSuCdpdpBGQDOlvD6ieAhS2vzFezHcUSynVQPVUMQw=; b=rwaUxg0uSHY7Ppv64eD6C2I80/qsRew4ZFG9m6c6sfGmAn63pAlltFKFoPovtLJ3dMLpk21L
 OcI/YudjLIwvr4nnoQK4XuI1jx16ZmXgbiLwbzIEnJG6AWlprfzBX2AZT2PJYGdXhOf8V+eJ
 I8jVVMaRgGqzpEHFlrLmIZyoO6Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f7310.7f0d07d4e148-smtp-out-n03;
 Fri, 21 Feb 2020 06:05:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29EB0C4479D; Fri, 21 Feb 2020 06:05:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DFFCC43383;
        Fri, 21 Feb 2020 06:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DFFCC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 2/2] drivers: qcom: Add SoC sleep stats driver
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190808061228.16573-1-mkshah@codeaurora.org>
 <20190808061228.16573-3-mkshah@codeaurora.org>
 <5d4c6c92.1c69fb81.876aa.90c6@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <3f3124e5-11ef-0fcd-675b-b9d8dde43515@codeaurora.org>
Date:   Fri, 21 Feb 2020 11:34:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5d4c6c92.1c69fb81.876aa.90c6@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/9/2019 12:10 AM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-08-07 23:12:28)
>> Qualcomm Technologies Inc's (QTI) chipsets support SoC level
>> low power modes. Statistics for SoC sleep stats are produced
>> by remote processor.
>>
>> Lets's add a driver to read the shared memory exported by the
>> remote processor and export to sysfs.
>>
>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> SoB chain is weird here too.
corrected in v2.
>
>> ---
>>   drivers/soc/qcom/Kconfig           |   9 ++
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/soc_sleep_stats.c | 249 +++++++++++++++++++++++++++++
> There should be a Documentation/ABI/ path in this diffstat above because
> you're adding sysfs attributes.
In v2 using debugfs for stats information.
>
> There's some similar support in the ARM PSCI spec for extracting
> idle/suspend stats, see section 5.21 PSCI_STAT_RESIDENCY/COUNT. Maybe
> this code can align with that feature in PSCI? At the least, I hope we
> can come up with a generic sysfs ABI that can be used to describe CPU
> and system wide power states in a way that userspace can read and
> understand how long the device was in these different power states. I
> would guess that other architectures like x86 may also want to get
> involved in reporting this information in a standard way, so please loop
> in some x86 power folks too.
>
> It would be neat if the PSCI feature could be used for this instead of
> having a custom SoC driver. Maybe that won't work though because this
> works for shipping firmware and/or because of the 'client_votes' thing
> which looks like special extra data describing the other subsystems? At
> least for some SoCs it may be all they need though, so keeping the PSCI
> call in mind would be good when developing the ABI and may be enough for
> userspace purposes. The client_votes part may be possible to layer on
> top of the PSCI calls anyway, and go into some other file so we can
> figure out which remoteproc is holding up suspend or idle states.
correct PSCI won't work here.
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 880cf0290962..7aac24430e99 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -163,6 +163,15 @@ config QCOM_SMSM
>>            Say yes here to support the Qualcomm Shared Memory State Machine.
>>            The state machine is represented by bits in shared memory.
>>   
>> +config QCOM_SOC_SLEEP_STATS
>> +       tristate "Qualcomm Technologies Inc. (QTI) SoC sleep stats driver"
>> +       depends on ARCH_QCOM
>> +       help
>> +         Qualcomm Technologies Inc. (QTI) SoC sleep stats driver to read
>> +         the shared memory exported by the remote processor related to
> Shared memory sounds like DDR.
Not a DDR.
>
>> +         various SoC level low power modes statistics and export to sysfs
>> +         interface.
>> +
>>   config QCOM_WCNSS_CTRL
>>          tristate "Qualcomm WCNSS control driver"
>>          depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc_sleep_stats.c
>> new file mode 100644
>> index 000000000000..5b95d68512ec
>> --- /dev/null
>> +++ b/drivers/soc/qcom/soc_sleep_stats.c
>> @@ -0,0 +1,249 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (c) 2011-2019, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
>> +
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
> Is this include used?
removed unused headers in v2.
>
>> +
>> +#define ARCH_TIMER_FREQ        19200000
> Can't this come through clk APIs? Or is this the ARM architected timer
> freqeuency?
Updated to use clk APIs
>> +
>> +struct stats_config {
>> +       u32 offset_addr;
>> +       u32 num_records;
>> +       bool appended_stats_avail;
>> +};
>> +
>> +struct soc_sleep_stats_data {
>> +       phys_addr_t stats_base;
>> +       resource_size_t stats_size;
>> +       const struct stats_config *config;
>> +       struct kobject *kobj;
>> +       struct kobj_attribute ka;
>> +       struct mutex lock;
>> +};
>> +
>> +struct entry {
>> +       __le32 stat_type;
>> +       __le32 count;
>> +       __le64 last_entered_at;
>> +       __le64 last_exited_at;
>> +       __le64 accumulated;
>> +};
>> +
>> +struct appended_entry {
>> +       __le32 client_votes;
>> +       __le32 reserved[3];
>> +};
>> +
>> +struct stats_entry {
>> +       struct entry entry;
>> +       struct appended_entry appended_entry;
>> +};
>> +
>> +static inline u64 get_time_in_sec(u64 counter)
>> +{
>> +       do_div(counter, ARCH_TIMER_FREQ);
>> +
>> +       return counter;
>> +}
>> +
>> +static inline ssize_t append_data_to_buf(char *buf, int length,
>> +                                        struct stats_entry *data)
>> +{
>> +       char stat_type[5] = {0};
>> +
>> +       memcpy(stat_type, &data->entry.stat_type, sizeof(u32));
> sizeof(u32) != 5. Is this on purpose?

yes, maximum name length 5.

>
>> +
>> +       return scnprintf(buf, length,
>> +                        "%s\n"
>> +                        "\tCount                    :%u\n"
>> +                        "\tLast Entered At(sec)     :%llu\n"
>> +                        "\tLast Exited At(sec)      :%llu\n"
>> +                        "\tAccumulated Duration(sec):%llu\n"
>> +                        "\tClient Votes             :0x%x\n\n",
>> +                        stat_type, data->entry.count,
>> +                        data->entry.last_entered_at,
>> +                        data->entry.last_exited_at,
>> +                        data->entry.accumulated,
>> +                        data->appended_entry.client_votes);
>> +}
>> +
>> +static ssize_t stats_show(struct kobject *obj, struct kobj_attribute *attr,
>> +                         char *buf)
>> +{
>> +       void __iomem *reg;
>> +       int i;
>> +       uint32_t offset;
>> +       ssize_t length = 0, op_length;
>> +       struct stats_entry data;
>> +       struct entry *e = &data.entry;
>> +       struct appended_entry *ae = &data.appended_entry;
>> +       struct soc_sleep_stats_data *drv = container_of(attr,
>> +                                          struct soc_sleep_stats_data, ka);
>> +
>> +       mutex_lock(&drv->lock);
>> +       reg = ioremap_nocache(drv->stats_base, drv->stats_size);
>> +       if (!reg) {
>> +               pr_err("io remap failed\n");
> This looks like a real bad idea to ioremap each time the stats are
> shown. Why not just map once in probe so we don't have to create a
> mapping and suffer the overhead involved in that?
Updated in v2 to ioremap only once in probe.
>
>> +               mutex_unlock(&drv->lock);
>> +               return length;
>> +       }
>> +
>> +       for (i = 0; i < drv->config->num_records; i++) {
>> +               offset = offsetof(struct entry, stat_type);
>> +               e->stat_type = le32_to_cpu(readl_relaxed(reg + offset));
>> +
>> +               offset = offsetof(struct entry, count);
>> +               e->count = le32_to_cpu(readl_relaxed(reg + offset));
>> +
>> +               offset = offsetof(struct entry, last_entered_at);
>> +               e->last_entered_at = le64_to_cpu(readq_relaxed(reg + offset));
>> +
>> +               offset = offsetof(struct entry, last_exited_at);
>> +               e->last_exited_at = le64_to_cpu(readq_relaxed(reg + offset));
>> +
>> +               offset = offsetof(struct entry, last_exited_at);
>> +               e->accumulated = le64_to_cpu(readq_relaxed(reg + offset));
>> +
>> +               e->last_entered_at = get_time_in_sec(e->last_entered_at);
>> +               e->last_exited_at = get_time_in_sec(e->last_exited_at);
>> +               e->accumulated = get_time_in_sec(e->accumulated);
>> +
>> +               reg += sizeof(struct entry);
>> +
>> +               if (drv->config->appended_stats_avail) {
>> +                       offset = offsetof(struct appended_entry, client_votes);
>> +                       ae->client_votes = le32_to_cpu(readl_relaxed(reg +
>> +                                                                    offset));
>> +
>> +                       reg += sizeof(struct appended_entry);
>> +               } else
>> +                       ae->client_votes = 0;
> Please add braces to the else statement when the if statement has
> braces.
Done.
>> +
>> +               op_length = append_data_to_buf(buf + length, PAGE_SIZE - length,
>> +                                              &data);
>> +               if (op_length >= PAGE_SIZE - length)
>> +                       goto exit;
>> +
>> +               length += op_length;
>> +       }
>> +exit:
>> +       iounmap(reg);
>> +       mutex_unlock(&drv->lock);
>> +       return length;
>> +}
>> +
>> +static int soc_sleep_stats_create_sysfs(struct platform_device *pdev,
>> +                                       struct soc_sleep_stats_data *drv)
>> +{
>> +       int ret = -ENOMEM;
>> +
>> +       drv->kobj = kobject_create_and_add("soc_sleep", power_kobj);
>> +       if (!drv->kobj)
>> +               goto fail;
> Just return -ENOMEM here. It is really weird to make kobjects directly
> like this. How is userspace expected to use this?
Done. using debugfs.
>> +
>> +       sysfs_attr_init(drv->ka.attr);
>> +       drv->ka.attr.mode = 0444;
>> +       drv->ka.attr.name = "stats";
>> +       drv->ka.show = stats_show;
>> +
>> +       ret = sysfs_create_file(drv->kobj, &drv->ka.attr);
>> +       if (ret)
>> +               goto fail;
> Just return sysfs_create_file()?
>
>> +
>> +       platform_set_drvdata(pdev, drv);
> Do this platform_set_drvdata in probe?
done.
>> +fail:
>> +       return ret;
>> +}
>> +
>> +static const struct stats_config rpm_data = {
>> +       .offset_addr = 0x14,
>> +       .num_records = 2,
>> +       .appended_stats_avail = true,
>> +};
>> +
>> +static const struct stats_config rpmh_data = {
>> +       .offset_addr = 0x4,
>> +       .num_records = 3,
>> +       .appended_stats_avail = false,
>> +};
>> +
>> +static const struct of_device_id soc_sleep_stats_table[] = {
>> +       { .compatible = "qcom,rpm-sleep-stats", .data = &rpm_data},
>> +       { .compatible = "qcom,rpmh-sleep-stats", .data = &rpmh_data},
>> +       { },
>> +};
>> +
>> +static int soc_sleep_stats_probe(struct platform_device *pdev)
>> +{
>> +       const struct of_device_id *match;
>> +       struct soc_sleep_stats_data *drv;
>> +       struct resource *res;
>> +       void __iomem *offset_addr;
>> +       int ret;
>> +
>> +       drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
>> +       if (!drv)
>> +               return -ENOMEM;
>> +
>> +       match = of_match_node(soc_sleep_stats_table, pdev->dev.of_node);
>> +       if (!match)
>> +               return -ENODEV;
>> +
>> +       drv->config = match->data;
> Is this of_device_get_match_data()?
done.
>
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res)
>> +               return PTR_ERR(res);
>> +
>> +       offset_addr = ioremap_nocache(res->start + drv->config->offset_addr,
>> +                                     sizeof(u32));
> Why not just devm_platform_ioremap_resource()?
this adds  drv->config->offset_addr before ioremap.
>
>> +       if (IS_ERR(offset_addr))
>> +               return PTR_ERR(offset_addr);
>> +
>> +       drv->stats_base = res->start | readl_relaxed(offset_addr);
>> +       drv->stats_size = resource_size(res);
>> +       iounmap(offset_addr);
>> +       mutex_init(&drv->lock);
> Hopefully this lock isn't required?
removed lock.
>
>> +
>> +       ret = soc_sleep_stats_create_sysfs(pdev, drv);
>> +       if (ret)
>> +               pr_info("Failed to create sysfs interface\n");
> Not pr_err()? Or dev_err()?
done.
>> +
>> +       return ret;
>> +}
>> +
>> +static int soc_sleep_stats_remove(struct platform_device *pdev)
>> +{
>> +       struct soc_sleep_stats_data *drv = platform_get_drvdata(pdev);
>> +
>> +       sysfs_remove_file(drv->kobj, &drv->ka.attr);
>> +       kobject_put(drv->kobj);
>> +       platform_set_drvdata(pdev, NULL);
> This last line isn't necessary. Please remove.
Done.
>
>> +
>> +       return 0;
>> +}
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
