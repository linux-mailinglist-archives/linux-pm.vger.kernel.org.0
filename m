Return-Path: <linux-pm+bounces-13749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B196E9CF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481A4286B51
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF513C3D6;
	Fri,  6 Sep 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ/YyJi1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310C12CDBF
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603249; cv=none; b=skBsJCT5pwsKaZMo7b4tlLhJPe7dPdbocoDWY2tGPPxvY3lZZi2mCgBR4Q2ffBB2R4I/UUrr5IK0Gn/j2cD072eR5fe+KiypI5TQfafMr2RZ08NOKKDS4Tg2pWfBuiGJgxWMJIrY6a6K0+HcXS01KVemcNTUAM1AUGQer62psuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603249; c=relaxed/simple;
	bh=Lx32bnxrpbPjpbgt4VkUy3hGsX6dXtQ2o97E8V7hN9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knMMZBcKBFs9ujVlwbW6dOWH3SCGSETQI2DUh1PTrXaHpZU3lyGTNBe2ppjBkncAEQkcBEdMA7H0B1OJGJC1JuBS482matA59q3n/avrIHk1FFRLMyyObOwJpNjQH6HlR6HoSdhfjZ6TvfjFKN/H2TDsSRnxRWTWMy0VabRf+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZ/YyJi1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so2018950a91.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725603248; x=1726208048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gz2DTDYFcWkZtaamsL1Ksg5rPTpuMwBQtW5iRfsoQE=;
        b=NZ/YyJi1M1wMgBVacnszYV/hOwk3lwKmgpA2Lx+8IhpPNiPZZxdcSfvZvRfk70XWg+
         IXLmja8QIb3psg8KkA3KHuzYrOqfQ7/3ec4nKaamqWqW8NjGY4BqvmKvhGXd205cRTqP
         9WWPKEOMvUEZ5qDDWNiWH8gtkYPRNU48A/Y+enfSds8N3+TSSxzzY+7IE816vobkh8ea
         kMi+/ycrjPiiPd6V0u5BnZQkt48hIp0xZR4hKPihpbSnYmt54hzWAAytagOQYKHn8qbj
         Ikk/CoTbQK+aFli+786wo2YiBLFDpSFgUHFfHHp+N0RMw63bpT39FDbteaj3yECMV5MH
         I0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725603248; x=1726208048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gz2DTDYFcWkZtaamsL1Ksg5rPTpuMwBQtW5iRfsoQE=;
        b=a3H8f05sjytSrpVBMOHFFd0PQWqTrL782kXCel17KQ2/gg6SzJSDrI/KSTS+2cCkOP
         Vd1meM7wdJZ6uYfA96XIcJqqDPs1oYY5C8GJjm+pKtEAXAkXb/+jm6+fu4lSdQ/reAZM
         xtmY6UiAAUo0kj8d6uVVEa9sMIWqTPImCHrKFXaYX0R8EnFYMZ6+1BqLa3n4GhyJrYnv
         XSCq+4gGsDESJyUHaEI18Zs5R3VF0AO8z5PiNAeS1jU6PYSDXBErMYHXvjdjyqzu7LBT
         WzDtzysPF4X9vYQ7tOkTqGKRZkrjQIkhrz6mn+ppkMbJjNEBREgHR59kOngfDb+nJmP9
         0UvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEk+z70j8IeKRTl0qtqkeWRgRLG+TFnEvZP+I+AqpnGJuTOJqDK9Q7f12xemKgPmxfo+gdaZtyHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpjM0GYIz7c9Rn95NIPIAmWmZnZuUmncW+Vx0NtiI7slFLsP2
	5hXa81CM+1pgtubQKcd8QGiI1c7bGOAXeHgmdGXhoZJ/HZT9SM47osQDfqsI6kg=
X-Google-Smtp-Source: AGHT+IHWGzm1aGaGO65+kelTFwC3pwYDkPl5A6OUnpU5ik9G44Sdbn90nWC3l7WB4gmF0230bNlwPw==
X-Received: by 2002:a17:90a:470f:b0:2d8:7445:7ab2 with SMTP id 98e67ed59e1d1-2dad516fb0bmr2331868a91.20.1725603247595;
        Thu, 05 Sep 2024 23:14:07 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0a694fsm658756a91.47.2024.09.05.23.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:14:07 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:44:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
Message-ID: <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org>
 <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
 <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
 <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
 <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7>
 <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>

On 04-09-24, 14:57, Ulf Hansson wrote:
> > Yeah, I missed that, it doesn't happen via DT but by platform code. I
> > do see problems where situation would be a bit ambiguous. Your example
> > with a minor change to your code:
> >
> >         opp_table_devA: opp-table-devA {
> >                 compatible = "operating-points-v2";
> >
> >                 opp-devA-50 {
> >                         opp-hz = /bits/ 64 <2500>;
> >                         required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> >                 };
> >                ....
> >
> >         devA {
> >                 compatible = "foo,bar";
> >                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> > pd_perf0 and pd_perf1 has OPP tables.
> >                 power-domain-names = "perf0", "perf1";
> >                 operating-points-v2 = <&opp_table_devA>;
> >         };
> >
> > Here, I don't think there is a way for us to know which genpd does
> > opp_pd_50 belongs to and to which one opp_pd_51 does.
> >
> > We solve this by sending clock_names and regulator_names in OPP
> > config structure. That gives the ordering in which required_opps are
> > present. The same needs to be done for genpd, and then genpd core
> > would be able to attach the right genpd with right required opp.
> 
> No, we don't need this for gend as $subject patch is addressing this
> problem too. Let me elaborate.
> 
> The OPP core holds the information about the devA's required-opps and
> to what OPP table each required-opps belongs to
> (opp_table->required_opp_tables[n]).
> 
> The genpd core holds the information about the allocated virtual
> devices that it creates when it attached devA to its power-domains.
> The virtual device(s) gets a genpd attached to it and that genpd also
> has an OPP table associated with it (genpd->opp_table).
> 
> By asking the OPP core to walk through the array of allocated
> required-opps for devA and to match it against a *one* of the virtual
> devices' genpd->opp_table, we can figure out at what index we should
> assign the virtual device to in the opp_table->required_devs[index].

How do we differentiate between two cases where the required-opps can
be defined as either of these:

required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)

OR

required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1

I thought this can't be fixed without some platform code telling how
the DT is really configured, i.e. order of the power domains in the
required-opps.

-- 
viresh

