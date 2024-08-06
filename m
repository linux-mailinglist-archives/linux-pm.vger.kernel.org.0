Return-Path: <linux-pm+bounces-11932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E0194887D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 06:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B641F237C6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 04:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76D176252;
	Tue,  6 Aug 2024 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy0L9+tZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D34AEE9
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919775; cv=none; b=oZRooDLkx9VsptlrabW6Xkk3Wh/uNULxLEWEtEZ72C74x20z6Llooz35TCVzj2pNGR26kvdyw68P5X7iOHh75in6Aswtw5/w/+DKuRqMAcAY4fkRX2SAHK5roFLFgoz9VNZw/CtAitldHhZvnAvSNZ+RM0D7kQDTHOkbXETfQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919775; c=relaxed/simple;
	bh=zTCOmw6gISVXSp48IiCz6bMdu5nKagmz8qJ2lcvbZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmd/7qGuFJoGsOsfRhH65sLqJaxwJYRmHL+QZrOVq4DhAzlPntmDBopJ3r83sCpXI8XPhOPrAhDopzDeITShZJM8HOuMqNyZxWfHuWsAvh34WTvwoGedtWyyWY5EIAEeVNsAAUZZRp4NI5vqIzuSwZIQIy721uBITnrEqJpWSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zy0L9+tZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so149580a12.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 21:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722919772; x=1723524572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHH2ZM2ZbaCsMqJvKElXG0mbw5W5n4WMRbqy0wJyJXY=;
        b=Zy0L9+tZE/luJcWdvbBOQDYp+kLlncZyZfklFwj+Mt4EAl10coWLtD5PkFe0Vs1ghe
         IOEJ0CELQSd1SWgxxhlXGtawRHyAJiI+vw34S1EUr+rg1iVk3BXcLot+Fuh11fOT05id
         tP4WB6H7I6h5q4kFxW6pRnJ//ebtQqgWhkYscqLyEAYOo9phVCR2tdsGcKnRQ6dPUH77
         +RW3r35SwhFj3y5m+cmJWLN+qwNEgtX+k8eK2KqcXHttnLvjzx4y9eiBf3+fC5cgdUoW
         bcceApp4z50JV5sgJi60BRCfPNyGtfGlqB7sEQuS/vkRILpvVWObNKqg+UA2tP5FivWJ
         2L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722919772; x=1723524572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHH2ZM2ZbaCsMqJvKElXG0mbw5W5n4WMRbqy0wJyJXY=;
        b=GBbEAys/NmaWQJYFSbaNHccyM6kL7WZAQ4vx2zQyNwMHOPpU7yjIeWvTg4KEKFVNXY
         6nA26LC0jIjgDEhxCdKwpLehV21TGUBgBAlJTVZKXpNEEcF15U4u6pAVKCGtIz7MiEdk
         1U3akjpBdr3kbIMm2VBFv849v6SciA5YmoRDij2hdN/DyVAEl4f87u6H8DCjcsgVbvA2
         Jzc2vEcoDReohNW203b/KlhtjNsjccOkfgYGkZueh63w6tUYfJ+/H/NWCTIQB4KRgeKt
         YAney/viomPG7zmExH7EMvmCxAD0ZtWnwVL3TQwqAPpy357YkS43LcLIoBm5FuDrfjoq
         aD3w==
X-Forwarded-Encrypted: i=1; AJvYcCWRRrmPnEPkH/PpqNKoH5lptT3oe2zNxEwmpvfR0sa2GwZdNVOzCXdgUO80R7XZVds9Q3Kn36zU6mtACibtiY+XfFVMx5KLQkE=
X-Gm-Message-State: AOJu0YyzM71wnXTdzfSjwSvcVAhFUHqYDfeP+APp4zXvW+eEwBJ3/xRR
	BoyJBis/oV+RbOqUsF+APzdnfor8GEEBPuCtrt1JHmg6LLWqj7NbDfe2P86epNo=
X-Google-Smtp-Source: AGHT+IGIufVjk3jVXDFP+ZPCWH1xn0RILusDbBQ8tTUG4kEpwICOp9qYPfj0joz3IsRdV9VFGoKiNQ==
X-Received: by 2002:a17:90b:2307:b0:2ca:7636:2214 with SMTP id 98e67ed59e1d1-2cff9414339mr17227568a91.4.1722919771767;
        Mon, 05 Aug 2024 21:49:31 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc406468sm11668707a91.1.2024.08.05.21.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 21:49:30 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:19:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
Message-ID: <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
References: <20240805202042.3229190-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805202042.3229190-1-robh@kernel.org>

On 05-08-24, 14:20, Rob Herring (Arm) wrote:
> The refactoring in commit dca2ef2b7d91 ("cpufreq: spear: Use
> of_property_for_each_u32() instead of open coding") left "i"
> uninitialized. Initialize it to 0.
> 
> Note that gcc doesn't detect this, only clang does.
> 
> Fixes: dca2ef2b7d91 ("cpufreq: spear: Use of_property_for_each_u32() instead of open coding")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408030418.gnJDcCpm-lkp@intel.com/
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/spear-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 4d28147c23f1..f8c16699a68d 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	struct cpufreq_frequency_table *freq_tbl;
>  	u32 val;
> -	int cnt, i, ret;
> +	int cnt, i = 0, ret;

We don't increment 'i' anymore, don't we need an i++ in:

        freq_tbl[i].frequency = val;

?

-- 
viresh

