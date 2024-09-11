Return-Path: <linux-pm+bounces-14028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4F975515
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF49B21657
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA641885A7;
	Wed, 11 Sep 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEnyciSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE526AC1
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064167; cv=none; b=utcYh9hqcS9MuNu0twcNKNUxUV5Rytk581xASysshC0t5H/w/bQvP/W1BMwWOdvtE8W6ToMLBAQ4762S5I5PtBxlsglGSWPKhIAFxVjYO5TYD+IYvYoOZDEku8oMbG4AdddOP5tVTm2HyjNbGkFvP+atrKRVWqTKRw1LPm10nhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064167; c=relaxed/simple;
	bh=zpw544kJb99C7V2QA8EV2Xh4RIz9pXAREp35pyCql3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlSvpbJXLPcIcqNGydlltwlO6Z4Vj4ej1H9WAKvDMBsdbnExHilH7tzfdgXF3E6ELGUVl8EaIpdkjUbyfPgP2e4UNvShTXOGSqixtyDc7ELxT9zvfW4dZ1RH89M/7uGOSvxa1Wjal2Zm7HlTX3mgFKAVCc1rCGG1acfwBAoJcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SEnyciSW; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso6830245276.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726064164; x=1726668964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zpw544kJb99C7V2QA8EV2Xh4RIz9pXAREp35pyCql3U=;
        b=SEnyciSWfcPkfvO2mYl1YcWMr2fKguZ+WMSARIqbarbqDgItHAp66hPOcZo7LAcEss
         SDmTTuuWBJEi5O5feXxw0VSrN7wOWfZw+L10w4MYxZC/iYbgWtu5azeN96lvPqbwl1hT
         PBkkHIWEbcbGQwqaaiX9ndRyDC+h3RVo1xUDMhy2JMeg1gGdcK3e4/PsffXW/3kUaIVa
         Yhcf5+XXxGitngs/uzscdexy1kpu0X1uFTzVtG5B17vzA8Jdtn4NEwVXR2M2sDRQ6cX3
         7qA1vDYX/ikRqEJxOAAo+uAIxv0dPlwJ4OhDPFPf6JLs4yGKgrJzk+EB10aIP5rqVHGu
         05Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064164; x=1726668964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpw544kJb99C7V2QA8EV2Xh4RIz9pXAREp35pyCql3U=;
        b=W2OTSnXM/oeTnq/JDV3SFqq2I0p6Qqlh2PWZrp/Bg4BdTXzcxmpAVuoobZceDIg3DT
         R6icIWxHlKDXmKBz59wvUYATp1hflcmsSJEhcBua3R1l1PfBu+8s0c08MWKnHCfW1CEq
         9jws6FXllT2m+cyv6M7zZs9RxIpFd1RlQmeFygwK/Z38Hj942SbF6DIJfRkkLwhWMgBc
         W/jCwiFGPGv6Ux97FLfvH7ly+QoRpM/+2Ifps4SW2HwrEdjt4ojNrQF59JGjyoK0ZpMz
         zc+G6ThiaD63HxG1Yn93HNGxm/adkHvO4fmR13V3d7/48Uw1rGuMET9AR65s/uDOba8m
         TSOg==
X-Forwarded-Encrypted: i=1; AJvYcCXwlnPFofrcQ1YFBqroF8YdYHUSJd5ngyZfLcPHX8E7lOD2nxmzer+fsF8xj902b1fU/0bevweNeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsROfUlhVlrIM9uUZWgTQ1hAzA1unw22VC6/ZGReIUl5v+BrG3
	zgYwEezKxfbJ6xtFl9Nq3vgmLynua0jctflWd9IfZozx+kcYkHjjn5uJKSfTzUqw5/pcHS/ErWQ
	xLB9e7XFFpdFrsXGJRisjnO0mb/mUNQW1sfIEpA==
X-Google-Smtp-Source: AGHT+IEot1ldnziQJykDX2V9Zx+o1+BcO7NdK/qhxMhKxDGfObrOoowZKUuQwltatFXxPEK5CTASOdwRLPe2F83pWJ4=
X-Received: by 2002:a05:6902:200a:b0:e0b:b2a7:d145 with SMTP id
 3f1490d57ef6-e1d34a0d41bmr13115799276.55.1726064163806; Wed, 11 Sep 2024
 07:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
 <20240903105321.suosbhkkkylfw4bv@vireshk-i7> <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
 <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7> <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>
 <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7> <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
 <CAKohponJsqOYAvQqU2qrBCXv_P0+0zKAm7-5gkKGPsF_kT7L0w@mail.gmail.com>
In-Reply-To: <CAKohponJsqOYAvQqU2qrBCXv_P0+0zKAm7-5gkKGPsF_kT7L0w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Sep 2024 16:15:27 +0200
Message-ID: <CAPDyKFpHYv1eEy==bHhCg6cX9MYdZr_VDoFKBnucZseQVkQWDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 08:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> FYI, I am on holidays now :)

Oh, nice! Enjoy!

>
> On Fri, 6 Sept 2024 at 14:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > How do we differentiate between two cases where the required-opps can
> > > be defined as either of these:
> > >
> > > required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> > >
> > > OR
> > >
> > > required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1
> > >
> > > I thought this can't be fixed without some platform code telling how
> > > the DT is really configured, i.e. order of the power domains in the
> > > required-opps.
> >
> > I don't think we need platform code for this.
> >
> > When registering a genpd provider, an OPP table gets assigned to it.
>
> So we will create a real OPP table in code, which will point to the common
> OPP table in DT. Fine.
>
> > When hooking up a device to one of its genpd providers, that virtual
> > device then also gets a handle to its genpd's OPP table.
>
> Right.
>
> If there are two genpds required for a device from the same genpd provider, the
> picture isn't very clear at this point. i.e. which required OPP
> belongs to which genpd,
> as both have same table in DT.

I agree that it's not very clear.

But to me, this seems like an orthogonal problem that really should
not be managed by platform specific code in consumer drivers.
Moreover, unless I am mistaken, I believe this isn't really a problem
for the currently supported use cases we have for required-opps. Or is
it?

That said, we already have two methods that helps us to deal with this issue:

1)
For a genpd OF provider that provides multiple genpds, the genpd/OPP
core tries to assign an OPP table for each genpd, based on the
power-domain index. In other words, if corresponding OPP-tables are
specified in the operating-points-v2 list, those would get assigned
accordingly.

2)
The genpd OF provider can control on a per genpd basis, whether there
should be an OPP table assigned to it. This is managed by assigning
the ->set_performance_state() callback for the genpd or leaving it
unassigned. Typically this works well, when there is one OPP-table
specified in the operating-points-v2 list for the provider - and only
one of the genpds that should use it.

If it turns out that we need something more flexible, I think we need
to look at extending the OPP/power-domain DT bindings. We would
probably need a "by-names" DT property, allowing us to specify the
mapping between the OPP-tables and the power-domains.

>
> > Each of the phandles in the required-opps points to another OPP table,
> > which OPP table should be associated with a specific genpd.
>
> Yes, but a simple order reversal in DT (which I sent in my last
> email), will not be picked
> by code at all. i.e. DT doesn't give the order in which required OPPs
> are present.

Assuming genpd OF providers are following 1) or 2), I don't think this
should be an issue.

>
> > In other words, the information is there, we should not need anything
> > additional in DT.

Kind regards
Uffe

