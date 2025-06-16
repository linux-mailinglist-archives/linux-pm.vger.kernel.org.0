Return-Path: <linux-pm+bounces-28797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A017BADAC01
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA610189103A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5F26D4E9;
	Mon, 16 Jun 2025 09:35:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFF1DB92A
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066547; cv=none; b=muNuqK/6y+UhYGJ0O1b4FsDD5PUfqq+3MPwsJJ4AZ5FdmH3u4ZkyDyopo4WmxI4jJwLHi27QmN+4EgeBedRH7/6llTEbijJ6WKshWBtGvMp73ZhoKbF1WzKn7pt/CN/HCUXGylysjA3HTZ0jrcRTj0lWFlz+/wRtAwOiWlJCbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066547; c=relaxed/simple;
	bh=/F6to937QCTaX2HBaj2QI5nWzbgJPtXb+RKFapCVG6c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jk3niL7o2zAmv6jceJhmdB9q1+IlyfZttCaNqTI2jq9IZNXLXSKcf8nz8QmHv8kKkwe8f8g8xR0EkrvJEK6RP9CU4BmqdgLzLCG2gVRHPP/OLE7vLEbfzdNSGBcMgDRVIR9aGG5Fn/QG8mLlnLSHu1zYP5cKDwNXLYpYoiTTiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLPvM1mTnz6L5LJ;
	Mon, 16 Jun 2025 17:33:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D73614050C;
	Mon, 16 Jun 2025 17:35:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 11:35:41 +0200
Date: Mon, 16 Jun 2025 10:35:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jie Zhan <zhanjie9@hisilicon.com>, <linuxarm@huawei.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add HiSilicon uncore frequency
 scaling driver
Message-ID: <20250616103447.000024dd@huawei.com>
In-Reply-To: <20250530081722.280776-3-zhanjie9@hisilicon.com>
References: <20250530081722.280776-1-zhanjie9@hisilicon.com>
	<20250530081722.280776-3-zhanjie9@hisilicon.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 16:17:22 +0800
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
Hi Zhanjie,

A few comments inline.  In general nice and clean.

I think only one that really needs a change it the one around the
CPU association firmware handling.

Jonathan


> ---
>  Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>  drivers/devfreq/Kconfig                       |  11 +
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/hisi_uncore_freq.c            | 656 ++++++++++++++++++
>  4 files changed, 677 insertions(+)
>  create mode 100644 drivers/devfreq/hisi_uncore_freq.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 1e7e0bb4c14e..fed95bb0bb6d 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -132,3 +132,12 @@ Description:
>  
>  		A list of governors that support the node:
>  		- simple_ondemand
> +
> +What:		/sys/class/devfreq/.../related_cpus
> +Date:		June 2025
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:	The list of CPUs whose performance is closely related to the
> +		frequency of this devfreq domain.
> +
> +		This file is only present if the hisi_uncore_freq driver is in
> +		use.

Unless this last statement was requested by another reviewer, I'd change it for
something more generic to allow it to be used by other drivers.  Something like

		This file is only present if a specific device has a close association
		with a subset of the CPUs.


> diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
> new file mode 100644
> index 000000000000..7e1b7f48d0f4
> --- /dev/null
> +++ b/drivers/devfreq/hisi_uncore_freq.c


> +enum hisi_uncore_freq_mode {
> +	HUCF_MODE_PLATFORM = 0,
> +	HUCF_MODE_OS,
> +	HUCF_MODE_MAX,

I assume these max entries are terminators?  I.e. nothing should ever
come after them?  If so you could drop the commas to make that explicit.

> +};
> +
> +#define HUCF_CAP_PLATFORM_CTRL	BIT(0)

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

Fits on one line under 80 chars.

> +	if (mrtt > time_delta)
> +		udelay(mrtt - time_delta);


