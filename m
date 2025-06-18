Return-Path: <linux-pm+bounces-29007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF1ADF5A4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7754C189EB0B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611D2F49F7;
	Wed, 18 Jun 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wid0jK4Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA03085D2
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270599; cv=none; b=gDScQPxq4TczalZv+bIfWK2bV0tsxbpgkaFm3LFjU/ww351h0Ui5tunTqf7wxnYRJQVDjZ6EqaBtBJGs9Rpev2h/XihfoL52m+el5lCC3BWFr9Ly5tVxgh6nPGrU2SmRxpfonpecybuBgiETWAIm+njaXIXdccvuanhRiY92HDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270599; c=relaxed/simple;
	bh=4Fd9qcUJXzQbN+9KTtCF1fqWdiXzbwzF6B966ci6XRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcPdZqm6zlcZQt6i/PGnMMsdOULaEADQNGsNFdHoH1uld7W+b1cFs/Ae9wAqBZ9YiL27pzWTDq8NR/6SZnmWD9g1Xk98PLBzmVkYcluHgb6BfzM4l3F4URSNFLI6CJubo9R9OAteMvwi+vpe+DfexQQLmmq18XR66YBGDvx5y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wid0jK4Q; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6062e41916dso3407494eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750270595; x=1750875395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ6KRNqHtUH9Gf6fw/A7PLcOlEK5Gn0mWYnHJo+61Ac=;
        b=wid0jK4Q15Vl/kw4kZKo7qejb44EIxGfESRFu6tffrMzE2exUJ6vtd1TQjIN+a49HH
         FPWBBAUbGVT0/6aKrHPY68p/dajy468RNMNnCnE8qhmCjdvLcF1d+IdJO+y4NnN9kwE1
         3RO8N5hKPqhhuFbL7zyTtQ1WLKHnWE/nqIIGB4u6g5N7oVSBJSio4RUTWh4AL4rQncP+
         FuXNB71wtpDaMWMTAUy99HRxRrToWljSkN9MpXMTfZvvfgff8Ow1RAno42NJREY84zO+
         GCR7/L3aqB9qmH9rD+uSWHYo6xQvvjBTxwkD8EpFXrctx/nIiXv7x39wn5J64mdplqSB
         4Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270595; x=1750875395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ6KRNqHtUH9Gf6fw/A7PLcOlEK5Gn0mWYnHJo+61Ac=;
        b=BMV0ZHFpdFczJ7bVbxz4AZg5yemosjkdb/P4oD7Ft1QR0pdCIf4NL6VFiFu2Kvm+PD
         Pzs17fCFb2mGOwgeNsL48idzaIOW8Hv1bkC8giI0HGTGcNDs95VOo+uFzyMff1sHoWRr
         LdBeZdiDd6tiz2Qua3GgijCo/8b0cn81A9WdUExiSY/rj0Ab+3+634qdI2qmZ1K2Hhpy
         jibJCWCuynPvFqIV9L+qcQPGodqFlBivR/1OTIqJzr47mNpRM9ewT/pGr1M4gnk2BzT6
         p5Cjn9/k+lDGUf4W6NU+TwbrzYnY/1KPWzwbaiEwtAyppL6DjMCrqATaSFfBJwNUf3b9
         05zg==
X-Forwarded-Encrypted: i=1; AJvYcCXZbRA8sN/AkMup4iWCiU7PEKO0WayxQ9qiuu5u6H/1/jS+ePRu8jtgAjXVq2gs5lJjPMxuLEBqsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnbWtN1o1Z6dgE8+vAOOQ4RPSJMUNAzMfUqAjAflK3eHxArjn
	+L/fegEdmJPd8+J79K1qHZhX7lDG3CELJL42/FOAAHruJwVHicPaFTJA5tHReaN9+WU=
X-Gm-Gg: ASbGncvr74ZtahqWlDNRHLSlIcBobYXSr13AEV+JdpTp9pJcNUXCZsYyy1IMhF0laIZ
	VXclp1KZvoFXr91MZMS2z0mUKjVDzanEJ6CENVQNp5iWcywMP/dnngKJ1xCLC3GRZFi2JmPCsOM
	muox0KermrP86XPMYkXaPdYnOUSZqEm5bvwJNFuSWrNClI84NHF3ot7v2yy9W/XYgcAYYI3mn6h
	0SEu36SNFC6bZLg23Yv+vpss8S21uC7MCBYj2DISEk0XsjO3wTc0DlGcMVBrPVWo815iazIGlOx
	CedBWNBXLO+qzRWEPvEdZRaKD7nmkakg8W5EsuP9fZQlbwh2SZn2jYWwjzMjtXnSLYOsPQ==
X-Google-Smtp-Source: AGHT+IERtISn8EPb8IizUWIQkj9b9iJsEPiQd/pV7ijZ/mH9QjGYp3xZSAl/4Lp/uwu1uArVd8eRSg==
X-Received: by 2002:a05:6820:1c8e:b0:611:3eb5:7272 with SMTP id 006d021491bc7-6113eb58a0amr3281471eaf.0.1750270595379;
        Wed, 18 Jun 2025 11:16:35 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61108f0b2fasm1471880eaf.30.2025.06.18.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:16:34 -0700 (PDT)
Date: Wed, 18 Jun 2025 21:16:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
Message-ID: <e463a278-7e6e-4287-9093-42d0a0d365d2@suswa.mountain>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com>
 <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
 <7hcyb1os9y.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hcyb1os9y.fsf@baylibre.com>

On Wed, Jun 18, 2025 at 10:48:09AM -0700, Kevin Hilman wrote:
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 88819659df83..3ede4baa4bee 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>  
> +int of_genpd_add_subdomain_map(struct device_node *np,
> +			       struct generic_pm_domain *domain,
> +			       int index)
> +{
> +	struct of_phandle_args parent_args;
> +	struct generic_pm_domain *parent_pd;
> +	struct device *dev = &domain->dev;
> +	int ret;
> +
> +	if (!domain)
> +		return -ENODEV;
> +
> +	/*
> +	 * Check for power-domain-map, which implies the primary
> +	 * power-doamin is a subdomain of the parent found in the map.
> +	 */
> +	ret = of_parse_phandle_with_args_map(np, NULL, "power-domain",
> +					     index, &parent_args);
> +	if (!ret && parent_args.np) {

Sorry for the pedanticry but could we flip this around?

	if (ret)
		return ret;

	if (!parent_args.np)
		return 0;

> +		parent_pd = genpd_get_from_provider(&parent_args);
> +		of_node_put(parent_args.np);
> +
> +		if (IS_ERR(parent_pd))
> +			return -EINVAL;

		return PTR_ERR(parent_pd);

> +
> +		ret = pm_genpd_add_subdomain(parent_pd, domain);
> +		if (!ret)

	if (ret)
		return ret;

	dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
		domain->name, parent_pd->name);

	return 0;

> +			dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
> +				domain->name, parent_pd->name);
> +	}
> +
> +	return ret;
> +}
> +


