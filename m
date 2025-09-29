Return-Path: <linux-pm+bounces-35546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D6BA89CC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33AC7AA5E4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299D2D061F;
	Mon, 29 Sep 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GICeAGSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C09289E07
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137986; cv=none; b=RFLU/jRIShem9uqPga2JLHgo5vS3hLWr94UQeXz6OS9dj9o2UGj8VHU2y4R0n8SW78hh6wTjT/fF/LiADpNqTH+pijGbd3Ruzobqbw64Amn3XppE2jl7v3UT+I1HdSruvRXj3weAvIjX08NDgy4dsxu+lqSG4XLRmEa2lzMaa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137986; c=relaxed/simple;
	bh=F6QPMSQ0e3v6IYWGpsg1DAlGPrduv5vyeTegzDeIf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCppf+7ueU+50WUBLvQMihJTQ9YMyd7iakm185ga4RoNGTpCuSYG8j56H+2TdhaqLCPMWdr6M19dcBe5GAOcX2iKXTcPSg4znk4T1GAMa0lQ2tgqDu00cJzlZsjxdYeoiFc9lXiqENYAfh4XCVSQdxMTGmvWew+VwX8Zsf0ECo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GICeAGSD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4512855b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759137984; x=1759742784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjBDdW6a6A4A7TeFZHGH031gzicAXAbFO5MjRo8D+ek=;
        b=GICeAGSDCIZr+G8YWm827/UMcEck0c6Xhc0zLQvCsfvCByug0NkDIiTLlgTFuidkrp
         miYr5wvib+HUmQgsfaR8TvgwkkUFjJyBx3vkGccWMdtzfJ3nYSCrCvkopmKM5NXpbAZi
         zjALvleaNxjrVycaqqZlN9Nf7aJbVzRKBjyYKwF+pBxYQgQKlAF4JF+0Yh6PtODv4XNp
         WhFqLItWTuscS5b+gUKlWFdoYczzpv/UsK6hyDn4TQaI17eAORGIQvjAuJl8IAYEFmzH
         OO1IckKb5K9jRFo3fQmfwHlnCU4b5ygbO7AWkNPVcaJQNNpa4TH7YP1fVwNLcFhsVI1v
         sn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137984; x=1759742784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjBDdW6a6A4A7TeFZHGH031gzicAXAbFO5MjRo8D+ek=;
        b=EE8RoChF6o5afZ9Ro15H6WhG6HujQwMkHxaGOm5XzCq/x1ysIWejl/+ndeiNtzQBZd
         /AA9vhKoBPCzMeYecbfLEmdbR/lWa4pQK6CLdfN+2Y7Sbz+OKTN9Z77OkbI2UzeE4uEZ
         /1iHKxfTlfnrsFzuKrfYKNsAtzQjlK6R2aPl+UHVgmXANWAzsuaM8fkZeUro8ET8yT/m
         Be8hVtxZXoMkKmBi8vdIZKmZRjnnuzpBVXLL8Zrhkk3iIEvJPinOETlRUP4krpTcGx38
         BcnSlsuXuktrfskBAmrlezmj1EmM2Zxe3OZeiC6WQKWyeRhnWoaOLo1n/ijD1fBzbDge
         Camw==
X-Forwarded-Encrypted: i=1; AJvYcCXc305OJfy8JrRGP0fli00XYLdhnetlcamgUXx97hhQi2M2L0+6dzNfu6S5r533qqZPq526BB1HRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrWeAiBZaQQoj0Ccqkk0XthXOb8SGOZ+pUhjUHW6oP4Fe7d1H
	mxLJRaOBbwXvc2ycNV4GCPYvLvXN6kjjrMsvN4WLFdVh5wls6haKwDdgucJUTAWNJSI=
X-Gm-Gg: ASbGncs6YpyVJobTTNY67x64XL4cvqtHx4iQcTqNC2kazixorouWNXDJSBGMG5+Tf4E
	EQQJQdM7bDKLqLHZ9PolpIM0RCtf2DtfM/+6m3+LO5p8PVrYtRB2HrUyvoeJhvskecikOv2EZj1
	UlLtYYGwSNgiJlAXYoRDAryY+xZzSdYbwt1Ae56UTmyEnbUPfbSjRPrQ+ttWyArm4HnAl4Vj4EA
	OywWl4dkDZ7ad0oKcJB+xHjY+fOLBeYvTUDU9mbaQxYVWZG8jbapbIpBCkIzE/DUJ/w814sb7Qu
	5jIcb5NqFHpOv7/0G4R0OFFdq8vK0rlatSKxpnVbH9hJRbXK4ibEmFOIxW515j5qgr5ZKSl1lRC
	OE/JmjfcHCGpxGbKCUsHzKMt0TTp7KCOQkaM=
X-Google-Smtp-Source: AGHT+IGusX2FU775hDQyaDVeUQ2fzYFr/WVOzWLXyy7HzrXzVv07AdOmx8KqU7JGAyhS3O+CN7fWhA==
X-Received: by 2002:a05:6a20:394a:b0:264:94:3f5f with SMTP id adf61e73a8af0-2e7c131dbb4mr21160856637.15.1759137984423;
        Mon, 29 Sep 2025 02:26:24 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca29sm10479302b3a.6.2025.09.29.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:26:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:56:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Message-ID: <20250929092621.zvodzktgw7ok3rin@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>

On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> This series fixes an issue with shared policy per cluster not scaling
> all cpus and with some cores being initialized by the subsystem.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v3:
> - Use more clearly named variables in patch 2
> - In patch 2, fail probe if no cpu rates reported by bpmp
> - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com
> 
> Changes in v2:
> - Set max freq instead of base freq in patch 2
> - Link to v1: https://lore.kernel.org/r/20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com
> 
> ---
> Aaron Kling (2):
>       cpufreq: tegra186: Set target frequency for all cpus in policy
>       cpufreq: tegra186: Initialize all cores to max frequencies
> 
>  drivers/cpufreq/tegra186-cpufreq.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh

