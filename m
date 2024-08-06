Return-Path: <linux-pm+bounces-11955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE1949B99
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 00:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDE1B21178
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7A172BDF;
	Tue,  6 Aug 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wyHKUIut"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF616DC0B
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984835; cv=none; b=sYsbJdqtZkv08teGgelYUsPs4UiLJeCOibIZBi8OmzoxlGvSPUwKHsLriBUtf2ytKCSLqSNy1SIqGSPB4Nr02FlGBMD95bg4/gSN5txYsgkEqCEXJfK7OGTftnhkPOKkpt/u7LZhQ+1y+i0XJlcnwcDdY0ceyhhFIAOBEJjUho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984835; c=relaxed/simple;
	bh=9VfVR2f2t0ueyMNKeDuMnIAc5gKoU+3ot0zpq0zg518=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kbwNdL24ocwXEZ4PmTV1QTHO2dBXj1bDoaaovSJ/WsoOXxffXwdIIXiVGIeuVesqC67N3X7e2WX2rqv7T2lTxB5li4oLMmaWQhX6unbBftJNlLuIr4g8CjddKunJFCnlhn+/ZmTZw7l93tE7BxqK7uMa5e02b0LCiTVG8M8lzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wyHKUIut; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so934718b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722984830; x=1723589630; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9lqcqknIkZNKr/KUrs9ocm/EfBzQr5ie1FKgPteVbQ=;
        b=wyHKUIut7YxJ2nElmw4K4LFwDcsJq4KHp2ExhfpmE1qFu95tpt0UIH6e6ZhOhZq/RV
         eOthClF1ENUS8gtVNXEXHUGpIyr5zgenPVLLgiAC4wQT/CKP+S0T1AJmdBvRxDRIaygc
         +eJXCtMXcapzK63D39Nvg3h83NvugdswnQKJwTamZ5gXb1RSbATTTt8C7OlcOaYx5UZZ
         VNFWEFLnk4fL59GdpXR9DD114szjjL5FVuNERu//nP0wdFLuSu3vbZmrKhSgXKxY99sr
         ShOiCe6z1ZHK02IZfcJK3T0nNFYj059iLPGi6F2XmYdWkwp4xjidu8sLpQtZESYiFILG
         iPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984830; x=1723589630;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9lqcqknIkZNKr/KUrs9ocm/EfBzQr5ie1FKgPteVbQ=;
        b=Kg3mJdQzMYcgKB7WnVH4O14Bg7gITd6M9aLjPpuuP6lFGPVemjGLQOLxTL8Oa9Dz4v
         9xXEvlfZwxJpYMTwpMpoDDQcV1zba81VjXYwkHdOupKDNwCR6/SklWp7mU1enKzk1O0t
         1x3Q3RIA5/f6SbSZhNvI280CR+aCYqEV98gMgETHwITutoRONSJ17U+cYtpkFO9WOg45
         lQuMN+3aqkOL7Ue8vRFMdzPilO2PwznOFFWqM4kGOeMmV/w2lrYHD9OqteM8tSNNziGS
         9Wu1oUlAEMs0v5agRLjT3VDj7flQu8PdxVq2VOkkLc2r6ECruVGfZpeqXFPaPrM5veAq
         YdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeiIHDOuggso3H/NuaRDMW64g1kPYPmleatbpOXv+TSpar4lyaCHyJ1m3IGKRiDqch6kcgDo5PcStSW0xigzczmh/wTUDOS7c=
X-Gm-Message-State: AOJu0YyWa7X1dlraC+4KV7oCTZBwrWaalfXa4eSXY4Zk5TNJFP7wXhkt
	TkOaZ1qRhlxYsQ3M6CoeDoGXhx9E77dbT32XJXW0A36xGp1h1E4eyqgbZp9jdbo=
X-Google-Smtp-Source: AGHT+IGfCa9EPhq0+cLJ8FNooOou6NRMGYCB8dr77pLtePhMz24rvpdJf9SLGtzqgJNYmfEB1epoig==
X-Received: by 2002:a05:6a20:2452:b0:1c4:cae1:d53e with SMTP id adf61e73a8af0-1c6995aa7femr22895830637.22.1722984830187;
        Tue, 06 Aug 2024 15:53:50 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec49b87sm7425888b3a.81.2024.08.06.15.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:53:49 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep
 Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
