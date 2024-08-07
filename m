Return-Path: <linux-pm+bounces-11974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8F894AE55
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002191C215AD
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F081386C6;
	Wed,  7 Aug 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rKPmNL2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC681AB6
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049158; cv=none; b=MNUe4Jgjcyvg+S/Rb79m40N/xcjp8hUN7ahHqvi3KRy91gxRs7GTqA36j+/X14y/4cFauKF5xcEP58Zn2g/7VbwAnxxi++vo7X4Pa1onZb2addcOkkZgHRqotj8EramQOwPZhqzjVNX/shFhiZGoiI2XnVmcrGDThQ331m/9Pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049158; c=relaxed/simple;
	bh=5kEPowMK5npbKOXBa7EIy5NR9e4isJ+bnLrLFWe+/ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDKy77Hgs/mPRT9puU8vMRyKgHV162LLrhOx6wCVJmhjNG95wwMqcQAD6/1lnJ30LOp18GYzdeELdi2QHpK/ivnqkG4wHpaxsh6MKcp0Fgy+XVnTP+ncODluYIBhAq6u5cdjXKS98BeiT2RlL6i4AU2Hraz/IVCU8xk+gMJN7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rKPmNL2X; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so49354a12.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2024 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723049154; x=1723653954; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOY3ZUXzU7Co5/aIs2/fh9HLg4+/kCPnWROfIcUoUkc=;
        b=rKPmNL2X/KFjldZCGAtkwrUYvU1ZXZs0uVNE7UHF/9NdlrQKQeU44HMd3gzeLO8Yfv
         H6Ji7ADEWUnlgEH+HkwHd6fYnbq+cz2qJic7y4vyYMw7rzcchXVxpTmPBjM+tcKW6WM4
         aK2jGElxcF3yhfpJryad8MXSjYWxMtfuqEojo6g0TaSedIkUpEZWykmKnkvyVwfMQYkQ
         V0CaDhGLXuV8Se2uS8dqWmSqMMQlH+9DH9BJT09U26SRZN8XaBI+Avv4j67DdWF3skvr
         3GNNwmPjGTvQJNQycpNoG9D1q0PJYDFAEE2zOUGkV5AWvHPNRfJOVgr6CJE8W9Af4t8+
         iJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049154; x=1723653954;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOY3ZUXzU7Co5/aIs2/fh9HLg4+/kCPnWROfIcUoUkc=;
        b=hdRrAPAre5MSFd18XbMjMH1BKD69NNv4ITGe9S/1jORj1lKf0K63kON2G6l3x+TXsi
         OkEkKg0H80wpcA/sGPlb65zruveeIuUM3FkGAPIGveirNf0JyBOKcQRBVH9YgLqY7B+6
         rqwUA7yL9k23Grks+OzQiDMupPTCScfkDyEFRK4q/79UlZ1GmD69r41jSwvcGN1z5aD+
         N5sF4w/aP/aeATTr26xE2ywHZO0wvP3BXpIN8oqRIeYpso4jSZ62DpsgaDpbfG3l8gN5
         rGz3BgRJrUMGotroAfAbyk92QD02mAlIz6PNzH6/N30jnhE5hbhzfO3MMnsTz7AzLN/U
         jTLg==
X-Forwarded-Encrypted: i=1; AJvYcCUn2MNXp3SzHTaszpDnAXYsc15SQQjKgAZUKiD3M7h6/Nj1Yfmr7irrwuqxzmiVdyLQzAuOiqMcLK9XcvvFXVRrVrXNJRKJD+I=
X-Gm-Message-State: AOJu0YxBVN5NfAA7Zc+yxrXqS35to/SRP9LtnMcgg3xhGczUIu+gHB7c
	vdAjmF7fLkg7umTohVU4EagH6jmVc30Yuu/pwZUERKWk7f/PTS80p9y4SQfWiRocmncQ9MigCVa
	kfjo=
