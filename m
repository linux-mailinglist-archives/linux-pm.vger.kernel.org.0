Return-Path: <linux-pm+bounces-31343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C65B0F51F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194D01CC19C0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBE2E7F22;
	Wed, 23 Jul 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxOP/11K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5C2DECC6
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280538; cv=none; b=lPcjaruj4y3yIE5+XycG8w1+UGmZtkwipJ/QeUerkEY4Vvk5UijGNimef7522+Qt0mge57+HEhd4Y2fIaG9u4WvyuaKjxip8sfBWbj4RVmUpR+YBPtH36qdL+K4r5/AmhPBlwy/tOSFG3r5MDqEttcJPaWDTB5YGG7MCYpDZ4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280538; c=relaxed/simple;
	bh=7FIhhnZ8N41qRo3DWI6Nxd1ct9+CqQ9isgpuBH/ie5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ9H5BoG7KCPQw+f+HEvZnv/i6dVxe8cc1uZHd+t3WjUsKT8wivfQNxipVOYSYYtoMGVJY+I5u5dUzOUlPJ+rNp4a84BDVe8YnF9GLMJ2px58CxwMXDfTqo+DzKSgeB+BlryULsosgzrA7LSn4Lpc1QDIk3rQxrhlz+GiP3DsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nxOP/11K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so61037055ad.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753280536; x=1753885336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TciU/i1TkWOg/dQpfTDJLSYQg3K8H+HAUNonVNlXDxc=;
        b=nxOP/11KsnIWHC+4/WV2j2raVK5w5H89ZjNjXJKMRRzrYwB/rFFieik0c/4l8WekRO
         P6OPIKghY73L0xZsOzOaTJjfjfyY6xxBnxGaLaoAIh8Jk4LMWXk0Zu+Xpmzug15Nz/68
         nWoxBG2cdy6I/MTASzkMJFxwcjK2fRVYmKwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280536; x=1753885336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciU/i1TkWOg/dQpfTDJLSYQg3K8H+HAUNonVNlXDxc=;
        b=eD2855sk/oustzT2lCat4khyoS82YO40RJyr7zngWAaNKY8theXfK2coDoiD7OcYrR
         FIfEgIstyafuJdY++n5R5KwGbNg8cX87NwVMUm4nHJa1+BqdpEbUncvDCuno7LxI7i13
         HOnfeyzP6caCJzqt+Mlx3fzvGqNLbRXd9fM3Ox9lPdNIB1WyNPPoxj19DkvT1lY9NfMR
         iGumjMUwihRcKYonbkcJNq5MxR556RbXAcVxJEb33DUCHV6RnbW87krZKh4DpcYzMscg
         0eU9+5dU3Aq/Y0dDypfd3Fbcg1Pl+5r3t5DhokheczAUwZNPKJJ4N4CSD33+hTNxKskc
         UQOA==
X-Forwarded-Encrypted: i=1; AJvYcCUHRKKc7lzo4K7TluE9qd9c60v6xo46fybjsIP422A875rwbh35LxCh80yxfmwJtu5PtOsJCcTttw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMdgXwRm+P/aOg64P39gx79LcYUTOOO82UsYnMDCnQOoO2cBJ
	KNx8Z3n50w0nHvx+6ASWkmdguOAYBH05U0uzEhTO4EYUqQ5YUXUZHN6ePUYIzOQviw==
X-Gm-Gg: ASbGncsVz0M/6gDSkVusU2xzFuaO0pj+7Z2SA5zGGDXvjtGbclzZKKHH0pdbvA/q/S2
	pUBlNOlM7YPEkK255HPM6ngf0M4vaDJ2cTGDBKPaO0QcZ8EroU1XEG6QoCbhxj1wydxOI0IDnY/
	hCjcJenlbtQuLMAi3jJqf3h7TfgDtuLkkLFuBmw9UbxHC+247eXCHgyRLaT73FK8jSmv9WDOGfK
	RWDcZhRgYmdvHmQzPfyci4Le43zXYxHoOZZg6X1D5vS11EytzVHTjBKC+M+W466zPdOK+5nnAcG
	1m7K2Z33a0AfKUXL63UcU0dx6ABG3zdjH1BKIf4jggRciEbNMtZ2MZyrgcnWAyrLFunlL3n5HM/
	R/PfmMXYoYXL0WuHh1tJZKDbJAQ==
X-Google-Smtp-Source: AGHT+IFHehEww7cuBGUSII6CaKL6VEu7S2bFVQoy4PwX8YkO74OJ6Bx6SiRgLGsBvkFTCiEe4F8f3w==
X-Received: by 2002:a17:902:c409:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23f9824cb15mr37151315ad.52.1753280536415;
        Wed, 23 Jul 2025 07:22:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:23e0:b24b:992e:55d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b48f2sm96955735ad.90.2025.07.23.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:22:15 -0700 (PDT)
Date: Wed, 23 Jul 2025 23:22:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PM: dpm: add module param to backtrace all CPUs
Message-ID: <pc5azqvv6bxpq4zuocjha7cmlmtowlwjapbo6uyb7pfp62fapf@lvgkhnt5vuap>
References: <20250723035955.486688-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723035955.486688-1-senozhatsky@chromium.org>

On (25/07/23 12:59), Sergey Senozhatsky wrote:
> Add dpm_all_cpu_backtrace module parameter which controls
> all CPU backtrace dump before DPM panics the system.  This
> is expected to help understanding what might have caused
> device timeout.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..9fb943afe246 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>  
>  #include "../base.h"
>  #include "power.h"
> @@ -517,6 +518,9 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>  	struct dpm_watchdog wd
>  
> +static bool __read_mostly dpm_all_cpu_backtrace;
> +module_param(dpm_all_cpu_backtrace, bool, 0644);
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
>  	unsigned int time_left;
>  
>  	if (wd->fatal) {
> +		unsigned int this_cpu = smp_processor_id();
> +
>  		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>  		show_stack(wd->tsk, NULL, KERN_EMERG);
> +		if (dpm_all_cpu_backtrace)
> +			trigger_single_cpu_backtrace(this_cpu);

This is silly, I do apologize.  This should be

			trigger_allbutcpu_cpu_backtrace(this_cpu);

We want to backtrace all CPUs, except the current one.  A silly
copy-paste mistake.

