Return-Path: <linux-pm+bounces-27320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA6ABB6B1
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABF8163B0E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77A267AF1;
	Mon, 19 May 2025 08:03:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC0266591
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641821; cv=none; b=DZH9+P8jIhnMan2hLJ/HWQU7QdQOSkYgjrawvnKNoWXr15j9xb3WMPHzFSaStdtkVplHqAJPKjhYCySRSOWFqECh2ug4xdikQ8PWeR1mCqAcoz0VUvz+QxOiK0vzqq2duHbVjHorRaF11mh9kUPPrbOKvHO2zRSRvSzh7O+VAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641821; c=relaxed/simple;
	bh=v3ZQl/uWwEu3WGZ2m26PnM1g9UrnUHhTYxW7ZH/xRms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QP1m+hDAwbqH/LRHwfRVH3PriS1zAVodUBlu7v0U0K8z+zXK2q9TvM07MS0QZvEfti0tCKqALFJ2Uv0DxQXWa9FGBT1e7yVUlPR87IkmJrCRaTdzec3OfBnt5bhSxo1fDS5y3Pv4stpC4rS45SUWUQ52V2x7mALPZEd3z1qKULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b197H45XHz10Wkj;
	Mon, 19 May 2025 15:59:07 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A1BD140154;
	Mon, 19 May 2025 16:03:28 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 May
 2025 16:03:27 +0800
Message-ID: <4f910767-9a96-6229-18cb-0119574eca00@hisilicon.com>
Date: Mon, 19 May 2025 16:03:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1] PM / devfreq: Add HiSilicon uncore frequency scaling
 driver
To: "lihuisong (C)" <lihuisong@huawei.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <liwei728@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250506021434.944386-1-zhanjie9@hisilicon.com>
 <8ef46e21-4ad0-46ef-bfb3-fc56094ef79d@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <8ef46e21-4ad0-46ef-bfb3-fc56094ef79d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Hi Huisong,

Thanks for reviewing.

On 12/05/2025 10:17, lihuisong (C) wrote:
> Hi Jie,
> 
> There are some trivia advice. please have a look.
> 
> /Huisong
> 在 2025/5/6 10:14, Jie Zhan 写道:
>> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
>> the devfreq framework.  The uncore domain contains shared computing
>> resources, including system interconnects and L3 cache.  The uncore
>> frequency significantly impacts the system-wide performance as well as
>> power consumption.  This driver adds support for runtime management of
>> uncore frequency from kernel and userspace.  The main function includes
>> setting and getting frequencies, changing frequency scaling policies, and
>> querying the list of CPUs whose performance is significantly related to
>> this uncore frequency domain, etc.  The driver communicates with a platform
>> controller through an ACPI PCC mailbox to take the actual actions of
>> frequency scaling.
>>
>> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>   drivers/devfreq/Kconfig            |  11 +
>>   drivers/devfreq/Makefile           |   1 +
>>   drivers/devfreq/hisi_uncore_freq.c | 722 +++++++++++++++++++++++++++++
>>   3 files changed, 734 insertions(+)
>>   create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>>

...

