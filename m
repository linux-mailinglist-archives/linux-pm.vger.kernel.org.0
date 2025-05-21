Return-Path: <linux-pm+bounces-27466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A9ABFCD7
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E3950047F
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E145289E14;
	Wed, 21 May 2025 18:29:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38027CB0D
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852154; cv=none; b=tKULScCA4l094oJxyGbidhzqzcEJGd9lKY+EE35iGVN+KS9dGt91TffgIbqMR3ZrjKZECPnm3HnUoH84aX0cTGU4nQX0WgenoY1KOhoX7eusqguNPL9XzhXE2w9Xf4kqkkfAUxD1HWVX1Gp94N9oNv2YUxt8DAaVehpJCd2DHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852154; c=relaxed/simple;
	bh=RqHNkBUYbSTvc38+pU86/Se8RCj8YTu14apXjVMJY88=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaaeWzo7kDEYF9HFz1kYr3Zuvts/IgXOtYV+ClcHB1yR9FQzIxxQElsM7amCn+NcSReylyGeXeG4jh/taBDjQ2T1kYqWrcmYnACtJ57YUSS81L0OrI7rDS/9K3iXIoNsUeeauxodK9HfCSX9buRapSUPHvLDSN3nAxzH+P6FrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2g0G4r57z6GD8h;
	Thu, 22 May 2025 02:28:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A19914020A;
	Thu, 22 May 2025 02:29:08 +0800 (CST)
Received: from localhost (10.195.34.206) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 20:29:07 +0200
Date: Wed, 21 May 2025 19:29:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jie Zhan <zhanjie9@hisilicon.com>, <linuxarm@huawei.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v3] PM / devfreq: Add HiSilicon uncore frequency scaling
 driver
Message-ID: <20250521192842.0000251b@huawei.com>
In-Reply-To: <20250521104956.2780150-1-zhanjie9@hisilicon.com>
References: <20250521104956.2780150-1-zhanjie9@hisilicon.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 18:49:56 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

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

Minor comments inline.

Is the userspace ABI documented already?

> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> new file mode 100644
> index 000000000000..1e9ee4827c3f
> --- /dev/null
> +++ b/drivers/devfreq/hisi_uncore_freq.c

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
> +		return PTR_ERR(pcc_chan);
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
> +	mutex_init(&uncore->pcc_lock);
For new code maybe use
	rc = devm_mutex_init()
	if (rc)
		goto err_pcc_chan_free;

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
If only called from devm don't bother with separate function.
> +{
> +	if (uncore->pchan) {

Given nothing to do if this isn't set, why register the cleanup if it isn't?

> +		guard(mutex)(&uncore->pcc_lock);
> +		pcc_mbox_free_channel(uncore->pchan);
> +		uncore->pchan = NULL;
> +	}
> +}
> +
> +static void devm_hisi_uncore_free_pcc_chan(void *data)
> +{
> +	hisi_uncore_free_pcc_chan(data);
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
> +	int rc;
> +
> +	uncore->chan_id = -1;
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     hisi_uncore_pcc_reg_scan, uncore);
> +	if (ACPI_FAILURE(status) || uncore->chan_id < 0) {
> +		dev_err(uncore->dev, "Failed to get a PCC channel\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = hisi_uncore_request_pcc_chan(uncore);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(uncore->dev,
> +					devm_hisi_uncore_free_pcc_chan,
> +					uncore);
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
> +	if (!pchan)
> +		return -ENODEV;
> +
> +	addr = (struct hisi_uncore_pcc_shmem __iomem *)pchan->shmem;
> +	if (!addr)
> +		return -EINVAL;
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
Why explicitly set status?  Just leave the c spec defined setting
of other fields to do that maybe?

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

goto not doing anything here...

I'd be tempted to use an else if (status & PCC_STATUS_ERROR)
and get rid of the label entirely.


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

	*profile = (struct devfreq_dev_profile) {
		.initial_freq = ...
etc
	};
makes this sort of fill things in code easier to read.

> +
> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_MODE, &data);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to get operate mode (%d)\n", rc);

return dev_err_probe(); and similar places.

