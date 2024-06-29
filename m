Return-Path: <linux-pm+bounces-10234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55F91CBD0
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339F41C21143
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB02C6B6;
	Sat, 29 Jun 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ngrv0r6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9D3A1BF
	for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652180; cv=none; b=PW71PkQsqr1QL/ffXfGgZ//fTNSl81IuWKj9ohSqUBGK7z8VSmGUW1zaAIDRhHLdpcDZYCZSvrKffgdhQb2j2Ffk1O+X0rjnhyEh3f3iIwWU2KH7NjpI9rdAdOdDnmM2vT5K7i3M3/fb0ZAoC5HhgGsi7pswo225nbljW0Njzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652180; c=relaxed/simple;
	bh=pU6vIjo0TJnurmPKVN5fHzou8qKVGA8HMkigq1y0Vo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAAZDXp17auoO0gweVxKf52z9Vo6DKVuu+gHhrOopsF6QGMBDwP3CTc6C/pS+50lXm2aFIyO3G0DBBrVwgySfpDJ6tIGIPqQsUygEJea0SHCwf7KdgAQyf8fqFPqejVgsvUEuvhCewsJyVuqUtyFjbJkd74IpXEPZBoaS5OOHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ngrv0r6q; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0365588ab8so991091276.1
        for <linux-pm@vger.kernel.org>; Sat, 29 Jun 2024 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719652178; x=1720256978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkImzYcOHr6ta3CkXEXaNWAHjpKXh0wLH49g05i5piU=;
        b=Ngrv0r6qYygTVndfuBJJUv3YpH/mV3ehBXFdB2yUeQx1dphphTcPiTnKYKLsR9DRyc
         zgXbA1gMHqyWAmLiELJYl4n0D+YV4qKzY1++XyEgbbZrlJn3Wk9KsvwSX6qWsHM8NmD2
         Zaq8DhR0kAEJ4Tgafh3WnYM1hIYeS2cpI9/N+SgB2KRQK4k+8MAtkTTCOygOlzHP3sN+
         AZ2tv5v6DNqg28j2pR3o8BRngpTQ/gkXTKvmsRG9M8pWGR12212yXtAyXLvB7goF77un
         fYoqwNptaKQWpQ8QjZyUBO7VI/l/q7nkWZEEepe/RH8Zuihm/gYf+Xjm1S4wVmpXzBY9
         b6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719652178; x=1720256978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkImzYcOHr6ta3CkXEXaNWAHjpKXh0wLH49g05i5piU=;
        b=unHSeAyP0gmvtRQSQPV1RTPDNeceZU4G1IBo3JUth3rMvQnv9ZDEfU4v0U/KbgbVcW
         +5tLlun9q4vApFLrWLEyJ4iltSBLuP1qUs6fPaigo9yDWqa0LARyEibYa5gU73JvfH0s
         Vigjtk4Gti7vzHU0rB0bej/tiHS5roKH78G1Mr4iSpL0tyVtbDyAr0r8fUVM7JrlMzpc
         tPHB+FJ0iZ4zvrYGgEu6nELNVYAWbflinL2/9m6BQMZYDIkpSv82bUM4zsKaoTVlqJCB
         F3DiYvt9fEU7nvszB2sCx8VRWL9CTGgQmKXtEnzJiRcERI6QeYcdK2M0i5bx7gJeXWeZ
         KH+g==
X-Forwarded-Encrypted: i=1; AJvYcCWe6k8R3UzRI1MxVlQ4ZPxUp9n8N5RoaWJ5lGBRhOvybQdxmJc0cHUqTaaSizep1009UGv7efQ7P37yIuJY3NJAmkrxQlynMLA=
X-Gm-Message-State: AOJu0Yz1qwZPg9rbHCxbq440/eoWgAn7tNBa08t48peI4VoO/i4kSb0D
	XyUYhHtmrxrUWSq9cs1wULY2MvfHYv32L3KizYkwL31tHLZNUhumGHiqzcvKob9HKPfsF/FOGG1
	ViRFUljS8FImPdNXM8GHwlSyEQAzCWbEPXJXxOw==