>> +
>> +static int hisi_uncore_request_pcc_chan(struct hisi_uncore_freq *uncore)
>> +{
>> +    struct pcc_mbox_chan *pcc_chan;
>> +    int rc;
>> +
>> +    uncore->cl = (struct mbox_client) {
>> +        .dev = uncore->dev,
>> +        .tx_block = false,
>> +        .knows_txdone = true,
>> +    };
>> +
>> +    pcc_chan = pcc_mbox_request_channel(&uncore->cl, uncore->chan_id);
>> +    if (IS_ERR(pcc_chan)) {
>> +        dev_err(uncore->dev, "Failed to request PCC channel %u\n",
>> +            uncore->chan_id);
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (!pcc_chan->shmem_base_addr) {
>> +        dev_err(uncore->dev, "Invalid PCC shared memory address\n");
>> +        rc = -EINVAL;
>> +        goto err_pcc_chan_free;
>> +    }
>> +
>> +    if (pcc_chan->shmem_size < sizeof(struct hisi_uncore_pcc_shmem)) {
>> +        dev_err(uncore->dev, "Invalid PCC shared memory size (%lluB)\n",
>> +            pcc_chan->shmem_size);
>> +        rc = -EINVAL;
>> +        goto err_pcc_chan_free;
>> +    }
>> +
>> +    uncore->pcc_shmem_addr = ioremap(pcc_chan->shmem_base_addr,
>> +                     pcc_chan->shmem_size);
> Now driver doesn't need to ioremap repeatly because of Sudeep's work.
> Please see the patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa362ffafa51b08cf8e2fcca38e056332f6b9b05

Cool. Now we can use pcc_chan->shmem. Will update the code based on that.

>> +    if (!uncore->pcc_shmem_addr) {
>> +        rc = -ENOMEM;
>> +        goto err_pcc_chan_free;
>> +    }
>> +

...

>> +static int hisi_uncore_cmd_send(struct hisi_uncore_freq *uncore,
>> +                u8 cmd, u32 *data)
>> +{
>> +    struct hisi_uncore_pcc_shmem __iomem *addr;
>> +    struct hisi_uncore_pcc_shmem shmem;
>> +    struct pcc_mbox_chan *pchan;
>> +    unsigned int mrtt;
>> +    s64 time_delta;
>> +    u16 status;
>> +    int rc;
>> +
>> +    guard(mutex)(&uncore->pcc_lock);
>> +
>> +    pchan = uncore->pchan;
>> +    addr = uncore->pcc_shmem_addr;
>> +
>> +    if (!pchan || !addr)
>> +        return -ENODEV;
> This parameter validation seems redundant. From driver point, it always be ok.

uncore->pchan could be NULL if hisi_uncore_cmd_send() if called after
hisi_uncore_free_pcc_chan().

In the driver detaching processor, the drv->remove() is called before devm
resources free, i.e. where devfreq device is freed.
Hence the devfreq governor, e.g. simpleondemand, could possibly issue a
freq request after the driver is removed.

The checking and setting uncore->pchan = NULL in this driver is trying to
protect against the above case.  It actually happened during our tests so
it's not redundant unless we get a better way to solve that.

>> +
>> +    /* Handle the Minimum Request Turnaround Time (MRTT) */
>> +    mrtt = pchan->min_turnaround_time;
>> +    time_delta = ktime_us_delta(ktime_get(),
>> +                    uncore->last_cmd_cmpl_time);
>> +    if (mrtt > time_delta)
>> +        udelay(mrtt - time_delta);
>> +
>> +    /* Copy data */
>> +    shmem.head = (struct acpi_pcct_shared_memory) {
>> +        .signature = PCC_SIGNATURE | uncore->chan_id,
>> +        .command = cmd,
>> +        .status = 0,
>> +    };
>> +    shmem.pcc_data.data = *data;
>> +    memcpy_toio(addr, &shmem, sizeof(shmem));
>> +
>> +    /* Ring doorbell */
>> +    rc = mbox_send_message(pchan->mchan, &cmd);
>> +    if (rc < 0) {
>> +        dev_err(uncore->dev, "Failed to send mbox message, %d\n", rc);
>> +        return rc;
>> +    }
>> +
>> +    /* Wait status */
>> +    rc = readw_poll_timeout(&addr->head.status, status,
>> +                status & (PCC_STATUS_CMD_COMPLETE |
>> +                      PCC_STATUS_ERROR),
>> +                HUCF_PCC_POLL_INTERVAL_US,
>> +                pchan->latency * HUCF_PCC_POLL_TIMEOUT_NUM);
>> +    if (rc) {
>> +        dev_err(uncore->dev, "PCC channel response timeout, cmd=%u\n", cmd);
>> +        goto exit;
>> +    }
>> +
>> +    if (status & PCC_STATUS_ERROR) {
>> +        dev_err(uncore->dev, "PCC cmd error, cmd=%u\n", cmd);
>> +        rc = -EIO;
>> +        goto exit;
>> +    }
>> +
>> +exit:
>> +    uncore->last_cmd_cmpl_time = ktime_get();
>> +
>> +    /* Copy data back */
>> +    memcpy_fromio(data, &addr->pcc_data.data, sizeof(*data));
>> +
>> +    /* Clear mailbox active req */
>> +    mbox_client_txdone(pchan->mchan, rc);
>> +
>> +    return rc;
>> +}
>> +
>> +static int hisi_uncore_target(struct device *dev, unsigned long *freq,
>> +                  u32 flags)
>> +{
>> +    struct hisi_uncore_freq *uncore = dev_get_drvdata(dev);
>> +    struct dev_pm_opp *opp;
>> +    u32 data;
>> +
>> +    /*
>> +     * ->target() might be called after drv->remove() and before governor
>> +     * stopped, so it's necessary to check here, but no need to warn.
>> +     */
>> +    if (!uncore || !uncore->pchan)
>> +        return 0;
> If have the following tips, this check can be removed, right?

See below.

...

>> +
>> +static int hisi_uncore_devfreq_register(struct hisi_uncore_freq *uncore)
>> +{
>> +    struct devfreq_dev_profile *profile;
>> +    unsigned long freq;
>> +    u32 data;
>> +    int rc;
>> +
>> +    rc = hisi_uncore_get_cur_freq(uncore->dev, &freq);
>> +    if (rc) {
>> +        dev_err(uncore->dev, "Failed to get plat init freq (%d)\n", rc);
>> +        return rc;
>> +    }
>> +
>> +    profile = devm_kzalloc(uncore->dev, sizeof(*profile), GFP_KERNEL);
>> +    if (!profile)
>> +        return -ENOMEM;
>> +
>> +    profile->initial_freq = freq;
>> +    profile->polling_ms = DEFAULT_POLLING_MS;
>> +    profile->timer = DEVFREQ_TIMER_DELAYED;
>> +    profile->target = hisi_uncore_target;
>> +    profile->get_dev_status = hisi_uncore_get_dev_status;
>> +    profile->get_cur_freq = hisi_uncore_get_cur_freq;
>> +
>> +    rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_MODE, &data);
>> +    if (rc) {
>> +        dev_err(uncore->dev, "Failed to get operate mode (%d)\n", rc);
>> +        return rc;
>> +    }
>> +
>> +    if (data == HUCF_MODE_PLATFORM)
>> +        uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
>> +                              hisi_platform_governor.name, NULL);
>> +    else
>> +        uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
>> +                              DEVFREQ_GOV_PERFORMANCE, NULL);
> This code creates sysfs file which will be freed after .remove() executed.
> However, the PCC channel is released in .remove().
> This may lead to UAF issue.

Not only those sysfs files, the whole devfreq device & governor is still
there after drv->remove().  That's the main cause of issues when
registering a devfreq device by devm_devfreq_add_device().

However, at the moment, we have prevented against any UAF issues?

> We have tow options:
> *option 1:*
> hisi_uncore_free_pcc_chan() also move to the last release instead of the .remove() by devm_add_action_or_reset() or devm_add_action().

I don't quite understand what this means.
hisi_uncore_free_pcc_chan() is currently the last step of drv->remove().
If we let it be managed by devm, it can't be guaranteed that the pcc chan
is freed after devfreq device is removed.

> *option 2:*
> Use devfreq_add_device() to replace devm_devfreq_add_device() and .remove() in driver call devfreq_remove_device() to delete these sysfs files.
> 
> There are the resources  dependency between these interfaces. And there is a potential release sequence in .remove, devm_xxx, and even the devm_xxx release inside.
> I prefer to explicitly free interfaces that have resource dependencies in driver.
> 
> 

This looks like a possible plan, but we will need to go back to the raw
ABIs.


Thanks!
Jie

...

