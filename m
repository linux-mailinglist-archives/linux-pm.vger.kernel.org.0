Return-Path: <linux-pm+bounces-11933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DED948AE0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 10:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7D31C21550
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4020165EF6;
	Tue,  6 Aug 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hp4ZJsd9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA492AF12
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931650; cv=none; b=M0wlN0k6WfO9xaboadAvVsOboYvWHWFZBHqdeZaHjfIg2nladAcEgXA6rI4/tcTGV+Lfl9Eofx4S9UAaF9Os7YEuvQqPlxp5nr2OIPDbokGuwsRWNC2XnE4OqRRHAbrEQtj9H+0SbqKpdDekcK+qhv9qFPyyPPXeFUsxOLnQurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931650; c=relaxed/simple;
	bh=QphvkAmmFS4wSNIYmzesiR0Qox7VEEk9NUTh2PY9eNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2c2odgkl/O6d4c2B6rwjjGyaZ182WFWcJ3WcP3Fw976ZUE04gbBPHkVl6hKOmSzgZP6HmVbHO0rzn87hhCmtjyaIdCsky7sAsH2mhOsVrJZN78/3d5+Zl39mCXYoAn2ttoJHxWe010C+k8wJCmqJRVGoLV1tJmt4AxEhjooPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hp4ZJsd9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b3ffc570bso1051725ab.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722931647; x=1723536447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qub7YzRLCF21XN8rZJTgyIXGtM65/0V9lLfsJRltDMk=;
        b=Hp4ZJsd9h24U4pVvu4pZc+HDG5YKiM5TmfuYnpNMOBdZ0pJruB3dwAeEZLhe8ovDo5
         Z0Fso9K5LgzNa7iNRjr5+DIUlNOtLP/YMAahJkwljwtHKnu5pYCBuiSTCoQEYBtP4202
         oB/3u2gzgbJyTDYRzDv9g0zaB+c/ga/ZQ/aaCJxu2uDppCxNI+g/xTFq5WHROjbpRjZ7
         bMhjSXFVe7iGwbEYOFfk7MnfL0JmiXMIUaW3dslDCdHKrieyoVJP954biyiJUIn0qiy3
         BboPBS8GGXsMwHrRL6P69BMwXLPJSV1MWQScHsFAkSACnIj88w/1Lc9PtITyyFpqxdIn
         tSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722931647; x=1723536447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qub7YzRLCF21XN8rZJTgyIXGtM65/0V9lLfsJRltDMk=;
        b=eN0jWXdcBgtbHRE1EeqcSRx9X5LUSJVRIOD7BsYhdnDKdHfUqcO94Zs70AxtHnI0FS
         +tFXEVHSTlDM56GgKTgRKKeqP45MZlF8GT7DOieKi7t0klG+0JQdJ1UQxnR4vlDkrJRE
         Q0vqbSCom2pIIBAwdGXd6QUE10U7hcCiAisv/fnazckQY80m7OmH9P6zuZX1f/TXAukA
         2uyI/HE25Bfl/TL32vc5BFkDUneANBBgHpOTlgzKxdpHd6au0ejr0/pt5e4heZ6j5hE7
         +cq9U1yaIcaU0zY24Eblny0FEapzqAMyqL4PQBkepS5vD+4kBrPUNn3OpQKShJNtYGw7
         D2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXhNlUbZ8taud21fuhf4EQSERQ++GZnaIpFBRd3/37S01CmvwU7i8PYtuDpKXFHT+JVQdNGZ1wOEVdgLJcTUkcMS/ZcPs9QdeA=
X-Gm-Message-State: AOJu0YzUnIW7e4NHWag6AODwb/VoGPfQx8goRP/bdLBKfOjeHcRyRrDk
	FN1s648NNTGLrdHTJaB/3fJ/gR07tuNbexbsuPZjNHz9JeiSCArgC9+LvhiNe14=
X-Google-Smtp-Source: AGHT+IFn7ETa1t/SyLWkrDAeT6jFrgmrqCEOKg30oSWB+1POwCxVUoZ+6PhTNMeg3hLDl0pxDqjZng==
X-Received: by 2002:a05:6e02:12b4:b0:39b:3205:6b93 with SMTP id e9e14a558f8ab-39b32056c3amr96151395ab.28.1722931646918;
        Tue, 06 Aug 2024 01:07:26 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ae34d0sm34806005ab.56.2024.08.06.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:07:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:07:23 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
