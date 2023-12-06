Return-Path: <linux-pm+bounces-730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E039580672E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 07:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCBFB21D5C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5F107A4;
	Wed,  6 Dec 2023 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1GRMpKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927011A5
	for <linux-pm@vger.kernel.org>; Tue,  5 Dec 2023 22:11:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0538d9bbcso44399385ad.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2023 22:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701843075; x=1702447875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKYZoWEFRs5dUVHYwgV/qy/EKtszPIUY4QdRgNvnJVU=;
        b=T1GRMpKojs0Dl4SDXSY3bYlk2QcssiMWR4Gx8x+SlVlehoejrOU8X/7c3pXEu4e1Cc
         wNlCnEOGkn4r0iWrZWnj5PWZO/97jC55fTflOC9bF0dnAs/dyi+uoKK6nm4oxApebsmK
         aemj1c1dlL4vtd+Bt7hEH/Z9UnbVCQOvBqXd96+kKsQUC2EdVNOYunCvXpL3D1F2eHN8
         qA+ZSKe4cs/3c/kbQie3jvHZgWZJSuLtRyzRSjDFDW/05y0yPvxKL+e7wYx03uFaY9qK
         fypDlh3v3RGff5pnPH+VZCRLCMwp0DmQTMMaRbJDcBIb3oAc24CgZzIuqZnU7faEA5s9
         g45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701843075; x=1702447875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKYZoWEFRs5dUVHYwgV/qy/EKtszPIUY4QdRgNvnJVU=;
        b=LUsXIxHAKsSznEIIOttsD2rC6wSe7GsHX/QI70yyrTIlbM7n1pxoJ3iwGWzezL9E7t
         N0CUMxUy956LH4xOsgXkSykViB+5+HBKcMkm43GnEPUWKE7qP7i8FmQxt3Gx7N5EpqlJ
         e9upW1Zf2uVnk3LnTus6G1AFZXMcgu4prPbrr3ZEFE2pF2fzU8KNrxHesR1uXK0QG3d5
         HHagVK1wckC1HCZy6bwZG+OahFoqVHsNnL1cBzYAEQTtrqs7XeLYOrHLYyKiv46ZMYY0
         bClDfsdyvKsg+k2iZCgAp9+DeHj+cT1Q9KYJGU4fQbPjpx1PI8TYFno9bsICb6qHBsZS
         K4CA==
X-Gm-Message-State: AOJu0YxqxXTCXSqTgHl3iKFDQgjSBOifo9hzWDcrliBrDMNUKMCA5V+p
	9H6lEnqcqGcp7xC5uRr6zX/SjA==
X-Google-Smtp-Source: AGHT+IEp5WARRfM1tPRtLayT9Eiln2oWucgWr5UerTnbv6+ix/Zqq7At6XJ0dwkVcZFV1u/taFf+bw==
X-Received: by 2002:a17:903:18a:b0:1d0:969b:4c0b with SMTP id z10-20020a170903018a00b001d0969b4c0bmr445601plg.101.1701843074923;
        Tue, 05 Dec 2023 22:11:14 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001cc2ebd2c2csm8512372plg.256.2023.12.05.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:11:14 -0800 (PST)
Date: Wed, 6 Dec 2023 11:41:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] cpufreq: scmi: process the result of
 devm_of_clk_add_hw_provider()
Message-ID: <20231206061111.yim5ahpwdovirtzu@vireshk-i7>
References: <2e919694-e124-4864-aa02-01d47495032b@wanadoo.fr>
 <20231205151220.18463-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205151220.18463-1-adiupina@astralinux.ru>
X-Spam-Level: *

On 05-12-23, 18:12, Alexandra Diupina wrote:
> devm_of_clk_add_hw_provider() may return an errno, so
> add a return value check
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2: replace dev_err() with dev_err_probe() as 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> suggested
>  drivers/cpufreq/scmi-cpufreq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index c8a7ccc42c16..4ee23f4ebf4a 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -334,8 +334,11 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  
>  #ifdef CONFIG_COMMON_CLK
>  	/* dummy clock provider as needed by OPP if clocks property is used */
> -	if (of_property_present(dev->of_node, "#clock-cells"))
> -		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +	if (of_property_present(dev->of_node, "#clock-cells")) {
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: registering clock provider failed\n", __func__);
> +	}
>  #endif
>  
>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);

Applied. Thanks.

-- 
viresh

