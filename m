Return-Path: <linux-pm+bounces-11934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ABF948B1E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 10:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A7F1F21860
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD04166F36;
	Tue,  6 Aug 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0IC6MIux"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A584165EE7
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932335; cv=none; b=kAQj7PhAqstj0obGFcyC5dLgeTpavnXZ6RZdQs4GeK25zOCKEhDkypYOsC2EIVolpwLo1RZbpDVDw+kBbNOWzh1vF/exyKucdIVU2uxDzmD3wCjzCG8Fbh1k4BZdsq21u+VCSLuhZOWR5kfsf+Udq7X0AQElrm4kTqWkeYNKGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932335; c=relaxed/simple;
	bh=yte5vG9VKOD6lKjbDQRT7GC2pyy7NFROFw7L+XQx008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA1/uojzUuBtI4WnFtjdWd6h1CSTLf8G5J/9xDtQJuKwr/e81DeMD1vbVYRwXSmlzcI6vKxExdHzOeGbv4JTCZtNim8ZP5+uLTBkUS3CKmYQ0G5rs7XUv+iIcZeKo01u7i1pnIq82H1uJALz3fF+nugkvJrVgKnvMj4NOmQy6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0IC6MIux; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f905eb19cso18777439f.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722932331; x=1723537131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBZfPqNU2oWRIpM7IHmG0mRj/x4u/OXicGm04hIfixw=;
        b=0IC6MIux+pgbpo5gx3hlesdjiM3GruWeGzlkSdi0k1EesbjTqjN79sTO6HMxl/gdEq
         8cSMalmHTkgm5kwuRns7ZZBcTPSGzmFFBtNYhzmU/lTYyQ7pY0tQMpStVOUyNrdFG+2r
         5YTZzo7GtCTUrSS7l5Bn9DzrNki/idHO0Mb3HmJOqB+YA81ZV3jrNEIl7VDH5R9RqU5H
         fgllW6H2GnQV4wUoM7DC0pMgC+pwlbbXJ9wzVM31RX/XNZ9wgoj4RpWtrNx1gHMBEc6X
         N4BKIS/pSF0q0o62eRYz/zcyi98+zCUzUzKKqtSO2FRCS4+pCtarzVmBM7WD7uc8yblk
         h1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722932331; x=1723537131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBZfPqNU2oWRIpM7IHmG0mRj/x4u/OXicGm04hIfixw=;
        b=Uo0gkgE/hBJTnrVQlFQOSPfD6T3OS/p32HZW3pVDp4M15TLbBSUTMEyiZ88xy790/8
         /WcgFN/4mzfCo2aqlvdieLoz205QbMVfAaPja25beHQJOXX3usutJtH77Ut9jL2jqLwV
         CeAxDtsVQ7BXNPgyinkHikmagougezoaWR66k1ldsgkFo7JcYvxtrAkQGhGEiXNT6KtM
         BE5JvT+Q5ZbK3PbFMlTw+81EMnKpgRzoi56bqcIwwDhwUw4VAnEhTxenfj6gZGZQTQ/Z
         MnNCXPhElRf2k0n/5eEVoEmfMcg4Jy9S4RM+PSrsVq2HYJ2QwbaeM2pvLKzaRQJAF996
         9AWw==
X-Forwarded-Encrypted: i=1; AJvYcCVgjXno84QwmwPFcVu5rBVPnHaEvQKB3JGgED3j2xpnWTOKgHYgPuEbQfKHbuxdSrViZ++bUcxZUIpox3LHE/8FXBroDTvXGeE=
X-Gm-Message-State: AOJu0YznJ4pr2ARZEwWXydjITIat0X2GLrQfQGr1AmJU1BHP86t2lp55
	9SW6bat6eLl4SUbDlgiseWoaZSjmCE6UILYNxxkzq2LBfSqAgYoZft1J8e6+y7U=
X-Google-Smtp-Source: AGHT+IEnMjssfn1tHGwLEI3HboWn9lT/r3BrtKO1At+7UuPTRgGKdWYqKsk244HKY3ky2lRZhIkcZQ==
X-Received: by 2002:a05:6602:1683:b0:807:eeef:4fb5 with SMTP id ca18e2360f4ac-81fd433fb70mr2059641239f.1.1722932331120;
        Tue, 06 Aug 2024 01:18:51 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a59e74sm2129519173.174.2024.08.06.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:18:50 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:18:47 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
Subject: Re: [PATCH 2/3] pmdomain: ti_sci: add wakeup constraint management
Message-ID: <5qvb3vt5s7egkyzpitgys6uylvvttrpbcar2dgshp2kk5he6sk@p34xb2xmebxq>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
 <20240805-lpm-v6-10-constraints-pmdomain-v1-2-d186b68ded4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805-lpm-v6-10-constraints-pmdomain-v1-2-d186b68ded4c@baylibre.com>

On Mon, Aug 05, 2024 at 04:38:40PM GMT, Kevin Hilman wrote:
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
> 
> Note: DM firmware clears all constraints on resume.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 4dc48a97f9b8..7cd6ae957289 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -51,6 +51,7 @@ struct ti_sci_pm_domain {
>  	struct ti_sci_genpd_provider *parent;
>  	s32 lat_constraint;
>  	bool constraint_sent;
> +	bool wkup_constraint;
>  };
>  
>  #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
> @@ -87,6 +88,26 @@ static inline void ti_sci_pd_clear_constraints(struct device *dev)
>  
>  	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  	pd->constraint_sent = false;
> +	pd->wkup_constraint = false;
> +}
> +
> +static inline bool ti_sci_pd_check_wkup_constraint(struct device *dev)

'check' in the function name sounds like a passive function. Maybe
ti_sci_pd_send_wkup_constraint() would indicate its purpose better?

> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	int ret;
> +
> +	if (device_may_wakeup(dev)) {
> +		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +							       TISCI_MSG_CONSTRAINT_SET);
> +		if (!ret) {
> +			pd->wkup_constraint = true;
> +			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +		}
> +	}
> +
> +	return pd->wkup_constraint;

Is this return value used anywhere?

Best
Markus

>  }
>  
>  /*
> @@ -158,6 +179,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>  	}
>  	pd->lat_constraint = val;
>  
> +	ti_sci_pd_check_wkup_constraint(dev);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.46.0
> 