> +
> +static int hisi_uncore_init_opp(struct hisi_uncore_freq *uncore)
> +{
> +	struct device *dev = uncore->dev;
> +	u32 data = 0, num, index;

Trivial personal preference. Don't mix assignment and no
assignment declarations.  It's every so slightly harder to read.

> +	unsigned long freq_mhz;
> +	int rc;
> +
> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_PLAT_FREQ_NUM,
> +				  &data);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "Failed to get plat freq num\n");
> +
> +	num = data;
> +
> +	for (index = 0; index < num; index++) {
> +		data = index;
> +		rc = hisi_uncore_cmd_send(uncore,
> +					  HUCF_PCC_CMD_GET_PLAT_FREQ_BY_IDX,
> +					  &data);
> +		if (rc) {
> +			dev_pm_opp_remove_all_dynamic(dev);
> +			return dev_err_probe(dev, rc,
> +				"Failed to get plat freq at index %u\n", index);
> +		}
> +		freq_mhz = data;
> +
> +		/* Don't care OPP votlage, take 1V as default */
voltage

Spell check in case I missed others.  A W=1 build tends to catch the simple ones
like this.

> +		rc = dev_pm_opp_add(dev, freq_mhz * HZ_PER_MHZ, 1000000);
> +		if (rc) {
> +			dev_pm_opp_remove_all_dynamic(dev);
> +			return dev_err_probe(dev, rc,
> +				"Add OPP %lu failed\n", freq_mhz);
> +		}
> +	}
> +
> +	return devm_add_action_or_reset(dev, devm_hisi_uncore_remove_opp, uncore);
Hmm. I'm normally a fan of registering these after the calls, but this is one
of the rare cases where pushing it before (with a comment) cleans up the code.

If you do that, then all the error cases in the loop just need to return and not
call the cleanup manually.

> +}

> +
> +static int hisi_platform_gov_handler(struct devfreq *df, unsigned int event,
> +				     void *val)
> +{
> +	struct hisi_uncore_freq *uncore = dev_get_drvdata(df->dev.parent);
> +	int rc = 0;
> +	u32 data;
> +
> +	if (WARN_ON(!uncore || !uncore->pchan))
> +		return -ENODEV;
> +
> +	switch (event) {
> +	case DEVFREQ_GOV_START:
> +		data = HUCF_MODE_PLATFORM;
> +		rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_MODE, &data);
> +		break;
> +	case DEVFREQ_GOV_STOP:
> +		data = HUCF_MODE_OS;
> +		rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_MODE, &data);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (rc)
> +		dev_err(uncore->dev, "Failed to set operate mode (%d)\n", rc);

Trivial: I'd push this up into the two case statements (with early returns) as then
you can also report what mode you were trying to set in the string.

> +
> +	return rc;
> +}

