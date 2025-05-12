Return-Path: <linux-pm+bounces-27033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF5AB2D6D
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49441171ED6
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B719D081;
	Mon, 12 May 2025 02:17:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10258834
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016240; cv=none; b=Ni/P2uj3Shx+uW1F71SbH9QFhjrxOF/gDp8edtd2AxZ8VEvhH01UQ3i9tn1eTc6Ty9PuA0XhP6lCtAOKZMb4xyQLEznL0+llDGCHFVrQ8eZBEdAL/gCI0eBx9cNIexvP1Ua3oqNhw6IQOVkS/1HmPcucDo3DXUkzcAWZ2lsq4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016240; c=relaxed/simple;
	bh=AaIXd7O7K3ccSyROWHz/Coh7yb9ipznJI7KyuDVX9xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LsEjxsjRacqOHFF5UODO3V8N1H1pJzC8DSwP0Whp+6CNhnBeSkFWCo7TOkfPT/rhjMkBErfNgVifgB730t06/wsc64KyGI8TFQYfylvYowPVl/fgsgns3RJE3ke8l8zdfEhZetRqZxCLSNtHWOF14dRIf1m1gZffBJsm20Vp5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZwjrJ3xSDz1d0rp;
	Mon, 12 May 2025 10:15:44 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A01A51800B2;
	Mon, 12 May 2025 10:17:07 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 May 2025 10:17:07 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 May
 2025 10:17:06 +0800
Message-ID: <8ef46e21-4ad0-46ef-bfb3-fc56094ef79d@huawei.com>
Date: Mon, 12 May 2025 10:17:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM / devfreq: Add HiSilicon uncore frequency scaling
 driver
To: Jie Zhan <zhanjie9@hisilicon.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <liwei728@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250506021434.944386-1-zhanjie9@hisilicon.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250506021434.944386-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Jie,

There are some trivia advice. please have a look.