> +		return rc;
> +	}
> +
> +	if (data == HUCF_MODE_PLATFORM)
> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
> +					  hisi_platform_governor.name, NULL);
> +	else
> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
> +					  DEVFREQ_GOV_PERFORMANCE, NULL);
> +	if (IS_ERR(uncore->devfreq)) {
> +		dev_err(uncore->dev, "Failed to add devfreq device\n");
> +		return PTR_ERR(uncore->devfreq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_uncore_mark_related_cpus(struct hisi_uncore_freq *uncore,
> +				 char *property, int (*get_topo_id)(int cpu),
> +				 const struct cpumask *(*get_cpumask)(int cpu))
> +{
> +	unsigned int i, cpu;
> +	size_t len;
> +	u32 *num;
> +	int rc;
> +
> +	rc = device_property_count_u32(uncore->dev, property);
> +	if (rc < 0)
> +		return rc;
> +	if (rc == 0)
> +		return -EINVAL;
> +
> +	len = rc;
> +	num = kcalloc(len, sizeof(*num), GFP_KERNEL);
Freed in all path so include cleanup.h and use

	u32 *num __free(kfree) = kcalloc(len, ..

and no need for goto as it'll get freed automagically.


> +	if (!num)
> +		return -ENOMEM;
> +
> +	rc = device_property_read_u32_array(uncore->dev, property, num, len);
> +	if (rc)
> +		goto out;
> +
> +	for (i = 0; i < len; i++) {
> +		for_each_possible_cpu(cpu) {
> +			if (get_topo_id(cpu) == num[i]) {
> +				cpumask_or(&uncore->related_cpus,
> +					   &uncore->related_cpus,
> +					   get_cpumask(cpu));
> +				break;
> +			}
> +		}
> +	}
> +
> +out:
> +	kfree(num);
> +
> +	return rc;
> +}
> +

> +static ssize_t related_cpus_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_uncore_freq *uncore = dev_get_drvdata(dev->parent);
> +
> +	return cpumap_print_to_pagebuf(true, buf, &uncore->related_cpus);
> +}
> +
> +DEVICE_ATTR_RO(related_cpus);
> +
> +static struct device_attribute *attr_group[] = {
> +	&dev_attr_related_cpus,
> +	NULL,

No comma on a terminating NULL. We don't want it to be easy to stick
things afterwards.

> +};
> +
> +static void hisi_uncore_remove_dev_interface(struct hisi_uncore_freq *uncore)
> +{
> +	struct device_attribute **attr = attr_group;
> +
> +	while (attr && *attr) {
> +		device_remove_file(&uncore->devfreq->dev, *attr);
> +		attr++;
With dev_groups approach you shouldn't need anything manual for this.

> +	}
> +}
> +
> +static void devm_hisi_uncore_remove_dev_interface(void *data)
> +{
> +	hisi_uncore_remove_dev_interface(data);
> +}
> +
> +static int hisi_uncore_init_dev_interface(struct hisi_uncore_freq *uncore)
> +{
> +	struct device_attribute **attr = attr_group;
> +	int rc;
> +
> +	rc = hisi_uncore_mark_related_cpus_wrap(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to mark related cpus (%d)\n", rc);
> +		return rc;

return dev_err_probe() as below.

> +	}
> +
> +	while (attr && *attr) {

How would attr not be true?

> +		rc = device_create_file(&uncore->devfreq->dev, *attr);

Normally we do a lot to avoid device_create_file as it causes
races with udev - it's unusual to add attributes directly to a platform
device from a driver... Why does it need to happen here?
Can use use dev_groups in the platform_driver.driver instead?


> +		if (rc) {
> +			hisi_uncore_remove_dev_interface(uncore);
> +			return rc;
> +		}
> +		attr++;
> +	}
> +
> +	return devm_add_action_or_reset(uncore->dev,
> +					devm_hisi_uncore_remove_dev_interface,
> +					uncore);
> +}
> +
> +static int hisi_uncore_freq_probe(struct platform_device *pdev)
> +{
> +	struct hisi_uncore_freq *uncore;
> +	u32 cap;
> +	int rc;
> +
> +	uncore = devm_kzalloc(&pdev->dev, sizeof(*uncore), GFP_KERNEL);

I'd define

	struct device *dev = &pdev->dev;

and use that for all the places you have pdev->dev or uncore->dev
Slightly shorter lines in lots of places.

> +	if (!uncore)
> +		return -ENOMEM;
> +
> +	uncore->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, uncore);
> +
> +	rc = hisi_uncore_init_pcc_chan(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to init PCC channel (%d)", rc);
> +		return rc;

Might as well use

		return dev_err_probe(dev, rc, "Failed to init PCC channel\n");

Should have \n on error messages really. (they get fixed up if you don't
but convention is have it still I think).

dev_err_probe() just pretty prints the return value and saves a bunch of
code by allowing you to return it's return value.

Use it for every case of dev_err that is only called from probe.

> +	}
> +
> +	rc = hisi_uncore_init_opp(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to init OPP (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_CAP, &cap);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to get capability (%d)\n", rc);
> +		return rc;
> +	}
> +	uncore->cap = cap;
> +
> +	rc = hisi_uncore_add_platform_gov(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to add hisi_platform governor (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = hisi_uncore_devfreq_register(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to register devfreq (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = hisi_uncore_init_dev_interface(uncore);
> +	if (rc) {
> +		dev_err(uncore->dev, "Failed to init custom device interfaces (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id hisi_uncore_freq_acpi_match[] = {
> +	{ "HISI04F1", },
> +	{ },

No need for that trailing comma on a terminating entry.

> +};
> +MODULE_DEVICE_TABLE(acpi, hisi_uncore_freq_acpi_match);
> +
> +static struct platform_driver hisi_uncore_freq_drv = {
> +	.probe	= hisi_uncore_freq_probe,
> +	.driver = {
> +		.name	= "hisi_uncore_freq",

No point in using a tab if it doesn't align with anything else!
(generally I dislike trying to force alignment, but here it's really pointless!)

> +		.acpi_match_table = hisi_uncore_freq_acpi_match,
> +	},
> +};
> +module_platform_driver(hisi_uncore_freq_drv);
> +
> +MODULE_DESCRIPTION("HiSilicon uncore frequency scaling driver");
> +MODULE_AUTHOR("Jie Zhan <zhanjie9@hisilicon.com>");
> +MODULE_LICENSE("GPL");