X-Google-Smtp-Source: AGHT+IHxoU4c9TW2ne/DKIUjalit3R983R9bboCeUNagSULPiKVpmA1NJ6hShMYv2gdgc3y6LWGxhjn/tJtAAq3MAak=
X-Received: by 2002:a05:6902:341:b0:e03:577c:b21d with SMTP id
 3f1490d57ef6-e036ec9cd86mr407694276.64.1719652177731; Sat, 29 Jun 2024
 02:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org> <20240625105425.pkociumt4biv4j36@vireshk-i7>
In-Reply-To: <20240625105425.pkociumt4biv4j36@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 29 Jun 2024 11:09:01 +0200
Message-ID: <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 12:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-06-24, 17:50, Ulf Hansson wrote:
> > In _set_opp() we are normally bailing out when trying to set an OPP that is
> > the current one. This make perfect sense, but becomes a problem when
> > _set_required_opps() calls it recursively.
> >
> > More precisely, when a required OPP is being shared by multiple PM domains,
> > we end up skipping to request the corresponding performance-state for all
> > of the PM domains, but the first one. Let's fix the problem, by calling
> > _set_opp_level() from _set_required_opps() instead.
> >
> > Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/opp/core.c | 47 +++++++++++++++++++++++-----------------------
> >  1 file changed, 24 insertions(+), 23 deletions(-)
>
> >  /* This is only called for PM domain for now */
> >  static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> >                             struct dev_pm_opp *opp, bool up)
> > @@ -1091,7 +1113,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> >               if (devs[index]) {
> >                       required_opp = opp ? opp->required_opps[index] : NULL;
> >
> > -                     ret = dev_pm_opp_set_opp(devs[index], required_opp);
> > +                     ret = _set_opp_level(devs[index], opp_table,
> > +                                          required_opp);
>
> No, we won't be doing this I guess. Its like going back instead of
> moving forward :)
>
> The required OPPs is not just a performance domain thing, but
> specially with devs[] here, it can be used to set OPP for any device
> type and so dev_pm_opp_set_opp() is the right call here.
>
> Coming back to the problem you are pointing to, I am not very clear of
> the whole picture here. Can you please help me get some details on
> that ?

I get your point, but I am not sure I agree with it.

For the required-opps, the only existing use case is power/perf
domains with performance-states, so why make the code more complicated
than it needs to be?

>
> From what I understand, you have a device which has multiple power
> domains. Now all these power domains share the same OPP table in the
> device tree (i.e. to avoid duplication of tables only). Is that right
> ?

No, that's not correct. Let me try to elaborate on my setup, which is
very similar to a use case on a Tegra platform.

...

pd_perf0: pd-perf0 {
    #power-domain-cells = <0>;
    operating-points-v2 = <&opp_table_pd_perf0>;
};

//Note: no opp-table
pd_power4: pd-power4 {
    #power-domain-cells = <0>;
     power-domains = <&pd_perf0>;
};

//Note: no opp-table
pd_power5: pd-power5 {
     #power-domain-cells = <0>;
     power-domains = <&pd_perf0>;
};

//Note: The opp_table_pm_test10 are having required-opps pointing to
pd_perf0's opp-table.
pm_test10 {
    ...
    power-domains = <&pd_power4>, <&pd_power5>;
    power-domain-names = "perf4", "perf5";
    operating-points-v2 = <&opp_table_pm_test10>;
};

...

>
> Even if in DT we have the same OPP table for all the domains, the OPP
> core will have separate OPP tables structures (as the domains aren't
> connected). And these OPP tables will have their own `current_opp`
> fields and so we shouldn't really bail out earlier.

In the use case above, we end up never voting on pd_power5.

>
> Maybe there is a bug somewhere that is causing it. Maybe I can look at
> the DT to find the issue ? (Hint: The OPP table shouldn't have the
> `shared` flag set).
>
> Maybe I completely misunderstood the whole thing :)

The DT parsing of the required-opps is already complicated and there
seems to be endless new corner-cases showing up. Maybe we can fix this
too, but perhaps we should simply take a step back and go for
simplifications instead?

Kind regards
Uffe

