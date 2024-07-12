Return-Path: <linux-pm+bounces-11050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A893B92FD10
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49601C22C5D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49115172BCD;
	Fri, 12 Jul 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhH2Spde"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2087172BB6
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796352; cv=none; b=Hu+SqwvQuudmKOCX9TCtJbs0nXTRBNNBqwmECCbRyML+imiMEAPbW1g9qo7XTAEg1d1mYEaiYIqMbgiFmprOD3C2XJRnbDhfZOmZ5IcfPRqnNJ6pgDFaVufRm8Ghpjo+RMjlyAmkzz5kJYFcJ0VIkrybWgwhu4CSvmDvsTBISfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796352; c=relaxed/simple;
	bh=bnDm4S2Cb8WIqgRpBHv1PQKSZ2P5W0wICQYPYNaTzAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHDR+diQDBXfC1rtWp1/+B+zfsenrDeTeB8wztY6fwaD/ez3LHIm67x4h8OwzZH1p/43VbJJ7+wKIjHDNl0uVjMxWeK+sdXtNxQQ2VDYHaWeQqJ42RNUDMIuR3GNefO9fk4NEubMaNdK1EVMUljf7voxPHdKRhNfzpoab2+nS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhH2Spde; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-704473c0698so1008690a34.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720796349; x=1721401149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27BnZNX+yLuK2i/gV97YiqGwQq9nRR1z4pbXBmit8bk=;
        b=zhH2SpdeAhDzbWELn+9D6SZR6Qt5pOKQLuzeNE1XBnXsuBfNMyoY1heihqvYW+houz
         f0lrTi6ODi18tHIq0vIcXstLVxmUzg+puljUY04y9dwv7DC6ioebSqlX1ZWUb5W3XIc9
         zB5rcmxZZvHILrctluSsUuqsAJfHyMUd+Ep3KPefMn3PiCfGof+/KgUQiRWvqoNQFtkq
         kp9UrtYujkG7kgDFqYA7IFFmxU3+quOpolRSJlg23EFexhXydY693HYdAUlMO//4oonj
         nNrt0Pdi+hEoMi3UezAHUFV4eqnZWQ5NGDLu4gmJH6HjGfUf3D6RDESkXqnkHsdQ3uj2
         OcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796349; x=1721401149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27BnZNX+yLuK2i/gV97YiqGwQq9nRR1z4pbXBmit8bk=;
        b=sN0oPiIXB87MClVFHuHTGSrLcwQ4CW66QFTEbj9cPCoGmwxPncMMFLOhcCqYvT4LDJ
         kZlrbFI8cbLl/H0NjD83RMofLpOAqBmPRljfixawUYCEOXOn/5xknYJuGgumuKaVStvW
         dRecRMaxYZcFAcoulq4au7FZ5M3ZsaZYyj9XnRL0vmxy+TxoneWsY1bGfdDCTx+GERok
         Como8Ti4GFDXbrnzRs08NsT9cAtjNOp6q9hWBrL/kdgtUgPgXZwa0nWHHgyUSRLoPuUD
         l86FG3j8uKN65CDml9FeJ2MyV560av00ef5DdU+N+MEKMkSHH+Y4M5MDLkOwlvSMjs9V
         Sckw==
X-Forwarded-Encrypted: i=1; AJvYcCXCnBAIlFXhJojxNQa6ucfzcaOnMZDIP2M6W+2pCKsXur1z9qT8zWdhwhrBGs2/Yac34QeTxKUWp7Z0xx0msAH3jKMGktGiuHk=
X-Gm-Message-State: AOJu0YwBkVFpahceZqKpGtXRgxdEIHTtfvfkLfokf5NO9bmTRhiO58Qy
	LQEsIoWmgFGad4aONta/hVcJy7+AsUDdefW6N68bSDGkkgNvANnlKFthsiQDXpws+qLrqNotKj4
	o
X-Google-Smtp-Source: AGHT+IEySt5aniXAFHyit5L3MDRAKT8uumq8Iirp+NMgW+MLVMKSDjwcdEa4X0nZ0XaR5xE8qRd8mA==
X-Received: by 2002:a05:6870:55cc:b0:260:3fb2:b718 with SMTP id 586e51a60fabf-2603fb32ba6mr4193638fac.41.1720796348681;
        Fri, 12 Jul 2024 07:59:08 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa0783dbsm2254075fac.32.2024.07.12.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:59:08 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:59:06 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: fix NULL-pointer dereference in error
 path
Message-ID: <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
References: <20240712144546.222119-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712144546.222119-1-brgl@bgdev.pl>

On Fri, Jul 12, 2024 at 04:45:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We may call pwrseq_target_free() on a target without the final unit
> assigned yet. In this case pwrseq_unit_put() will dereference
> a NULL-pointer. Add a check to the latter function.
> 
> Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
> index 9c32b07a55e7..fe07100e4b33 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *ref);
>  
>  static void pwrseq_unit_put(struct pwrseq_unit *unit)
>  {
> -	kref_put(&unit->ref, pwrseq_unit_release);
> +	if (unit)

I was wondering where you would put the check.  But it needs to be:

	if (!IS_ERR_OR_NULL(unit))

regards,
dan carpenter

> +		kref_put(&unit->ref, pwrseq_unit_release);
>  }
>  
>  /**
> -- 
> 2.43.0

