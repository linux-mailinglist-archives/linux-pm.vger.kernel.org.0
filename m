Return-Path: <linux-pm+bounces-13573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D496BD6D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C51F215AB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8941DA607;
	Wed,  4 Sep 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcDSA0P8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAA1DA31F
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454667; cv=none; b=TEo/2cUs0U06uds47j4PYC4k2YiWmL1OUbTxN0i+uS2hUKBGANNmjcsnU1ZM9+huYi7uZoC+ZMOblh0KQ/7VeZGFJ6K42EU6yohvr/kw2pUUJxEHJhx1/VcrDPJfb9j3EZKXK5BNPsklynidpBTCtLLA2IU8sS0kTigwU9IFmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454667; c=relaxed/simple;
	bh=9E2sEOIlaoNEZOy1HfVJKJTyT/pV/HhU4SufJHG+JU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMhBwIHYY2/fjP+RY5DscVC+XwlIyPG8tnsTh2kpn9JXfiQuy6PoZkgXCvuQ7eUegn5kQaI1fe5PBtfzEg0hiI+LVEvCvFc4NAbZKLOLTO9Z0tMrSARPGhFhogxOcIcrWATFOiUDTTXkg/t7S/ypwpJUL44SYb6bUTC0AR7RmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcDSA0P8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e04196b7603so7105375276.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725454665; x=1726059465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40ANBPXcSCxw7uCvibaj/PvGGL8rKu8dFRasC4YYI2c=;
        b=YcDSA0P8o5/ChCRz/K16Tld4GpmWAAQxTEa0RKgAlW/PNrSwupEVZhr7F9T8KB/qXE
         avCQjo4W2RNHDKnLKtTAXK7ZEa2YWcvHOeHT7fPIYCUfrwi3FYup2DRf7G1+lSUPOzt3
         xLeEZF/3OLq2EZKUW1EMnYnvt3EHPyZDWRPo+xDTJyoTO3/8BXRK7mKezuLsSzgDrKa5
         WvcTRxFBd+sgzzbwZIo2kNGsfHqmyC7jZF71Moqfq/h7fXotL8HbiM0x2c9FKZKhp6ao
         qB1mqpaDQ260P2/d84PzLKSgKhlA8R9FHs70eDRTOIcWQMrec9bxd72EypFg07PSAKt7
         Zuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454665; x=1726059465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40ANBPXcSCxw7uCvibaj/PvGGL8rKu8dFRasC4YYI2c=;
        b=rUFR4ioxXoHO6xot6zjU7kWXKANtdjwf3qEDhOhOeOGccu9pQTOwwq5UaASfE+tUj0
         aZGnFMpRdg7Qx7xKAZ6qdrEG6qn/KIj6DBy+esHyd4smfukheIeCtjJ15ZJaqYgYdJ5Q
         xL+ZOlCzytGb9XO44gnECS7ncTw05RTpXfnB5AULJDbP1GyxENj5oKVlJBp+GVu7QS5Y
         WfzUM5ZXN3ZYHXGIrNWjfVrfAaRTW5YknB4nmaAvzPvp+neGm7ay3w18Pz1VSjzTvZxO
         TpgAhv0NGTQCeU7C72GcvKZ6KbsFM1mBQ7C12TsmLr9ZRM0V4WYl1LLdHE6J9KDusm17
         QCrA==
X-Forwarded-Encrypted: i=1; AJvYcCX5wrLe6V5Cr8Yvad9JL/iQfhS/059C062Si4/vUQ99ThUDFdW7YLZQ7h9tKjq9gdX1GTyrKQwM6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OkeFHJpFyj5BVDgb3/eFa0DPYwAO2XsHAftiabWRNsm3kGPk
	OnpnMd5q+wKWch1Ymf4gn775h5VIV5MplAK0fhrfUDMwmuUFaeGaqQyya1OQ7RHqF/RfFIdoduF
	3dXIKmS+6LV1nGXqt4nxk9AdWU4J6A1RXH7cDqA==
