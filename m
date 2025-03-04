Return-Path: <linux-pm+bounces-23352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D05A4DB39
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 11:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727D6188FD81
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896001FCCF7;
	Tue,  4 Mar 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqu81SRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CA1EFFB8
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085181; cv=none; b=oQYTgH2Nj15nWbuyPnaI7PrJwWUGTavIyloqGGWzJNncx6YLdsTqN074gOZg2WfduTjSwMyvCPhzyCUgCplAg7a7051NDdn8kDKdNBVqm5nClKOr1etNRwdeLcT6VFfrflfWLM7YrbvkPLgja1FnIv4sWnDrLjIzTRcyXv6MWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085181; c=relaxed/simple;
	bh=2z4xJ/oVBzhQcfL4L8jnNsoPpesn5R7TIXhKiA9UeKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7ws0rfOKQ9GkJhu+1E+aAfIm3FCYLNmzSFLbFXLv36aAX5e7261G8hEOF0hVUskBI4m+s2ppFPEj/QCLG5YRc7PO+kxxXoaF4GqZLt1fP6vDcAu1F/4FQZDVRkxQJw9tjsJyOoDJH7wS7XZva2a5o4/IwkqGBhsvBXrtnh00p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hqu81SRd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223959039f4so50466995ad.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085179; x=1741689979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQbDCOHa2pj582SZg3Jgs217+eBO1p9MvDkVyDBmmeA=;
        b=hqu81SRdwa3wEd5xYJV80SaN9wPaFJniwHRdjcH4Ejx0JtJf/Kc/Kr/Q7lT+qPBvSM
         h+UtWX8JZ5hl1d33q1itu8nIMmUMtxa7V5fGz6bzWuagdvCd11TOJBHZS9viASycfE9E
         oL5SmP4Xqj9p8/ch963aYpR+5cUOwZG7JhNVT/uFIFSB2hGKKM9VallDIHJ9hU4ldNhM
         cmYqYKFkbMPFwAwLZzTufoeSYU28glDdXDiA/WWKAXD1z6TxuOvpIiGeRfZbJnijhL+G
         JvbQJ/3+1OGW2DWoGwaqklNj5YTNbepzi8DJKK/pRK1yXMDH1tFVkhIANzX9V9C6L8uJ
         w7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085179; x=1741689979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQbDCOHa2pj582SZg3Jgs217+eBO1p9MvDkVyDBmmeA=;
        b=g6P4I6P1yGf5uZaGofpO2d4MKP8oySCk+at+hjrEOkz0l/KU9Xwnze+tTc3KK9lkGc
         Twm2CfKFFaahGkjWO+cn618b3Lyc71KlZgZRWIkGBzTn9mT0ZF8wC4EpnZ4YHXK1SoLJ
         5wtlyc4LGrywTWk+eDyLFYvwab/7jlw8vnjDemRzjyucfsvng9jfvt8LwsrV0jdXcfGG
         bPESIjfvR6KAnFY9pZ0zVEAm8/DaG9DwAewZim8yOp90avVxDwoppN/lcYb13c+Q0hgL
         bSuDJWlEl82NJAgLdHNrf0/YmfJMEWz73iU342kZX4sUeknKVphrXA90Pmka5IfGCL8/
         Nlgg==
X-Forwarded-Encrypted: i=1; AJvYcCXXj9hePm7a+T++PtD4gTeVT218qbDq5w0P3mGOPUzGNrbwkGjLcDwNpvPNPnltiY0ygEco+5xi5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7QffUQqvhODTASL0VT8hA20oBKRTW7w25iZvs7N8zXgQkKjB
	kFD0g0UGM1bla4woqd1wd8Ox2WHqRfPcxOh5iEQaTM8jofFTRgBPx5RpQ0SBb/U=
X-Gm-Gg: ASbGncuDjB5Pjk5+j4Z67KF09tGu4L0LtgaijPNBHgnmYMiykJCiLfb428VHOVN/r6S
	Lc6ndC5rCKbHjXJlGn9APM2DFueoJYKHjpWfApKBFLOhY1WHlUYBCsgZgQdOjKRcyiAKkBpefyl
	RRlmHmyMeEdHOcvpwRyDuVgkJ9dLu1YBeVoM3SRbIXp1rNvaqnY93Twbw6erlTLrxDjakMi40LC
	rVg+mIe7ucYM2/BMPVneRdeA+gFHrvnQdyh/VXauYsdpJ9YqcpaadkfaPo/Sks1JhyeF6LSKMfP
	w40ByafNAGmxlpsFAMzOuwFIkwEPzcev5grIFrqbjZgsnQ==
X-Google-Smtp-Source: AGHT+IGJt/FnrpzymxUjIqCIkUti+b2qTGqcr76eFWaDRGxtiT/MuoYL9mWlXIKVzc+48AhF9ZOMeA==
X-Received: by 2002:a05:6a00:92a1:b0:736:3f4d:4d49 with SMTP id d2e1a72fcca58-7363f4d5011mr17422751b3a.8.1741085178806;
        Tue, 04 Mar 2025 02:46:18 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm10592435b3a.153.2025.03.04.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:46:17 -0800 (PST)
Date: Tue, 4 Mar 2025 16:16:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: tegra194: Allow building for Tegra234
Message-ID: <20250304104614.ws3yikqfrip26hfp@vireshk-i7>
References: <20250226-build-tegra234-v2-1-cf7e0828714e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-build-tegra234-v2-1-cf7e0828714e@gmail.com>

On 26-02-25, 12:51, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Support was added for Tegra234 in the referenced commit, but the Kconfig
> was not updated to allow building for the arch.
> 
> Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v2:
> - Drop pci patch which duplicates
>   https://lore.kernel.org/lkml/20250128044244.2766334-1-vidyas@nvidia.com/
> - Link to v1: https://lore.kernel.org/r/20250224-build-tegra234-v1-0-39e4e912f968@gmail.com
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

