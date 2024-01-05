Return-Path: <linux-pm+bounces-1881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDE825233
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696891C22FFC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0820303;
	Fri,  5 Jan 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4n0J9fo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7F24B5D
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e84fded7so9385095ad.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jan 2024 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704450962; x=1705055762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYVk8A2W+FUtJ8Xy1Wnlgo/2i74l4ok4AKaqwgOLkgQ=;
        b=B4n0J9fo8Ijo8Pif/PrLgphBQxS+cnNkdD0yjCVLLWzjSL+MgVnsRRGSPrLje1yc4O
         Vk3bTc7kkFjGWcuXHeVM5Hk6HNo63tUGjxmfsr9/g0AdsiFeAtZhYQ74ai/i7zpWlyfX
         s+vazXxvZTmYnhx/NF2wqbuXRDMfWUl7xIoeJGVtyKZ7hhou0mltw1sUIj99fagILEUj
         cVn6lr7/M8y0ufeamZYHPuH+quR1j1nJFBWOPtaNKMn625Dg1G1+WZCQLNJi9fVGbNFf
         Yl70CMhxLmtleVgriNhbymQKCQZuRDjQWyNEdU//udzx7/4K/i4T0qHYZ91Eo5fCBtOR
         zBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450962; x=1705055762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYVk8A2W+FUtJ8Xy1Wnlgo/2i74l4ok4AKaqwgOLkgQ=;
        b=Icu6BbCq6ki7YdBbdcLFTkNEhIluNctaVIjv1W0907+JWvznWFvhrmROT/Lguw0bAP
         +FDsW65+utDEaByNJJXyEaxSuwlenxbv7FeQoU8389Hzoajdx+F7kc/Gqdqtb/T4iV9Z
         BBjznzM5lmIKOQIydyQzfGqzzTcvCQtuiRGHDbEW+uspA4Eb6VAiNh2J/oJIhg3TONIe
         ym6nhKcdwavRAxI41bCm6MC+6nXWFWSSWmH3Pqb4iT/oEwPXqHozVuXXeONqxvq4jgvq
         459EgESXxM7ySa+bBjnvegqC7VrdRuWFSwPLuvfAha1j1mM6nfcjLXYPC0TTFmk5Zynt
         5X4w==
X-Gm-Message-State: AOJu0Yz12ggZJmXVpuXBooAgZrkve2TN6J8wO8hSXKd5S0xNKN0mMf52
	b05OaQ5Z0haZqeD1AfMRAT/OOnrVkPlVCg==
X-Google-Smtp-Source: AGHT+IHoKcEtt38NlGK00XipqMe2SBKo1AhufkFFOv92P9hxGY8Eq/awqID3GPMUNAoD8jAAyAXh8Q==
X-Received: by 2002:a17:903:1c4:b0:1d4:2732:5cfb with SMTP id e4-20020a17090301c400b001d427325cfbmr1971565plh.100.1704450962074;
        Fri, 05 Jan 2024 02:36:02 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d08bbcf78bsm1103069plh.74.2024.01.05.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:36:01 -0800 (PST)
Date: Fri, 5 Jan 2024 16:05:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>, Nishanth Menon <nm@ti.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-tegra@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] OPP: Remove the unused argument to config_clks_t
Message-ID: <20240105103559.jj4vbo4fnhodayvx@vireshk-i7>
References: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
 <64ee255e-9a5a-405e-b342-e91c55bd95ce@kernel.org>
 <d994e6c3-f69e-4910-b699-65cb3ab6c72b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d994e6c3-f69e-4910-b699-65cb3ab6c72b@kernel.org>

On 04-01-24, 13:56, Konrad Dybcio wrote:
> 
> 
> On 4.01.2024 13:53, Konrad Dybcio wrote:
> > 
> > On 3.01.2024 11:48, Viresh Kumar wrote:
> >> The OPP core needs to take care of a special case, where the OPPs aren't
> >> available for a device, but in order to keep the same unified interface
> >> for the driver, the same OPP core API must take care of performing a
> >> simple clk_set_rate() for the device.
> >>
> >> This required the extra argument, but that is used only within the OPP
> >> core and the drivers don't need to take care of that.
> >>
> >> Simplify the external API and handle it differently within the OPP core.
> >>
> >> This shouldn't result in any functional change.
> > Hi, so this apparently breaks serial on Qualcomm platforms using
> > "qcom,geni-debug-uart".. I'm seeing garbage on the console, likely
> > meaning that ratesetting wasn't done.
> 
> +CC Bjorn, Dmitry
> 
> Probably also worth noting it only happens when an OPP table is present
> in the device tree.

Found the issue. Dropped the patch for now. Not sure if there is a
clean way of handling it right now.

-- 
viresh

