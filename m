Return-Path: <linux-pm+bounces-13761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2396EE88
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77771F2180B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70721156238;
	Fri,  6 Sep 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thfqbTkw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51568BFF
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612596; cv=none; b=GSuTISDzLQgLRNHc+TxO8nZ+D2XfggskHR3gc0vEs8Dd1oIMGcIhUa0nwVEW/1Cb6Fka4ITW+uqqTPhIjjJQGAJmHET7i4V0W+Au+uNpUIoF4sfz3CHt9LKQ5dajqdgVaT07fOa5ddjiemPAcaAle12WjDgyy9ov5i6F/9pD+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612596; c=relaxed/simple;
	bh=4j+xA8Np1vhYYDzwctbUrNK37qB7oXmgVzMqNnvoab0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTWRLYdYitm96+hobr0aXM6zifUdocem9UgUFt/KdXnNW9nuK5N4tWmrb/tk9rEepoc6GJRkep+8nLXmP6bb2HcEW6ZC8pft3o/1Q2XDrX66sfOQN8lTLhdXg8CxTriMQjhy/qCz4/vZWzRQd2mRDhLQvaoWu86DTBz9J3kuwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=thfqbTkw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1854817276.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725612594; x=1726217394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1BzqdqQe6y9gQJcPLLSM3ZzX5+39rivWVxZta/SdSo=;
        b=thfqbTkwKkKtGIjFzV3xjinogeh9vRP4T1mfy0igCaoZQxqZJzGjiCJFmTWVYQbJg3
         IOiQTtwHiWUv4oohbCOFOBhyZQa4826luEMuzKhJKp7IMWNlfxZC7ejKlylUQ++JGj1C
         TsP7U2/JfJbvrZDx3hmqbJ2tpnqS0qKMsXCo1e4/Qj0pDCRC8su663hoOpVixewXD3HP
         uYh50HvzdfFxYkXo9lPlgi1DqyuVR/S/jly1dyY4HI4vUG+g4arRwfhtBHahDB5p3pnh
         imUFciiihyqiwMCOREtqbSufqmNvYokchi48mMozpJRvriES6o+IlcaFSzSXZmcru/Qz
         wX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612594; x=1726217394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1BzqdqQe6y9gQJcPLLSM3ZzX5+39rivWVxZta/SdSo=;
        b=H7kZy+QHWR6hAjVDzuXgBdAjVynqyY3FcBpseuVcdR2E8pXeNwDGrLbIc4Hfigp2WS
         SV3I1hOlbt5z9MJ7D1wVxWXv0YqTIIj+Xm9AzImduZhGwyLgYFu0H2mmA9/F7Yted2Sn
         5TcnX7G0yDwS4x6S+DdMG3AIDZNJpONxLH1ZrvnF051vL1LfOijt1UeeR7MnZGUezT4N
         diGlQ/vF91H9xQ4E4xkzlba7nVuYnyQSVw8t8a9QNXBAq0N/8lcqq0JSm11+5ef2lBQC
         Nw7sz3092p0N0OGQn4BeOnfkDOS17Owp6bwPVFcjerXkrrSZxCTFCOoSuZIEvGDAgyvQ
         MC4g==
X-Forwarded-Encrypted: i=1; AJvYcCXBpC7p1HgjzcPZTyJ0Wt4KI1gII5GrdM89Hd1X2O5tRk/El4Lsb64Xft9zFUIDzZb1+IF/M9nTkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPjJ8Hxw1wAt+zYRUfkvTa5DKVuuQ1mbucFnFMTcQGKTQLgyW
	UlVivvA2y8+PS20EZ3OXXu58TKzSlO+HC/eowdGyQ31RhR7vCusmuVQFTJqFuxqbBxP0dRO1Fp9
	N3KC/+szA3zcqlBf4IWWmk3SnzRdu7R+fCOvx2w==
X-Google-Smtp-Source: AGHT+IHGxSbE/NE5PDqLxc5pXTVylIfDPFOzzeODSdvXFNuUYnR4N34XJw+Tr2XTBa+Gby93rK8fgt7N+kyqrZ6A0+o=
X-Received: by 2002:a05:6902:1245:b0:e1a:b102:4802 with SMTP id
 3f1490d57ef6-e1d349f20f5mr2581521276.35.1725612593745; Fri, 06 Sep 2024
 01:49:53 -0700 (PDT)
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
 <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7>
In-Reply-To: <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 10:49:17 +0200
Message-ID: <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
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

On Fri, 6 Sept 2024 at 08:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-09-24, 14:57, Ulf Hansson wrote:
> > > Yeah, I missed that, it doesn't happen via DT but by platform code. I
> > > do see problems where situation would be a bit ambiguous. Your example
> > > with a minor change to your code:
> > >
> > >         opp_table_devA: opp-table-devA {
> > >                 compatible = "operating-points-v2";
> > >
> > >                 opp-devA-50 {
> > >                         opp-hz = /bits/ 64 <2500>;
> > >                         required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> > >                 };
> > >                ....
> > >
> > >         devA {
> > >                 compatible = "foo,bar";
> > >                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> > > pd_perf0 and pd_perf1 has OPP tables.
> > >                 power-domain-names = "perf0", "perf1";
> > >                 operating-points-v2 = <&opp_table_devA>;
> > >         };
> > >
> > > Here, I don't think there is a way for us to know which genpd does
> > > opp_pd_50 belongs to and to which one opp_pd_51 does.
> > >
> > > We solve this by sending clock_names and regulator_names in OPP
> > > config structure. That gives the ordering in which required_opps are
> > > present. The same needs to be done for genpd, and then genpd core
> > > would be able to attach the right genpd with right required opp.
> >
> > No, we don't need this for gend as $subject patch is addressing this
> > problem too. Let me elaborate.
> >
> > The OPP core holds the information about the devA's required-opps and
> > to what OPP table each required-opps belongs to
> > (opp_table->required_opp_tables[n]).
> >
> > The genpd core holds the information about the allocated virtual
> > devices that it creates when it attached devA to its power-domains.
> > The virtual device(s) gets a genpd attached to it and that genpd also
> > has an OPP table associated with it (genpd->opp_table).
> >
> > By asking the OPP core to walk through the array of allocated
> > required-opps for devA and to match it against a *one* of the virtual
> > devices' genpd->opp_table, we can figure out at what index we should
> > assign the virtual device to in the opp_table->required_devs[index].
>
> How do we differentiate between two cases where the required-opps can
> be defined as either of these:
>
> required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
>
> OR
>
> required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1
>
> I thought this can't be fixed without some platform code telling how
> the DT is really configured, i.e. order of the power domains in the
> required-opps.

I don't think we need platform code for this.

When registering a genpd provider, an OPP table gets assigned to it.
When hooking up a device to one of its genpd providers, that virtual
device then also gets a handle to its genpd's OPP table.

Each of the phandles in the required-opps points to another OPP table,
which OPP table should be associated with a specific genpd.

In other words, the information is there, we should not need anything
additional in DT.

Kind regards
Uffe

