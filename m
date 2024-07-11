Return-Path: <linux-pm+bounces-10984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D82192E560
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CC9B22A9A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495015958D;
	Thu, 11 Jul 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXE8x6CS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EF158DCE
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695956; cv=none; b=JmgCKKbxOns0MiPTALNQ4DniTJO1ROKU4smlWIhTW6llIWRL/DHmwR+S6bm6HCDiAjkBz/9yeg+6K4dgqgoI98ZEn+5wAe2roioANRrUHUv8fj8BP0S86tjRZL/Tv9sLwqhuUhPAHhsuE+Ji+F5v+frF0nJ7NDVsdWs55YuGqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695956; c=relaxed/simple;
	bh=j9NiAkcYaZRamBP4qRY3h61EYjWuLcJWwXFrgkmMxhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrFU5+QGYBm7o2uMxNm3zQ7DhQP1uNj3p3nAT/FJxIZeBizIg3QhmLuvCxLcv+SfbCtccGLPvVIT393E9rEWBTCz0tcoJvYiYFsEQap9RRzRJTgxoh4OznkwTE3u+xZM5Pca9K651iyY70g1IADrMyocR5VtJgs++F57O9IRVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXE8x6CS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so760922276.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720695954; x=1721300754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j9NiAkcYaZRamBP4qRY3h61EYjWuLcJWwXFrgkmMxhc=;
        b=NXE8x6CSZHTwPIXNdvJkrHhs8T62DP6eLaxflpb2uynoki2fmz1eG6hrL4Z/9154dA
         N8ZjkNF5bKl1P6kaI3+IcqplAx6Ex29DO8niwk3wlkxzdJXCqVNiv6cB1NeevofpRdgf
         6r/nY+/kG3FRJBrP8qdD4zdMQyBtD4t65Mplv3e/VdDCi5VM+rGCT79eBLNRHqOnBZNE
         mRrxkZCGayDBn5OFMVvldLeULdINXibXHVAx9W4z2NNnOxQDoVS9Ctt65ngK2otlYwCd
         YWFVM++Y8J76S0WbjV2NaWN4ikKsc1OS9XE/4XoG6lw8davOMshR82DpoNa4jOxcfiHb
         vrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720695954; x=1721300754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9NiAkcYaZRamBP4qRY3h61EYjWuLcJWwXFrgkmMxhc=;
        b=JD21/Pz53Z5khMscNCluSptzK2IgM/uQnz4aGlyKh+DMbPiflStLmreA32uMNs7yRV
         EzJ4rE4MghRNIFB0tlCw+nqa6zBYViejV/WiqQs1zTch9KlAIOlmDH++vcK27bQHNHsu
         QdI5VFa1W7ODxMGG1o3vx+YTiU5wix+Cy+xt/bR/2YBt/HtUOuQbuTQYwBezjvB7bOkl
         Ueff8A4tlaSAluDVABCSA+oQD7lf8UB12Re1u4zVlb8tWAhhGvdZTm3EKhiuZuhvwyba
         lWJDb7XHEizgeWmaRi8dZRvBdhfgDnehr3iSGheq+Uwk3/+r0FsqxtBHLOLz7MYFnUY4
         YEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8MD6w8cCBIqpb99n4v6jJzCfH0UEvauMLqVAxsbUvGjFQ3Xi9GpHtpyrN+MMkJj3vysSQ/Zeq+o3Y/FPMnU/IAP1k4++fn+0=
X-Gm-Message-State: AOJu0YxJNYtis61i18dnLA0LJouSXKygqVAh+hS+uO0PuN77hJLNijH2
	TQ+F4gwnYVZZA1VXdAzgOXvImbvrWmZmqr7CrYApzRluYnoz7qhe2+KqN7+FLK+SyPeWZEU5NQF
	mgY8J69RjfFlD6ggnXaA4SBJt+aT75IBTHzmfdw==
X-Google-Smtp-Source: AGHT+IFr78C3FB3Wiso6ZeI7SPSIkZqE37WM3KiUtBxtkNcdoByPdi/4+jEHifoR7ryqA6byJNjbDwvYVpZ0laFSM0U=
X-Received: by 2002:a25:d809:0:b0:e03:af3d:d4d6 with SMTP id
 3f1490d57ef6-e041b20c6b3mr9365953276.42.1720695953858; Thu, 11 Jul 2024
 04:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7> <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
In-Reply-To: <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 13:05:17 +0200
Message-ID: <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 11 Jul 2024 at 05:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 10-07-24, 15:51, Ulf Hansson wrote:
> > > I think this should work, but in this case we seem to need a similar
> > > thing for dev_pm_opp_set_rate().
> >
> > We don't go to that path for genpd's I recall. Do we ? For genpd's,
> > since there is no freq, we always call _set_opp().
>
> You are right! Although, maybe it's still preferred to do it in
> _set_opp() as it looks like the code would be more consistent? No?

No matter how we do this, we end up enforcing OPPs for genpds.

It means that we may be requesting the same performance-level that we
have already requested for the device. Of course genpd manages this,
but it just seems a bit in-efficient to mee. Or maybe this isn't a big
deal as consumer drivers should end up doing this anyway?

Kind regards
Uffe

