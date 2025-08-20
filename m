Return-Path: <linux-pm+bounces-32670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4FB2D2E3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFDB5E3898
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 04:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C61243367;
	Wed, 20 Aug 2025 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWsP+1Zw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40322139CE
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662848; cv=none; b=E36FQ2pYhpedkvIAojsFAXCWuCLYAxp2ZSlD1XfRI4S3gehYYdZ7UPPVYtiQrik13674WKDqGklIeY5Q3A9TewFdBcYuEHly1dGZeV5VCQ44D6iYlIUI1/+t4rR+MXwN7njGO/bXNfoFrbE9CMGXP1/ZAsXaDm+z/fDQn4YCFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662848; c=relaxed/simple;
	bh=fAgaMPplb2lrDBwavf7iOGhQZHwJMxat6ZSt4nk3FYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/f7uuvAexoRdAB32TKAilioo5qTvl7wsqWuUqKD91WxNkt8mVzd3gbJ9sL3liLRFjSjEhSPqkX96VVd9rXB6qwzj73ymMbND/EFQ3k718fik9CiqN8a7HVVFBdza5v58QQFiHR4NyX11ah7NOwidmHoCSfRiLtBAAO6ZmH3qFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWsP+1Zw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266d6f57so5993472a91.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755662845; x=1756267645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61TbShyZGmEFoOQMK1FLzfzRsfZunqsPJaTJZw2MfRg=;
        b=dWsP+1ZwoxZ5KWVgUrz0+gc9H/sT1LC+c2a8+kJhL2NjH6wySeINx9gnktOLvdQZDf
         J2hTy/7FmGxH9qp1c1YAAJRfO8mYfAz7XcMI0HLUjTvJrpH80H4Qyf5JgSI4EaJiNF6X
         Ujpbf5a1yFMoEVzlXTVZ7Ggcyj4pvUNbxXBJ4CJcq8MxmIgHWuYge8bVWCLBp5KjdLdC
         Zv89/3NIDKBlAIV3ttlCzMujUR217jzrCoKfZPoypmT7L0ipCNGVUNQ6xMSdglkp1vWV
         1Xm6Qzdkqm+EGNh4xoS7k+PLhEmgVL+NUGPnxzzjxSlsgWolodkJRocZRsakpALhzQly
         GBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755662845; x=1756267645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61TbShyZGmEFoOQMK1FLzfzRsfZunqsPJaTJZw2MfRg=;
        b=B2NOBMs35RYWKQFxU9mC8aipZk+hEaQKHCea3ZC091+JgOpyFU2TynXfmff06CPfaQ
         OD0THD+RJ/jeI5xo+211fWJDCeo+VqQsU++9eh+5iqAlDuuQndd+bK/jVqJ2jI+E1JKb
         S/k3ecJ2nS9VI1KzoUqvrEup+a726AWKs3FxF0+OAB1JZISe+D+8St8Sw6VFSMzZOVq3
         XJ+JgqcsWLR/BWqVKLYVKk7L21I1qbpp23mEIBbHhmTpZj5GlCJq7xSACycU4s/3GXLa
         2qB3M8VsldPJ7uK9CkpL/o4SNFUHd4TZfLMd3BUyyKpJmwqFYoo+vc8O4NautlWw+sKK
         mJvw==
X-Forwarded-Encrypted: i=1; AJvYcCWE9Xe0M7kNXeUSSqYQ0dOAU6VYx4ugIHxjDuNVvpn5tqSfkSU5l5Qjh8Pm4rytYUNB8YYxWH7E7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGfVwiHGlnx4iew35IzvxLg275GeEi0q5vF+Q+n6NbMq1J9u1
	f6EhbcRsSttiL5RimTrnGvax0/UkLKSrV83Y6LLYjL/hwRQ9ZVmXw17+0AjKwAUA54k=
X-Gm-Gg: ASbGncvgqE4zh6jib3n8BwiGjpLTLv94lWTtqHi16Hwp0ANc2A5nGb3+IJ9Unhvn2gC
	mTVkmlgHda7nN0TKG7G7Ip/kemkxP57l75uUemk0CZO1hIKpJgIwl6bL/L8ooBqBCL5r4OwB+BD
	EvpXLIMrqstyyy3iF9a90I+UCCmszbX9asW4J9bw8q/HqdN9l/mjCCdTMDcEtnOhMpVCCZqtSKv
	0rSdfV+k3AZr2708fmyG219meNr9rG2Q//kTSGJOoO7VqMMngzCLHEa57ohNLgiovI3Ubp8LceT
	p/s2YLMg1SuSftqCXg1E4tDaLsCneX/6St3CbPTQCDBXgailP7vKeTg5x0KW7e0IYl3bsKNBJ+X
	wMFk8dY5bEN3j/uKgdWL1wyNV
X-Google-Smtp-Source: AGHT+IEF8aL/OwClRkLK03kIO5ZYX/8TW6kXe9vwkD7+3xAbrkceAzbVpiAbQQ6RgDwBHRsjj6oH3Q==
X-Received: by 2002:a17:903:1ce:b0:242:29e1:38f0 with SMTP id d9443c01a7336-245ef14b770mr19823785ad.24.1755662845050;
        Tue, 19 Aug 2025 21:07:25 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f3bfesm12339785ad.119.2025.08.19.21.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:07:24 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:37:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek-hw: don't use error path on NULL fdvfs
Message-ID: <20250820040722.fdf2544cdz6k6dcq@vireshk-i7>
References: <20250819-mt8196-cpufreq-fix-v1-1-adb60a3082dc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-mt8196-cpufreq-fix-v1-1-adb60a3082dc@collabora.com>

On 19-08-25, 13:21, Nicolas Frattaroli wrote:
> The IS_ERR_OR_NULL check for priv->fdvfs is inappropriate, and should be
> an IS_ERR check instead, as a NULL value here would propagate it to
> PTR_ERR.
> 
> In practice, there is no problem here, as devm_of_iomap cannot return
> NULL in any circumstance. However, it causes a Smatch static checker
> warning.
> 
> Fix the warning by changing the check from IS_ERR_OR_NULL to IS_ERR.
> 
> Fixes: 32e0d669f3ac ("cpufreq: mediatek-hw: Add support for MT8196")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/aKQubSEXH1TXQpnR@stanley.mountain/
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

