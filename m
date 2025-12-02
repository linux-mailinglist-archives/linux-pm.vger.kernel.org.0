Return-Path: <linux-pm+bounces-39084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0FC9BF70
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6783A91DC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69125D546;
	Tue,  2 Dec 2025 15:31:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB22725A338
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689512; cv=none; b=mEl0id8Hwlm4krt41Uuy8E6DtcB1w8IUS9HnNRA/VCFnZh+jWnkIN2N8VfaRdkBeWvCAyt4BBrhY4SkEYD9AseGNslFKor/4yXuyMPFIy69K7k/3alVMPnRZGaRdjj/P58jksuNrSgm5vuNZLzdd4Qhxnx6GnO7PKlZ43Bpbl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689512; c=relaxed/simple;
	bh=+Z7QSyFsn+EJDzp+U1QZ7QZSCcvRgHbeLZRY2fCBkUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtSkTgL2taV1DX5G0lM33qP70Z7ayql1zpKYauGrxBHtmAFCIO+HAm9sYw0KHc3M3PrpUb5zLcNzgcxSRk6Sluzu1yO7OsfpmgWSlM7Kup2h1ZcvawfMIPT83jHAhLZBBa6wsIug4msZIXKI9T/MY9edHXWKeSnP+M5N24xnmRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD1D1477;
	Tue,  2 Dec 2025 07:31:41 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BED73F66E;
	Tue,  2 Dec 2025 07:31:42 -0800 (PST)
Date: Tue, 2 Dec 2025 16:31:48 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	gregkh@linuxfoundation.org, dakr@kernel.org,
	ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
Message-ID: <aS8GZOuaS1-j14MD@arm.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <aS2z0EURwHbbGZab@arm.com>
 <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>

On Tue, Dec 02, 2025 at 11:05:25AM +0800, zhenglifeng (A) wrote:
> On 2025/12/1 23:27, Beata Michalska wrote:
> > Hi,
> > 
> > Apologies for the delay in reviewing this - currently in progress....
> > Out of curiosity: what's the cpufreq driver used for testing this series ?
> 
> I used cppc_cpufreq for testing this. But with some modifications in
> processor_driver.c, or you'll find that the driver will fail to load with
> maxcpus set. The modification below is only a temporary solution. I'm still
> working on that.
>
Right, so overall the implementation looks good - thanks for that.
There are two issues though with the cppc cpufreq driver.

One: as you have already noticed - it fails to register when
cpumask_present != cpumask_online.

Second: it will mix the sources of the freq scale if not all CPUs within the
policy have AMUs enabled/valid. This is due to the fact that at the time of
registering the driver and initializing the FIE support policy->cpus ==
policy->related_cpus. Assuming scenario when there are two CPUs within the
policy, one being offline and missing valid AMU counters,
the topology_set_scale_freq_source from cppc cpufreq driver will register
the tick handler for both CPUs, whereas AMU support will (rightly so) register
only for the firs one. When the second CPU comes online, the mismatch will be
detected and the arch callback will get cleared for the first CPU, but the
second one will remain unchanged.

That said, I do not think any of those issues is a blocker for this series.
But both would need fixing.

---
BR
Beata


> ---
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 5d824435b26b..2f286a1b0b02 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
>  MODULE_LICENSE("GPL");
>  
> +static int acpi_processor_start(struct device *dev);
>  static int acpi_processor_stop(struct device *dev);
>  
>  static const struct acpi_device_id processor_device_ids[] = {
> @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver = {
>  	.name = "processor",
>  	.bus = &cpu_subsys,
>  	.acpi_match_table = processor_device_ids,
> +	.probe = acpi_processor_start,
>  	.remove = acpi_processor_stop,
>  };
>  
> @@ -191,6 +193,21 @@ static int __acpi_processor_start(struct acpi_device *device)
>  	return result;
>  }
>  
> +static int acpi_processor_start(struct device *dev)
> +{
> +	struct acpi_device *device = ACPI_COMPANION(dev);
> +	int ret;
> +
> +	if (!device)
> +		return -ENODEV;
> +
> +	/* Protect against concurrent CPU hotplug operations */
> +	cpu_hotplug_disable();
> +	ret = __acpi_processor_start(device);
> +	cpu_hotplug_enable();
> +	return ret;
> +}
> +
>  static int acpi_processor_stop(struct device *dev)
>  {
>  	struct acpi_device *device = ACPI_COMPANION(dev);
> @@ -264,9 +281,9 @@ static int __init acpi_processor_driver_init(void)
>  
>  	acpi_processor_register_idle_driver();
>  
> -	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> -				   "acpi/cpu-drv:online",
> -				   acpi_soft_cpu_online, NULL);
> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					   "acpi/cpu-drv:online",
> +					   acpi_soft_cpu_online, NULL);
>  	if (result < 0)
>  		goto err;
>  	hp_online = result;
> 
> > 
> > ---
> > BR
> > Beata
> > On Wed, Nov 19, 2025 at 04:13:53PM +0800, Lifeng Zheng wrote:
> >> Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
> >> even though they're eligible.
> >>
> >>
> > 
> 

