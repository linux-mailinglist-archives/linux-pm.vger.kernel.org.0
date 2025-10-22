Return-Path: <linux-pm+bounces-36625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECABFA266
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 08:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AF71897619
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E52EAB6B;
	Wed, 22 Oct 2025 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKqpF+hP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C32EC540
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112929; cv=none; b=Fvsd+yloUloyVoxYb/9lmXY0ImP62pIRavYW3R4+XFhjtoddQ4Zd19rjlKqTtg7FYg7QomqVj+YYcYv7Rw6oJV4rdC3ao740XddgeQqnutKp5q6xXa0NaTP4NSYHUFXk5iHBMmXqU9hxiWqXwS+5r6lYJja9AHK2FD4h5zGXNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112929; c=relaxed/simple;
	bh=uNd0RlezKmVOkkCFnO3wa4SdchHNHXgBhmGRBya+TZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgUBlA8MoFX0EMFgJ+UGL2N9vmMx3U36P870Ija+ZThqrCDTTeW3N9v9gdx0rWPL9ecboc0T8lT0O6mUHDTKGBlPwlRLqyeP+wTeCukd0kwX1gDgQ+g5aNky+fCxki+OOwmHSf9UiW8pV8e6zqC89+HlNe54sO0HpkrJwArwZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKqpF+hP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cdba26639so522448a12.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761112923; x=1761717723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKqDAZxx1reZjTRMo7FvolWvlhv6pTm58+Z40R0DLEQ=;
        b=eKqpF+hP8Qbu3WbRL1Cu/e12XbVa8+AAEYIMi0P31MHcpq1v81UMrb/4C9zSK6AuOr
         z7Wjz61qr72WZxGlM0KXV+POp8WVj1nuV6yHeHG772YwOaJbcPx7ZU5VGQTxSsBKNsDD
         tC3BH8JAiYDj0y4N2XzwRyuolOTakgMmdRckXqQxSyMXTg0Szy3qtK4nMH2fPqkrPR/a
         D7YJuAcE1qmNXJBfoQDcqJQ70CUVxWehHcqWgC/Kn74BS8ejG+o8fCaC9PDKE4X7Uvi/
         A0gFJ3dfYeplAM1H86RVUfwBbqUsr4tDmv6CfS1s3aWtiKKfvVJSsvD7F239+xR2rA8P
         HAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112923; x=1761717723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKqDAZxx1reZjTRMo7FvolWvlhv6pTm58+Z40R0DLEQ=;
        b=tLWy4j9pmNT90BiyB5hIX3H1j3aILsGEPvuqIfpsLkWUGqgwaziz3nyx0GijRxkjiU
         gtf1p/WGO/xVRo9gS45QDm64RT452ShKMa92D9uedU1LQ9+qIkTJIIeGiwipIwQj3YGu
         OWZzd5Qjs2vLFrF6x88yCghgRWxrdBgojsaYym/Si3ZPUr48rsi/2QKsJl8oo0jngvcY
         ppL5P83TKffY9H3/sMOXd1mIHZh9d+Gi6fvaFf3yo/Elz3I8bXd55tUSu3res+iJTUCq
         IVHYr/138NEMnJHjDApX1ve+0QWZxoJ8BV1pScDXqDM0vkkCxjULaB1CWRyazGX12A69
         ub6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVQxrUNZMf4w3EyRKWZ/yjmJYE+w93Fllp2sctfUsvSLeQKVcwRS72IO0UBx3QJplijJQp+BBG6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNuXKNpa+x0HAI83NWUDDnuNEyPDpg96XMu1oFtVdFxblSptF
	uDU5DYkVU1Y2BJXXVcrl3l/lgB6MgebsRP3aHvJhGFOx7TGsfC12U4x3ZPpGTQdx7BI=
X-Gm-Gg: ASbGncv3U68b+5e1KYOVRGHnJtdAYmw7oG8LeDSKxTfae4nx3gDiQN/dai8Ib9ZUt6a
	FaiR+lysIOyGK6pVsjXFhkSO9pfi8My6L+g4zPllVJ8C4nrmCdGHzzYfDxGwpwJdZDEDB7ztT1f
	Bc+BWs+M8udjNYZ740VqdWPaR/FDlWWpNd/zDjjzoHERHdZ6bZiKe3X8SH8Wm10UvvWe4sXiD/x
	15LHA3nsaYFmbnDF15GILPIgIvx/rfzoJtxZEj4Gq5Ivyz63r/s/Yg4N534NeeHPbymkcnYE/bW
	iklHukjzTA4kepApPQnWWY94tR2op0wXqAL4m44dcER6QiZQcUaGy8yLhlqzK/T13Ai9a3+b+02
	tKkpVK1mM6eg0gNxAYtJbGUAUB0WrN2Zr3gqi3Hy9g2HwTz7Xdwfo7+AQgG7brOrMx68W8obuZB
	jANQ==
X-Google-Smtp-Source: AGHT+IGnZYhZ63rWNSf5aRz/1B5HoUov1Sbx9ncDDRSOtX2wKHaECGMRKtQmrnXwpxWiNTSuOjN5Bw==
X-Received: by 2002:a17:902:ecc2:b0:269:a6b2:2463 with SMTP id d9443c01a7336-292ffc0b82emr31764605ad.16.1761112922908;
        Tue, 21 Oct 2025 23:02:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292469104edsm128908115ad.0.2025.10.21.23.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:02:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:31:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: tegra186: add OPP support and set bandwidth
Message-ID: <bxec7gq3b62g5jdyxs7oo4dvq4dd5hwczdsvbimjka7u4zwye5@iubxkvn2mbre>
References: <20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gmail.com>

On 21-10-25, 20:08, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add support to use OPP table from DT in Tegra186 cpufreq driver.
> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> Cross check the OPP's present in DT against the LUT from BPMP-FW
> and enable only those DT OPP's which are present in LUT also.
> 
> The OPP table in DT has CPU Frequency to bandwidth mapping where
> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> number of MC channels which can vary as per the boot configuration.
> This per channel bandwidth from OPP table will be later converted by
> MC driver to final bandwidth value by multiplying with number of
> channels before being handled in the EMC driver.
> 
> If OPP table is not present in DT, then use the LUT from BPMP-FW
> directy as the CPU frequency table and not do the DRAM frequency

  directly

> scaling which is same as the current behavior.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied with:

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 35f1c1371f6a..34ed943c5f34 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -127,9 +127,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
 
        /* Disable all opps and cross-validate against LUT later */
        for (rate = 0; ; rate++) {
-               struct dev_pm_opp *opp __free(put_opp);
-
-               opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+               struct dev_pm_opp *opp __free(put_opp) =
+                       dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
                if (IS_ERR(opp))
                        break;
 
@@ -145,9 +144,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
         * Enable only those DT OPP's which are present in LUT also.
         */
        cpufreq_for_each_valid_entry(pos, bpmp_lut) {
-               struct dev_pm_opp *opp __free(put_opp);
-
-               opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * HZ_PER_KHZ, false);
+               struct dev_pm_opp *opp __free(put_opp) =
+                       dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * HZ_PER_KHZ, false);
                if (IS_ERR(opp))
                        continue;

-- 
viresh

