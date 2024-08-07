Return-Path: <linux-pm+bounces-11957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61395949FAD
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78561F221AB
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476471A0701;
	Wed,  7 Aug 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pw4ql3ha"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF151A01DB
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011233; cv=none; b=uMAQsgkCZvj67dalrWDRKw6sHMzWIOlOfnBDqIbC0c3mNZlY5MRUXoW4ws5CRPwwhgYnqLJFKicyG8ZzsNsRZugR4RmtvN8QrbUIdo8ThAt3HHWZYHxojFroA8/O3PqqiAh1vnyzZ8lIwIdN1TdBxv+a5uIaqB3jlLKAvzCvXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011233; c=relaxed/simple;
	bh=/hLqGS4RW2osi+CzojnzpTJ6bT5GHLG9+f9CaN9pkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM/v6R0oyW48EKHYfMJa8vduAQmZNpIVtdkUEJMW52KbYCDAs1lkwFbrblL1b0kBBwYIxBHxDyqyJNXsbnLbIY5FlYvIXSIQTwHwd0SFrbHvYQkf78pprB8w+6NaHcvdwviHRoIupTaaNHZtA1ScuJRwpoQPvCR6Xt54tRORo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pw4ql3ha; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b0826298cso5122645ab.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723011229; x=1723616029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaXX3Ti8LVh0QhYtjiN/Ek6p9//RV33r09bqNQCaVew=;
        b=Pw4ql3hamFvWTM9WHZwp5daT8zLIh/4gBR4MefU+E+hRgK+vEC8fm3OttvfiwWF3+f
         nY33334TwuXTweFqsnThReKPafJDwcE5rUXrdsnDClY/MHsMohYfrcclSbDFcdUvqTuR
         PgAlg6YR9tZa9QDe8qdDKWIVLaucsVi6cYf0OIlZqSHY3oHJWcwF2bqN/LD+wcH1zXdL
         ZTr4MXkQQpWGvZSaRml4uUgsp508z4JsXRj1epnmTxvVrZuIGJTesNsdKQJkRhJ3G7u5
         RVqrzhULH6KvqT2QcAQ8W5u+alp0rujTGWY6VvKpIUM8ajk34gYgZmQAUr1i5mwXgque
         1sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723011229; x=1723616029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaXX3Ti8LVh0QhYtjiN/Ek6p9//RV33r09bqNQCaVew=;
        b=RBRyp63soj0pzGtjMsafbCCbpD4sOyXXf7YoL7okoGiDCiJ8EKIfnLVAN/fgwySFro
         jTdhkGujuT0qvj6IBPOoLU2MTA0qFelGQH7ZOr6kGJSxf2zPUy32WOHR68AkMk2NQIkY
         dzVmLteCFpOMG/HBF1pVYV2LzS/kL6wRBLz2Lf3NcixEjRywGOhuNiwDGTv6PsJSbfKK
         izxviP5expAh41ob+VSHMjpQFQnbSf2bTAk7S1i5QEpS+lAKDhDhIe36J4Vvc9J//pQu
         b0hkdJ0RZc0zTLB4UdX1ET/q7MVuhjCyPeEL+M5UFcCzy4BRmyKY7TMuH981KIx0rL5n
         lLbA==
X-Forwarded-Encrypted: i=1; AJvYcCWuBCLTUePnjdGwbUIqteTuZNDWs/bb8r0OuOPQBTyPBAY0Ty7gEUBaeODdzEGt/6EbNlPrxMTaUgWhInzZSJHtPhIyRcVfzUI=
X-Gm-Message-State: AOJu0YyiRUhTh5pZQuRThJaOpTkr64/GzjNWO4/ZF1eexOigQLVB0BAJ
	l+3ftCsy2KGjEf3rYSkUoST32+5cxd6+PO9CUEDHEGNGP+rhEJPLCXfo2BXaGVc=
X-Google-Smtp-Source: AGHT+IFW+itKDG6bDxyKNHaXE//lu8p5lKnqqUhHeRkU86Qqj0k7amjbZcNDsezUANK4CQwdMSkAsw==
X-Received: by 2002:a05:6e02:218d:b0:39b:2daf:1b82 with SMTP id e9e14a558f8ab-39b2daf1e07mr192657625ab.16.1723011228835;
        Tue, 06 Aug 2024 23:13:48 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6987db1sm2626534173.24.2024.08.06.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:13:48 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:13:44 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Message-ID: <phvhe4ojhohgmcvfpgrizi2gmd4kdb6ragywqypzmivujl4ufa@ejwkycojwhw7>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
 <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>
 <hhgcy6kkggxkvveftkk2dqzxskyyp542zwonocg7puouzuu4n2@bkccm5wbe2hj>
 <7hbk25w9du.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7hbk25w9du.fsf@baylibre.com>

