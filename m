Return-Path: <linux-pm+bounces-31721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287DB17C25
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C48164001
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A31D61B7;
	Fri,  1 Aug 2025 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQD1xHRO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241C433B3
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023427; cv=none; b=nkPH46cc6VvAmmbfrR04Eak4NO1gevKqjqHHQSB8cbIEU4XYgRmVArHkMsNjt9YBZOzyLYnSCpx9fIs6Kta50b4Xn3otf0G77vWNxQVSjOBipEKenjdn2iJ72APZuVeTS4exNle3MYGmDXuAtGJrhL2TF6tD63LDN1O+8RLtWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023427; c=relaxed/simple;
	bh=x4xrAZi9DV72hy3uEXv6HfE7wskOE4NrkV2UapFsKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPnuL0/Vv8wxE3xulubhL2BljA7Q6FbpMCCLYdiyLU7GRCNyVcvud8ahoFvUCZ4h8+K6lFj20qMmVRKJFkbMWsqJC9bTJDgJZtkCNmkSTLXNxNF45fZIb+hC5OZVUpCAAGhGf75IZi4FTlnIrhWXL7IS+cqhT7AN3mTaaDG51Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQD1xHRO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b423036a317so748827a12.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 21:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754023425; x=1754628225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl+4qIf3VCeXg1U9yhGdOAryWgWsMQ3QOS9OYjY4gi8=;
        b=TQD1xHROGkkEC83UVYPX1Im4HeGpnHPVkYpYOqFKbeclggCBQmn00CKyCnXYCYpcnE
         6AIbFSulYaEmJp7Rd241V3N7FigSqWTc+YpWwVF3X3nNGdUmBOt5q7H/RGpFVAYVqeby
         Q9ymsM9moddN6/V91hh30J4IB+EXwiSw6sZ3b5yVZvzkFF9RZeIj/iHDv0h85cDKnu3G
         E+pQhCEaQQHChghMNVhvwz2JbPFPI9tuqWn6sIJ6oa8d28tByua96LxVtdSRdsh2CLrD
         HAU95NdAMtcexlI0GTqWOh+ZKrOnnSYoSFYua3TuIJ/5bPyYQeXSPW4ZjzHonkWOCR/P
         tTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754023425; x=1754628225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl+4qIf3VCeXg1U9yhGdOAryWgWsMQ3QOS9OYjY4gi8=;
        b=GTjfHPezA3GYzaTG4tPZgGA7jFtZQicdlh7msaRTlNvH6PCHJUZC/o2S7VVMor4Kq/
         kSubR1hfEBTZI22MNypfLP1v3Xjt+Jn5Bk1EgTkqmN9sdF+T9PgPHskrLmz0H/WHPXWS
         gEygf2HvjacWqRDqLQ+dd4YjxsjvN1ajuim2xMWdVQhNJHyEVyRJFVXQO3EZhyEIyMtM
         VzT36sDBdgbR87LwKUf8g3Qzzq1oXOvZT7a7xomWfjmSsr71wWtWL0o0zUJZ4QGnF3Z3
         xe1H2IyuB9WM7c97GnWK7/a92ApFA1bMonEmZNfNbaaypkXsNnjmCeNfYgXwwn/vMmPo
         aDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpYBJI5kYbIGl7DqhTrxKsPFcRHz4I3EWy6QSqlzvT2XzyDuo7L4OnmztWsbjuuEDka5Z91PejeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7L1h4erv4XXgE842Z3dCG/RIpufp9TwQRtvnRRJ/f1++ai9Qt
	ggd+E7YLxbFqDeiIV9f6+LI4kIkw56kYip/6PHv9iAZtzViUsTfkN3qoIOkPBBZWm0E=
X-Gm-Gg: ASbGncuE3ipR/aDn7Ucruf6LOkonTYUnKsAaLcctU2Wto6nR/25I22wfcc4sx77jwFK
	U/n0/Szd+ZtoOuAZHxR7bQzNd56n0TSUOL9K9BWWru1kITOjlVy24/M08cKjnLMuyqzWcfpAO+w
	qjVCykrRKHViq8CdnWunWdGx/T8zqqDtd7ke7RfdU6gn6wi4pFVGdtK+Y/q//mPlRVxjHNikNxb
	X5tR1aOKbUMZ2yk+jTHrpXWOCSzf2TYRQm6kWTTjxGTce2kprvKD8x1rkjqFbXD5O65Mxvj41vJ
	YyCNUS0Xp3Kes6ybgHTq+V6sk5BP+OAlKFztdp2md/WhlHFe7iY/6LrMTQ21GWP7iTVRpEDPq15
	kN2pucsFwq2+chuWVtKCRLRU=
X-Google-Smtp-Source: AGHT+IHh0NQjQXgu/NABbk1MMkudf0ISHIflblBn5cv5f3bj7pvk76Fugngfe7B8q3wIxDrd+KoGpQ==
X-Received: by 2002:a17:903:2290:b0:240:e9d:6c43 with SMTP id d9443c01a7336-24096b771ffmr143978085ad.51.1754023425316;
        Thu, 31 Jul 2025 21:43:45 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c94sm31563565ad.93.2025.07.31.21.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:43:44 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:13:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
References: <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIvQvLL34br6haQi@arm.com>

On 31-07-25, 22:23, Beata Michalska wrote:
> The reason why I mentioned that is that getting current frequency
> for an idle CPU seems like smth we could potentially optimise away and save some
> cycles (fixing other problems on the way, like this one).

I agree with that idea, just that the cpufreq core may not be the right place
for that. Doing that in the driver should be fine.

> But if that's undesired for any reason, it's perfectly fine to stay with

-- 
viresh

