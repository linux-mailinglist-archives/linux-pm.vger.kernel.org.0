Return-Path: <linux-pm+bounces-29966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A59AF0D8D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB24E2B87
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9821C187;
	Wed,  2 Jul 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2TeDSNG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630F235341
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443933; cv=none; b=Jbzm6zUA70NT5dt5Tj9/vXkXHeuylsV4+lgyB+PXXzXSJEHqU1BsSfgQf7cz2+aTIvAiSfJqPxpbuI4CW0/AQn4Gbb2yMvGiMs9Ey0LQdRuKdv0uDYxX9skYd0NLLJyDdSIAmAceNehnhnv6doyJ6aHtm4CQKWqlH8pu8UraIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443933; c=relaxed/simple;
	bh=z0Z5jvK6xUvtBK4jnkZkseYCrZ79UTYnTdxbGRs6ZSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjWrZT5n+3E+neLX72VPzQr20GZRET3TnsBzE5HPZRv30+MvLXwn8aUVMGeACGnijIQT7gEs3wRQledLYyShCxPBXTTgwJ92Ecy/5dHP5Mukiyh4K532hgDK8FxgyKTmA9xQ+iknZKI9IVr+jtg+qoOj/AuRV5MDgbwKKwTPcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i2TeDSNG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234c5b57557so40694335ad.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2025 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751443930; x=1752048730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy53KgmSlwJ+OJKWpNvJE3andfzWWOVCz+777PvTMw4=;
        b=i2TeDSNGtUgm+EL+XAnsMEId4NkbW1o96T2UmskStRLoLd/liWptHY13il2s8bhgBh
         CK7ANf4kJq4QMBGPwkkTstGujdvVwzhLrd1gmiseMNW6CxzYOQIyiEiPSXWqgOFs4phM
         PoZ8gPbmenJeXNHvqEx5XpXzKvSxePdXbMjuePNWqs9hxEKOxdtmK1PHBI9sqHCHkLIq
         28SOoBNWmn6Np/lfVzeV+WsPngwZ26yPB45TwgAFhHyGcbtdL9EFnTkSCfJLpbj6E9wr
         NY0SC1q87IQqJpJ2KMR6DVZd8P5RbgV2CnLCBGtb6DvLtFp3PCIqyiQmOrfXCtmZT6/N
         xM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443930; x=1752048730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy53KgmSlwJ+OJKWpNvJE3andfzWWOVCz+777PvTMw4=;
        b=r6G3u+QqqK2tyDn2Rzl2X2u7mgJR82vGuXMTq5rzqtw0HsOLFWZgu97d2s5dIkhX2I
         7uv2+NUFQT7G3U/uJEYWPYxydtGjWkLUGqmUupgQvAWKYRKBofkYKMgKkEttE+FxOSGZ
         8BpMU3PKKncgm7bugxbBYO7+VrKpWa8d6ZLhbrQdXAZCNIIih/LOBcWCTiidC2nyVKR/
         GJr2oIs3TW1BFVGGEBJ4PBjuEk41dl5BjoAvaskJ2S5FbH3iPmfV03PDEBQb9U1kbHkK
         Q5CD1w5upcPdoUWURbmueLabRrP20BzzpRXn5HuB4GiC5xBho4FR7Kj7k2n5MkMsKVtL
         cahg==
X-Forwarded-Encrypted: i=1; AJvYcCXUVaMRKKih0EaSO9hbS55JqctUK+A7m7WvYRIoiD1LgcEa/vsj7mhXYN8+a8im3RWV3C6iohcOzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsrh0/2ohp+kteYy6Q0WL46svqJiSpz3V39VxFb1zCpJHk778R
	I8tmImON6Gacnds59NgqhcUQdtRsaXibZ1okthNSGg+3XE2c7wtFuzN0wUY1JvYTRH8=
X-Gm-Gg: ASbGnctIIirPNlPMF9yRP+DqAGlfucBPf0em0AhHfL4VHbhPEDCx/cDerSnPuVCAG9t
	pNPiVVMnkRpNWfyv9M9oJA890o+O9iVnV1C3kSCkCKZuTZFQOhtd2ZLiccou/hOi3hACUf+mK1h
	1LWszujZmWwfsfN2DAlPanuKvvTUvBFQA95HrrYMfJanl2nYh/wuw7UnfMnhGZpuTqq00hGfhCS
	pPRSA0jcOlAgLLwi/KIW59jorrR2DzFtmRLqy/YLYjnbUBqXOY6L13zxDJ3czJZS7BMe18r5ajS
	80oSpzYuejeCNOvnGgYdvfCSezWBrKyl/kihXsFdfWK46TmdMh5eYx5KG2A/OlE=
X-Google-Smtp-Source: AGHT+IE7wcE0iwVAH1jLYj4z9nMQShh8CBuXC3Zk4EQNxjP7Cck5KCN98jBFqey7FxfNbCfChiLb2Q==
X-Received: by 2002:a17:903:3c6b:b0:234:9670:cc73 with SMTP id d9443c01a7336-23c6e490fc1mr32796355ad.5.1751443930566;
        Wed, 02 Jul 2025 01:12:10 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1bc3sm121786925ad.28.2025.07.02.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:12:10 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:42:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: tegra124: Allow building as a module
Message-ID: <20250702081207.bzru3mtl56ns372v@vireshk-i7>
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
 <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-tegra124-cpufreq-v5-3-66ab3640a570@gmail.com>

On 02-07-25, 02:46, Aaron Kling via B4 Relay wrote:
> +static struct platform_device *platform_device;

Maybe initialize this to an error value...

> +static void __exit tegra_cpufreq_module_exit(void)
> +{
> +	if (platform_device && !IS_ERR(platform_device))

... and then this could be simplified ?

Or use !IS_ERR_OR_NULL .

-- 
viresh

