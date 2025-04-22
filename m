Return-Path: <linux-pm+bounces-25894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6FA9657F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 12:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC103BB428
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09B202C58;
	Tue, 22 Apr 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVyXQnha"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5671E231E
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316658; cv=none; b=ZjSUwksgQfT4fq8PYdft+nTh8DYw7AzyXvxP2pV0ZJtBej4lAeZzs5AVqR5e87/tO7D6YYICYjNRuFsIfxUvVIiADfMWF3IEbsNYL82QDwc2Hgs3u7WvXdp+DmLMT8FBzzb4B6pDy6KnlRdD8wOkjZh3Poh9uV58oxQ6/Yl07os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316658; c=relaxed/simple;
	bh=Cjd17WZaONmrhVw68jD6Qssqs4daHsX5Hz8FTe6t92s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtj2iBI7Q2wXuN2R/pciml4U1qrnd1gEZCz/Vo+gIlkc18dXxB2e2O2lf/ZNbzF3nYQtuKN4SZeZuvyM0D9HrUeYaZE/ScqDJ5OI95iWmHHcxpcLMkPj+fH4014cZ3LFV9FLXRbD+GDGD0+K6+mG+DkGBU/EJbvQ4G/oqFCMmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVyXQnha; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2264aefc45dso79125305ad.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745316656; x=1745921456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t95g/lR8j0dWt1fCMqN6PrwRyQPmObNHmaTJOEuO6uc=;
        b=aVyXQnhaqVhH3PtOucaprdub1ikDAdigUlH7ixSEnwQFlYvdoK4v1Mg/3O6cBkKJgj
         p961DjeUbiHqJC+Net8qOOt/ftkt1YgBZXeMDOSUaeipipf0TSc4r2R2vfgUDr66VU/N
         fKCBIYx7TBd2VG3IQ9VCFsnYvbqqjLIlf6uawAtw7CZqJpQbxKzQbGdl4rIwlUz8XqCq
         E4p60bWpKKWb89KvAWUGvOKh9ioue5UsiwDs1rw01zAGP1NgOw+Kx3cjmEnWBcZ7Cbrw
         PJ4UHH0F1i4sm7akyk60oqXpIe4v6PpDJ2W1LNcnENnu+SE03FEQeeb4itdrq2d4Iey1
         3qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316656; x=1745921456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t95g/lR8j0dWt1fCMqN6PrwRyQPmObNHmaTJOEuO6uc=;
        b=uk7qDtjSizj6z6pSyYuEcCFNj2sEi65yGjaDRenTE33xe9X8zQ5KzW59HDRLOAFy0u
         5xUvXg6eNTHfeZX2FZRu4hcjSWCpckWHKUDGa8TnZRBhGANodjo0LhWwNyxJlYtNvJEl
         JhhYtaJGvfD2UzZmSU866NAkgdMs6kRvlrXf6eFlpnJsS3gWVvUz/Jk7W2xUYNwx2sUv
         oxOKqZ8vy4E6jXWi3Eg14eAd8Isz3gm/l/+2toM4draIH1aOj6AKhoq/niyQcGs3hCvn
         ICbPOOk5txyh6KAgqP+lN44h5SUHAr9UG1TpyWD75AovarLgCTCamTWO4tHJOujWdX37
         kX9A==
X-Forwarded-Encrypted: i=1; AJvYcCVCZAfc94LmSi3aSmRIxv4nMcvtyPInLRO/aFFje13S+qxssWobOMf1uvKhI24RIRKQXQpsS85YXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdCDg/ZpUpHeJO+zceGzuCOd1GDiV7EHG8ozYK3zy+/cEfAyl
	H3WQ34O7vLXWFGaHVoD2dDtS3TY72A5bgkIGvElfrVlkZs1AnVnGfI433JmXJ40=
X-Gm-Gg: ASbGncsDqFKCJO/4ll8d2HRgObwTteCfMaVc3Rl5dPIarA2C8PEDviAqqU7aTcpC/qK
	gPHtvkpAJyccxq4OM9ua5ItPU1xfdH6fb+Q+KKI/jyv9Lmf+9P1q5mItQx26I6sGzkTHNFSu24L
	rblbwKenHBAlEgX/jFQH/rQ09/aHkT1Qr28s2/JjHmxmTc794cEJfA2dF+e7NAJZ9e/O7QNB23y
	FHn/uC2lUDioo2NWWZvrSt9pGxInEiPV+2n418iG5EWLC4Sk8O1YavYfALTKXclTgX/rmktmKK8
	rCndxvhiLKiD8RO6l+/bPa4I5ubnYmFdDgmaCCvtXg==
X-Google-Smtp-Source: AGHT+IHx3LxCoR15j6pU7YV6La/DWIC9xool04WI58xGPvEE97FATAcHmmOW/Bqbgnnhga/h2+yG3g==
X-Received: by 2002:a17:903:22c9:b0:220:e5be:29c7 with SMTP id d9443c01a7336-22c53607de7mr229581345ad.39.1745316656093;
        Tue, 22 Apr 2025 03:10:56 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecec0esm80925705ad.163.2025.04.22.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:10:55 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:40:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: tegra124: Allow building as a module
Message-ID: <20250422101053.kjg4dctendvcg3hv@vireshk-i7>
References: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
 <20250421-tegra124-cpufreq-v3-2-95eaba968467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-tegra124-cpufreq-v3-2-95eaba968467@gmail.com>

On 21-04-25, 12:33, Aaron Kling via B4 Relay wrote:
> +static void __exit tegra_cpufreq_module_exit(void)

Shouldn't name be tegra_cpufreq_exit() ? Just like
tegra_cpufreq_init().


> +{
> +	struct tegra124_cpufreq_priv *priv;
> +
> +	if (platform_device && !IS_ERR(platform_device)) {
> +		priv = dev_get_drvdata(&platform_device->dev);
> +
> +		clk_put(priv->pllp_clk);
> +		clk_put(priv->pllx_clk);
> +		clk_put(priv->dfll_clk);
> +		clk_put(priv->cpu_clk);

Shouldn't this be done from remove() as the resources were acquired in
probe() ? tegra_cpufreq_exit() should only revert what's done
by tegra_cpufreq_init().

-- 
viresh

