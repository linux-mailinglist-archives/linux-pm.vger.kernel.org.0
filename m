Return-Path: <linux-pm+bounces-35945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BDBD168D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 07:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44486346F1F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD02C15A2;
	Mon, 13 Oct 2025 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGcSJ2Af"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BE23AB8B
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760332125; cv=none; b=th1MCUMiPlaJtCilt65Cvdg7f9x74HjIOsqA8odyRpw0NlYmCP5cK2M1tbm7P5OnL+dHNYhrmDn96+WkfZfAHQVJREexoMtrw1dcecAUB/yYW6JFT+TCYxKT0AM4RRmFj7TDmIDUFGgIjUtwxdPlAJqhA0/8HHhOCIR4o+zQj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760332125; c=relaxed/simple;
	bh=JW2KZzHBHGQ+XKshSFr20YBoYNWz1TvAot2oKeFV9kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ady97R8L1RPVIwmoZKNkuI7thdH5/dp6zqE+ATibY5XvXJNrGyu+0tuA2bDZDbrbnUCxsp5gGdaWRBYY/Sf7EcE408iGoBC/nRvAOqj2jYtF44sID/QcwtTDi+1Qmq8TRjGtl7BE6sAB3zRwKMnVkl7Z7mCU5F2uwtK2Mqrsico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGcSJ2Af; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781db5068b8so3039379b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2025 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760332123; x=1760936923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvMGF2m9NKomiMPkcFDrgY9B/XQ2FXotq7iRDHPw2HM=;
        b=DGcSJ2Af6VYmbrtuCzQG3CMmb1RhZwaLy/chU9o2lUUr70Bx2+z3r/OMvV0xYYZQaP
         eA16OXeckD7LDEPs5jQU6+fV23sXpMRaYgbQ6ObGNFp/Jg5iHFT2ZcNlHPoO55kIH4Tf
         VvbRMvZdohIEapQ9BF/G6g2n2nHsWsVs3c6TuRAKPbOwpLuWIhTCmCsToee6YyUG+Xwj
         zlL3m1vxw7MJoZIMh2wJ26ewgNdyVNUko7VgXB4Poad0kFnqgWm+AKYxtseB3POYaXQr
         +XLJ/2bvwsqb/VW7BhAwPG8K8AyGuxtOh5GkLvxpI12AHo/S+oYzfoSEjL7NDdwlNNcr
         8x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760332123; x=1760936923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvMGF2m9NKomiMPkcFDrgY9B/XQ2FXotq7iRDHPw2HM=;
        b=eAf7UJ80OqppxuQwgYHrAaR2TL+16r2qR0V6wjFnn7Nnhll149KvHd0MbGncBW0TW1
         wtB7U21VIG+Kbf4V4mfZ0o8G7HpXdQfCf0XdFXIjl9LEhyCIEANaYu9HAeCts6tyxrqB
         F8JBk2dTCczFo1IeeRvoC8JVBrtpMRut+0NRMAKEmz7eFHSLeuCjQ4EUGxBQN/s6Fwoc
         0TPFCIplDwKmDbBFS/BiRgt3KgnZXaVy6TYRtf1dzBAXJcqhCbrsbDUtb2xkUNQ9gFcJ
         KOgzMiX13jzSIcIROST3w9Jif42AN3y2wllh5ERbpamp/rGkeQURMcSQoiF6Sw3fUFYj
         0PvA==
X-Forwarded-Encrypted: i=1; AJvYcCWTQDON32tZbAvOIz3+bxTaBe/PHILc5bSFFnPicqM6Spec9YVW9QFvlsF5ILjRSCPKyinom20QKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO8GlYDDKi7IIOU1s4S2oz8bh/2svvWAOKAeBSTylI5HIt32B
	vv22lVDrKwpxeIorOwUzEAQsropXYwf5X2rkoEW5750J6PvbLemIGvTjN3gmmMGnS+c=
X-Gm-Gg: ASbGnctUwEnvUgY2EZvelCNRVT5g8uUezteMB16sH5UVZf2mZ31Nx79/4XKi3o66IWA
	iIn5ANoJcqWhhr9NZZKUb3nGuw65ou02UWDsbw5k+ypgdaYmOkm5YODWvCrABYny5cABzCy7kBf
	05Jju3KxxEWZWcCTSyr1c8P0agxSNmIw37N71hn8rkwM/HQBoswhR333aBRKImjx470PAcIaTgW
	zIPDH8ivtpGfcTRpHY3TsnBKD8dVtKSG0TO1V3BQvF5QkwQjE2eeeNlUgahwO5ULt6vH6W14MMh
	H2X0ERUwPXY9ctSy8YFKp8uJozgA0sxVgCwTBxSG4y8zDzuEovNUcpYcRE6fQX6E4+SafZZOKZx
	Ii9SNcn9zDTCgQzuZZFXHTQSj0GmCUXzHO+PEtHSfJIjMzRGq4wPfmQLvQEcfmivIHjmY
X-Google-Smtp-Source: AGHT+IFr1jDMWruKiXaI53Y1xIrFgDt+3JcFOtGMWWSDIGVWWBQCIaxajxNyZnXlqxumYlg8hTxd+w==
X-Received: by 2002:a05:6a21:99a1:b0:302:c800:bc0b with SMTP id adf61e73a8af0-32da83e64d7mr25164345637.44.1760332123377;
        Sun, 12 Oct 2025 22:08:43 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm10155168b3a.32.2025.10.12.22.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:08:42 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:38:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set
 bandwidth
Message-ID: <5ind7yevxsrsd3ws5rkl5z3zuxw4yrqoclqg7q6beunc6kgr2n@qmgbgw5q2ltc>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <20250909-tegra186-icc-v2-1-09413724e781@gmail.com>
 <20250930103006.octwlx53p2shwq2v@vireshk-i7>
 <CALHNRZ84s8rxQKWZeF-bfS31nK6ay4_MspmYa4+qapf9gtk+Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ84s8rxQKWZeF-bfS31nK6ay4_MspmYa4+qapf9gtk+Fg@mail.gmail.com>

On 12-10-25, 21:32, Aaron Kling wrote:
> On Tue, Sep 30, 2025 at 5:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 09-09-25, 01:21, Aaron Kling via B4 Relay wrote:
> > > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
> > > +{
> > > +     struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
> > > +     struct dev_pm_opp *opp __free(put_opp);
> >
> > The usage here looks incorrect..
> >
> > > +     struct device *dev;
> > > +     int ret;
> > > +
> > > +     dev = get_cpu_device(policy->cpu);
> > > +     if (!dev)
> > > +             return -ENODEV;
> >
> > On failure, we would return from here with a garbage `opp` pointer, which the
> > OPP core may try to free ?
> >
> > Moving the variable definition here would fix that.
> 
> If the var was NULL initialized, would the free handle that correctly?
> Keeping the declarations at the start of the function reads better
> imo.

include/linux/cleanup.h has some recommendations around that.

-- 
viresh

