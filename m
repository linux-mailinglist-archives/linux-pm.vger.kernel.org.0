Return-Path: <linux-pm+bounces-13684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EED96D718
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BAB287640
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410F199938;
	Thu,  5 Sep 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEL/tg1X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93809198856
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535859; cv=none; b=XSv+8X3/h/BkxjbKhElj7uUdgaqqHgGIfIGwS0GAnQLJXu+Ib3cy85rcZmlp4Ill2VQVl0V9kEblBM0Qo0YYKcWy8+o2jn/TbITRh1VWpaDMJJlbA/29/i9CLqEFNolEsOXo3w5/YWZlh7IAdtRbQKBCaXSssuQ5VhoIpvofbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535859; c=relaxed/simple;
	bh=cZ2Wx8fvaET/7JxQTjEgWR4ZohNvUR3xeq5khiLj2os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFyS78mCltyxy8xWmhTRatMzux/MEaQbLO+y+cczjToz5ZUG0KAy7IfPx1F/EBjkusTRN2W0r41Cwj3CQgJFubQYjTiADhWP2ZOh4BL6/g56tosB/8LJZ4yRn9DC4wr04Vb+MYzZKTV8bGPADzU3wZG/rfLhP6Su9w4ZsEnMXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BEL/tg1X; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so776346276.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725535855; x=1726140655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XO3SHERgjVtdUY92f/1GsvMnaAL4bpA7+aeJ5dWueio=;
        b=BEL/tg1X2o8LpfKZYbFJCOwHGahGqVQhDjew+VUB6fgrcHuCQ4AhDos39fG29PWgbO
         vlfLRVMvILqZZt6CA7oqQXUJ1dYqyczLu4Hf65GtH7gQ4eZh/Qjxv7T/K66CcNRS4IUk
         dgztp1ZavihG/er9EHpOMESsCNO223YZZz+ALac+2tQvUZTsmwlTQqJWHBQPyCCRTLfv
         BsAK3bCh8TjWJXvsaioHIAq/FoQ6+zDvArwZ8G6aYpivPB65YFkfm6W1wSsM6Inp9JxW
         O0w4AdwKuZuwCBy1vVkEGb+bWussOOWEw1XMuD4jJffNaTNbTXIvmGH+jQwy3GNMXY4J
         ejew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725535855; x=1726140655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO3SHERgjVtdUY92f/1GsvMnaAL4bpA7+aeJ5dWueio=;
        b=aKqaOOP3jVnqDJEORBTL/pZfq8fCNnmQYTkEUxadtpxcP9GtcJzNRfHV9RD7f0fVU2
         eJII0edb9phnPTBQC3wQU6VvH8rqAh7dsvEGb0Mhzwji6AcAXpZxRlyK1QbN3v8uKYRJ
         Ofl+SKzLeAF2IPvqM8sP5BpeXACVN6bK8zNPaYDhGTgFM1PzFWB6BVNyHv9xleA+BbRo
         nYVBGButpaM0hxLAkmXLc90wA4wbSYNTh1jbMwaITbr2S8ilDtFs6n+kh7OH5sRbeSe2
         Xtr++YJnl7RuauB7vJiFw//95uwsKTNbF5KS9yN5wPfnsGEmqpnzMTcsai3Ub6JX0VHs
         uuIw==
X-Gm-Message-State: AOJu0YyAodhnSEJwjSdrpZmN1TYlNYb/KIltOvD0OBzV4TKHhAdNV73+
	/6j7DtFQxznR2xeNPhEesBVQ1xWh5T1F6BuQ30Pjx4/G0PmZNcGrjO74I5cMbhz67DzQ2ilVvrX
	kugR1yZ4ktBAz/UbTII95w9g7IbiXvTN4R5OIpw==
X-Google-Smtp-Source: AGHT+IHV34c7EEOOI3qO09nipDkXPQmHy+t5wyoFib/rFaG11CrIUkeU2FoaK9HyFVSRXWcO/a+E0H5PLgECkn89HQk=
X-Received: by 2002:a05:6902:2204:b0:e1a:a86b:8ebd with SMTP id
 3f1490d57ef6-e1aa86b9b77mr16971362276.17.1725535855449; Thu, 05 Sep 2024
 04:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <20240819-lpm-v6-10-constraints-pmdomain-v2-1-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-1-461325a6008f@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:30:19 +0200
Message-ID: <CAPDyKFrCyvSLYh9DoC661M-2D33oU9x5tFOe+Oem04V5KfqG3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pmdomain: ti_sci: add per-device latency
 constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
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
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..963272fa387b 100644
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
> @@ -51,6 +53,29 @@ struct ti_sci_pm_domain {
>
>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
>
> +static inline bool ti_sci_pd_is_valid_constraint(s32 val)
> +{
> +       return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}

Should we perhaps add a generic helper function for this? Seems like a
similar check is done at other places in the kernel too.

> +
> +static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
> +{

Looks like you may want to turn this into a static void rather than
static int. At least the caller, below, doesn't care about the return
value.

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
> +
> +       return ret;
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -79,6 +104,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
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
> @@ -188,6 +229,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
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

Other than the minor things above, this looks good to me.

Kind regards
Uffe

