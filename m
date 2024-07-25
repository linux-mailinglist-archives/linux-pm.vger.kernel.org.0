Return-Path: <linux-pm+bounces-11393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D290F93BEFA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFCB1C214B8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A92197549;
	Thu, 25 Jul 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiwxPXij"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655216C690
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899348; cv=none; b=CD9gbZe2D0z7fL3LFlWAoLPOqLoUhkKJzz4HZRWGUkWD6MooljgVjkKVdaU1OI/aGSW7tqBemJEFd3bp9f7OF6WB4JxDVCexFcpmRjOO7mxQgpRO2OooT9Z60yAlEUQgar+Nq182YGLpWtvM/zAbMeN8Fix7ROuyzjN9ywVUKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899348; c=relaxed/simple;
	bh=bLdP/yluvMBuIJt5YOH7LjpEzuVagCOShgdj7rj20iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePQa8MTfAloYgqHPhWmmiLT4MYFekE9CD8Yjc+4HcCJVg8/gnR2rgrZlNEJC6YN9wDKwhJgNp9RSgUz7UfbrSE0UBz8F4hltYwqx+Y2pC+T3XDDJcdyYu6VZXOszryX4pNQJ6ICTrm5NKBEc846nbR4GyAfAad61IberLiv3TSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fiwxPXij; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e026a2238d8so649296276.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721899345; x=1722504145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLdP/yluvMBuIJt5YOH7LjpEzuVagCOShgdj7rj20iM=;
        b=fiwxPXijBCu7+N8DoCx2O94TElHx8cHfp4nWrtKajcuoxmzPN+AiKgoRA6jhzu4Dpt
         I6iak6KREbCsIUW8+DUNCkhN1i+pVECnrttjkE53J6/dqI7OlR1SpIMehHQGBaGyV2zN
         HbYz8TeOWnaFUNc/XimaUNNbPS+3gVfKkp9x4PwkHHwHedH/yPXGN3E2oVgp/PrbBUYD
         97qNNzFMP+GindQeEqJmk94tFit0d7/zk4UvMQP7br8DxIGdoby8CNMfIWYukbvlDT+W
         qSJfkBPe+Un0EMc6rqDkwNBxRIztcZMnCFB0s7gp/AoxTmsGdazuy+FLN+HSq2cPHI9c
         mojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899345; x=1722504145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLdP/yluvMBuIJt5YOH7LjpEzuVagCOShgdj7rj20iM=;
        b=DwMux9otkcoitsElFxouCe2rES9dyit11urr/B6n5JCYpb0x4LipnbIvUCURa6A6bM
         5IXN7Np2IV1lkr+HbjOSpAsAkSlkWBIhOfS8Y6UR4whZylMHVaxAkqDl7814Fjf65s5e
         CGBeZYcFgQ19mneDWS1mr5zVNRf5v+nzylIq0Ezy8LPflWDbDn/jv8cdV55bhoyQAKjX
         LpMmW6Pix2YGsfEJs/Z0YqcfUBKO6L2YCahH/YV7zZC/112GWahTtGzTGFuK4HyangHn
         twLFfcWRvBH6yJLGEmXTus0FbDMtRPQEphQPgzTNkNwCPQDoR7bacXmsMSgPvoxqtjl+
         S33g==
X-Forwarded-Encrypted: i=1; AJvYcCU1AAfI6oS3iXA7jYoosoqLe1r/K2d9sxNflP/d1dW2yfDpcC4tAympuBoV9u7W1gmgPuMvKUWbv0hxV90NySJVJhDGnZEWFSI=
X-Gm-Message-State: AOJu0YxRgCfgbvasLlmtJ59hHaN8ZwMXwCW0yhu8qLJxXweuzvq5VfwK
	tRi/SpSd29CbTTabTBSmJN1N8JPDXYfMTfyKU3X9BMOF9LAbt8lAknuj4BfyfOa9PGkab4iGiGb
	Mh3VPhlNUBVpW8l1/j8e79+kjBxTVuCfADCKajQ==
