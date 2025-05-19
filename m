Return-Path: <linux-pm+bounces-27335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC9ABBB0E
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDED61685FE
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A662741D8;
	Mon, 19 May 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWeoyF8n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3282459E7
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650394; cv=none; b=mA9uNnmDax6gPRYzm5GCq6djMyazoAvRIgGCz0IP5cI+pTAOqI6RpQUgbFaVJ2Ouhylj8xRMD+jJxJdIs/D7LgvpSBZnYEqR/stEaE8Y5TVxk1LcKv8w2Ywbh9M4sgXrufyeVs2XXvJErbZzlWQB2mKl8JMQo7Em15v4P++1zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650394; c=relaxed/simple;
	bh=6T1f1gQ788CwCIndP7K5d2YwrhlQLWj57RrD8MAtP7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWrBZNaGY7HI7pvpksb5a7aRQSGrdGY0031YIK9I+hnWXRXTQd/8Fm/L0W8z3Uv6sWVM+j91vgMMoUWA64f+WWKUe2aaDhg/6qNdIdGRBiDlY/4jQL3d4Jsp1VUqysUrTkqQtIRV+Za2bUP2Q5ocXa0fHPpaKFgb9Mg+8HRvqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWeoyF8n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231e21d3b63so34072895ad.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747650392; x=1748255192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94QENvQ1KWEG5NwI/w4uyuU8E14TEUfGFeGO7c7WDvo=;
        b=sWeoyF8neBCSuvdV+42RbR1GCnL48ocG3rxQtKbvMBbaVZIs2yt6esFFy12BewYbOu
         40eaf2VfRtvXa16PSA7ZKkX6zaMogWpgiwk5vdPP+PR5QI7LdFLrmiGw7EYLDTKeoL7G
         0PcjXVYDwp0Byyditw7zUTIiSnzVy9DX3uLXB0tez8LKgJy3fu8R7oNBIbYuY0KdJhOg
         ag4f/ZNMTrL3HwvX0rYu0+WGJC4mI5v8jY5c1nDChegHsRiN2YeXLvUUixh/eyWZGns1
         XIjK1N+WB3BXKfO7sQzbWi3qvafyHxwVPba7IS5k0Wk+HkiisNxUckwyufDyB3lKI1K8
         LjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650392; x=1748255192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94QENvQ1KWEG5NwI/w4uyuU8E14TEUfGFeGO7c7WDvo=;
        b=EQNWSMPE4/i3RQeNUvhq7VRXPlDxxR6MIGDxxmjaT3GuyhYt2QIfvnu/XIqnQSIosT
         pV4o+FyJk+feZROXqY0mophgmlyjYDWiM9m6Zt7avj5PVw2ya58e8Ukz4EPCYH+bK4Wl
         PCOTe+A8WzIa/d55iy1CLND7YWT2znA5gxQqhwKrAVntapA5Ajk5qQMdN0ncwSjXFKCu
         UiBBf5ONN7O9as4tWh/lcHFGJ9ynVmRXvS4LdKyjBEKX+uZKadjIZKZsFoKz1D524l91
         dkSr/nngGd4qJFyh6R6MzoYRL2HETg9ZIzq3Gij1YDassPedbkpjZ7+wb5gYTAenYmbb
         KMwg==
X-Forwarded-Encrypted: i=1; AJvYcCUwfJRQnStdV2WsjqvrxvdcZa6826JBrOXDhVBQQBXW4fU2dh/Fl6+AZ7LI3+Ks6Y2PaZLDdhjQhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxk2LxxLqsMf7WjMEalsNjDGv4sktAgib5AlA9jS3+sfxdDSXa
	EBZguYeb8plYni2a1zWCpsWtmCZ7Xr6PXlHU3b1cXFxio4VRySPTOZKYzeKQZUFLEapeLeSeABI
	+FZhY
X-Gm-Gg: ASbGncvQGpIO++dxSrsvMAqKsCeR6JRYebKUaSuiciUFwQSxmLZ37CM7MTxfndKZDIp
	0HON/Dx6OTyZxaaTv8jrXddlh+N/52g675jTqnoNgW1i1Aquv7bSfB/KOMmK7tNaI/Xj+P3SE6E
	j8pr3g4steZXydpIU6gxAZf5T3iU3a4VIgl8Eqsy7FmUHDkAEfaSyEBsNEjr8mxVut9Jg+iYv0F
	JwCmD0ks27z6DYjSsafPeb9LiuC48WoR31gfP/kgN5KzP3brG4lCUaRAuS4gHS9ILW93Gc6Nhr3
	tWtRINhaX8Vida5gMz5uI84U2oFyn1i0mCzLHJ/J+or/ZwMbLlG2
X-Google-Smtp-Source: AGHT+IFOX0X2+R42qCuUGR5p/td3W4u1++p+fajp/DYt04hZBSF3cDqdXMoReTclZppoLGO2xeShYQ==
X-Received: by 2002:a17:90b:5710:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-30e830fbf1fmr18521513a91.10.1747650381025;
        Mon, 19 May 2025 03:26:21 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d1d12c7sm6314287a91.0.2025.05.19.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:26:20 -0700 (PDT)
Date: Mon, 19 May 2025 15:56:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
Message-ID: <20250519102618.4thbahapz3lfmfo5@vireshk-i7>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>

On 14-05-25, 11:31, Jon Hunter wrote:
> > +static void tegra124_cpufreq_remove(struct platform_device *pdev)
> > +{
> > +	struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
> > +
> > +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> > +		platform_device_unregister(priv->cpufreq_dt_pdev);
> > +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	clk_put(priv->pllp_clk);
> > +	clk_put(priv->pllx_clk);
> > +	clk_put(priv->dfll_clk);
> > +	clk_put(priv->cpu_clk);
> 
> 
> If we use devm_clk_get() in probe, then we should be able to avoid this.

Not sure if we can do that. The clks belong to the CPU device, while
the devm_* functions are using &pdev->dev. The CPU device never goes
away and so the resources won't get freed if we use devm for the CPU
device.

-- 
viresh

