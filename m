Return-Path: <linux-pm+bounces-13396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E145696998E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5941C22B51
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5E1A3036;
	Tue,  3 Sep 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWQLHUpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A01A0BC6
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357309; cv=none; b=rWfTnKJRfK+ER5sOAhDVfUzhpZBMxLkj4Idi+Z35JgHS42DlgG2sxl+jcA+aaRDSawQID2NRBbCWwT3Fscjw8r8V9hpx7mEbU6Sh8sJXyHzuOl0w0Q7VSF2Fyl9j1olMPHbtGnxosOt47SIFNYWrjhf/XunRI4t9Mzzz1qNgAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357309; c=relaxed/simple;
	bh=r/D2XT9csu2hRnKwa7lr4pddgJFqYkNRTZD+HvrK5yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbm1RvMVz9lF+1wM+t44rIe0bAToPy9XG53VtqOKypRAYmmrdrZDW7408c6bAnOa6hBOK5Zy+PqW5ViMK+e9khrwyTuJWGBAG4e2ky2y5Z8zshXK9dTibtxex011l+ByWh2aNj2b12a9mO95iIhfTYWp7jWdubzr21vu3N+O4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWQLHUpO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a80979028so3832151276.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725357307; x=1725962107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFqqyo1243gLC8lCdcnS069gRZejGhzhqXUGlqO3d/I=;
        b=FWQLHUpO39uToecSQdsk7vlCb0xkyRpSb0COBxCyy3BGLftVXO3K9624zyCqWHgWlM
         6myKdEgRNH2O0OynsP+4dulNFeMGe9eHK+hxY6tbFIL82/xglOq0kSR8LOI4kqpxjCpP
         meB11FoRFTIoVOYaud/TCllqed/bsC6yCt7oXc0i3fQQes2mHR1B0k//3Ootyowo0bSx
         l8Fcgf00K6dxfHj2N5LrqhnSTYRXKkmbyTvjjeyzo76RUfrxHYfzvi7t+kQUwJIqRYOj
         GY21wwWqNn4x3fSTvxDUXT1ZIigZulPolYVT47equ7HCQiJpA0WqhESQAHDHMAVy1ZbY
         u+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725357307; x=1725962107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFqqyo1243gLC8lCdcnS069gRZejGhzhqXUGlqO3d/I=;
        b=FK3fSELHfpMALMqTKR4tsVDp6EtjcsWFmpMxUNh/Pvi4Dz5+LjTrY/Ms9ieYpjyJUh
         SVrSs57t0oRmTJlP9BDwDvsdn9wq8/0QWqzocbpJyctmSEXXGwKyn50QPFwHaosGBYWu
         4pMpYV8MiZCzKs0C/Gxt1vhX2P6JqFw8UB0Z5YQabkbgOfGMTB6oVazom58YWbKsDJqC
         eyuAiEzR48b1b4+1mhr8icT5p81yCKzcdFnqGHXrwDCERB29xMQF2kwONn21jWEbPhJ1
         qSyIaCtSjbezu66WOrppajMKLkcoLzsExgy1lWiIRV0ohpUshaDwDhqMsQ0gSXVCzdaf
         xfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY6ja3FDAbtJHrSxwlVtNCuEFbpP1EdD8wjRP2J/GjW0pASfrPCwH4s8SsgznTCKM0b4of3q7E0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sw7Wv+xI+6YRJDDp8q9o1yVswW8VuTKjKAP9aDvRWne1ONEW
	y4cXjIgrefekw1S9zqXdfBQY5CyI0s64unvRveu38e5TVkwMEdazm6DJbZyPOs71hAF7OtR6h+A
	DkM8rt6WgGhC2Fng6b53At2pMmSr45v/C1EiN3A==
X-Google-Smtp-Source: AGHT+IH+1PDql0ueQ/ES8PwB2F7M/INUIUGvNZZEUFj51QsjECCxPIJAbbiizLcpEvWmhRUegd7BueLrC0lx7UTd+48=
X-Received: by 2002:a05:6902:723:b0:e13:cb77:5fda with SMTP id
 3f1490d57ef6-e1a79ff67d7mr15832832276.12.1725357307286; Tue, 03 Sep 2024
 02:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
In-Reply-To: <20240903071638.bedt3gllqdacf43a@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 11:54:30 +0200
Message-ID: <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
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

On Tue, 3 Sept 2024 at 09:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-24, 00:48, Ulf Hansson wrote:
> > To fix this problem, let's instead start by letting the OPP core find the
> > device node for the required OPP table and then let genpd search for a
> > corresponding OPP table, allowing us the find the correct required-dev to
> > assign for it.
>
> Why was doing this necessary ?

Let me try to elaborate a bit more.

In the current code, genpd_find_opp_table() tries to find an OPP table
for the genpd that the device is getting attached to. Then genpd
passes that OPP table via devm_pm_opp_set_config(), to let the OPP
core to hook up a required-dev for it. This was a naive approach, as
that OPP table may not be the one that actually corresponds to a
required-opps for the required-dev. Consider the below in DT.

        opp_table_devA: opp-table-devA {
                compatible = "operating-points-v2";

                opp-devA-50 {
                        opp-hz = /bits/ 64 <2500>;
                        required-opps = <&opp_pd_50>; //corresponds to
pd_perf1's OPP table
                };
               ....

        devA {
                compatible = "foo,bar";
                power-domains = <&pd_perf0>, <&pd_perf1>; //both
pd_perf0 and pd_perf1 has OPP tables.
                power-domain-names = "perf0", "perf1";
                operating-points-v2 = <&opp_table_devA>;
        };

To make sure we assign the correct required-dev for cases like the
above, we need to let the OPP core to iterate through the available
required-opps and see if some of them are corresponding to the OPP
table for the genpd the required-dev belongs too.

To manage this in a non-genpd specific way, I added another callback
in struct dev_pm_opp_config. In this way, it should work for any
future possible required-devs types too, I think.

Kind regards
Uffe

