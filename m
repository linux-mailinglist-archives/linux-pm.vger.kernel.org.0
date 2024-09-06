Return-Path: <linux-pm+bounces-13764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656D96EEB8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3020F285571
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B621BE84F;
	Fri,  6 Sep 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzu1YsHt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C31BE22C
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613291; cv=none; b=QlYN2F1O5OJDU8U5DMp+Zn8oj9Ssk/mg6a5US0WpGVmAcq95WT3ZEMqKHOgzhGBjHaxObncr8J4TkabnQDXDEgCrOnOXCIK+e8ltikpD+n1LNa9LitxqVxBiKv9+fjktu7s72Uw7rTIXoPfUs5Zv8y/IYnVNAlkQD70ai1KJp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613291; c=relaxed/simple;
	bh=qrQ9YgUhH+H/Te/OsxLs4U6f7nJKyvkqUdMM9wubSJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYDf5Zq/NJtmSGuz0saT3F9+OZIk38HhAkzwfEtBbErLupGwu4w4A7ic9MqjExhObAYP+C3MSKqCVkFAC58SSO44L3Dt/jFIQowfd1u8N7C76RY9F6l+GMxOb7mnFuHO22zIMQWH+gAnkwOAi2hNr+xcqFsjoMbnczNbWH1C514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzu1YsHt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9463037cso1862407276.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613289; x=1726218089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QEWJHIT/hdvLCuZB6AcivByjiJ8SklO4OGwL+coTQI=;
        b=hzu1YsHt+oAqyv2GkpNj2XovmwmRXGIrL6jgRkQKEUM9rHhGzbQ4bXVXPfer9BJ4nV
         YGEybTV0bb0jheckb9s3oNMWjXSzAD6oGhOGN0jg9EpxnwC5elhL+3svEeS3O5ePZP3G
         hCxq9A07SIr5BcJfk6xtOIE08h9tfME9SncI+laRDEYTIiYCndHKue4eGHiylB2guJK9
         VmLB+efUIiaVTfdzJo+g6WSV/yitWGYUKfZekevDFcW8NUo9ls8E2kfzEEBvqejujV1E
         Ju0YzMe60DW8MW/kRGlXJWrzSZjvNzIrIYPGzrOVkJOw/QG/SB5oLh8nNMm3URoXCZA7
         4t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613289; x=1726218089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QEWJHIT/hdvLCuZB6AcivByjiJ8SklO4OGwL+coTQI=;
        b=nsz5ntPz3z/F+radd3mvr9hCVBR7uFuEjpwlEitG+2XH4LZHVQNDlUqtbp3EsEu3Qt
         m+npm1a59zAQ8xCLScJWCwmq/yQllg8JwRBNHDApyG1gXcj0GzD+3Ewg3rHipv7W7dMI
         XCMt1O4Nw08ba8wXKYYiTJb9tAmmxUGy9zKmkQJap/0w9EEv8ceLpIEJv0Hx/CWBjd2V
         AfdO0/nOiM8aSi+sZgdOoBeUns/dGZIhY4pxbRM9frK4/gWXWw1lPsIL1Q1PI+Ybz8/B
         KI3jE43FDqhZD1LzSsxu4V1fytiOZAucu/XHY9NWODjRZjxOYW3llcCx7nbe4Bvwb9Ub
         ipdA==
X-Gm-Message-State: AOJu0YwR4XlYwWQKt0+ZySLWl9CHlrAqHn/C7b3+WwFrMG7QPqgtHalz
	7l+hh/9P5JLmjoRtv+G5UwM8aJPxcBqzX4TvpNAvP5PSV4NkY92gJdxd9O5zGBN+Uy9Ft1Wmhnx
	/P2XsB9M+8xXPuyQ/Oxy6OO48puiNvBBRNJeLzA==
X-Google-Smtp-Source: AGHT+IGq+SDLPnETEb82wVVaWN4yKIhqYi2KkdUpODCUzthRjVo1BPJdvjkP3c8J679Do0Qyd9Of2aRVmQ9Xtl34CME=
X-Received: by 2002:a05:6902:2085:b0:e1a:9c37:6e67 with SMTP id
 3f1490d57ef6-e1d34a2a35cmr1831405276.54.1725613288676; Fri, 06 Sep 2024
 02:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
 <20240905-lpm-v6-10-constraints-pmdomain-v3-1-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-1-e359cbb39654@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:00:52 +0200
Message-ID: <CAPDyKFq6gD3gAmz2hHTGga6YFXfq6KuaQvP-GVo1JYbkOUV8Pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmdomain: ti_sci: add per-device latency
 constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 00:03, Kevin Hilman <khilman@baylibre.com> wrote:
>
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
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..bb95c40ab3ea 100644
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
> @@ -51,6 +53,27 @@ struct ti_sci_pm_domain {
>
>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>
> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
> +{
> +       return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
> +
> +static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
> +{
> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +       const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +       int ret;
> +
> +       ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
> +       if (ret)
> +               dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
> +                       ret);
> +       else
> +               dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
> +                       pd->idx, val);
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -79,6 +102,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
>                 return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
>  }
>
> +static int ti_sci_pd_suspend(struct device *dev)
> +{
> +       int ret;
> +       s32 val;
> +
> +       ret = pm_generic_suspend(dev);
> +       if (ret)
> +               return ret;
> +
> +       val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> +       if (ti_sci_pd_is_valid_constraint(val))
> +               ti_sci_pd_set_lat_constraint(dev, val);
> +
> +       return 0;
> +}
> +
>  /*
>   * ti_sci_pd_xlate(): translation service for TI SCI genpds
>   * @genpdspec: DT identification data for the genpd
> @@ -188,6 +227,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 pd->pd.power_on = ti_sci_pd_power_on;
>                                 pd->idx = args.args[0];
>                                 pd->parent = pd_provider;
> +                               /*
> +                                * If SCI constraint functions are present, then firmware
> +                                * supports the constraints API.
> +                                */
> +                               if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
> +                                   pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
> +                                       pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
>
>                                 pm_genpd_init(&pd->pd, NULL, true);
>
>
> --
> 2.46.0
>