Subject: Re: [PATCH 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
In-Reply-To: <hhgcy6kkggxkvveftkk2dqzxskyyp542zwonocg7puouzuu4n2@bkccm5wbe2hj>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
 <20240805-lpm-v6-10-constraints-pmdomain-v1-1-d186b68ded4c@baylibre.com>
 <hhgcy6kkggxkvveftkk2dqzxskyyp542zwonocg7puouzuu4n2@bkccm5wbe2hj>
Date: Tue, 06 Aug 2024 15:53:49 -0700
Message-ID: <7hbk25w9du.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> Hi Kevin,
>
> On Mon, Aug 05, 2024 at 04:38:39PM GMT, Kevin Hilman wrote:
>> For each device in a TI SCI PM domain, check whether the device has
>> any resume latency constraints set via per-device PM QoS.  If
>> constraints are set, send them to DM via the new SCI constraints API.
>> 
>> Checking for constraints happen:
>> 
>> 1) before SCI PM domain power off (->power_off() hook)
>> 2) before system-wide suspend (via ->suspend() hook)
>> 
>> For TI SCI devices that are runtime PM enabled, check (1) will be the
>> primary method, and will happen when the TI SCI PM domain is powered
>> off (e.g. when the runtime PM usecount of the last device in that
>> domain goes to zero.)
>> 
>> For devices that are either not runtime PM enabled, or are not yet
>> runtime suspended (e.g. due to being used during the suspend path),
>> the constraints check will happen by check(2).
>> 
>> Since constraints can be sent by either (1) or (2), driver keeps track
>> of whether a valid constraint has been sent already.
>> 
>> An important detail here is that the PM domain driver inserts itself
>> into the path of both the ->suspend() and ->resume() hook path
>> of *all* devices in the PM domain.  This allows generic PM domain code
>> to handle the constraint management and communication with TI SCI.
>> 
>> Further, this allows device drivers to use existing PM QoS APIs to
>> add/update constraints.
>> 
>> DM firmware clears constraints during its resume, so Linux has
>> to check/update/send constraints each time system suspends.
>> 
>> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>
> In general this looks good, two small things below.
>
>> ---
>>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 91 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 1510d5ddae3d..4dc48a97f9b8 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/slab.h>
>> +#include <linux/pm_qos.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/soc/ti/ti_sci_protocol.h>
>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>  
>> @@ -47,10 +49,46 @@ struct ti_sci_pm_domain {
>>  	struct generic_pm_domain pd;
>>  	struct list_head node;
>>  	struct ti_sci_genpd_provider *parent;
>> +	s32 lat_constraint;
>> +	bool constraint_sent;
>>  };
>>  
>>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>>  
>> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
>> +{
>> +	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> +}
>> +
>> +static int ti_sci_pd_send_constraint(struct device *dev, s32 val)
>> +{
>> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> +	int ret;
>> +
>> +	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
>> +	if (!ret) {
>> +		pd->constraint_sent = true;
>> +		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
>> +			pd->idx, val);
>> +	} else {
>> +		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
>> +			ret);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static inline void ti_sci_pd_clear_constraints(struct device *dev)
>> +{
>> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> +
>> +	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> +	pd->constraint_sent = false;
>> +}
>> +
>>  /*
>>   * ti_sci_pd_power_off(): genpd power down hook
>>   * @domain: pointer to the powerdomain to power off
>> @@ -59,6 +97,18 @@ static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
>>  {
>>  	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
>>  	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> +	struct pm_domain_data *pdd;
>> +
>> +	list_for_each_entry(pdd, &domain->dev_list, list_node) {
>> +		struct device *dev = pdd->dev;
>> +		s32 val;
>> +
>> +		/* If device has any resume latency constraints, send 'em */
>> +		val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> +		if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent)
>> +			ti_sci_pd_send_constraint(dev, val);
>> +		pd->lat_constraint = val;
>> +	}
>>  
>>  	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
>>  }
>> @@ -79,6 +129,38 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>>  		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>>  }
>>  
>> +static int ti_sci_pd_resume(struct device *dev)
>> +{
>> +	ti_sci_pd_clear_constraints(dev);
>> +	return pm_generic_resume(dev);
>> +}
>> +
>> +static int ti_sci_pd_suspend(struct device *dev)
>> +{
>> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>> +	s32 val;
>> +	int ret;
>> +
>> +	ret = pm_generic_suspend(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Check if device has any resume latency constraints */
>> +	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> +	if (ti_sci_pd_is_valid_constraint(val) && !pd->constraint_sent) {
>> +		if (genpd && genpd->status == GENPD_STATE_OFF)
>> +			dev_warn(dev, "%s: %s: already off.\n", genpd->name, __func__);
>> +		else if (pm_runtime_suspended(dev))
>> +			dev_warn(dev, "%s: %s: already RPM suspended.\n", genpd->name, __func__);
>> +		else
>> +			ti_sci_pd_send_constraint(dev, val);
>> +	}
>> +	pd->lat_constraint = val;
>
> Could you get rid of pd->constraint_sent? I don't really see a situation
> where it would be necessary.

It is necessary for runtime PM enabled devices that also use
constraints.  For a device like that, if a constraint is present it will
be sent when the PM domain is powered off (right after the runtime PM
usecount goes to zero.)  Later, during system-wide suspend, the suspend
hook for that same device might try to send the constraint again if we
don't keep track of whether the constraint was already sent.

>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
>>   * @genpdspec: DT identification data for the genpd
>> @@ -188,7 +270,15 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>>  				pd->pd.power_on = ti_sci_pd_power_on;
>>  				pd->idx = args.args[0];
>>  				pd->parent = pd_provider;
>> -
>> +				pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>
> Optionally you could use ti_sci_pd_clear_constraints() here instead.

hmm, yes.  Good catch.

Kevin