X-Google-Smtp-Source: AGHT+IHv32q/Dww8pcfbsHuuIT4hJr8/2ZHQ97ux3ZX4BwITDamJ4v4NkMFXVPjNU54b72O6TOTXdehGNiVfv1jQFf8=
X-Received: by 2002:a05:6902:70d:b0:e02:b51f:830f with SMTP id
 3f1490d57ef6-e0b2cd8ec12mr1229263276.41.1721899345252; Thu, 25 Jul 2024
 02:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7> <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7> <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
 <20240725060211.e5pnfk46c6lxedpg@vireshk-i7>
In-Reply-To: <20240725060211.e5pnfk46c6lxedpg@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Jul 2024 11:21:48 +0200
Message-ID: <CAPDyKFpSmZgxtmCtiTrFOwgj7ZpNpkDMhxsK0KnuGsWi1a9U5g@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 08:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-07-24, 12:38, Ulf Hansson wrote:
> > I understand your point, but we don't need to call
> > dev_pm_opp_set_opp() from _set_required_opps() to accomplish this.
>
> I _strongly_ feel that the OPP core should be doing what other frameworks, like
> clk, regulator, genpd, are doing in this case. Call recursively.
>
> > In fact, I have realized that calling dev_pm_opp_set_opp() from there
> > doesn't work the way we expected.
> >
> > More precisely, at each recursive call to dev_pm_opp_set_opp() we are
> > changing the OPP for a genpd's OPP table for a device that has been
> > attached to it. The problem with this, is that we may have several
> > devices being attached to the same genpd, thus sharing the same
> > OPP-table that is being used for their required OPPs. So, we may have
> > several active requests for different OPPs for a genpd's OPP table
> > simultaneously. It seems wrong from the OPP library point of view. To
> > me, it's would be better to leave any kind of aggregation to be
> > managed by genpd itself.
>
> Right. I see this problem too and that's why I said earlier that OPP core was
> designed for a different use case and genpd doesn't fit perfectly. Though I
> don't see how several calls the dev_pm_opp_set_opp() simultaneously is a
> problem. This can happen without recursive calling too, where simultaneous calls
> for genpds occur.

Right.

The main issue in regards to the above, is that we may end up trying
to vote for different devices, which votes correspond to the same
OPP/OPP-table. The one that comes first will request the OPP, the
other ones will be ignored as the OPP core thinks there is no reason
to already set the current OPP.

>
> I think the main problem here, on how genpd doesn't fit with OPP core, is that
> the OPP core is trying to do some sort of aggregation generally at its level,
> like avoiding a change of OPP if the OPP is same. I think the right way to fix
> this is by not doing any aggregation at OPP core level and genpd handle it all.
> Which you are also aligned with I guess. This would also mean that OPP core
> shouldn't try configuring, clk, regulator, bandwidth, etc for a genpd. The Genpd
> core should handle that, else we may end up incorrectly configuring things.
>
> I guess this is what you were trying to say as well, when you were trying to
> replace the recursive call with set-level only.

Right, I think we are in agreement. Aggregation of the
*performance-state* (opp-level) needs to be managed by genpd, solely.

>
> I think, we don't need that change but rather avoid all these extra settings
> from dev_pm_opp_set_opp() itself.
>
> Also consider that genpd configuration doesn't only happen with recursive call,
> but can happen with a call to dev_pm_opp_set_opp() directly too for the genpd.

Right.

>
> > The API as such isn't the problem, but rather that we are recursivly
> > calling dev_pm_opp_set_opp() for the required-devs.
>
> I think that design is rather correct, just like other frameworks. Just that we
> need to do only set-level for genpds and nothing else. That will have exactly
> the same behavior that you want.

I don't quite understand what you are proposing. Do you want to add a
separate path for opp-levels?

The problem with that would be that platforms (Tegra at least) are
already using a combination of opp-level and clocks.

>
> > In the single PM domain case, this would simply not work, as there is
> > not a separate virtual device we can assign to the required-dev to.
>
> We can assign the real device in that case, why is that a problem ?

To be able to call dev_pm_opp_set_opp() on the required-dev (which
would be the real device in this case), we need to add it to genpd's
OPP table by calling _add_opp_dev() on it. See _opp_attach_genpd().

The problem with this, is that the real device already has its own OPP
table (with the required-OPPs pointing to genpd's OPP table), which
means that we would end up adding the device to two different OPP
tables.

Kind regards
Uffe