Subject: Re: [PATCH 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Message-ID: <hhgcy6kkggxkvveftkk2dqzxskyyp542zwonocg7puouzuu4n2@bkccm5wbe2hj>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
 <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>

Hi Kevin,

On Mon, Aug 05, 2024 at 04:38:39PM GMT, Kevin Hilman wrote:
> For each device in a TI SCI PM domain, check whether the device has
> any resume latency constraints set via per-device PM QoS.  If
> constraints are set, send them to DM via the new SCI constraints API.
> 
> Checking for constraints happen:
> 
> 1) before SCI PM domain power off (->power_off() hook)
> 2) before system-wide suspend (via ->suspend() hook)
> 
> For TI SCI devices that are runtime PM enabled, check (1) will be the
> primary method, and will happen when the TI SCI PM domain is powered
> off (e.g. when the runtime PM usecount of the last device in that
> domain goes to zero.)
> 
> For devices that are either not runtime PM enabled, or are not yet
> runtime suspended (e.g. due to being used during the suspend path),
> the constraints check will happen by check(2).
> 
> Since constraints can be sent by either (1) or (2), driver keeps track
> of whether a valid constraint has been sent already.
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
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

In general this looks good, two small things below.

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..4dc48a97f9b8 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -13,6 +13,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> +#include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soc/ti/ti_sci_protocol.h>
>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
> @@ -47,10 +49,46 @@ struct ti_sci_pm_domain {
>  	struct generic_pm_domain pd;
>  	struct list_head node;
>  	struct ti_sci_genpd_provider *parent;
> +	s32 lat_constraint;
> +	bool constraint_sent;
>  };
>  
>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>  
> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
> +{
> +	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
> +
> +static int ti_sci_pd_send_constraint(struct device *dev, s32 val)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	int ret;
> +
> +	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
> +	if (!ret) {
> +		pd->constraint_sent = true;
> +		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
> +			pd->idx, val);
> +	} else {
> +		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
> +			ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void ti_sci_pd_clear_constraints(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +
> +	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +	pd->constraint_sent = false;
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -59,6 +97,18 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
>  {
>  	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
>  	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	struct pm_domain_data *pdd;
> +
> +	list_for_each_entry(pdd, &domain->dev_list, list_node) {
> +		struct device *dev = pdd->dev;
> +		s32 val;
> +
> +		/* If device has any resume latency constraints, send 'em */
> +		val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> +		if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent)
> +			ti_sci_pd_send_constraint(dev, val);
> +		pd->lat_constraint = val;
> +	}
>  
>  	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
>  }
> @@ -79,6 +129,38 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>  		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>  }
>  
> +static int ti_sci_pd_resume(struct device *dev)
> +{
> +	ti_sci_pd_clear_constraints(dev);
> +	return pm_generic_resume(dev);
> +}
> +
> +static int ti_sci_pd_suspend(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	s32 val;
> +	int ret;
> +
> +	ret = pm_generic_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Check if device has any resume latency constraints */
> +	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> +	if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent) {
> +		if (genpd && genpd->status == GENPD_STATE_OFF)
> +			dev_warn(dev, "%s: %s: already off.\n", genpd->name, __func__);
> +		else if (pm_runtime_suspended(dev))
> +			dev_warn(dev, "%s: %s: already RPM suspended.\n", genpd->name, __func__);
> +		else
> +			ti_sci_pd_send_constraint(dev, val);
> +	}
> +	pd->lat_constraint = val;

Could you get rid of pd->constraint_sent? I don't really see a situation
where it would be necessary.

> +
> +	return 0;
> +}
> +
>  /*
>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
>   * @genpdspec: DT identification data for the genpd
> @@ -188,7 +270,15 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>  				pd->pd.power_on = ti_sci_pd_power_on;
>  				pd->idx = args.args[0];
>  				pd->parent = pd_provider;
> -
> +				pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;

Optionally you could use ti_sci_pd_clear_constraints() here instead.

Best,
Markus

> +				/*
> +				 * If SCI constraint functions are present, then firmware
> +				 * supports the constraints API.
> +				 */
> +				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint) {
> +					pd->pd.domain.ops.resume = ti_sci_pd_resume;
> +					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
> +				}
>  				pm_genpd_init(&pd->pd, NULL, true);
>  
>  				list_add(&pd->node, &pd_provider->pd_list);
> 
> -- 
> 2.46.0
> 