X-Google-Smtp-Source: AGHT+IFTNPkgqyCMw8p07kCpHFqTvauPXMIZuzWkhMd/PM7xx1hGw4E57ep2OyllbBVqADQ37gs88S2PSvWUS9JDFQ8=
X-Received: by 2002:a05:6902:f89:b0:e16:52ea:832a with SMTP id
 3f1490d57ef6-e1a7a02a4e5mr20050130276.27.1725454665208; Wed, 04 Sep 2024
 05:57:45 -0700 (PDT)
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
 <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7>
In-Reply-To: <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Sep 2024 14:57:08 +0200
Message-ID: <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>
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

On Wed, 4 Sept 2024 at 08:40, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-24, 13:43, Ulf Hansson wrote:
> > On Tue, 3 Sept 2024 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 03-09-24, 11:54, Ulf Hansson wrote:
> > > > In the current code, genpd_find_opp_table() tries to find an OPP table
> > > > for the genpd that the device is getting attached to. Then genpd
> > > > passes that OPP table via devm_pm_opp_set_config(), to let the OPP
> > > > core to hook up a required-dev for it. This was a naive approach, as
> > > > that OPP table may not be the one that actually corresponds to a
> > > > required-opps for the required-dev. Consider the below in DT.
> > > >
> > > >         opp_table_devA: opp-table-devA {
> > > >                 compatible = "operating-points-v2";
> > > >
> > > >                 opp-devA-50 {
> > > >                         opp-hz = /bits/ 64 <2500>;
> > > >                         required-opps = <&opp_pd_50>; //corresponds to
> > > > pd_perf1's OPP table
> > > >                 };
> > > >                ....
> > > >
> > > >         devA {
> > > >                 compatible = "foo,bar";
> > > >                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> > > > pd_perf0 and pd_perf1 has OPP tables.
> > > >                 power-domain-names = "perf0", "perf1";
> > > >                 operating-points-v2 = <&opp_table_devA>;
> > > >         };
> > >
> > > I think another way forward would be to send an index along with
> > > required-dev information (now that you do it one by one). That index
> > > would be the index of the genpd in the genpd-list for the device. That
> > > would make it work, isn't it ?
> >
> > I am not sure how that index will be much helpful, but maybe I am not
> > fully understanding what you propose.
> >
> > Please note that the index of the power-domain doesn't need to match
> > the index of the required-opps.
>
> Yeah, I missed that, it doesn't happen via DT but by platform code. I
> do see problems where situation would be a bit ambiguous. Your example
> with a minor change to your code:
>
>         opp_table_devA: opp-table-devA {
>                 compatible = "operating-points-v2";
>
>                 opp-devA-50 {
>                         opp-hz = /bits/ 64 <2500>;
>                         required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
>                 };
>                ....
>
>         devA {
>                 compatible = "foo,bar";
>                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> pd_perf0 and pd_perf1 has OPP tables.
>                 power-domain-names = "perf0", "perf1";
>                 operating-points-v2 = <&opp_table_devA>;
>         };
>
> Here, I don't think there is a way for us to know which genpd does
> opp_pd_50 belongs to and to which one opp_pd_51 does.
>
> We solve this by sending clock_names and regulator_names in OPP
> config structure. That gives the ordering in which required_opps are
> present. The same needs to be done for genpd, and then genpd core
> would be able to attach the right genpd with right required opp.

No, we don't need this for gend as $subject patch is addressing this
problem too. Let me elaborate.

The OPP core holds the information about the devA's required-opps and
to what OPP table each required-opps belongs to
(opp_table->required_opp_tables[n]).

The genpd core holds the information about the allocated virtual
devices that it creates when it attached devA to its power-domains.
The virtual device(s) gets a genpd attached to it and that genpd also
has an OPP table associated with it (genpd->opp_table).

By asking the OPP core to walk through the array of allocated
required-opps for devA and to match it against a *one* of the virtual
devices' genpd->opp_table, we can figure out at what index we should
assign the virtual device to in the opp_table->required_devs[index].

Kind regards
Uffe

