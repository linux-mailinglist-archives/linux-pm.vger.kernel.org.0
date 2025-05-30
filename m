Return-Path: <linux-pm+bounces-27857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91FAC8C58
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D5816EA65
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC0223DF9;
	Fri, 30 May 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jG22c/7v"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C008223705;
	Fri, 30 May 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601865; cv=none; b=X6OdvX1XpQUzWmlrK42z+zYXiarZbis8QEgrevAtpNDW8+qbgHynbSGqQSvXcklX71J5WPcBRMWwuuLZdLqvsnKbAlCyI7wnEx6/brkhehfRiIEqRa8qEPm/shEpi6M+0INGfHimcjugyg8/wYEHkGu/kndUOefGdNmufQetHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601865; c=relaxed/simple;
	bh=5p4XWsx0jf6NSKCj+C+Da3cl/O0ML/Hef265T22onPQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E34MdFqr8t0mp21xNIJ7k8NgRFCKHhpio2k1es1/NO4K+deHJ3ICzNWBFW9GmxzTLrIY6BODWLGgahF/L0pyX82n1eW/DXaQoXE9ksCPbcUAbY8mBUfDpEBzYdsQqm5RHSwg8a5OOlXEqir2xU4xmTadgCKz3vcgbMYWdD7yjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jG22c/7v; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54UAiEwv3855647;
	Fri, 30 May 2025 05:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748601854;
	bh=6PT0MJjr6h+sjKtj45n5Ffv1RGeDB0XEv19iMD9iMQI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jG22c/7vTLxuFatEBkh800+/XGXG4wsKFtJdoJubj017uUYbfs6RvVmsbCcK+DX48
	 9QXiefzIvbpXHSFLZ49tr7cLGHWlVLLbvussUhfgQMJ6dzToSExsg6TEJB4/Mr6rRM
	 PAsQS4uRpGCNNWvzcE407c3uG/oW6qicuImhjNsw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54UAiEv02817456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 30 May 2025 05:44:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 May 2025 05:44:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 May 2025 05:44:13 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54UAiCng2997568;
	Fri, 30 May 2025 05:44:13 -0500
Date: Fri, 30 May 2025 16:14:12 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <kamlesh@ti.com>
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <20250530104412.cc73ewso5ydjhmsk@lcpd911>
References: <20250530103527.2244951-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530103527.2244951-1-d-gole@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On May 30, 2025 at 16:05:27 +0530, Dhruva Gole wrote:
> Optimize the SCMI power domain driver to only initialize domains that are
> actually referenced in the device tree. Previously, the driver would
> initialize all possible domains up to the maximum ID, which could lead to
> unnecessary firmware calls and longer probe times.
> 
> Key changes:
> - Scan device tree to identify which power domains are actually referenced
> - Use bitmap to track needed domains instead of initializing all
> - Only perform state queries and initialization for referenced domains
> - Maintain proper array sizing for power domain framework compatibility
> - Keep full provider structure to support late binding
> 
> This optimization reduces probe time and unnecessary firmware interactions
> by only initializing power domains that are actually used in the system.
> For example, in a system with 100 possible domains but only 3 referenced
> in the device tree, we now only initialize those 3 domains instead of
> all 100.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---


Adding Sudeep and a few others who I missed adding initially.

