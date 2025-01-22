Return-Path: <linux-pm+bounces-20788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9299A18C7A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8274F1884E41
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68701C07CB;
	Wed, 22 Jan 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ly2m0ges"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B391C1AB6
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529206; cv=none; b=GlFUSRycwdqVNtAWDKhUaMSOdfgWAI4OApyhPAlDaO0ePT0wg+CFLUlBXKBl40N/M/cLcSUO0xN5kByGj2n4OEYVF1iCNm6yGl+qpMMzE4YtGa6j2vN3mZiaHyINMf0gESjd+wS/J81W7Kye+U0hs4KBZ1xPlkUiliSmAKekvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529206; c=relaxed/simple;
	bh=rE3huaUwuvRW31ymAALiNNK+Xoq032LfTLcrVI/CohE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPHzb3wy/3UPSqgoSucbNJVkcfZSEzmry7JydTSFz092bshz12FTPCNhLNGGO3o6ymwYtRUR5gqNnb6O0usr+kSSOiTey4Shd/S2449eomTp23DYbWquZjfx4hpxImjnnA+d/cqwKNQ4VMOhVw9NwM7xmHWKX/CIn3oL639aoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ly2m0ges; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso112146125ad.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 23:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737529203; x=1738134003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0cpSsSU+s48P7VGsqPLX+zN61KloEKzbVZ7uGDypMk=;
        b=Ly2m0gesf1d9Q9bxX227CLmU1n5PfAUYHpHN3jsm348QvsGv4Yw8EtW2ksFDfrgo0W
         nbOjeWf6SNaKtq6tL/hby5fjDLqYzoxwafQrFzW+92hb6hSGM4alnVt/z8JvSpFvmm80
         DVmoMcir3j016yufURPgco9DnvAAgciHcYBDLnWUMWZcQ8dmQcAExOKTIji+un4h0Zhq
         Dxdx1+Jv+fm1OYPm5h0BQJnrkOkoaOI71uwoYEgF2fx1tR1yID2XLWY5UohaWdH+vAxX
         1vUJMQ6Ue7lvFdv7a+RRLOqAb43DRLsSxhsXumZdfh6sWAnVVRN6zkdgKYP1i9s1+3rO
         DMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529203; x=1738134003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0cpSsSU+s48P7VGsqPLX+zN61KloEKzbVZ7uGDypMk=;
        b=uHDdR8Bm7EeAhiLKlg1jQUt78VT3zvNWB1y3wU5R5ll6SHenTcNOZtvstvmf8mYesX
         cwdwFN91ZIiBjTkqfzJiaP8nb9paWg+qm0fp9u3h/L9+1t2uKeLzqwrnJjHSVbnnSGPn
         Iee2boMVnTUyuR1kf1e2M9AKW/Knyp6hB3k6yHh8TFseGuW/PhiDjz7Qnmq/Cdxh8wdg
         LKJvFa18TUKwf2+ztlFVYLSCUa9ULN7jUu0BP+3QN5G4Oarhc7D2ErSWYPKQc5D1wIG3
         0q/XN+/Dt5hmqesfEVpLJ7xlMUKto3P7s44X4SbkT4u1wdmZSDY4svwgpDkBzlp8j2HD
         cgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDobgJGUL0vLE9EJJO2nl4RBILpicOHMvUGw6fWQIkdHnAecyXjNaWnzJg/qQSxaZiDHT9rNjPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgjFPlvuVR5AUKrAG2yxMkkC5c46N1cz9ElqK8GMDomWVbwA9
	5uREk0ufnFyBK7LYOYN3tmF9ReeSzKE6rVYT1SGm2M3GjWRB69G/jUbxBe6z2ws=
X-Gm-Gg: ASbGncskcgEhbb8BznDMABq2GC6FgrWiBmHYvN7oJdqubGVdLac9Od4fn8DZN6cGN7Q
	g2LwB6GKbGCVdKtdATQhtWPPbnLzP1j+oy1zdF+AQl1Rr8D+ALGSpXOG/3UgZhmeWUDAK7v0myy
	HpNJE8ML4ZRNW1h/ukrw1ZNL2hdWJwgf6hphB4e+BckPMn4TV0hxvnwf7+GivGxJCQ1m278EXyj
	g7nD8GWmrj1Bqm7cmwdMOeCp0VayNlyPf/spNiLNC0vupA8DlBlFU5XR/e0fYIslhSaDO7I
X-Google-Smtp-Source: AGHT+IGCQkIn7ZTTkuomqxvmrLN2VvgdOGMSBHS9ZrBTJ2eSunnuFvbJbM/+2VYv6IstsZzPPKTOrA==
X-Received: by 2002:a05:6a20:244d:b0:1db:e464:7b69 with SMTP id adf61e73a8af0-1eb214e82damr30884725637.20.1737529203154;
        Tue, 21 Jan 2025 23:00:03 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabacdb13sm10193287b3a.168.2025.01.21.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:00:02 -0800 (PST)
Date: Wed, 22 Jan 2025 12:30:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: airoha: add CONFIG_OF dependency
Message-ID: <20250122070000.sawplgg5tfhrvdfw@vireshk-i7>
References: <20250122065516.1483301-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122065516.1483301-1-arnd@kernel.org>

On 22-01-25, 07:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing without CONFIG_OF leads to a harmless build warning:
> 
> drivers/cpufreq/airoha-cpufreq.c:109:34: error: 'airoha_cpufreq_match_list' defined but not used [-Werror=unused-const-variable=]
>   109 | static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It would be possible to mark the variable as __maybe_unused to shut up
> that warning, but a Kconfig dependency seems more appropriate as this still
> allows build testing in allmodconfig and randconfig builds on all
> architectures.
> 
> Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 704e84d00639..9e46960f6a86 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -18,6 +18,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>  config ARM_AIROHA_SOC_CPUFREQ
>  	tristate "Airoha EN7581 SoC CPUFreq support"
>  	depends on ARCH_AIROHA || COMPILE_TEST
> +	depends on OF
>  	select PM_OPP
>  	default ARCH_AIROHA
>  	help

Applied. Thanks.

-- 
viresh

