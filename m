Return-Path: <linux-pm+bounces-11599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A445E93FF8B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230DB1F23892
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885218C351;
	Mon, 29 Jul 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQngmwtR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DE188CD5
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285072; cv=none; b=indxX5nNS/elMEfYm+pJGDmM0oAlH002ol7RfyKODfU6OwvKH/gyKOqOsR7A0pyS/R27PTclPBSmjPe6PQEQIQ41HL5VbmkyWEP+yCmgNUagtvQqGJzYUaj49yM6nTEZzoGCt6+alTeHU48NSLsJpFoLlxCQ8EV5usgMat3F100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285072; c=relaxed/simple;
	bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpsbnBjUoalWRAfwA0OOfBPUX5r5YEgrXMr6uBUzATZIYaD83LDEX0ZcXzFRlrdI/flVWkpLlTUT343DntGdbUDxg1l4gvE5oCGSmwpfkb0lVCtMNgFfrDkao90BNZTgDGPdmZ9rjnFI67bM2snv8CrfMCsyaanMaScbs7NNkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQngmwtR; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0b286b922eso2299192276.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722285068; x=1722889868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
        b=KQngmwtRP5cPVG0MyedAHOP6kErCF9qnqQXLqr0rhQR4m72Sc4+f3Fa0g/AzKqqqFN
         5wlO2pgjZjFdrEUTls+fT8doj63YCLamJPcVK3t5IIhdSlYP4zgBilApoCj3eAuxdYwh
         hykS4C/9NCIRFmTg8hXUvM0LvYECA3k5rAkDBRZe+4hhslzNyY+u+xGagzbrcCxNIxmu
         Npmw0WmgIa/yBuzm87mpqvULt4Gje1ZuqkW1zqvnWVT9hc4yVt8jr/4DTZh+oTAf0PPN
         UMJFUkhza3ntX3rgNGu8BdKa3JgkazK+gThFhVOQoMJgra4FuA0lD8oOOqtsZtisX6oT
         1NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285068; x=1722889868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1aS1lQVKXhrl5osmvtQvkwGB3PQXy+5n+7ZkC2IU7k=;
        b=d5HJpNe6f+yuP6LpykfckMTntixt0H0rbPNtc04EuxJKlFD2GIFTf9kKhPHj8kUowZ
         VHt2YiTEb0tOrYylb+deVDm/5HZKWaY+Ir2yj7FJWjcZq8bva8jk32jPghITexy026QO
         uYx7MrwDxIvbXaNYp15WybF2XmUSTyZUvSvPyYOZQ9W+roJyMmbqStjbU9jKIOXPcRLy
         uVWA06gY7qkkLzKNpolyKwY0qHCWanS0jp7/hbRULYers3WKXGc3KW0XhYBuLy7tg/5u
         nth7Hzg+st8KEdGtYpUqvFcF+T2qUj4NFWNPqzEbPNXSOB6bisBZSzgV9OCK703VtPo/
         zE/g==
X-Forwarded-Encrypted: i=1; AJvYcCUkZV6MYef5ebB8p0AtU0PgRRVknD4pcGWQxQVZrjq0TxH5G8odBa8wUzFSm01PhLUk0pVm83tN6GB89NMbKIZ2et+eEAPms1k=
X-Gm-Message-State: AOJu0YzXHa5KcJVx8xF8j1h66bsbMgQ/zyI2KSzKMbHPTTnQ5ZlRPiJv
	xRaaHhbRxNKwtf6BhOMAkJYMTsx+vzUZuMvJo4oMUT/F4vitVtqGKSRLrmu3F3wxe4yYzOl8Q9t
	PaP5ozFeSiXAjrIhCKeb51rP0TyahEJUjizbZUg==
X-Google-Smtp-Source: AGHT+IE6PA+41Auz36YFIeCSe3gwULhATNq0ZrmnNpIMKRjzsevvjklMTd8qJRePRRiUM6vSVA+XVdVmqlOtJX4UP9w=
X-Received: by 2002:a05:6902:c09:b0:e0b:3c55:747d with SMTP id
 3f1490d57ef6-e0b545af5f2mr9330015276.37.1722285068532; Mon, 29 Jul 2024
 13:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7> <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7> <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
 <20240725112519.d6ec7obtclsf3ace@vireshk-i7> <CAPDyKFqTtqYEFfaHq-jbxnp5gD7qm9TbLrah=k=VD2TRArvU8A@mail.gmail.com>
 <20240729060550.crgrmbnlv66645w2@vireshk-i7>
In-Reply-To: <20240729060550.crgrmbnlv66645w2@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Jul 2024 22:30:31 +0200
Message-ID: <CAPDyKFosi4dhf36iNaNgGN6RHLDunL1nEwD+A_aW2khxER59nQ@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 08:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-07-24, 22:05, Ulf Hansson wrote:
> > > > > I think that design is rather correct, just like other frameworks. Just that we
> > > > > need to do only set-level for genpds and nothing else. That will have exactly
> > > > > the same behavior that you want.
> > > >
> > > > I don't quite understand what you are proposing. Do you want to add a
> > > > separate path for opp-levels?
> > >
> > > Not separate paths, but ignore clk/regulator changes if the table belongs to a
> > > genpd.
> > >
> > > > The problem with that would be that platforms (Tegra at least) are
> > > > already using a combination of opp-level and clocks.
> > >
> > > If they are using both for a genpd's OPP table (and changes are made for both
> > > opp-level and clock by the OPP core), then it should already be wrong, isn't it?
> >
> > They are changing the clock through the device's OPP table and the
> > level (performance-state) via genpd's table (using required OPPs).
> > This works fine as of today.
>
> There is a problem here I guess then. Lets say there are two devices A and B,
> that depend on a genpd.
>
> A requests required OPP 5 (level 5, clk 1.4 GHz), followed by
> B requests required OPP 3 (level 3, clk 1 GHz).
>
> After this level will be configured to 5 and clk to 1 GHz I think.

The level would be 5, as the aggregated votes in genpd would be
correct in this case.

In regards to the clocks, I assume this is handled correctly too, as
the clocks are per device clocks that don't belong to the genpd.

>
> > It's working today for *opp-level* only, because of the commit above.
> > That's correct.
>
> Good.
>
> > My point is that calling dev_pm_opp_set_opp() recursively from
> > _set_required_opps() doesn't make sense for the single PM domain case,
> > as we can't assign a required-dev for it. This leads to an
> > inconsistent behaviour when managing the required-OPPs.
>
> We won't be calling that because of the above patch. In case of a single dev,
> the required device isn't set and so we will never end up calling
> dev_pm_opp_set_opp() for a single genpd case.

That's right, but why do we want to call dev_pm_opp_set_opp() for the
multiple PM domain case then? It makes the behaviour inconsistent.

Kind regards
Uffe

