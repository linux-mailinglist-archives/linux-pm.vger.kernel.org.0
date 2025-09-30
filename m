Return-Path: <linux-pm+bounces-35598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E9BAC7AB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A621C83DC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA82F9DAB;
	Tue, 30 Sep 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qz3uZlMZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B64298CAB
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228211; cv=none; b=tj7HxoH8ytjOWXcj1Zz9AXgsiUYl4qibaUA7xTZgUsKsydh2zcyK2fqBiIQJdl9pxvuMyEA0KsvBSiZJOPaU+PNqbHziYme8LUvbAuGlKq1tQwvnJSWoQ8KSutxanEBX8KbJpfK0GQ+q3EuInSG+F1XXhwLuPl5XalJsGgQ0Kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228211; c=relaxed/simple;
	bh=LlAd46X4AMd1hwxDl9JpZBtSvrds+zrXrLm1hCZMZGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpk0fdrHVIPeNBvFI1e2x2oawsjcKGWYaA2z1pruLzepXSkM4z2+ZCvXw4tYbZLh2oZVO041NZXo5MmyV1in7uCVZCFLCVZDocwu8zf6Q9JaRNOGlDGfg71jVGhYse+ckbsQIqDvsplnLemr+MjV2lvy4Z3zdxgpOSy6hDMb1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qz3uZlMZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eec33b737so60151355ad.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759228209; x=1759833009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Bti2R28/RAVcQBXOrb8jZ4ikDl7tBOWMDlFZn02oZ4=;
        b=qz3uZlMZevLjFLfnFdPjS7DJyFCcC4z+WUPimXuo8Txym21x+GCXTI6jSzAzhSJs05
         bj4zWMYDpuxSq0z20B0xjz4iwvmJ3vvi2RxQvyWNqHwm4MwYq1Bf1N47Rf9qhf9D4au9
         kcCK5wq7ipecWcP3ZZw/VNwIjprmbIqbYn/eoVnkwKIK2CKk62OSjk2c0PfxJJPNkuTi
         B2NPfix3wcaC3lMK3OskKF0mwPctPFR3wEHDffQGle3cTnWmjkYHn9SOr2exjERnka6b
         2LWH2ybpP1iFRkIfFtl+DSl9iIkUh299cNZviOViPweK9VawxiS9gle4K3Ktds8eiCjk
         KzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759228209; x=1759833009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bti2R28/RAVcQBXOrb8jZ4ikDl7tBOWMDlFZn02oZ4=;
        b=RdlnyX2Eowy5bcYaCGdSPoFIlQcFVKJVuUloupoe1yee1e0A+02dLlSzQDVMMmYKBv
         Y/YXq0R1v41pTBo2wD3YuHEjJ9VtCtNyJt2Zk3wmEQdwMVOycRToWsSppskklR3FZiQt
         K/dd9d0I3knLJabDiT27cYcdLcT1cf2epQwz6G1zsCG2n78R9vD1QWpl1VlZiikNGflx
         eimkgUZoFT7/KDzJ/D/Dle13Fqci/uLk2ZEuIeXSQv0RrohJjcFMNLklG0a56Kyvv9SH
         Tab6mWhLMLuEpe9Xt5dTpHbvhuwBmgpIzO94oql1H+wspIIshvKJOv+xCkf3cV5htLJv
         xpqg==
X-Forwarded-Encrypted: i=1; AJvYcCUl9H0bYgOORs1JtFy7ipUu4WXjxl4lEL2tJllZw72Zk/EnkC9wJDFJgWciszYAKWzlnmd57ouc3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDNQVRqONTXXmkKtawbAcPCok4s97crgTi0+3p2bnE2iquVRu
	Fao+M1hKhExTbkGpmNCfks8vBnyKTpjWlA+aXyhpC+QRRGv2ZUiF/n/tnCD30ykFxfk=
X-Gm-Gg: ASbGncudMU7olgTkU4rBGswlMlgAua5AmtsFvuvH1Enhi+7adMbJkw+UfFmbJ3tEvWE
	EokeojnVRoC8Ht+FIpB1CmcHzTRm1pw9MclBe0HT+JoMjYA2gBXsd90rYTSFK1/pstzI/aQA7KC
	4b5ctN6HiKmh3T6n+A28o8Ks4TrBYiK6TBbYJne4QumZKa/pdHJLPEpAKSUwecPvR8Im4HpKa4F
	4pODuoY19YHHJaJszy/x+ras3A97SPczED1OSH9o2EXzEsT/HGKlNsCxw/AoSVVP7zWFeeWikCV
	Amh2mzmejE/hO5e+aaphqClKSkExzGCrscYQULg9RYAH+sL0BLEi8GDNN4Iosv9SNcU33QqA1y4
	k8sEiiEG+/f99cOn6/FR0/lI1qpFeH0zcxPqHn9J/p1D4ev+4B8XWYhccO63UJKZOH9Ax/A==
X-Google-Smtp-Source: AGHT+IGvSXNfKcREmK5xdLdLGpoBcxZHLK9ma2oRLZHFgufwj2uLeXd8vq5DC3f0IouV+OETawQEFA==
X-Received: by 2002:a17:902:d0c9:b0:24c:da3b:7376 with SMTP id d9443c01a7336-27ed49fb299mr159575375ad.26.1759228209125;
        Tue, 30 Sep 2025 03:30:09 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1fd9sm154739555ad.142.2025.09.30.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:30:08 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:00:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set
 bandwidth
Message-ID: <20250930103006.octwlx53p2shwq2v@vireshk-i7>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <20250909-tegra186-icc-v2-1-09413724e781@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-tegra186-icc-v2-1-09413724e781@gmail.com>

On 09-09-25, 01:21, Aaron Kling via B4 Relay wrote:
> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
> +{
> +	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
> +	struct dev_pm_opp *opp __free(put_opp);

The usage here looks incorrect..

> +	struct device *dev;
> +	int ret;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;

On failure, we would return from here with a garbage `opp` pointer, which the
OPP core may try to free ?

Moving the variable definition here would fix that.

> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * HZ_PER_KHZ, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	if (ret)
> +		data->icc_dram_bw_scaling = false;
> +
> +	return ret;
> +}

-- 
viresh

