Return-Path: <linux-pm+bounces-27229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B9AB98A3
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFEA188BB60
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86A22FF37;
	Fri, 16 May 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yt97lc3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EF22F75C
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387260; cv=none; b=FBnYc9DaXSSkVaZq3+e/ekVjwuTQgAsGNeCNpZewcNHGjud4ewS+60fxFaHJ0komcd3I9Ue1kBO+sgCdfGiNg55zqq+am8tws/g2uBeiQOWNeW0uo4IHv4z4PhAgx8iTToUxbSTKczC9M6ChWx9WA/G+McjzaZg6Ms77W0Jeihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387260; c=relaxed/simple;
	bh=LKnFOUwwXq/9fAvcKvTjoW/6ZFr5JUhO2L711QhoihA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwK3mJQFmdANZHmSg1pfEG/L2BWOmmsNmPmTg4B7AeKYjmB7WfgUeQrWYDhFk+Q7adgCijuAl+2IXmICVPS2CSVTj0ZkIWZxnMuZ+XqYsHH+nq7R9QcRMWHJxG7gjEP3AW8kGxmS2+wDf+4u2lJTnmNx5AchWjI8kpgO5cR6QFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yt97lc3e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso11066485e9.1
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747387256; x=1747992056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oVkdhl0yZ1MFLhzxiopsXMYZ7EZJ0whWLEhnArATGGM=;
        b=yt97lc3e5iz9s7CTwnr5fw38Q04ZN+A9rhPxyeIhYoC1E/Z6M2KlEH0gLtv29oBBDj
         Gv0zvo5yQSvwgBPht518ICoLAM3dP/x9QrstAsaogn+8F9KXqPHKBb7Or1lYlTEwEKFU
         22SvuXQfLDDdYr2pPWrKPsudEk8lwDrmGFgFq+Nrc697Ym2/8kMCKaM09k3q00B6DUIV
         50Y4leJyswQUOe55uu+aKouyephrTKusMS3Rfa5tY663V1BwAJg8Vh2MLkttdpLrJ+qp
         NnNEYot0MFayLff8B5Ws/fpK5FmTwggGs1IcfAh2FTjtrn6RO+dLLRDGtx3MloIBy45k
         3+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747387256; x=1747992056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVkdhl0yZ1MFLhzxiopsXMYZ7EZJ0whWLEhnArATGGM=;
        b=OdqzCzXdq66O0wUrhRIlC47slgjGYdtZB5kqXeCnIjWDozAV3uw8rZEYmU9+4nSzEM
         fgh1WJkI9mQS3db8uXZsekE6Ru6baW6vjf2aZbSFksnVNpzqVYQnVih+stadMT8PS1gq
         EWnrEeFAIry05eC9NU+uX4zumbPdCA13t7VdeD+uTJ+8A6AZ7stEscoV3qImCfypD2tf
         6+4ICQRVhWH3xrhooSk4i+BYiQy9dwHUfFvR0J4tHtH6F0qt+/g8sENLbPpBgPXlwtO7
         FwLTPCLrtWlhf4IvNLQhNWFBtjb4D0RK61glfAoyoxQAF2LVLVDPXs9tp8hszuZkR91L
         D4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy1LFxFYAyPiPImHI/x4RyXlgvSZMFkmy6cvL5ZGcnQLHNVFPW/awFq6PecrdmjwJG913u7rCgRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WJVjJEdJIkETlcfBXKB9vHH3bhSKIDb2tkEHq9AiJQ+mex/e
	guu9d4hy7tUmBB38+CanNWk3W+4WyBSHqkNPsDi9DcCOJI7OAp+qJr6K6ORpqCFS50c=
X-Gm-Gg: ASbGncsSPJpe5FqOf0GMtTh7K1RDuqGdVvHPItdh9fQKkK567em7aBSjYuDYBnEqoL5
	8PG9gxqc/OZO2+mRc2PWk0yNcED95Tz8BBgAwp3IlzOd35rlVw5NSCMrxxiuEu1/f5jMlACGo1p
	X6UZ5vDGW5DUHPHzzOEns3zmn+SO5ETW2G3QfPWmM9Zgl/A51DkcPt6537W5UsOxDrup1PkoXGK
	2ndYbAeINr+iRznJ7RFZnXqV1LN8VeFnAad0vUuiiGDU6Iv2j3Mwp+6ciGymip0vut9culxoxKo
	jq2JCy8EyVjDWnvV1DPae+ILfPT/xAoiW6mwzItpa9YuaSKuAi9F4AZ9oziDJ1Q7x8dB61KOSrg
	mDv4k4KcS9t5rIg==
X-Google-Smtp-Source: AGHT+IES3ifXyD0j3PvByP7vCZ00BMKCLJoV59bgFS9BgxMTVRCSsT0jxN+o23wdcE+SKI61YC0zEw==
X-Received: by 2002:a05:600c:34d5:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442fefd5e7fmr17195875e9.1.1747387256441;
        Fri, 16 May 2025 02:20:56 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d263sm2210297f8f.3.2025.05.16.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:20:55 -0700 (PDT)
Date: Fri, 16 May 2025 11:20:54 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] soc: tegra: fuse: add Tegra114 nvmem cells and
 fuse lookups
Message-ID: <aCcDdqXo_d34BHpE@mai.linaro.org>
References: <20250321145326.113211-1-clamor95@gmail.com>
 <20250321145326.113211-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321145326.113211-2-clamor95@gmail.com>

On Fri, Mar 21, 2025 at 04:53:22PM +0200, Svyatoslav Ryhel wrote:
> Add missing Tegra114 nvmem cells and fuse lookups which were added for
> Tegra124+ but omitted for Tegra114.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra30.c | 122 ++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c

Why this code does not end up in a fuse-tegra114.c ? (as there is
speedo-tegra114.c along in the directory) ?

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

