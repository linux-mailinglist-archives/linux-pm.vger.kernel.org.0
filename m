Return-Path: <linux-pm+bounces-32676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62FB2D3BF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 07:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CF1586E22
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016421CA0C;
	Wed, 20 Aug 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXmymuyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC391C3306
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668884; cv=none; b=ZgwpGjqkcAXDWbOipR4iNutn5wgovHecu+DprGCVNriLnx3j3aYutSq52ey6SL4oAc08mGlVnYLY+lyEWUTjrhreI30EJDRzhowOBw2JfLZLIhFAru7gQ6ZCbdXkIqh2+5RjGPwuWKgYlJ6tI+5Yi+0Uup724Q1nc1Ni7ks8t8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668884; c=relaxed/simple;
	bh=r+w8WvwWHNQ4VwOfdxeCscDSyg5iTvG3fk5pdUlOBw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4/4sXcDhvDp7p1o45rW/gnTtVBlUTRXhm+Z90NYb/i7E6TyouEjqw8yTzoTFBoipVxFzDqR1y/wGGCahEdSxEynuWuDN7VIbIhtGmOtaFSP3SqlufJxsA7u+TNMSBAB+GxWOYDtCH7pkUvxn/g2bXQzXCtMZ3X76WsYMJ0bMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXmymuyn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb09041so5212066b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 22:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755668882; x=1756273682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vW8840o/ycg8xvcBZ4mzSNjiiU65u1hBI4Xzd3lb1KY=;
        b=YXmymuynHBdxEF4HlAV6TTIOgR+nr+wxNh0sH64TXUpd9MoPQRvnFHaNmLyhDiL8OZ
         NRkgiSdHB9T2mpo5NyvoTP0R5vw8Uzxw4AfAGkGz6MOTuRxBzv/k2aBoMwD/m75pCEwT
         IEA3jdlgNVkm/qg40/0C4+sDht3kKQHbNnlekZv6w0OwjtjRixgiKiv2Zf885sHB+uyW
         dwisMqJZd4NavO7aUbkYtLZR9DBJVr4fQDRUEfPWIu+p+iCVPye8zMCXh7bFI9O4ZxW8
         MeeZoaIzDHA0YcmZEVdJKpiXPYjsx7F9+hzwAv/gyutWwnnJTymZjONLHhGdZVDYIePL
         Ylpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755668882; x=1756273682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW8840o/ycg8xvcBZ4mzSNjiiU65u1hBI4Xzd3lb1KY=;
        b=BkwOKFpQLlgUVq5yVixHcmcO98IVNXdNUnEvcZSngLLMhe51uYvZy4nWE1wVMOYXkI
         L7dnSI6xqDu7NgNUtVvU4Mn2hvjUILdOv8q1E2BBrOJGudSEiihMiYi7agQjexRTwa/y
         0hLEy94M7f6zxk8YkifPePGUAwq5GDCxoXNgL6tqUKGzecFMy67a2oTO2I2u51CKfHg+
         eUWaiOxqENKyep3Y5bBiYIPRKoW/Gv0jnkdY3dfj49Ru2o2SMmutRQvkHVd0dnz6PS9r
         rAzxojtJaaBmD8uoFwny0Lv9uGWHllizjQvanRP+rPO4gvZtb3MktEuFOHNfhZrxv7EQ
         JTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3zCg23dAU6RFjImC/M80EYqu87oYD2EN5iDRxMzBlBDf4i6obcSFEaubBmyz0nzq2MgkLp5jlKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGIFooFusjoWAwECmDtpAYpvihjMCapXqtHdgko11WSaORUt3
	JXlIqCtGRK/F0EiEtgKRtWlH1xFAdtNvNr0BmPvvkB337/zd+g8f7331aywwchlqiA0=
X-Gm-Gg: ASbGncsgmPJ6ZOzq/5dvyPYXV6lj7jsimQ0YzsPQrlC4ULYkoBogw3nbpLFgvU9/9mf
	0H4dHUFnKUKCuxtAogvCbDW/Ir2LbW+swNJAvLoi+N8xad96OgYO7l08gxsqnn7ig963CzHfvsR
	Qp53cTK0rCUNQp62OFSdrwa0KyCKlIhKlmWXLc5vpmdEbyLeX3g2ds9YM7o82t1BwdUUyClGl7A
	krtTTJNhh7B+cfMP1ErEkQjN7rf8PWLL8OKRICLZ2ikir71wIZN2veoDMk/mX320bWQxFTaOiXD
	ERbAX4+jr4UGj5TOM3+sOQN88x2YZZ2RsgpfcPStsCUV9zqx10XkSxbj4IewxHszVEPPNN7WZTi
	M2LuD81lpu7ajW/48QU1SwKRh
X-Google-Smtp-Source: AGHT+IH2Xq01l1q2X39vBmw9ze+Dsd/H2thv74xC2wrCKl2UpQcwUaIMycYjfq6gt0/zvw2HiqQMAw==
X-Received: by 2002:a05:6a21:32a6:b0:243:755:58b8 with SMTP id adf61e73a8af0-2431ba737b4mr2735426637.57.1755668882295;
        Tue, 19 Aug 2025 22:48:02 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e250e52dsm1075206a91.6.2025.08.19.22.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:48:01 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:17:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
Message-ID: <20250820054759.iewwi6uvsvowc422@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-3-zhangzihuan@kylinos.cn>
 <20250819105925.34o5f5attd5rboh7@vireshk-i7>
 <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe2344d-e825-44c0-ad2b-9544b123079f@kylinos.cn>

On 20-08-25, 13:42, Zihuan Zhang wrote:
> You’re right, we didn’t really consider that case before.
> 
> The interface of cpufreq_set_policy() does look a bit odd:
> 
> - drivers using governors don’t really need the new_pol parameter
> 
> - while drivers using the setpolicy method don’t need the new_gov one.

Right, one argument is _always_ unused. If we could have handled that via a
single argument, it would have been nice.

> I guess this might be due to some historical reasons.
> 
> The question is whether it’s worth modifying this function, or if we should
> just keep it as it is.

Unless there is a better way :)

-- 
viresh

