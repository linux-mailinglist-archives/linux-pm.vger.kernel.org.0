Return-Path: <linux-pm+bounces-11515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF193E92B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 22:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F071C20B23
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA86F2E7;
	Sun, 28 Jul 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbtExgpU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EB55886
	for <linux-pm@vger.kernel.org>; Sun, 28 Jul 2024 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197157; cv=none; b=A7yLKD2w2tv30tt2X97IHRKTaroRk1g1IBK1Y7lMAwDj0mIqLQntSFq394Fp82mO3PCVQF5AxZxJbx3d52qz58yzcCVs63bapPxNdeHBjmHt9bqEQZhf4ghyVpAb5N32icd2ILmVw1azS/WtyW80vsk+gE7+fNUJq0O/q2oe8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197157; c=relaxed/simple;
	bh=8qeNIwj16ieiaUyi224RZB9BZqdEjEHvR9Is2j0uLPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihBut/nkB3KiYh8su0m0B+CZ9ZQlO3k2Cjwss+vkeBWyaPPVtrrP1lXKYexx35yuTkkRW3vx4lZ6bi69sl1j8nfIoK9R++ZRsFtQ9/cRxnAKFlwuyqS20GaS6XKOh+TGVPKdvZWYKFUT0SpNBv2twUpa7MxG/imIyEMMf22soB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NbtExgpU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0874f138aeso933508276.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Jul 2024 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722197155; x=1722801955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qeNIwj16ieiaUyi224RZB9BZqdEjEHvR9Is2j0uLPw=;
        b=NbtExgpUkz1knVd9HWgufMYvshbWKWPal27eBL46FSpycKb/nYTdeTxh0TohtQJ36A
         2AzZiXpmrNGD+X4EESNIFxsVXWNVeOPyXbBRV/8OZSD1brZnQeRm9lYH1TocdKejFOYS
         YfXHNQUm8xDD64zQ6Zin5zq1NT2620JufHCCk7eejxbQaoqTByeoqsVxbqDojqMT9J1g
         C0OF9FWHTtpO2lklrRZLFemD7oO6VsUW9p08PlBG3Yca8DPRRiEb4dqUXsVoFsEa7bUf
         KFIWRJn3qNMtVe/gLKct9WR6HKAWd4Q0L/HDI2h9TMC29+hdZkkIr2QvrEAi5yI5RORv
         uKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722197155; x=1722801955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qeNIwj16ieiaUyi224RZB9BZqdEjEHvR9Is2j0uLPw=;
        b=XcMA5c3dmvv7bXz6DS20Oy3f+q8sM84oFdtEyDEayhthZFWjyiyUbQ4VwsRgaGf7oy
         kw+rtp6UJHDmrtkq13tFcby1e9dN+ZCB7cuLTg/cWLrTnlEuhrL14ZWf+FO4aP5FxTwk
         qyoJBdDmcC/bWR8ZGEst4DktEzlFre4OyC/GVJxpbirCB5KJfaXi5gs5UshY20PRn9c/
         G8T77Sip87xoTh8kNoxkjEJJ4IcKo62FHal9oxe/RlpXmE4a0Xc+0xuGNlwgBhDXKf5X
         ELP/aJAmOLZ3cBsAm332BZoYMJfW7C4WCmv4RUV1LfjlJcBZb9bee2i5HuFqIqsOzuKE
         qXzA==
X-Forwarded-Encrypted: i=1; AJvYcCX/XuAL0sVlR82rXI/+lvifjSdF56rT9+iYTKOLkadYDk7II/AgAr2lfrejqcJ1hY0YPwWkzcyaxXNCVQ0CG2G1LqCMv9veiS8=
X-Gm-Message-State: AOJu0YxdsPdik4FR4lForZ7BAZcry7w2r/6bk+UCDPgIzpUgJrNwJHxi
	ilOEAYsYrOKRJof9KLluAkQDR2I3jCL8LphAq8IlMSgd12TGKfI8UVPfv6mjkecp2OBPdj85Gb/
	YxjI4ogehiGtnKybQPgoYDbv8rNNMK+GMJdxgb2hKOy6MC5k8Sys=
X-Google-Smtp-Source: AGHT+IH4VuGtnxaaMubh5K8LxqivpdTRbAvbqN7TNbbLCLoKj6PCh4Ss6cSMuqSbY7Yz6HIX8oOVeIGVxbVBUgzgnio=
X-Received: by 2002:a05:6902:c08:b0:e08:5f16:813 with SMTP id
 3f1490d57ef6-e0b5464eb88mr5349192276.53.1722197154745; Sun, 28 Jul 2024
 13:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7> <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7> <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7> <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
 <20240725112519.d6ec7obtclsf3ace@vireshk-i7>
In-Reply-To: <20240725112519.d6ec7obtclsf3ace@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Jul 2024 22:05:18 +0200
Message-ID: <CAPDyKFqTtqYEFfaHq-jbxnp5gD7qm9TbLrah=k=VD2TRArvU8A@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 13:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-07-24, 11:21, Ulf Hansson wrote:
> > Right.
> >
> > The main issue in regards to the above, is that we may end up trying
> > to vote for different devices, which votes correspond to the same
> > OPP/OPP-table. The one that comes first will request the OPP, the
> > other ones will be ignored as the OPP core thinks there is no reason
> > to already set the current OPP.
>
> Right, but that won't happen with the diff I shared earlier where we set
> "forced" to true. Isn't it ?

Correct.

>
> > > I think that design is rather correct, just like other frameworks. Just that we
> > > need to do only set-level for genpds and nothing else. That will have exactly
> > > the same behavior that you want.
> >
> > I don't quite understand what you are proposing. Do you want to add a
> > separate path for opp-levels?
>
> Not separate paths, but ignore clk/regulator changes if the table belongs to a
> genpd.
>
> > The problem with that would be that platforms (Tegra at least) are
> > already using a combination of opp-level and clocks.
>
> If they are using both for a genpd's OPP table (and changes are made for both
> opp-level and clock by the OPP core), then it should already be wrong, isn't it?

They are changing the clock through the device's OPP table and the
level (performance-state) via genpd's table (using required OPPs).
This works fine as of today.

> Two simultaneous calls to dev_pm_opp_set_opp() would set the level correctly (as
> aggregation happens in the genpd core), but clock setting would always reflect
> the second caller. This should be fixed too, isn't it ?

As I said before, I don't see a need for this. The recursive call to
dev_pm_opp_set_opp() is today superfluous.

>
> > To be able to call dev_pm_opp_set_opp() on the required-dev (which
> > would be the real device in this case), we need to add it to genpd's
> > OPP table by calling _add_opp_dev() on it. See _opp_attach_genpd().
> >
> > The problem with this, is that the real device already has its own OPP
> > table (with the required-OPPs pointing to genpd's OPP table), which
> > means that we would end up adding the device to two different OPP
> > tables.
>
> I was terrified for a minute after reading this and the current code, as I also
> thought there is an issue there. But I was confident that we used to take care
> of this case separately earlier. A short dive into git logs got me to this:
>
> commit 6d366d0e5446 ("OPP: Use _set_opp_level() for single genpd case")
>
> This should be working just fine I guess.

It's working today for *opp-level* only, because of the commit above.
That's correct.

My point is that calling dev_pm_opp_set_opp() recursively from
_set_required_opps() doesn't make sense for the single PM domain case,
as we can't assign a required-dev for it. This leads to an
inconsistent behaviour when managing the required-OPPs.

To make the behavior consistent (and to fix the bug), I still think it
would be better to do something along what $subject patch proposes.

Kind regards
Uffe