/Huisong
在 2025/5/6 10:14, Jie Zhan 写道:
> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
> the devfreq framework.  The uncore domain contains shared computing
> resources, including system interconnects and L3 cache.  The uncore
> frequency significantly impacts the system-wide performance as well as
> power consumption.  This driver adds support for runtime management of
> uncore frequency from kernel and userspace.  The main function includes
> setting and getting frequencies, changing frequency scaling policies, and
> querying the list of CPUs whose performance is significantly related to
> this uncore frequency domain, etc.  The driver communicates with a platform
> controller through an ACPI PCC mailbox to take the actual actions of
> frequency scaling.
>
> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>   drivers/devfreq/Kconfig            |  11 +
>   drivers/devfreq/Makefile           |   1 +
>   drivers/devfreq/hisi_uncore_freq.c | 722 +++++++++++++++++++++++++++++
>   3 files changed, 734 insertions(+)
>   create mode 100644 drivers/devfreq/hisi_uncore_freq.c
>
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 3c4862a752b5..7ab09739bf21 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -90,6 +90,17 @@ config ARM_EXYNOS_BUS_DEVFREQ
>   	  and adjusts the operating frequencies and voltages with OPP support.
>   	  This does not yet operate with optimal voltages.
>   
> +config ARM_HISI_UNCORE_DEVFREQ
> +	tristate "HiSilicon uncore DEVFREQ Driver"
> +	depends on (PCC && ACPI && ACPI_PPTT) || COMPILE_TEST
> +	select DEVFREQ_GOV_PERFORMANCE
> +	select DEVFREQ_GOV_USERSPACE
> +	help
> +	  This adds a DEVFREQ driver that manages uncore frequency scaling for
> +	  HiSilicon Kunpeng SoCs. This enables runtime management of uncore
> +	  frequency scaling from kernel and userspace. The uncore domain
> +	  contains system interconnects and L3 cache.
> +
>   config ARM_IMX_BUS_DEVFREQ
>   	tristate "i.MX Generic Bus DEVFREQ Driver"
>   	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index bf40d04928d0..404179d79a9d 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>   
>   # DEVFREQ Drivers
>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_HISI_UNCORE_DEVFREQ)	+= hisi_uncore_freq.o
>   obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>   obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> new file mode 100644
> index 000000000000..c093ada438f0
> --- /dev/null
> +++ b/drivers/devfreq/hisi_uncore_freq.c
> @@ -0,0 +1,722 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HiSilicon uncore frequency scaling driver
> + *
> + * Copyright (c) 2025 HiSilicon Co., Ltd
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/devfreq.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/property.h>
> +#include <linux/topology.h>
> +#include <linux/units.h>
> +#include <acpi/pcc.h>
> +
> +#include "governor.h"
> +
> +struct hisi_uncore_pcc_data {
> +	u16 status;
> +	u16 resv;
> +	u32 data;
> +};
> +
> +struct hisi_uncore_pcc_shmem {
> +	struct acpi_pcct_shared_memory head;
> +	struct hisi_uncore_pcc_data pcc_data;
> +};
> +
> +enum hisi_uncore_pcc_cmd_type {
> +	HUCF_PCC_CMD_GET_CAP = 0,
> +	HUCF_PCC_CMD_GET_FREQ,
> +	HUCF_PCC_CMD_SET_FREQ,
> +	HUCF_PCC_CMD_GET_MODE,
> +	HUCF_PCC_CMD_SET_MODE,
> +	HUCF_PCC_CMD_GET_PLAT_FREQ_NUM,
> +	HUCF_PCC_CMD_GET_PLAT_FREQ_BY_IDX,
> +	HUCF_PCC_CMD_MAX = 256,
> +};
> +
> +static int hisi_platform_gov_usage;
> +static DEFINE_MUTEX(hisi_platform_gov_usage_lock);
> +
> +enum hisi_uncore_freq_mode {
> +	HUCF_MODE_PLATFORM = 0,
> +	HUCF_MODE_OS,
> +	HUCF_MODE_MAX,
> +};
> +
> +#define HUCF_CAP_PLATFORM_CTRL	BIT(0)
> +
> +/**
> + * struct hisi_uncore_freq - hisi uncore frequency scaling device data
> + * @dev:		device of this frequency scaling driver
> + * @cl:			mailbox client object
> + * @pchan:		PCC mailbox channel
> + * @pcc_shmem_addr:	PCC shared memory base address
> + * @chan_id:		PCC channel ID
> + * @last_cmd_cmpl_time:	timestamp of the last completed PCC command
> + * @pcc_lock:		PCC channel lock
> + * @devfreq:		devfreq data of this hisi_uncore_freq device
> + * @related_cpus:	CPUs whose performance is majorly affected by this
> + *			uncore frequency domain
> + * @cap:		capabililty flag
> + */
> +struct hisi_uncore_freq {
> +	struct device *dev;
> +	struct mbox_client cl;
> +	struct pcc_mbox_chan *pchan;
> +	void __iomem *pcc_shmem_addr;
> +	int chan_id;
> +	ktime_t last_cmd_cmpl_time;
> +	struct mutex pcc_lock;
> +	struct devfreq *devfreq;
> +	struct cpumask related_cpus;
> +	u32 cap;
> +};
> +
> +/* PCC channel timeout = PCC nominal latency * NUM */
> +#define HUCF_PCC_POLL_TIMEOUT_NUM	1000
> +#define HUCF_PCC_POLL_INTERVAL_US	5
> +
> +/* Default polling interval in ms for devfreq governors*/
> +#define DEFAULT_POLLING_MS 100
> +
> +static int hisi_uncore_request_pcc_chan(struct hisi_uncore_freq *uncore)
> +{
> +	struct pcc_mbox_chan *pcc_chan;
> +	int rc;
> +
> +	uncore->cl = (struct mbox_client) {
> +		.dev = uncore->dev,
> +		.tx_block = false,
> +		.knows_txdone = true,
> +	};
> +
> +	pcc_chan = pcc_mbox_request_channel(&uncore->cl, uncore->chan_id);
> +	if (IS_ERR(pcc_chan)) {
> +		dev_err(uncore->dev, "Failed to request PCC channel %u\n",
> +			uncore->chan_id);
> +		return -ENODEV;
> +	}
> +
> +	if (!pcc_chan->shmem_base_addr) {
> +		dev_err(uncore->dev, "Invalid PCC shared memory address\n");
> +		rc = -EINVAL;
> +		goto err_pcc_chan_free;
> +	}
> +
> +	if (pcc_chan->shmem_size < sizeof(struct hisi_uncore_pcc_shmem)) {
> +		dev_err(uncore->dev, "Invalid PCC shared memory size (%lluB)\n",
> +			pcc_chan->shmem_size);
> +		rc = -EINVAL;
> +		goto err_pcc_chan_free;
> +	}
> +
> +	uncore->pcc_shmem_addr = ioremap(pcc_chan->shmem_base_addr,
> +					 pcc_chan->shmem_size);
Now driver doesn't need to ioremap repeatly because of Sudeep's work.
Please see the patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa362ffafa51b08cf8e2fcca38e056332f6b9b05 

> +	if (!uncore->pcc_shmem_addr) {
> +		rc = -ENOMEM;
> +		goto err_pcc_chan_free;
> +	}
> +
> +	mutex_init(&uncore->pcc_lock);
> +	uncore->pchan = pcc_chan;
> +
> +	return 0;
> +
> +err_pcc_chan_free:
> +	pcc_mbox_free_channel(pcc_chan);
> +
> +	return rc;
> +}
> +
> +static void hisi_uncore_free_pcc_chan(struct hisi_uncore_freq *uncore)
> +{
> +	if (uncore->pchan) {
> +		guard(mutex)(&uncore->pcc_lock);
> +		pcc_mbox_free_channel(uncore->pchan);
> +		uncore->pchan = NULL;
> +	}
> +}
> +
> +static acpi_status hisi_uncore_pcc_reg_scan(struct acpi_resource *res,
> +					    void *ctx)
> +{
> +	struct acpi_resource_generic_register *reg;
> +	struct hisi_uncore_freq *uncore;
> +
> +	if (!res || res->type != ACPI_RESOURCE_TYPE_GENERIC_REGISTER)
> +		return AE_OK;
> +
> +	reg = &res->data.generic_reg;
> +	if (reg->space_id != ACPI_ADR_SPACE_PLATFORM_COMM)
> +		return AE_OK;
> +
> +	if (!ctx)
> +		return AE_ERROR;
> +
> +	uncore = ctx;
> +	/* PCC subspace ID stored in Access Size */
> +	uncore->chan_id = reg->access_size;
> +
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static int hisi_uncore_init_pcc_chan(struct hisi_uncore_freq *uncore)
> +{
> +	acpi_handle handle = ACPI_HANDLE(uncore->dev);
> +	acpi_status status;
> +
> +	uncore->chan_id = -1;
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     hisi_uncore_pcc_reg_scan, uncore);
> +	if (ACPI_FAILURE(status) || uncore->chan_id < 0) {
> +		dev_err(uncore->dev, "Failed to get a PCC channel\n");
> +		return -ENODEV;
> +	}
> +
> +	return hisi_uncore_request_pcc_chan(uncore);
> +}
> +
> +static int hisi_uncore_cmd_send(struct hisi_uncore_freq *uncore,
> +				u8 cmd, u32 *data)
> +{
> +	struct hisi_uncore_pcc_shmem __iomem *addr;
> +	struct hisi_uncore_pcc_shmem shmem;
> +	struct pcc_mbox_chan *pchan;
> +	unsigned int mrtt;
> +	s64 time_delta;
> +	u16 status;
> +	int rc;
> +
> +	guard(mutex)(&uncore->pcc_lock);
> +
> +	pchan = uncore->pchan;
> +	addr = uncore->pcc_shmem_addr;
> +
> +	if (!pchan || !addr)
> +		return -ENODEV;
This parameter validation seems redundant. From driver point, it always 
be ok.
> +
> +	/* Handle the Minimum Request Turnaround Time (MRTT) */
> +	mrtt = pchan->min_turnaround_time;
> +	time_delta = ktime_us_delta(ktime_get(),
> +				    uncore->last_cmd_cmpl_time);
> +	if (mrtt > time_delta)
> +		udelay(mrtt - time_delta);
> +
> +	/* Copy data */
> +	shmem.head = (struct acpi_pcct_shared_memory) {
> +		.signature = PCC_SIGNATURE | uncore->chan_id,
> +		.command = cmd,
> +		.status = 0,
> +	};
> +	shmem.pcc_data.data = *data;
> +	memcpy_toio(addr, &shmem, sizeof(shmem));
> +
> +	/* Ring doorbell */
> +	rc = mbox_send_message(pchan->mchan, &cmd);
> +	if (rc < 0) {
> +		dev_err(uncore->dev, "Failed to send mbox message, %d\n", rc);
> +		return rc;
> +	}
> +
> +	/* Wait status */
> +	rc = readw_poll_timeout(&addr->head.status, status,
> +				status & (PCC_STATUS_CMD_COMPLETE |
> +					  PCC_STATUS_ERROR),
> +				HUCF_PCC_POLL_INTERVAL_US,
> +				pchan->latency * HUCF_PCC_POLL_TIMEOUT_NUM);
> +	if (rc) {
> +		dev_err(uncore->dev, "PCC channel response timeout, cmd=%u\n", cmd);
> +		goto exit;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		dev_err(uncore->dev, "PCC cmd error, cmd=%u\n", cmd);
> +		rc = -EIO;
> +		goto exit;
> +	}
> +
> +exit:
> +	uncore->last_cmd_cmpl_time = ktime_get();
> +
> +	/* Copy data back */
> +	memcpy_fromio(data, &addr->pcc_data.data, sizeof(*data));
> +
> +	/* Clear mailbox active req */
> +	mbox_client_txdone(pchan->mchan, rc);
> +
> +	return rc;
> +}
> +
> +static int hisi_uncore_target(struct device *dev, unsigned long *freq,
> +			      u32 flags)
> +{
> +	struct hisi_uncore_freq *uncore = dev_get_drvdata(dev);
> +	struct dev_pm_opp *opp;
> +	u32 data;
> +
> +	/*
> +	 * ->target() might be called after drv->remove() and before governor
> +	 * stopped, so it's necessary to check here, but no need to warn.
> +	 */
> +	if (!uncore || !uncore->pchan)
> +		return 0;
If have the following tips, this check can be removed, right?
> +
> +	opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq);
> +		return PTR_ERR(opp);
> +	}
> +	dev_pm_opp_put(opp);
> +
> +	data = (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
> +
> +	return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data);
> +}
> +
<...>
> +
> +static int hisi_uncore_devfreq_register(struct hisi_uncore_freq *uncore)
> +{
> +	struct devfreq_dev_profile *profile;
> +	unsigned long freq;
> +	u32 data;
> +	int rc;
> +
> +	rc = hisi_uncore_get_cur_freq(uncore->dev, &freq);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to get plat init freq (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	profile = devm_kzalloc(uncore->dev, sizeof(*profile), GFP_KERNEL);
> +	if (!profile)
> +		return -ENOMEM;
> +
> +	profile->initial_freq = freq;
> +	profile->polling_ms = DEFAULT_POLLING_MS;
> +	profile->timer = DEVFREQ_TIMER_DELAYED;
> +	profile->target = hisi_uncore_target;
> +	profile->get_dev_status = hisi_uncore_get_dev_status;
> +	profile->get_cur_freq = hisi_uncore_get_cur_freq;
> +
> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_MODE, &data);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to get operate mode (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	if (data == HUCF_MODE_PLATFORM)
> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
> +							  hisi_platform_governor.name, NULL);
> +	else
> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
> +							  DEVFREQ_GOV_PERFORMANCE, NULL);
This code creates sysfs file which will be freed after .remove() executed.
However, the PCC channel is released in .remove().
This may lead to UAF issue.
We have tow options:
*option 1:*
hisi_uncore_free_pcc_chan() also move to the last release instead of the 
.remove() by devm_add_action_or_reset() or devm_add_action().
*option 2:*
Use devfreq_add_device() to replace devm_devfreq_add_device() and 
.remove() in driver call devfreq_remove_device() to delete these sysfs 
files.

