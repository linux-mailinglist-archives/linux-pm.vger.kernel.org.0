Return-Path: <linux-pm+bounces-29014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5925ADF75A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 22:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF7189FEB0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D02192EF;
	Wed, 18 Jun 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f+HQw1a8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2D219E8F
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276814; cv=none; b=FgBCGayKgscY+OfRHc+YVYdwKHhrdLoQEhd7LIc0MTUVIq5yrrvq2/3Jy2RGesIF4tkl0lAO1CJnZbhPq7Q+4ADEg7TzEgUp1IauCINSeFL2BNTaXy6DWWHuGIZhq7sJTNo/DY8uF3MZ9B4OXUFpWD/yBOOA2rBWlYjDuZgnnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276814; c=relaxed/simple;
	bh=Thq4Q06cdpVu9pDEN+/3JBZrpgyjUXOgoUe0gvNvhSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLS+dFogbzYwvepLTJlXuoln3mxh32Y30CiCoNSj6GdvpGFOWZ5Tv8TixU9WRBG2ximrUAR3smeTtNXXoqiwKdOvT+wDixT7hkT1Dl/PZemAnDCVMBtEXvuNTWTec4TXaHtZ3r25GWirhXwhE9mvMTNJQiD2dYqMTc8uPgJp3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f+HQw1a8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so102108a12.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750276812; x=1750881612; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiOzVfjBcF1fRtJg0Y1H//g4cNADDmQDLTn0mBy9kzo=;
        b=f+HQw1a8sMcwX9xo2U1ygWT+QWYLU0F4HBcOvrIkAhCmztVGuDaq3zoVf/NAP0kpfw
         b//W5zthQDGjYjyaDRMyN+Vcnbe3zV5Nr6eA5NBgoD21zoiEIKj5XGz8UmEKhmkhSSjP
         5UIZtEbw8qUOmBAgLNSxnqYCIRQKGVfkxQQ+5PAhVTqCJspZmoDvMZLberAIxHiWb9+8
         E17c2hE79UE6tIXmsD2oGjxPt9ffdno7l/yYSpPPiVPQf6+bZWgsejQCwpSAiGcirihs
         6odCbGg5ExPNl15Tr/DCA2ExS8YbnMOl0bMF1ygsFr+6j1t2ZuD4YEvoosB6mIduVVnD
         +Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750276812; x=1750881612;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiOzVfjBcF1fRtJg0Y1H//g4cNADDmQDLTn0mBy9kzo=;
        b=BeiPjuFmO1305TlwImum6nQtPeVpgglcBYRiKV3NDC69yH2uaauss0IJGyAjMKRVnk
         /VLd63Oyr6So2tBKGo88NBf4YcAWamNleayRFZkIw/i89x5yx6EcIUhoQGUr7ZilSPrO
         rwF9QqdlWeoOHx93ppHMDkttgKEmhDcu8G2F4nMvFsqTHZ9B78OtapWArvwEKT4blzBp
         8Jz6a0e/q+UDE8Ivxm2UuLRBulLIFJZwQQq0mLo4PFshVTPMDht0FJNg7QtvuH1Xf+vJ
         BO//j2G8AcTGj1Kt0KCVlNAGr02lqQ+L1rZKDOLQVWVQzkSc7ynxm7BGt5k/wfszjlL5
         p00w==
X-Forwarded-Encrypted: i=1; AJvYcCX6dBBSIWojAQwOkzLj42Yrg7KH3nHtD/eG4iuACc8TNveXRZKbThPt6kGqj2wXjNlMqW+dpnYYYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQPicVc8QFBmuvzoo7/SJAPjqUlkXaeez7I8JxhyFXe+NXP+e
	rKFotvvB3h4ZTIe6MvzMWjf+PTomPqTri4EYcBzXC1wgul1hSSC5uy2mYzXew4mt1og=
X-Gm-Gg: ASbGncstEJgjIBEMwqz2Lp+rEdmWA4JRVsVPo1pdg9GTqDBNUmUJ3cHLrqI1Vjajup6
	v2OUEvv+QMowpjrLHR0ZEaFNNa1f6PAuW4AJY41gEgklKHNCmtSU8Lu3ryvkIPsH0vDH31452eW
	ECLtmlE1qWeBnTtndRuAgYRCDyFC/ea71ZC/WQMv2v8VelgTxvg3La1tokClLQc+tKSkx8Q6R0p
	ij/kLqoW25j4g71pIhbJcED1NG37RlXIjOre+FIPzzVfHJ1WwThf4MNt6nSwykW26kWRaOMCQRd
	zjIXJcdz+P2OjyYadODEgC4Zyd4yI4NCDFkvroytYbEjoBxE+39EBZpv3zXR
X-Google-Smtp-Source: AGHT+IH3xjpyQ4ebVaMo9DbY1gh/tZqYj3qhoffl3icr75QW+zCNKAPlpcq7GyNn9O1WQp4oMM2scw==
X-Received: by 2002:a17:90b:2dd2:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-313f1c7dacfmr29693399a91.7.1750276811912;
        Wed, 18 Jun 2025 13:00:11 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3157a605f21sm1629583a91.0.2025.06.18.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:00:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
In-Reply-To: <e463a278-7e6e-4287-9093-42d0a0d365d2@suswa.mountain>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com>
 <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
 <7hcyb1os9y.fsf@baylibre.com>
 <e463a278-7e6e-4287-9093-42d0a0d365d2@suswa.mountain>
Date: Wed, 18 Jun 2025 13:00:10 -0700
Message-ID: <7h5xgsq0qd.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Dan,

Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Wed, Jun 18, 2025 at 10:48:09AM -0700, Kevin Hilman wrote:
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 88819659df83..3ede4baa4bee 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>>  }
>>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>>  
>> +int of_genpd_add_subdomain_map(struct device_node *np,
>> +			       struct generic_pm_domain *domain,
>> +			       int index)
>> +{
>> +	struct of_phandle_args parent_args;
>> +	struct generic_pm_domain *parent_pd;
>> +	struct device *dev = &domain->dev;
>> +	int ret;
>> +
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * Check for power-domain-map, which implies the primary
>> +	 * power-doamin is a subdomain of the parent found in the map.
>> +	 */
>> +	ret = of_parse_phandle_with_args_map(np, NULL, "power-domain",
>> +					     index, &parent_args);
>> +	if (!ret && parent_args.np) {
>
> Sorry for the pedanticry but could we flip this around?

Sure.  This is early prototype code for discsussing the big-picture
approach, but I appreciate the review.  I'll clean that up when I get
past the RFC phase.

Thanks!

Kevin