> 
> Hi all,
> The approach of doing a lazy init was briefly proposed in this [1] 2024
> Embedded Open Source talk. It was also brought up in the monthly ARM
> SCMI meetings that take place and it didn't recieve too much opposition.
> 
> This greatly helps to improve the boot time, and I have some data to
> back this up as well. This[2] experiment was done on a TI AM62L SoC
> (which is yet to make it upstream) to measure the time taken in the scmi
> pm domain probe function when it does a full 0..N scmi pd init vs just
> the ones being used in the device tree.
> 
> If you have any feedback on this, please let me know. If not, I will go
> ahead and post a "non-RFC" patch assuming everyone is mostly on board
> with this. Also request other SCMI consumers to test this out as much as
> possible to see if it breaks in any situations.
> 
> [1] https://static.sched.com/hosted_files/eoss24/2f/ARM_SCMI_Primer_Dhruva_kamlesh.pdf
> [2] https://gist.github.com/DhruvaG2000/75d6a4c31e817f56587537b022761c45
> 
> Applies cleanly on top of next-20250530, built and tested on top of the
> same
> 
> ---
> 
>  drivers/pmdomain/arm/scmi_pm_domain.c | 88 ++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 2a213c218126..8acbfe249ed2 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -10,6 +10,8 @@
>  #include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/scmi_protocol.h>
> +#include <linux/of.h>
> +
>  
>  static const struct scmi_power_proto_ops *power_ops;
>  
> @@ -47,14 +49,20 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
>  
>  static int scmi_pm_domain_probe(struct scmi_device *sdev)
>  {
> -	int num_domains, i;
>  	struct device *dev = &sdev->dev;
> -	struct device_node *np = dev->of_node;
> +	struct device_node *np;
>  	struct scmi_pm_domain *scmi_pd;
> -	struct genpd_onecell_data *scmi_pd_data;
> -	struct generic_pm_domain **domains;
> +	struct of_phandle_args args;
>  	const struct scmi_handle *handle = sdev->handle;
>  	struct scmi_protocol_handle *ph;
> +	struct genpd_onecell_data *scmi_pd_data;
> +	struct generic_pm_domain **domains;
> +	int max_id = -1;
> +	int index, num_domains;
> +	ktime_t start_time = ktime_get();
> +	unsigned long *domain_ids;
> +
> +	dev_err(dev, "Starting optimized SCMI power domain probe\n");
>  
>  	if (!handle)
>  		return -ENODEV;
> @@ -69,54 +77,90 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>  		return num_domains;
>  	}
>  
> -	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
> -	if (!scmi_pd)
> +	domain_ids = devm_bitmap_zalloc(dev, num_domains, GFP_KERNEL);
> +	if (!domain_ids)
>  		return -ENOMEM;
>  
> +	/* Find referenced domain IDs and mark them in bitmap */
> +	for_each_node_with_property(np, "power-domains") {
> +		index = 0;
> +		while (!of_parse_phandle_with_args(np, "power-domains",
> +					"#power-domain-cells",
> +					index, &args)) {
> +			if (args.args_count >= 1 && args.np == dev->of_node) {
> +				int id = args.args[0];
> +				if (id < num_domains) {
> +					set_bit(id, domain_ids);
> +					max_id = max(max_id, id);
> +					dev_dbg(dev, "Found power domain reference %d from node %pOF\n",
> +							id, np);
> +				}
> +			}
> +			of_node_put(args.np);
> +			index++;
> +		}
> +	}
> +
> +	if (max_id < 0) {
> +		dev_warn(dev, "No power domains referenced in device tree\n");
> +		/* Create provider anyway as domains might be referenced later */
> +		max_id = 0;
> +	}
> +
> +	dev_warn(dev, "Highest referenced domain ID: %d\n", max_id);
> +
>  	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
>  	if (!scmi_pd_data)
>  		return -ENOMEM;
>  
> -	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> +	domains = devm_kcalloc(dev, max_id + 1, sizeof(*domains), GFP_KERNEL);
>  	if (!domains)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < num_domains; i++, scmi_pd++) {
> +	scmi_pd = devm_kcalloc(dev, max_id + 1, sizeof(*scmi_pd), GFP_KERNEL);
> +	if (!scmi_pd)
> +		return -ENOMEM;
> +
> +	/* Initialize only referenced domains */
> +	for_each_set_bit(index, domain_ids, num_domains) {
>  		u32 state;
>  
> -		if (power_ops->state_get(ph, i, &state)) {
> -			dev_warn(dev, "failed to get state for domain %d\n", i);
> +		if (power_ops->state_get(ph, index, &state)) {
> +			dev_err(dev, "Domain %d not available\n", index);
>  			continue;
>  		}
>  
> -		/*
> -		 * Register the explicit power on request to the firmware so
> -		 * that it is tracked as used by OSPM agent and not
> -		 * accidentally turned off with OSPM's knowledge
> -		 */
> -		if (state == SCMI_POWER_STATE_GENERIC_ON)
> -			power_ops->state_set(ph, i, state);
> +		dev_warn(dev, "Initializing referenced domain %d\n", index);
>  
> -		scmi_pd->domain = i;
> +		scmi_pd->domain = index;
>  		scmi_pd->ph = ph;
> -		scmi_pd->name = power_ops->name_get(ph, i);
> +		scmi_pd->name = power_ops->name_get(ph, index);
>  		scmi_pd->genpd.name = scmi_pd->name;
>  		scmi_pd->genpd.power_off = scmi_pd_power_off;
>  		scmi_pd->genpd.power_on = scmi_pd_power_on;
>  		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>  
> +		if (state == SCMI_POWER_STATE_GENERIC_ON) {
> +			dev_warn(dev, "Domain %d is ON, registering state\n", index);
> +			power_ops->state_set(ph, index, state);
> +		}
> +
>  		pm_genpd_init(&scmi_pd->genpd, NULL,
>  			      state == SCMI_POWER_STATE_GENERIC_OFF);
>  
> -		domains[i] = &scmi_pd->genpd;
> +		domains[index] = &scmi_pd->genpd;
> +		scmi_pd++;
>  	}
>  
>  	scmi_pd_data->domains = domains;
> -	scmi_pd_data->num_domains = num_domains;
> +	scmi_pd_data->num_domains = max_id + 1;
>  
>  	dev_set_drvdata(dev, scmi_pd_data);
>  
> -	return of_genpd_add_provider_onecell(np, scmi_pd_data);
> +	dev_err(dev, "SCMI power domains probe completed in %lld us\n",
> +			ktime_us_delta(ktime_get(), start_time));
> +
> +	return of_genpd_add_provider_onecell(dev->of_node, scmi_pd_data);
>  }
>  
>  static void scmi_pm_domain_remove(struct scmi_device *sdev)
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