There are the resources  dependency between these interfaces. And there 
is a potential release sequence in .remove, devm_xxx, and even the 
devm_xxx release inside.
I prefer to explicitly free interfaces that have resource dependencies 
in driver.


> +	if (IS_ERR(uncore->devfreq)) {
> +		dev_err(uncore->dev, "Failed to add devfreq device\n");
> +		return PTR_ERR(uncore->devfreq);
> +	}
> +
> +	return 0;
> +}
> +
<...>
> +
> +	rc = hisi_uncore_init_dev_interface(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to init custom device interfaces (%d)\n", rc);
> +		goto err_remove_platform_gov;
> +	}
> +
> +	return 0;
> +
> +err_remove_platform_gov:
> +	hisi_uncore_remove_platform_gov(uncore);
> +
> +err_free_opp:
> +	dev_pm_opp_remove_all_dynamic(uncore->dev);
> +
> +err_free_pcc_chan:
> +	hisi_uncore_free_pcc_chan(uncore);
> +
> +	return rc;
> +}
> +
> +static void hisi_uncore_freq_remove(struct platform_device *pdev)
> +{
> +	struct hisi_uncore_freq *uncore = platform_get_drvdata(pdev);
> +
> +	hisi_uncore_remove_dev_interface(uncore);
> +	hisi_uncore_remove_platform_gov(uncore);
> +	dev_pm_opp_remove_all_dynamic(uncore->dev);
> +	hisi_uncore_free_pcc_chan(uncore);
> +}
> +
<...>

