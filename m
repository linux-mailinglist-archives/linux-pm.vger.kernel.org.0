Return-Path: <linux-pm+bounces-10311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9F891EEA9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 07:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70991F21BA8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 05:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558F49621;
	Tue,  2 Jul 2024 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7XXWNXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB779CC
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899828; cv=none; b=RV5xW4uJWABgJVoW4qjh1BSKNuy78Ak7FUdB6Jbn64bZ+bPaZM0JkJHFm06c/7BR2Tnm0sqB0AEF8Nvu9w1GUOH7gEfYJRhIQjop1/QGnS7a6CySu5Bvvl0Cf1ClqPTPum5eYeTN0Eobx+a7vsYXHStB9jgRkdaRn7Ts3NYhbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899828; c=relaxed/simple;
	bh=hrWd+DMfhLdhgvgZ6CcFG8Yrdx//qAY+wVKO8Ywgkv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbJZLGH2G3LzWhL47FK5opsv27GXoTHj/cFiNP2uI1ivU+s6pasrluc6Kj1Nxi/H6ntvtHPAstm8qhtGPcZf8fGOCAt0N1RyFUeOqR2Fh3f5nQdsFYkQ7vNbUrEobec9HEYJlwYlFkqQ8tNqfC3qYTy6t7bmsayvIWdccOQanAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q7XXWNXI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9de13d6baso22748605ad.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2024 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719899826; x=1720504626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5rG7724QFwFDpF6Kn0xpJ+NJU0J1nnnGMkvWaoZGyc=;
        b=Q7XXWNXImDCrtYHPdzBHtx39ccJ1r7eAdGwnAnwgJUBky6uKE8qDY6noZ5qDUGggBg
         K0bkA5gNWFkYQrUo+NmXhwLO7qkV90ACGgfEhs+vSDf3u/6S1R4SKyriuUjl4z4jPAsa
         6LTnrI18muMeE2piIJLNeoEjt0h3rISrzVZ2H+JSizWaoWJHvZbToK0LOI0PikJCy3rl
         9Te6evRbuA1MXR7dv0r6TY8AXaVd1rCcX5WQiX/jWY5oDr0C0Be7c9ISbBxGqAKHb5E5
         I4/gbTQpumopUjOards1Hsluz+R+3mrskMUV7fsKNGeauCfjXs2UGYqX6wJclVc5OEix
         Z+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719899826; x=1720504626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5rG7724QFwFDpF6Kn0xpJ+NJU0J1nnnGMkvWaoZGyc=;
        b=Ps0bI0ukSn+4stlKTP87/PMAegFZt4QuqYKA7341dT8tUaB1fBMQVHseuRX4JWlnVL
         WwcTJJIujhu2Nky2YGz6u1WvilxKcDVccday05wLbtyNJQGodTm1Wt8FwU+WKrZe+6DJ
         PkZIpzHyZUntUxYbNCt7fSheL9j3q2OlrgDQWie0rdwDYMSQDXhVWemiB2azE2fmyvOz
         Ky9yve10HUl6tW+Qs7h66dgCp5ishjQieQUDtzbZ+6QM26jXbuGSW2WiZLcrEQHoDpua
         1u8K/enJHv+G/haGg6br5m1RXEZv9Ll4x8aw1p2IBGth80ZslYhFot4Ldp6lnQ6Ckb4t
         YSBA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lkix02sR7t0kEOQPJElncPH/M2BEGc5Uw3weJDd+9iNp6Z41ZnlSCYOnnKMWCPWA4W5Nyf7xMmeJHez0g/f+YpDg+nZzsKw=
X-Gm-Message-State: AOJu0YzPGIt7CHqq5hV9VuxxspfSkXBDp8QoYBoeFkkMINZy1+GYEOWH
	3TeMAGxUpG4PdBaWdNzQ7l8QbL3gYqHHKKhfkheIrciCH+W+kEnhulDQbcws55M=
X-Google-Smtp-Source: AGHT+IHCa/XZ44PQvOPHK1Yiee37rkwXi6KHLsgAh7cZkOVdJcrPdLHRisJCUzRqNJuStcv8fmZSkw==
X-Received: by 2002:a17:903:2446:b0:1fa:d1df:d41e with SMTP id d9443c01a7336-1fadbcf4690mr46300745ad.58.1719899826024;
        Mon, 01 Jul 2024 22:57:06 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad067031fsm66279735ad.259.2024.07.01.22.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 22:57:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:27:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240702055703.obendyy2ykbbutrz@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>

On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  	int cpu, ret;
>  
>  	data = dev_get_platdata(&pdev->dev);
> -	if (!data) {
> -		dev_err(&pdev->dev,
> -			"failed to get mtk cpufreq platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,

What's the point of calling dev_err_probe() when we know for sure that
the error isn't EPROBE_DEFER ?

> +				     "failed to get mtk cpufreq platform data\n");
>  
>  	for_each_possible_cpu(cpu) {
>  		info = mtk_cpu_dvfs_info_lookup(cpu);
> @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>  		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			ret = -ENOMEM;
> +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");

Same here.

-- 
viresh

