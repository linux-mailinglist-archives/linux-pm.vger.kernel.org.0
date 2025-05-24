Return-Path: <linux-pm+bounces-27623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8FAC2EA4
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0416A21C49
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA416F0FE;
	Sat, 24 May 2025 09:55:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4024690
	for <linux-pm@vger.kernel.org>; Sat, 24 May 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748080509; cv=none; b=q8O06oOhXBZfoEKYOewZh1VXKVBw1TY1ZwSzTd7bxdyClHrHafruZ/f0dJ5HlshUHjlUcc1y8MVKzhOmFDFTNNyyl8B5c9FBJfTp4ZI0RiXX5+y8VzDuTAwvMKu0R+ZhEdwjOgsuJ1BGh0atILGcCGgTqZuK3bI1YL11PBlOR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748080509; c=relaxed/simple;
	bh=CEX1z2hqHxe8QOUfyVvOcKSNgDkyXdy5M1TzWfeWvm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PcyB2Bpx4L2wMMWy6IbkYQiPGXKGhs0aU/QCx5rSHa1QmFxmBCUkKBhE0T9bQ5BmZ4BgdaOTnf49KfzxIjLphW0Cy9pydgaBdG9LY089R+PF8PvzVNZz7BBy2ze1y/bw7Qr/prUdf88xFpGte5v3agSBS9ODdKllZxAx/JGKgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4b4HNJ1N6qz2CdX3;
	Sat, 24 May 2025 17:51:12 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A6091402C3;
	Sat, 24 May 2025 17:54:55 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 May
 2025 17:54:54 +0800
Message-ID: <595f2574-4ee8-9684-7692-757bfe9c9cd1@hisilicon.com>
Date: Sat, 24 May 2025 17:54:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3] PM / devfreq: Add HiSilicon uncore frequency scaling
 driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <linuxarm@huawei.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <alireza.sanaee@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<liwei728@huawei.com>, <prime.zeng@hisilicon.com>
References: <20250521104956.2780150-1-zhanjie9@hisilicon.com>
 <20250521192842.0000251b@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250521192842.0000251b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Thanks a lot for reviewing!

On 22/05/2025 02:29, Jonathan Cameron wrote:
> On Wed, 21 May 2025 18:49:56 +0800
> Jie Zhan <zhanjie9@hisilicon.com> wrote:
> 
>> Add the HiSilicon uncore frequency scaling driver for Kunpeng SoCs based on
>> the devfreq framework.  The uncore domain contains shared computing
>> resources, including system interconnects and L3 cache.  The uncore
>> frequency significantly impacts the system-wide performance as well as
>> power consumption.  This driver adds support for runtime management of
>> uncore frequency from kernel and userspace.  The main function includes
>> setting and getting frequencies, changing frequency scaling policies, and
>> querying the list of CPUs whose performance is significantly related to
>> this uncore frequency domain, etc.  The driver communicates with a platform
>> controller through an ACPI PCC mailbox to take the actual actions of
>> frequency scaling.
>>
>> Co-developed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> 
> Minor comments inline.
> 
> Is the userspace ABI documented already?

The common devfreq sysfs ABIs are documented in
Documentation/ABI/testing/sysfs-class-devfreq.

This driver adds a custom sysfs file 'related_cpus' to indicate userspace
that the performance of these cpus is closely related to this uncore freq
domain.
Will update that in the doc in v4.

