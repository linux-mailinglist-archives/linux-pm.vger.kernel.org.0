Return-Path: <linux-pm+bounces-18901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365FB9EAEA5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2EE188A040
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6942080F9;
	Tue, 10 Dec 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jZE1pnzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AF2080EF;
	Tue, 10 Dec 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827672; cv=none; b=WFJfasSwB9DnF0DYFMXLFZNJFHXhvyH6Od219QNKDIjTtDLmWzoCg4xrygX9l+saTZqptiKbP/HGJAtnpYwBUEi1G0nD1WVTGwiqJgpDSSTidVq3Sfqqgknze+cz6muk2ulcx9653F39f6c7btSdpGcF96ycK6K8IHjQ5qAcjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827672; c=relaxed/simple;
	bh=IQlkfVohiBszOKxw6iFuII8QZAX6UbMGw1fFirdU+GI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osw8GySvA18aVY6jwqmxW2xHjIayFz3KFU4Fdmy9h6LVbKZKRNU1uDsgCKqbQBnK1OkYpHgf+ioZmgSeT4FftQDWO5nea24wHiBbctPrg0rpD0jwS0dV3IZkWRMBhIDzDq8N0Y4O7RWQfkfRd3bdRwJjfeYqKrcx1SOIt4mNhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jZE1pnzR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAlbqh2453885
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 04:47:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733827657;
	bh=0Q2mjqK2utewnwz3SOQOMOSFMFJ6XlJSNAJslzIgiJI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jZE1pnzR0Y7+n1EAHHaHZVWis7kL5hRKkEDugXvnvg3+fOUgbtObJbND0HWMn3GY+
	 6gwDkM9zUoUNJtAmqx8ibu5bt2P1th+sdKw35QA8yWLSSLN+jjlOv8nYE8AVTsV5a0
	 9Z2WYMkVizoD7QvC1tcxSyiIO4MskccTUIeBxpKA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAAlbiq077159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 04:47:37 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 04:47:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 04:47:36 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAAla88122432;
	Tue, 10 Dec 2024 04:47:36 -0600
Date: Tue, 10 Dec 2024 16:17:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
        Nishanth
 Menon <nm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] pmdomain: ti_sci: add per-device latency
 constraint management
Message-ID: <20241210104735.dtzdhdds6l7yjvgk@lcpd911>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
 <20241206-lpm-v6-10-constraints-pmdomain-v6-1-833980158c68@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-1-833980158c68@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 06, 2024 at 14:12:50 -0800, Kevin Hilman wrote:
> For each device in a TI SCI PM domain, check whether the device has
> any resume latency constraints set via per-device PM QoS.  If
> constraints are set, send them to DM via the new SCI constraints API.
> 
> Checking for constraints happen for each device before system-wide
> suspend (via ->suspend() hook.)
> 
> An important detail here is that the PM domain driver inserts itself
> into the path of both the ->suspend() and ->resume() hook path
> of *all* devices in the PM domain.  This allows generic PM domain code
> to handle the constraint management and communication with TI SCI.
> 
> Further, this allows device drivers to use existing PM QoS APIs to
> add/update constraints.
> 
> DM firmware clears constraints during its resume, so Linux has
> to check/update/send constraints each time system suspends.
> 
> Also note that the PM QoS framework uses usecs as the units for
> latency whereas the TI SCI firmware uses msecs, so a conversion is
> needed before passing to TI SCI.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 0e4bd749d067309654307484c5bb98711bf06daf..963fe1901c959197d5d8b5d34fd8420dfb180087 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -13,6 +13,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> +#include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>

nit: Do we not need to sort these includes alphabetically?

>  #include <linux/soc/ti/ti_sci_protocol.h>
>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
> @@ -51,6 +53,32 @@ struct ti_sci_pm_domain {
>  
>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>  
> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
> +{
> +	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	u16 val_ms;
> +	int ret;
> +
> +	/* PM QoS latency unit is usecs, TI SCI uses msecs */
> +	val_ms = val / USEC_PER_MSEC;
> +	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val_ms, TISCI_MSG_CONSTRAINT_SET);
> +	if (ret)
> +		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
> +			ret);
> +	else
> +		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
> +			pd->idx, val);
> +}
> +#endif
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -79,6 +107,26 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>  		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int ti_sci_pd_suspend(struct device *dev)
> +{
> +	int ret;
> +	s32 val;
> +
> +	ret = pm_generic_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> +	if (ti_sci_pd_is_valid_constraint(val))
> +		ti_sci_pd_set_lat_constraint(dev, val);
> +
> +	return 0;
> +}
> +#else
> +#define ti_sci_pd_suspend		NULL
> +#endif
> +
>  /*
>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
>   * @genpdspec: DT identification data for the genpd
> @@ -182,6 +230,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  				pd->pd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>  				pd->idx = args.args[0];
>  				pd->parent = pd_provider;
> +				/*
> +				 * If SCI constraint functions are present, then firmware
> +				 * supports the constraints API.
> +				 */
> +				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
> +				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
> +					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;

Rest looks good.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

