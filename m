Return-Path: <linux-pm+bounces-13517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FC96B1F9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B061C20CBF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B98136E30;
	Wed,  4 Sep 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x53A48pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33A12FB37
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432009; cv=none; b=jBDsKc3fTx5ir8DtqaxzQmxAAOwWZm6D2jJ3FdjSHpMnOBJ7ey3jB+POm75x00PlY4TgyeXAoXKgGECfexvctiCSecRvMEVYAHsMbDIg/XQTH0Umg8jW+f68mfdmh9nKEOc4rJf4EG+OzePKGAPr3EBIy0L6QnlLANbiycYmUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432009; c=relaxed/simple;
	bh=CoxiJJKWdAjigpQGIxD8SiRTyH2ak4uk+IET6q2fxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snX1q9ULDzic6Fss+h6SSZHXUNI1WHsgR6geg+G/qu17XBu9l0sxDtJUIFu/543F7i4MYGbqki4+EVN/bAO1ZjeH79+OPcJ6tOKiI8aJAPjqyODSt0k5QZd+G0LOsm4A3uz0gi3aOo9M5Sw/csTEKws1dzm6VcPLqkYo/y0JPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x53A48pv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053a0bd0a6so39815795ad.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725432007; x=1726036807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6doCfw4HCb32OQMbjmCLG+TU/114o4M/q6YdI760JZ4=;
        b=x53A48pvQCztImQDdGwOyF3BEFL8q49h2Ae0Y+Mj5Z+P2hZvc2zbBWLjm+5t9q2SYx
         l7e60kuHWOQlHQRbKNifUqgVeb7ZgGYBZdEh1fOZgEyogMq7yiaqIo1wUL2S2sAPgtc7
         mFXU82Rrbyekn2gB/j019SO9LyqvM+TfTlcf52n6BYOGma13wCM+tAEe2QMIjDq3Y4vA
         NSSZ4+57JGci/pLp1zt0dhDNWjgAZ8WSzAj+Eq1/b2TBMWhecpy3UXWrY2YZamHY/A93
         Y1V4QtWEVsf2wWw7GiG6xEOLk6VwC/ok5TchUWtM2euir1n8kVyY79k1yebNIwveSi25
         TP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725432007; x=1726036807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6doCfw4HCb32OQMbjmCLG+TU/114o4M/q6YdI760JZ4=;
        b=jd4sFSOno7dNNTh06j3aG7FxiqZ7TKlE4TidywZQKNq9K6ccYt32RyOhdswlsiOwEL
         bzfomV2Ae9uGWMWjFQnnABgBV+MC61hvCjcHlrfShG7USlE3ER4pd2qHhAgF9uByCl9Q
         taU+vFxYXf3RJQ4rXNOjR/DhpxQIO6RHqdHHJKScnnPLmaVU+ereM/RSqEFIELU43BGS
         8T91JtaLbTBNZncZVE7mFncAQso7+bKwKdXS9Paw5+/GcwckjN+rKS5+Ok6+/Ul4JKqp
         FJzDkpCuVnhAVUYhm75cnQ2qoYUkI3bxm7Hzak/zDAUG+jwm0ZyTBsrmsnAv30VJCKk6
         pIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoiOZhAfkUXMiXl4L3vSSkLrzmmcbp0sak10+l8fBFW8STk8IGVqsMlmfa21wAJbmJQmnwlrTofA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGFcf0ds18NYbYm2Q26uzRWKoTtO3kJG5W5VqDLNZ0NCyrf68
	WOQ7D8w8hETvp2R37mNDYlE6052h84l3SgNGEtJo9ggKK3oQ3NqkovE6rHTTS6s=
X-Google-Smtp-Source: AGHT+IFgoUTJs1aTtqKZPgOlbkSNFTbBVjtZlk7jKlvoaPHiFCGIuGZXoxSjXqIJ5HO1fvlUEu1wCw==
X-Received: by 2002:a17:903:230a:b0:203:a13a:c49e with SMTP id d9443c01a7336-20699acb7bfmr50747695ad.1.1725432007455;
        Tue, 03 Sep 2024 23:40:07 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67c00sm7344735ad.273.2024.09.03.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:40:06 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:10:04 +0530
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
Message-ID: <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org>
 <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
 <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
 <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>

On 03-09-24, 13:43, Ulf Hansson wrote:
> On Tue, 3 Sept 2024 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 03-09-24, 11:54, Ulf Hansson wrote:
> > > In the current code, genpd_find_opp_table() tries to find an OPP table
> > > for the genpd that the device is getting attached to. Then genpd
> > > passes that OPP table via devm_pm_opp_set_config(), to let the OPP
> > > core to hook up a required-dev for it. This was a naive approach, as
> > > that OPP table may not be the one that actually corresponds to a
> > > required-opps for the required-dev. Consider the below in DT.
> > >
> > >         opp_table_devA: opp-table-devA {
> > >                 compatible = "operating-points-v2";
> > >
> > >                 opp-devA-50 {
> > >                         opp-hz = /bits/ 64 <2500>;
> > >                         required-opps = <&opp_pd_50>; //corresponds to
> > > pd_perf1's OPP table
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
> >
> > I think another way forward would be to send an index along with
> > required-dev information (now that you do it one by one). That index
> > would be the index of the genpd in the genpd-list for the device. That
> > would make it work, isn't it ?
> 
> I am not sure how that index will be much helpful, but maybe I am not
> fully understanding what you propose.
> 
> Please note that the index of the power-domain doesn't need to match
> the index of the required-opps.

Yeah, I missed that, it doesn't happen via DT but by platform code. I
do see problems where situation would be a bit ambiguous. Your example
with a minor change to your code:

        opp_table_devA: opp-table-devA {
                compatible = "operating-points-v2";

                opp-devA-50 {
                        opp-hz = /bits/ 64 <2500>;
                        required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
                };
               ....

        devA {
                compatible = "foo,bar";
                power-domains = <&pd_perf0>, <&pd_perf1>; //both
pd_perf0 and pd_perf1 has OPP tables.
                power-domain-names = "perf0", "perf1";
                operating-points-v2 = <&opp_table_devA>;
        };

Here, I don't think there is a way for us to know which genpd does
opp_pd_50 belongs to and to which one opp_pd_51 does.

We solve this by sending clock_names and regulator_names in OPP
config structure. That gives the ordering in which required_opps are
present. The same needs to be done for genpd, and then genpd core
would be able to attach the right genpd with right required opp.

-- 
viresh

