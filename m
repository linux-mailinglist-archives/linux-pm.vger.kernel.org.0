Return-Path: <linux-pm+bounces-8511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8038D7AE1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 06:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFFD1C20886
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA310962;
	Mon,  3 Jun 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyXFbgHV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A0182AF
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389801; cv=none; b=qr3QeHFVhGNEO27Xq4bcH9J1gC8TaBEwxuKFjkk/nKxX/3lbOmNvdmw54OQDvhA4U+nout333u5V+SaFY71mVyX8Uj/nC+lb7g1GY65hv6wvHplPcohlBmtoplCAXOVw0MPDQucouIIgXGvlZWNhOswVmsAzPuV3FQBYYRajQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389801; c=relaxed/simple;
	bh=HzZDgjQYuvmDJq3i4NfWqunXjEzQo7xEJGoCmHbV/5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM9v5foyn3EUnrBTt1BzX5J7KzvT2tgqAF4HUrWtUxEP+VIiQUi9oOkWqWMzZ2BHxMf3YhYrIFzTMCroJRZk0WjMeyjGm5WXRpgE+hMPoF9dE7ikFjXDBN2n0KL+7OfG1hStuVXp5KCrTcwb7ydpRuC8q2tsFy96tpitPK4PByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RyXFbgHV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c1a5913777so3210902a91.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2024 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717389799; x=1717994599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYCOigvbPRn1QXs7z+gV/0ewTOfNCducvc/Nnzd9dqg=;
        b=RyXFbgHVwxJ7iHwNfYHy4EomjZhBymGGFNR70KPmuZb42DcwzybOa+um7fHAJ4d3CA
         E62P3RmxxJuI1a/hLUDodfg4Wzwj6AblMC+D41ea9NxUHB59h9QXAVC64VCofEyr05RG
         hgopo4pUGvQDeSQQYZmCWZ4Yb9iRSgQN9aH/cx2ZSyYM3SFpdLmc2A+X1Vnsi4abCXkJ
         gzgfu4Yreer5FWrBnk+JErr9iK7rDpzNewJ6vDHY5Tm00ZLDBBJ75YDfaa1XKt3YuW4M
         kQByNuEQBXIfQJLYSUc06KZeooyNJddJqtJFmRLIKdB2EOtkxIVR0fD8dqDiX8GklgoD
         4hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717389799; x=1717994599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYCOigvbPRn1QXs7z+gV/0ewTOfNCducvc/Nnzd9dqg=;
        b=hxDI0KMF1h6PzTX9nHOD0wVd3uBanyjenfFvcCloGgzFdt+HSABKdJH9CFK56m41sM
         2hgEThUlKTWsRdzPxMfMRhI57az+oQU7C/pmlKnDmb1ZifT7B3eAdzsk3L8/O99kn7Fy
         IMvyMAQo5HiC4fs8ogFaFBlMTDPqypT7BHeJ3zdh5HEbuap0suo7O2P6kBrDffBlBPtY
         8XcOHlIYwFj3rqAYSymzOkypJRoI2bzHRzNIyE4Fr5sF3o+N7on+KIqPlUVIcxtHf6az
         Oe8SdeVrvyYUrmZUbDwHPwlpw6spErOBL5gPBdL6ptOkxsT66d2n+c8g3pW+CndxpTn9
         MIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw4kcv2nme12tQyN70QLEAJzEb/WrYyBwQN/DdiabXrsFBkSLKcD/dFqk+7345dZfB66HcZC/5ctHJkCBbxcXHWDszWtdG8RI=
X-Gm-Message-State: AOJu0YyS4BWohH+5IbzUOOmhx658g5wspmhrVJ7k8gBfwIzfXhwWI/l9
	XCxrexUrt4De9aaVeKSH3XJDqpW8zedLM1OKfO8XIIE7HDIFNcj81QM6ul4T1+o=
X-Google-Smtp-Source: AGHT+IGICJDgYZTyQLtQrb19UNS8GlFzTTuoxROSl97QOLqPlxpWyNoDe4s7cwH3PGktOiIdZ3+6hQ==
X-Received: by 2002:a17:90b:50c6:b0:2b1:e314:a5e6 with SMTP id 98e67ed59e1d1-2c1dc56c32amr7244785a91.7.1717389799209;
        Sun, 02 Jun 2024 21:43:19 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1ac1f9208sm7241985a91.41.2024.06.02.21.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 21:43:18 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:13:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt-platdev: add missing MODULE_DESCRIPTION()
 macro
Message-ID: <20240603044316.7psjarzpopab3pmq@vireshk-i7>
References: <20240602-md-cpufreq-dt-platdev-v1-1-63c7d91c00ba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602-md-cpufreq-dt-platdev-v1-1-63c7d91c00ba@quicinc.com>

On 02-06-24, 15:14, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/cpufreq-dt-platdev.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index c74dd1e01e0d..cac379ba006d 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -233,4 +233,5 @@ static int __init cpufreq_dt_platdev_init(void)
>  			       sizeof(struct cpufreq_dt_platform_data)));
>  }
>  core_initcall(cpufreq_dt_platdev_init);
> +MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
>  MODULE_LICENSE("GPL");

Applied. Thanks.

-- 
viresh