X-Google-Smtp-Source: AGHT+IENG/U2H5j6dHzOUizyHzNsqJWakSioMKdV7DC//hZnoLMtt6j0GfUx7Gr+UESNVoq9jSsQvg==
X-Received: by 2002:a05:6a20:1015:b0:1c2:a29b:efb4 with SMTP id adf61e73a8af0-1c6ed7d6778mr3087168637.24.1723049154198;
        Wed, 07 Aug 2024 09:45:54 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfffasm8494736b3a.124.2024.08.07.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:45:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep
 Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
In-Reply-To: <phvhe4ojhohgmcvfpgrizi2gmd4kdb6ragywqypzmivujl4ufa@ejwkycojwhw7>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
 <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>
 <hhgcy6kkggxkvveftkk2dqzxskyyp542zwonocg7puouzuu4n2@bkccm5wbe2hj>
 <7hbk25w9du.fsf@baylibre.com>
 <phvhe4ojhohgmcvfpgrizi2gmd4kdb6ragywqypzmivujl4ufa@ejwkycojwhw7>
Date: Wed, 07 Aug 2024 09:45:52 -0700
Message-ID: <7hikwcl1rz.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> On Tue, Aug 06, 2024 at 03:53:49PM GMT, Kevin Hilman wrote:
>> Markus Schneider-Pargmann <msp@baylibre.com> writes:
>> 
>> > Hi Kevin,
>> >
>> > On Mon, Aug 05, 2024 at 04:38:39PM GMT, Kevin Hilman wrote:
>> >> For each device in a TI SCI PM domain, check whether the device has
>> >> any resume latency constraints set via per-device PM QoS.  If
>> >> constraints are set, send them to DM via the new SCI constraints API.
>> >> 
>> >> Checking for constraints happen:
>> >> 
>> >> 1) before SCI PM domain power off (->power_off() hook)
>> >> 2) before system-wide suspend (via ->suspend() hook)
>> >> 
>> >> For TI SCI devices that are runtime PM enabled, check (1) will be the
>> >> primary method, and will happen when the TI SCI PM domain is powered
>> >> off (e.g. when the runtime PM usecount of the last device in that
>> >> domain goes to zero.)
>> >> 
>> >> For devices that are either not runtime PM enabled, or are not yet
>> >> runtime suspended (e.g. due to being used during the suspend path),
>> >> the constraints check will happen by check(2).
>> >> 
>> >> Since constraints can be sent by either (1) or (2), driver keeps track
>> >> of whether a valid constraint has been sent already.
>> >> 
>> >> An important detail here is that the PM domain driver inserts itself
>> >> into the path of both the ->suspend() and ->resume() hook path
>> >> of *all* devices in the PM domain.  This allows generic PM domain code
>> >> to handle the constraint management and communication with TI SCI.
>> >> 
>> >> Further, this allows device drivers to use existing PM QoS APIs to
>> >> add/update constraints.
>> >> 
>> >> DM firmware clears constraints during its resume, so Linux has
>> >> to check/update/send constraints each time system suspends.
>> >> 
>> >> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> >> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> >> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> >
>> > Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> >
>> > In general this looks good, two small things below.
>> >
>> >> ---
>> >>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>> >>  1 file changed, 91 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> >> index 1510d5ddae3d..4dc48a97f9b8 100644
>> >> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> >> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> >> @@ -13,6 +13,8 @@
>> >>  #include <linux/platform_device.h>
>> >>  #include <linux/pm_domain.h>
>> >>  #include <linux/slab.h>
>> >> +#include <linux/pm_qos.h>
>> >> +#include <linux/pm_runtime.h>
>> >>  #include <linux/soc/ti/ti_sci_protocol.h>
>> >>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> >>  
>> >> @@ -47,10 +49,46 @@ struct ti_sci_pm_domain {
>> >>  	struct generic_pm_domain pd;
>> >>  	struct list_head node;
>> >>  	struct ti_sci_genpd_provider *parent;
>> >> +	s32 lat_constraint;
>> >> +	bool constraint_sent;
>> >>  };
>> >>  
>> >>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>> >>  
>> >> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
>> >> +{
>> >> +	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> >> +}
>> >> +
>> >> +static int ti_sci_pd_send_constraint(struct device *dev, s32 val)
>> >> +{
>> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> >> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> >> +	int ret;
>> >> +
>> >> +	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
>> >> +	if (!ret) {
>> >> +		pd->constraint_sent = true;
>> >> +		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
>> >> +			pd->idx, val);
>> >> +	} else {
>> >> +		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
>> >> +			ret);
>> >> +	}
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static inline void ti_sci_pd_clear_constraints(struct device *dev)
>> >> +{
>> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> >> +
>> >> +	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> >> +	pd->constraint_sent = false;
>> >> +}
>> >> +
>> >>  /*
>> >>   * ti_sci_pd_power_off(): genpd power down hook
>> >>   * @domain: pointer to the powerdomain to power off
>> >> @@ -59,6 +97,18 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
>> >>  {
>> >>  	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
>> >>  	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> >> +	struct pm_domain_data *pdd;
>> >> +
>> >> +	list_for_each_entry(pdd, &domain->dev_list, list_node) {
>> >> +		struct device *dev = pdd->dev;
>> >> +		s32 val;
>> >> +
>> >> +		/* If device has any resume latency constraints, send 'em */
>> >> +		val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> >> +		if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent)
>> >> +			ti_sci_pd_send_constraint(dev, val);
>> >> +		pd->lat_constraint = val;
>> >> +	}
>> >>  
>> >>  	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
>> >>  }
>> >> @@ -79,6 +129,38 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>> >>  		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>> >>  }
>> >>  
>> >> +static int ti_sci_pd_resume(struct device *dev)
>> >> +{
>> >> +	ti_sci_pd_clear_constraints(dev);
>> >> +	return pm_generic_resume(dev);
>> >> +}
>> >> +
>> >> +static int ti_sci_pd_suspend(struct device *dev)
>> >> +{
>> >> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> >> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> >> +	s32 val;
>> >> +	int ret;
>> >> +
>> >> +	ret = pm_generic_suspend(dev);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	/* Check if device has any resume latency constraints */
>> >> +	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> >> +	if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent) {
>> >> +		if (genpd && genpd->status == GENPD_STATE_OFF)
>> >> +			dev_warn(dev, "%s: %s: already off.\n", genpd->name, __func__);
>> >> +		else if (pm_runtime_suspended(dev))
>> >> +			dev_warn(dev, "%s: %s: already RPM suspended.\n", genpd->name, __func__);
>> >> +		else
>> >> +			ti_sci_pd_send_constraint(dev, val);
>> >> +	}
>> >> +	pd->lat_constraint = val;
>> >
>> > Could you get rid of pd->constraint_sent? I don't really see a situation
>> > where it would be necessary.
>> 
>> It is necessary for runtime PM enabled devices that also use
>> constraints.  For a device like that, if a constraint is present it will
>> be sent when the PM domain is powered off (right after the runtime PM
>> usecount goes to zero.)  Later, during system-wide suspend, the suspend
>> hook for that same device might try to send the constraint again if we
>> don't keep track of whether the constraint was already sent.
>
> But wouldn't in that case pd->lat_constraint also be valid as you set it
> only after sending the constraint? So if you check for that instead of
> pd->constraint_sent, could you remove constraint_sent? On resume it is
> always reset as well.
>
> It just looked to me like if it is valid then it would have also been
> sent, which is the same semantic as the bool.

hmm, yeah.  I think you're right that constraint valid and constraint
sent are the same thing.

In earlier versions of the firmware, there was slightly different
behavior about how constraints were cleared, but with how it works now,
I think it can be removed.

I'll test with that for the next version.

Thanks for the review!

Kevin

