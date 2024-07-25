Return-Path: <linux-pm+bounces-11402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76F393C0C1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DA31C20D47
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AE199241;
	Thu, 25 Jul 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJSumhwg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4701991D7
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906724; cv=none; b=oazZdy3CoZOQFYj5roi5sZxOPJxAXPBb4SZXeg3tIba//b7L+0Ug3QmaFbjLg8fOuwPCCoGVTPpu/3GCaBXvza5ObaDiuO8VvHtwljPDghBzOdH3M5iPQxZqb/QKQ4Ov5f0CYzE3yOI3casmZP7VoX8oelvijx+7YgOaXCtOt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906724; c=relaxed/simple;
	bh=JsK7yJjBr07hesTWuuOd0Olz1bm2HQodZpRdnFA5cgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv9NExnWg7ZIsEll4VqA5wXRj2SWhm8W/Pxf/4nH3pQcwXz4lLjefhuY0/a8oYeGOln6cmeSpuDpOPJ/pc9PDVthnjaFEiRmXKGjPhwd04SjANaEmM30vcOWSlmtaqzTJ5uY9kHmezbT82EN9Dp8JNmMAYlyXMvYXy/NKSR4pTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJSumhwg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3dab2bb288aso471407b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906722; x=1722511522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pB5alhK3P/rWHh7+6LRvYSZnbMJZGnDqL1m2WfhmM9Q=;
        b=HJSumhwgmCZaXodmOfg9ocbC3JhI/zX3ZkZKQpY8n7OmYpBJQaCFWdKtCbqGheR0lj
         wk9rAZTfmsWYHGAB2HSKqndQpPWohjTi4ATfVsBpp4nxGYYGSG8TiH414rB5URn744rt
         jchQGsCf3hNbbqxUhEJmNCaRbsbICuv1smWBhpVyQlhlmcjfmW5UF8Xmzzu7MLLb9oKR
         e9RFiSPPil4Y38xgvFxYs05KHV7UoPQUkkd+zQiOaNt8lkGOjSwPOU7xnwJvjItrFhRp
         1j3dyzCoaKZFahyeSVpjcy3LGgcwI08hIBxIesIVAYETq7zEjEqkpNf9R6LG/mLzFAFH
         Dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906722; x=1722511522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB5alhK3P/rWHh7+6LRvYSZnbMJZGnDqL1m2WfhmM9Q=;
        b=AojUAK1W/QZo5Xu9bB2VZE58u3iHp/+cV+1F8hQa91a7Nt/ftPHn9Fydex3oUo13pl
         wM/R9ZE03otNgvFwiTyuY4Y/yTvBYIZ5YdXLHy/rQwMW3HhUzuOeoL52naxelbwB+Brl
         US74YwjDdLpgmf9weBpowBOsmU49OkSk7oz14AYiFCOLzdhLXnDUbhdheGUeuW5ClZYh
         V8yBe8HBj+ITPVuKKG8ltZWz4KwVjuhfEnAlUlUsquyyerm1YDEJP9bwaOOPGQ7j4702
         vgv6p2/TuEfR3ww/FiVeV/Df2xzzy/cmS5KXHEL1UMDlJaZVvrsoGhny8FbHQa8pPr1s
         AxNw==
X-Forwarded-Encrypted: i=1; AJvYcCUpHiOrsev0KN9l6YZKoFPETq+GBXy6YFvqDPZq//3oDYUvvhwb2RricGNv59RsPFOavyKM/Jzh7Z8rgddQ7YcLavv7Qn1I6Ow=
X-Gm-Message-State: AOJu0YwG3himTBAJmMPa8DwhkUMkmEJUGN6EHX3Rwq/QDFSPVgmeU3nr
	qKdGdQ1iyU+vgxGg4lnD7oiRngfK1yDy0/Y1jvFzALtiyRYMElPMcdBndZfbiy8=
X-Google-Smtp-Source: AGHT+IGB/C7i53ZMxQDVG7er3qrj96VmG0v9dXH1VLSTmcs7GQ7h6A9jCwiBR5/hKLh7wLBNc8M2NA==
X-Received: by 2002:a05:6870:b020:b0:229:f022:ef83 with SMTP id 586e51a60fabf-266ede9b2f8mr1951899fac.43.1721906722263;
        Thu, 25 Jul 2024 04:25:22 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8af074sm937252b3a.218.2024.07.25.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:25:21 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:55:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240725112519.d6ec7obtclsf3ace@vireshk-i7>
References: <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
 <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7>
 <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7>
 <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7>
 <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>

On 25-07-24, 11:21, Ulf Hansson wrote:
> Right.
> 
> The main issue in regards to the above, is that we may end up trying
> to vote for different devices, which votes correspond to the same
> OPP/OPP-table. The one that comes first will request the OPP, the
> other ones will be ignored as the OPP core thinks there is no reason
> to already set the current OPP.

Right, but that won't happen with the diff I shared earlier where we set
"forced" to true. Isn't it ?

> > I think that design is rather correct, just like other frameworks. Just that we
> > need to do only set-level for genpds and nothing else. That will have exactly
> > the same behavior that you want.
> 
> I don't quite understand what you are proposing. Do you want to add a
> separate path for opp-levels?

Not separate paths, but ignore clk/regulator changes if the table belongs to a
genpd.

> The problem with that would be that platforms (Tegra at least) are
> already using a combination of opp-level and clocks.

If they are using both for a genpd's OPP table (and changes are made for both
opp-level and clock by the OPP core), then it should already be wrong, isn't it?
Two simultaneous calls to dev_pm_opp_set_opp() would set the level correctly (as
aggregation happens in the genpd core), but clock setting would always reflect
the second caller. This should be fixed too, isn't it ?

> To be able to call dev_pm_opp_set_opp() on the required-dev (which
> would be the real device in this case), we need to add it to genpd's
> OPP table by calling _add_opp_dev() on it. See _opp_attach_genpd().
> 
> The problem with this, is that the real device already has its own OPP
> table (with the required-OPPs pointing to genpd's OPP table), which
> means that we would end up adding the device to two different OPP
> tables.

I was terrified for a minute after reading this and the current code, as I also
thought there is an issue there. But I was confident that we used to take care
of this case separately earlier. A short dive into git logs got me to this:

commit 6d366d0e5446 ("OPP: Use _set_opp_level() for single genpd case")

This should be working just fine I guess.

-- 
viresh