> 
>> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
>> new file mode 100644
>> index 000000000000..1e9ee4827c3f
>> --- /dev/null
>> +++ b/drivers/devfreq/hisi_uncore_freq.c
> 
>> +/* PCC channel timeout = PCC nominal latency * NUM */
>> +#define HUCF_PCC_POLL_TIMEOUT_NUM	1000
>> +#define HUCF_PCC_POLL_INTERVAL_US	5
>> +
>> +/* Default polling interval in ms for devfreq governors*/
>> +#define DEFAULT_POLLING_MS 100
>> +
>> +static int hisi_uncore_request_pcc_chan(struct hisi_uncore_freq *uncore)
>> +{
>> +	struct pcc_mbox_chan *pcc_chan;
>> +	int rc;
>> +
>> +	uncore->cl = (struct mbox_client) {
>> +		.dev = uncore->dev,
>> +		.tx_block = false,
>> +		.knows_txdone = true,
>> +	};
>> +
>> +	pcc_chan = pcc_mbox_request_channel(&uncore->cl, uncore->chan_id);
>> +	if (IS_ERR(pcc_chan)) {
>> +		dev_err(uncore->dev, "Failed to request PCC channel %u\n",
>> +			uncore->chan_id);
>> +		return PTR_ERR(pcc_chan);
>> +	}
>> +
>> +	if (!pcc_chan->shmem_base_addr) {
>> +		dev_err(uncore->dev, "Invalid PCC shared memory address\n");
>> +		rc = -EINVAL;
>> +		goto err_pcc_chan_free;
>> +	}
>> +
>> +	if (pcc_chan->shmem_size < sizeof(struct hisi_uncore_pcc_shmem)) {
>> +		dev_err(uncore->dev, "Invalid PCC shared memory size (%lluB)\n",
>> +			pcc_chan->shmem_size);
>> +		rc = -EINVAL;
>> +		goto err_pcc_chan_free;
>> +	}
>> +
>> +	mutex_init(&uncore->pcc_lock);
> For new code maybe use
> 	rc = devm_mutex_init()
> 	if (rc)
> 		goto err_pcc_chan_free;
> 

Done

>> +	uncore->pchan = pcc_chan;
>> +
>> +	return 0;
>> +
>> +err_pcc_chan_free:
>> +	pcc_mbox_free_channel(pcc_chan);
>> +
>> +	return rc;
>> +}
>> +
>> +static void hisi_uncore_free_pcc_chan(struct hisi_uncore_freq *uncore)
> If only called from devm don't bother with separate function.
>> +{
>> +	if (uncore->pchan) {
> 
> Given nothing to do if this isn't set, why register the cleanup if it isn't?
> 

This should be deleted since v2.
Removed in v4 now.

>> +		guard(mutex)(&uncore->pcc_lock);
>> +		pcc_mbox_free_channel(uncore->pchan);
>> +		uncore->pchan = NULL;
>> +	}
>> +}
>> +
>> +static void devm_hisi_uncore_free_pcc_chan(void *data)
>> +{
>> +	hisi_uncore_free_pcc_chan(data);
>> +}
>> +
>> +static acpi_status hisi_uncore_pcc_reg_scan(struct acpi_resource *res,
>> +					    void *ctx)
>> +{
>> +	struct acpi_resource_generic_register *reg;
>> +	struct hisi_uncore_freq *uncore;
>> +
>> +	if (!res || res->type != ACPI_RESOURCE_TYPE_GENERIC_REGISTER)
>> +		return AE_OK;
>> +
>> +	reg = &res->data.generic_reg;
>> +	if (reg->space_id != ACPI_ADR_SPACE_PLATFORM_COMM)
>> +		return AE_OK;
>> +
>> +	if (!ctx)
>> +		return AE_ERROR;
>> +
>> +	uncore = ctx;
>> +	/* PCC subspace ID stored in Access Size */
>> +	uncore->chan_id = reg->access_size;
>> +
>> +	return AE_CTRL_TERMINATE;
>> +}
>> +
>> +static int hisi_uncore_init_pcc_chan(struct hisi_uncore_freq *uncore)
>> +{
>> +	acpi_handle handle = ACPI_HANDLE(uncore->dev);
>> +	acpi_status status;
>> +	int rc;
>> +
>> +	uncore->chan_id = -1;
>> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>> +				     hisi_uncore_pcc_reg_scan, uncore);
>> +	if (ACPI_FAILURE(status) || uncore->chan_id < 0) {
>> +		dev_err(uncore->dev, "Failed to get a PCC channel\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = hisi_uncore_request_pcc_chan(uncore);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return devm_add_action_or_reset(uncore->dev,
>> +					devm_hisi_uncore_free_pcc_chan,
>> +					uncore);
>> +}
>> +
>> +static int hisi_uncore_cmd_send(struct hisi_uncore_freq *uncore,
>> +				u8 cmd, u32 *data)
>> +{
>> +	struct hisi_uncore_pcc_shmem __iomem *addr;
>> +	struct hisi_uncore_pcc_shmem shmem;
>> +	struct pcc_mbox_chan *pchan;
>> +	unsigned int mrtt;
>> +	s64 time_delta;
>> +	u16 status;
>> +	int rc;
>> +
>> +	guard(mutex)(&uncore->pcc_lock);
>> +
>> +	pchan = uncore->pchan;
>> +	if (!pchan)
>> +		return -ENODEV;
>> +
>> +	addr = (struct hisi_uncore_pcc_shmem __iomem *)pchan->shmem;
>> +	if (!addr)
>> +		return -EINVAL;
>> +
>> +	/* Handle the Minimum Request Turnaround Time (MRTT) */
>> +	mrtt = pchan->min_turnaround_time;
>> +	time_delta = ktime_us_delta(ktime_get(),
>> +				    uncore->last_cmd_cmpl_time);
>> +	if (mrtt > time_delta)
>> +		udelay(mrtt - time_delta);
>> +
>> +	/* Copy data */
>> +	shmem.head = (struct acpi_pcct_shared_memory) {
>> +		.signature = PCC_SIGNATURE | uncore->chan_id,
>> +		.command = cmd,
>> +		.status = 0,
> Why explicitly set status?  Just leave the c spec defined setting
> of other fields to do that maybe?
> 

Sure.

>> +	};
>> +	shmem.pcc_data.data = *data;
>> +	memcpy_toio(addr, &shmem, sizeof(shmem));
>> +
>> +	/* Ring doorbell */
>> +	rc = mbox_send_message(pchan->mchan, &cmd);
>> +	if (rc < 0) {
>> +		dev_err(uncore->dev, "Failed to send mbox message, %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	/* Wait status */
>> +	rc = readw_poll_timeout(&addr->head.status, status,
>> +				status & (PCC_STATUS_CMD_COMPLETE |
>> +					  PCC_STATUS_ERROR),
>> +				HUCF_PCC_POLL_INTERVAL_US,
>> +				pchan->latency * HUCF_PCC_POLL_TIMEOUT_NUM);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "PCC channel response timeout, cmd=%u\n", cmd);
>> +		goto exit;
>> +	}
>> +
>> +	if (status & PCC_STATUS_ERROR) {
>> +		dev_err(uncore->dev, "PCC cmd error, cmd=%u\n", cmd);
>> +		rc = -EIO;
>> +		goto exit;
> 
> goto not doing anything here...
> 
> I'd be tempted to use an else if (status & PCC_STATUS_ERROR)
> and get rid of the label entirely.
> 
> 

Yeah that looks more sensible.
Done.

>> +	}
>> +
>> +exit:
>> +	uncore->last_cmd_cmpl_time = ktime_get();
>> +
>> +	/* Copy data back */
>> +	memcpy_fromio(data, &addr->pcc_data.data, sizeof(*data));
>> +
>> +	/* Clear mailbox active req */
>> +	mbox_client_txdone(pchan->mchan, rc);
>> +
>> +	return rc;
>> +}
> 
>> +static int hisi_uncore_devfreq_register(struct hisi_uncore_freq *uncore)
>> +{
>> +	struct devfreq_dev_profile *profile;
>> +	unsigned long freq;
>> +	u32 data;
>> +	int rc;
>> +
>> +	rc = hisi_uncore_get_cur_freq(uncore->dev, &freq);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to get plat init freq (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	profile = devm_kzalloc(uncore->dev, sizeof(*profile), GFP_KERNEL);
>> +	if (!profile)
>> +		return -ENOMEM;
>> +
>> +	profile->initial_freq = freq;
>> +	profile->polling_ms = DEFAULT_POLLING_MS;
>> +	profile->timer = DEVFREQ_TIMER_DELAYED;
>> +	profile->target = hisi_uncore_target;
>> +	profile->get_dev_status = hisi_uncore_get_dev_status;
>> +	profile->get_cur_freq = hisi_uncore_get_cur_freq;
> 
> 	*profile = (struct devfreq_dev_profile) {
> 		.initial_freq = ...
> etc
> 	};
> makes this sort of fill things in code easier to read.
> 

Done.

>> +
>> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_MODE, &data);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to get operate mode (%d)\n", rc);
> 
> return dev_err_probe(); and similar places.
> 

Thanks, done for all.

>> +		return rc;
>> +	}
>> +
>> +	if (data == HUCF_MODE_PLATFORM)
>> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
>> +					  hisi_platform_governor.name, NULL);
>> +	else
>> +		uncore->devfreq = devm_devfreq_add_device(uncore->dev, profile,
>> +					  DEVFREQ_GOV_PERFORMANCE, NULL);
>> +	if (IS_ERR(uncore->devfreq)) {
>> +		dev_err(uncore->dev, "Failed to add devfreq device\n");
>> +		return PTR_ERR(uncore->devfreq);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_uncore_mark_related_cpus(struct hisi_uncore_freq *uncore,
>> +				 char *property, int (*get_topo_id)(int cpu),
>> +				 const struct cpumask *(*get_cpumask)(int cpu))
>> +{
>> +	unsigned int i, cpu;
>> +	size_t len;
>> +	u32 *num;
>> +	int rc;
>> +
>> +	rc = device_property_count_u32(uncore->dev, property);
>> +	if (rc < 0)
>> +		return rc;
>> +	if (rc == 0)
>> +		return -EINVAL;
>> +
>> +	len = rc;
>> +	num = kcalloc(len, sizeof(*num), GFP_KERNEL);
> Freed in all path so include cleanup.h and use
> 
> 	u32 *num __free(kfree) = kcalloc(len, ..
> 
> and no need for goto as it'll get freed automagically.
> 
> 

Sure. Thanks!

>> +	if (!num)
>> +		return -ENOMEM;
>> +
>> +	rc = device_property_read_u32_array(uncore->dev, property, num, len);
>> +	if (rc)
>> +		goto out;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		for_each_possible_cpu(cpu) {
>> +			if (get_topo_id(cpu) == num[i]) {
>> +				cpumask_or(&uncore->related_cpus,
>> +					   &uncore->related_cpus,
>> +					   get_cpumask(cpu));
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +out:
>> +	kfree(num);
>> +
>> +	return rc;
>> +}
>> +
> 
>> +static ssize_t related_cpus_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct hisi_uncore_freq *uncore = dev_get_drvdata(dev->parent);
>> +
>> +	return cpumap_print_to_pagebuf(true, buf, &uncore->related_cpus);
>> +}
>> +
>> +DEVICE_ATTR_RO(related_cpus);
>> +
>> +static struct device_attribute *attr_group[] = {
>> +	&dev_attr_related_cpus,
>> +	NULL,
> 
> No comma on a terminating NULL. We don't want it to be easy to stick
> things afterwards.
> 

Cool.

>> +};
>> +
>> +static void hisi_uncore_remove_dev_interface(struct hisi_uncore_freq *uncore)
>> +{
>> +	struct device_attribute **attr = attr_group;
>> +
>> +	while (attr && *attr) {
>> +		device_remove_file(&uncore->devfreq->dev, *attr);
>> +		attr++;
> With dev_groups approach you shouldn't need anything manual for this.
> 

Indeed, thanks for pointing it out.

>> +	}
>> +}
>> +
>> +static void devm_hisi_uncore_remove_dev_interface(void *data)
>> +{
>> +	hisi_uncore_remove_dev_interface(data);
>> +}
>> +
>> +static int hisi_uncore_init_dev_interface(struct hisi_uncore_freq *uncore)
>> +{
>> +	struct device_attribute **attr = attr_group;
>> +	int rc;
>> +
>> +	rc = hisi_uncore_mark_related_cpus_wrap(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to mark related cpus (%d)\n", rc);
>> +		return rc;
> 
> return dev_err_probe() as below.
> 

Done

>> +	}
>> +
>> +	while (attr && *attr) {
> 
> How would attr not be true?
> 
>> +		rc = device_create_file(&uncore->devfreq->dev, *attr);
> 
> Normally we do a lot to avoid device_create_file as it causes
> races with udev - it's unusual to add attributes directly to a platform
> device from a driver... Why does it need to happen here?
> Can use use dev_groups in the platform_driver.driver instead?
> 
> 

Yeah that makes the code cleaner and safer.  Done.

>> +		if (rc) {
>> +			hisi_uncore_remove_dev_interface(uncore);
>> +			return rc;
>> +		}
>> +		attr++;
>> +	}
>> +
>> +	return devm_add_action_or_reset(uncore->dev,
>> +					devm_hisi_uncore_remove_dev_interface,
>> +					uncore);
>> +}
>> +
>> +static int hisi_uncore_freq_probe(struct platform_device *pdev)
>> +{
>> +	struct hisi_uncore_freq *uncore;
>> +	u32 cap;
>> +	int rc;
>> +
>> +	uncore = devm_kzalloc(&pdev->dev, sizeof(*uncore), GFP_KERNEL);
> 
> I'd define
> 
> 	struct device *dev = &pdev->dev;
> 
> and use that for all the places you have pdev->dev or uncore->dev
> Slightly shorter lines in lots of places.
> 

Sure.

>> +	if (!uncore)
>> +		return -ENOMEM;
>> +
>> +	uncore->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, uncore);
>> +
>> +	rc = hisi_uncore_init_pcc_chan(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to init PCC channel (%d)", rc);
>> +		return rc;
> 
> Might as well use
> 
> 		return dev_err_probe(dev, rc, "Failed to init PCC channel\n");
> 
> Should have \n on error messages really. (they get fixed up if you don't
> but convention is have it still I think).

Yeah I missed it here.

> 
> dev_err_probe() just pretty prints the return value and saves a bunch of
> code by allowing you to return it's return value.
> 
> Use it for every case of dev_err that is only called from probe.
> 

Done.

>> +	}
>> +
>> +	rc = hisi_uncore_init_opp(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to init OPP (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_CAP, &cap);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to get capability (%d)\n", rc);
>> +		return rc;
>> +	}
>> +	uncore->cap = cap;
>> +
>> +	rc = hisi_uncore_add_platform_gov(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to add hisi_platform governor (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = hisi_uncore_devfreq_register(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to register devfreq (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = hisi_uncore_init_dev_interface(uncore);
>> +	if (rc) {
>> +		dev_err(uncore->dev, "Failed to init custom device interfaces (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id hisi_uncore_freq_acpi_match[] = {
>> +	{ "HISI04F1", },
>> +	{ },
> 
> No need for that trailing comma on a terminating entry.
> 

Done

>> +};
>> +MODULE_DEVICE_TABLE(acpi, hisi_uncore_freq_acpi_match);
>> +
>> +static struct platform_driver hisi_uncore_freq_drv = {
>> +	.probe	= hisi_uncore_freq_probe,
>> +	.driver = {
>> +		.name	= "hisi_uncore_freq",
> 
> No point in using a tab if it doesn't align with anything else!
> (generally I dislike trying to force alignment, but here it's really pointless!)
> 

Yeah.  Actually that's not my intention.  That might be a misclick :D

>> +		.acpi_match_table = hisi_uncore_freq_acpi_match,
>> +	},
>> +};
>> +module_platform_driver(hisi_uncore_freq_drv);
>> +
>> +MODULE_DESCRIPTION("HiSilicon uncore frequency scaling driver");
>> +MODULE_AUTHOR("Jie Zhan <zhanjie9@hisilicon.com>");
>> +MODULE_LICENSE("GPL");
> 

