Return-Path: <linux-pm+bounces-13412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29043969C39
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C3285912
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675E1AD246;
	Tue,  3 Sep 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/cqvHR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9361A42C2
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363824; cv=none; b=KEb5Sajv3LyDagAxdfoqdlTkAafoxlW7RYk4NflStPI23KCY8XZQWfnVVsCnqMkKQ9ZCS9JtebIn8w2HrW/0odSfMVlmF3Q63Tq2RQtdTwVGJAC46EJG7Xp+ZwOcythDDnkgNzOiBeiJk7Ry/2XljefxvN+wTkhDq7s6tuTcOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363824; c=relaxed/simple;
	bh=TxBUswhpUFjD2PIh0U8XQayS/jnbn9rUdr1/vY8JI/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOXPmIMGkoiW67KKM/RionKdSFNcv1rsWNrW4Z5lB3+gRWqjJlNsIHNTV8ohPNFAHkrCJyIzN/vRkGf7VHYyYSDV19yb2eETa7TVYcnQ1wtXuMSUNDvuWKigmwA8hVXA3qNBjd/MeU0k69Ry+h7WSlQ7u0psgjzAqFML7ms1i2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/cqvHR4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a9dc3f0a3so2670364276.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725363820; x=1725968620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdF9MVtCXj0ldBEZbIYs+MFigsWqijFAoDRsuv3Mur4=;
        b=Y/cqvHR4veWm2roLuwqWuhxKJcw9fbUsm7UK57BkRtyOeOV7KPTOCU//YQsmtac2dB
         +y2mtzXap2baMVmyy7VZGH3lRzdFi0tH+0Dl9+a0w9qsR1+FBPY4S1fg3//WtYcYG+Vc
         1FPvgSWe8rrsVuPtITJv1JR5JOTlnWhnKqjntLPWHM5lXMPlL6Xg80mJtyslOD45qgI9
         ppMZIxNgIVy+sAHqxqWP1hL9m6WhUwZeX8qFyRufiAIVWJfpyc4JB1JSihJdsR7I7Yw9
         Dm4f2EAfL50kK7p3atxJbpM24glloIZPUaJyopI5TDBIyv4/qdgAg5njDpdbBHABG5gV
         9cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363820; x=1725968620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdF9MVtCXj0ldBEZbIYs+MFigsWqijFAoDRsuv3Mur4=;
        b=cKEf3XbHs6RNPWU2EgsXSF9gb1XRFfju+gaQ9E3uhglIgs5Udnz8b36PEC20RZKWik
         lq485N+DfZ3URkd0KBHf8oL5Yg2G77FOvz6SusXc6UbdmAWSBu46b3/HQi+69tVTaAM4
         A+qL5c+S1GjWMd79hX6R3mOIEkbi4aU2AmQp1R3Pjp36qL3e9sylUdsqoP5NQsRRRFTf
         EbaOyN/3nIXRmCqFJ41PH2mJtk3B2ucMMJRrI5Y0lAcMWzOe8lOLFFvyZ1Ey2nSYgAR3
         uJwodsTEd3RT2SF1hlhb0P6B8I7wHfnh9b1RJVou8uQ4j6XcGz1Csx1/uTbHA0G3YeP9
         HXDw==
X-Forwarded-Encrypted: i=1; AJvYcCWOFWPVq29ztlJ0gduYNRuV3py8tPvOjKOqxh9FXLgGTyBzUeL/9XNGUwhV+i8b3mSSj8KPLMXROw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOMHMXk+8NWRn8nMnXrMVsvuVJkQPd8qJMB7eDXG47cFoECdx
	dohcUXsi23Burh1HkLs486vesg4uRiuFL2qD4w5CGZe3LVtcBP+OtlRpTx8kXdlobdhFUf4IEuP
	q4FO9AgXrfboN5i7k/jwwDYCAjRa+bMLgVBCQbQ==
X-Google-Smtp-Source: AGHT+IHsDuH/TAqeHRCZZGOx6eleOYg0y+sTS5+zHNDOJ0N1S7gTa6ofslpNrt9a/ru5VN98gCbAFZhY32ZtaiDskgE=
X-Received: by 2002:a05:6902:2493:b0:e11:8088:3a5f with SMTP id
 3f1490d57ef6-e1a7a19de6emr15605038276.48.1725363820330; Tue, 03 Sep 2024
 04:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com> <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
In-Reply-To: <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 13:43:04 +0200
Message-ID: <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
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

On Tue, 3 Sept 2024 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-24, 11:54, Ulf Hansson wrote:
> > Let me try to elaborate a bit more.
> >
> > In the current code, genpd_find_opp_table() tries to find an OPP table
> > for the genpd that the device is getting attached to. Then genpd
> > passes that OPP table via devm_pm_opp_set_config(), to let the OPP
> > core to hook up a required-dev for it. This was a naive approach, as
> > that OPP table may not be the one that actually corresponds to a
> > required-opps for the required-dev. Consider the below in DT.
> >
> >         opp_table_devA: opp-table-devA {
> >                 compatible = "operating-points-v2";
> >
> >                 opp-devA-50 {
> >                         opp-hz = /bits/ 64 <2500>;
> >                         required-opps = <&opp_pd_50>; //corresponds to
> > pd_perf1's OPP table
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
>
> I think another way forward would be to send an index along with
> required-dev information (now that you do it one by one). That index
> would be the index of the genpd in the genpd-list for the device. That
> would make it work, isn't it ?

I am not sure how that index will be much helpful, but maybe I am not
fully understanding what you propose.

Please note that the index of the power-domain doesn't need to match
the index of the required-opps.

It's only the phandle of the required-opps, at some index, that can
point out to which power-domain (and thus what required-dev) it
belongs to.

>
> I would like to avoid (another) callback from the OPP core, we already
> have few of them and I don't like them a lot. Moreover, genpd should
> be able to get the right required opp, with an index. Unless I am
> mistaken and this still doesn't solve it :)

Sorry, but I couldn't figure out a better option.

>
> > To make sure we assign the correct required-dev for cases like the
> > above, we need to let the OPP core to iterate through the available
> > required-opps and see if some of them are corresponding to the OPP
> > table for the genpd the required-dev belongs too.
> >
> > To manage this in a non-genpd specific way, I added another callback
> > in struct dev_pm_opp_config. In this way, it should work for any
> > future possible required-devs types too, I think.
>
> --
> viresh

Kind regards
Uffe