> +
> +static int hisi_uncore_add_platform_gov(struct hisi_uncore_freq *uncore)
> +{
> +	int rc = 0;

Initialized in only path where it's used.  Maybe push this
declaration down to if (hisi_platform_gov_usage() block 

> +
> +	if (!(uncore->cap & HUCF_CAP_PLATFORM_CTRL))
> +		return 0;
> +
> +	guard(mutex)(&hisi_platform_gov_usage_lock);
> +
> +	if (hisi_platform_gov_usage == 0) {
> +		rc = devfreq_add_governor(&hisi_platform_governor);

		int rc = devfreq....

> +		if (rc)
> +			return rc;
> +	}
> +	hisi_platform_gov_usage++;
> +
> +	return devm_add_action_or_reset(uncore->dev,
> +					devm_hisi_uncore_remove_platform_gov,
> +					uncore);
> +}
> +
> +static int hisi_uncore_mark_related_cpus(struct hisi_uncore_freq *uncore,
> +				 char *property, int (*get_topo_id)(int cpu),
> +				 const struct cpumask *(*get_cpumask)(int cpu))
> +{
> +	unsigned int i, cpu;
> +	size_t len;
> +	int rc;
> +
> +	rc = device_property_count_u32(uncore->dev, property);
> +	if (rc < 0)
> +		return rc;
Most of the errors here don't reflect it not being found and are things
were we should probably fail the driver probe (so someone can fix whatever
is wrong with the firmware.)  I think only -EINVAL means not here
(technically arguments are not valid)

> +	if (rc == 0)
> +		return -EINVAL;
> +
> +	len = rc;
> +	u32 *num __free(kfree) = kcalloc(len, sizeof(*num), GFP_KERNEL);
> +	if (!num)
> +		return -ENOMEM;

On this failure path, falling over the other route below doesn't make much sense.

> +
> +	rc = device_property_read_u32_array(uncore->dev, property, num, len);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < len; i++) {
> +		for_each_possible_cpu(cpu) {
> +			if (get_topo_id(cpu) == num[i]) {

You could flip to reduce indent.  Marginal though so up to you and definitely
not worth another spin.

			if (get_topo_id(cpu) != num[i])
				continue;

			cpumask_or(&uncore->related_cpus, &uncore->related_cpus,
				   get_cpumask(cpu));
			break;

> +				cpumask_or(&uncore->related_cpus,
> +					   &uncore->related_cpus,
> +					   get_cpumask(cpu));
> +				break;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_package_id(int cpu)
> +{
> +	return topology_physical_package_id(cpu);
> +}
> +
> +static const struct cpumask *get_package_cpumask(int cpu)
> +{
> +	return topology_core_cpumask(cpu);
> +}
> +
> +static int get_cluster_id(int cpu)
> +{
> +	return topology_cluster_id(cpu);
> +}
> +
> +static const struct cpumask *get_cluster_cpumask(int cpu)
> +{
> +	return topology_cluster_cpumask(cpu);
> +}
> +
> +static int hisi_uncore_mark_related_cpus_wrap(struct hisi_uncore_freq *uncore)
> +{
> +	int rc;
> +
> +	cpumask_clear(&uncore->related_cpus);
> +
> +	rc = hisi_uncore_mark_related_cpus(uncore, "related-package",
> +					   get_package_id,
> +					   get_package_cpumask);
> +	if (rc == 0)
> +		return rc;

return 0;  might make it a tiny bit more explicit that this is a good path.
Maybe a comment in here on why that is a good path.
I think this is trying one then the other and only one is expected to be
present?  Perhaps be a little more paranoid here and check what was seen was
-EINVAL.

	if (rc != -EINVAL)
		return rc; /* May be 0 or another error code */

Perhaps with an ACPI snippet in the patch description to illustrate what
is going on here.


> +
> +	return hisi_uncore_mark_related_cpus(uncore, "related-cluster",
> +					     get_cluster_id,
> +					     get_cluster_cpumask);
> +}

> +static int hisi_uncore_devfreq_register(struct hisi_uncore_freq *uncore)
> +{
> +	struct devfreq_dev_profile *profile;
> +	struct device *dev = uncore->dev;
> +	unsigned long freq;
> +	u32 data;
> +	int rc;
> +
> +	rc = hisi_uncore_get_cur_freq(dev, &freq);
One for another day:
Whilst we do indeed need to do this, it seems like a small optimization to
devfreq would be to check for initial_freq == 0 and if it is try get_cur_freq()
after registration. Mind you I checked and this only seems to apply to
the imx drivers and this one.

> +	if (rc)
> +		return dev_err_probe(dev, rc, "Failed to get plat init freq\n");
> +
> +	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
> +	if (!profile)
> +		return -ENOMEM;
> +
> +	*profile = (struct devfreq_dev_profile) {
> +		.initial_freq = freq,
> +		.polling_ms = HUCF_DEFAULT_POLLING_MS,
> +		.timer = DEVFREQ_TIMER_DELAYED,
> +		.target = hisi_uncore_target,
> +		.get_dev_status = hisi_uncore_get_dev_status,
> +		.get_cur_freq = hisi_uncore_get_cur_freq,
> +		.dev_groups = hisi_uncore_freq_groups,
> +	};
> +
> +	rc = hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_GET_MODE, &data);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "Failed to get operate mode\n");
> +
> +	if (data == HUCF_MODE_PLATFORM)
> +		uncore->devfreq = devm_devfreq_add_device(dev, profile,
> +					  hisi_platform_governor.name, NULL);
> +	else
> +		uncore->devfreq = devm_devfreq_add_device(dev, profile,
> +					  DEVFREQ_GOV_PERFORMANCE, NULL);
> +	if (IS_ERR(uncore->devfreq))
> +		return dev_err_probe(dev, PTR_ERR(uncore->devfreq),
> +			"Failed to add devfreq device\n");
> +
> +	return 0;
> +}