On Tue, Aug 06, 2024 at 03:53:49PM GMT, Kevin Hilman wrote:
> Markus Schneider-Pargmann <msp@baylibre.com> writes:
> 
> > Hi Kevin,
> >
> > On Mon, Aug 05, 2024 at 04:38:39PM GMT, Kevin Hilman wrote:
> >> For each device in a TI SCI PM domain, check whether the device has
> >> any resume latency constraints set via per-device PM QoS.  If
> >> constraints are set, send them to DM via the new SCI constraints API.
> >> 
> >> Checking for constraints happen:
> >> 
> >> 1) before SCI PM domain power off (->power_off() hook)
> >> 2) before system-wide suspend (via ->suspend() hook)
> >> 
> >> For TI SCI devices that are runtime PM enabled, check (1) will be the
> >> primary method, and will happen when the TI SCI PM domain is powered
> >> off (e.g. when the runtime PM usecount of the last device in that
> >> domain goes to zero.)
> >> 
> >> For devices that are either not runtime PM enabled, or are not yet
> >> runtime suspended (e.g. due to being used during the suspend path),
> >> the constraints check will happen by check(2).
> >> 
> >> Since constraints can be sent by either (1) or (2), driver keeps track
> >> of whether a valid constraint has been sent already.
> >> 
> >> An important detail here is that the PM domain driver inserts itself
> >> into the path of both the ->suspend() and ->resume() hook path
> >> of *all* devices in the PM domain.  This allows generic PM domain code
> >> to handle the constraint management and communication with TI SCI.
> >> 
> >> Further, this allows device drivers to use existing PM QoS APIs to
> >> add/update constraints.
> >> 
> >> DM firmware clears constraints during its resume, so Linux has
> >> to check/update/send constraints each time system suspends.
> >> 
> >> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> >> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> >> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> >
> > Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >
> > In general this looks good, two small things below.
> >
> >> ---
> >>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 91 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> >> index 1510d5ddae3d..4dc48a97f9b8 100644
> >> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> >> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> >> @@ -13,6 +13,8 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_domain.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/pm_qos.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/soc/ti/ti_sci_protocol.h>
> >>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
> >>  
> >> @@ -47,10 +49,46 @@ struct ti_sci_pm_domain {
> >>  	struct generic_pm_domain pd;
> >>  	struct list_head node;
> >>  	struct ti_sci_genpd_provider *parent;
> >> +	s32 lat_constraint;
> >> +	bool constraint_sent;
> >>  };
> >>  
> >>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
> >>  
> >> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
> >> +{
> >> +	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> >> +}
> >> +
> >> +static int ti_sci_pd_send_constraint(struct device *dev, s32 val)
> >> +{
> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> >> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> >> +	int ret;
> >> +
> >> +	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
> >> +	if (!ret) {
> >> +		pd->constraint_sent = true;
> >> +		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
> >> +			pd->idx, val);
> >> +	} else {
> >> +		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
> >> +			ret);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static inline void ti_sci_pd_clear_constraints(struct device *dev)
> >> +{
> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> >> +
> >> +	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> >> +	pd->constraint_sent = false;
> >> +}
> >> +
> >>  /*
> >>   * ti_sci_pd_power_off(): genpd power down hook
> >>   * @domain: pointer to the powerdomain to power off
> >> @@ -59,6 +97,18 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
> >>  {
> >>  	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
> >>  	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> >> +	struct pm_domain_data *pdd;
> >> +
> >> +	list_for_each_entry(pdd, &domain->dev_list, list_node) {
> >> +		struct device *dev = pdd->dev;
> >> +		s32 val;
> >> +
> >> +		/* If device has any resume latency constraints, send 'em */
> >> +		val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> >> +		if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent)
> >> +			ti_sci_pd_send_constraint(dev, val);
> >> +		pd->lat_constraint = val;
> >> +	}
> >>  
> >>  	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
> >>  }
> >> @@ -79,6 +129,38 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
> >>  		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
> >>  }
> >>  
> >> +static int ti_sci_pd_resume(struct device *dev)
> >> +{
> >> +	ti_sci_pd_clear_constraints(dev);
> >> +	return pm_generic_resume(dev);
> >> +}
> >> +
> >> +static int ti_sci_pd_suspend(struct device *dev)
> >> +{
> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> >> +	s32 val;
> >> +	int ret;
> >> +
> >> +	ret = pm_generic_suspend(dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Check if device has any resume latency constraints */
> >> +	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> >> +	if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent) {
> >> +		if (genpd && genpd->status == GENPD_STATE_OFF)
> >> +			dev_warn(dev, "%s: %s: already off.\n", genpd->name, __func__);
> >> +		else if (pm_runtime_suspended(dev))
> >> +			dev_warn(dev, "%s: %s: already RPM suspended.\n", genpd->name, __func__);
> >> +		else
> >> +			ti_sci_pd_send_constraint(dev, val);
> >> +	}
> >> +	pd->lat_constraint = val;
> >
> > Could you get rid of pd->constraint_sent? I don't really see a situation
> > where it would be necessary.
> 
> It is necessary for runtime PM enabled devices that also use
> constraints.  For a device like that, if a constraint is present it will
> be sent when the PM domain is powered off (right after the runtime PM
> usecount goes to zero.)  Later, during system-wide suspend, the suspend
> hook for that same device might try to send the constraint again if we
> don't keep track of whether the constraint was already sent.

But wouldn't in that case pd->lat_constraint also be valid as you set it
only after sending the constraint? So if you check for that instead of
pd->constraint_sent, could you remove constraint_sent? On resume it is
always reset as well.

It just looked to me like if it is valid then it would have also been
sent, which is the same semantic as the bool.

Best
Markus

> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /*
> >>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
> >>   * @genpdspec: DT identification data for the genpd
> >> @@ -188,7 +270,15 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
> >>  				pd->pd.power_on = ti_sci_pd_power_on;
> >>  				pd->idx = args.args[0];
> >>  				pd->parent = pd_provider;
> >> -
> >> +				pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> >
> > Optionally you could use ti_sci_pd_clear_constraints() here instead.
> 
> hmm, yes.  Good catch.
> 
> Kevin

