Return-Path: <linux-pm+bounces-26883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94EAAF822
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D84F9E336F
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73E2236F0;
	Thu,  8 May 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqfpSduV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF846222595
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700501; cv=none; b=e/8RJNfyrF2vmZjf3bnMx3PVSsljZ4LIodMY53XDtwhrTzpGRHl2G3Qd21UZPsXsVtQbJLMHCTMkReJc0Sv+4ShlX+kEyHgaqSeceiv0oL2Ljtd5tWhVk2frgcGBBvHPzu4qAAOk150+5tfYwbuAsnIykw57Z8ECh+Hc06Em/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700501; c=relaxed/simple;
	bh=XshUOr28r6ZZkb+yL1lgKFOURqljAiLtgGQWw8Tj5Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upyPvQOMLGfzvijmb6gmP5tThG/tdH0adfy8LFi/VWLLT/lJxV+PhwreMSZeccpSjWYFyzrIzx/Ycir46S13GpbOiwRzdLB8cq1aCFB5aaGOECTkf5rT35aoobVU884FFw3ITcrQDs2d02xnkw6NNcsJHPZT7wAJSnUXEx9y6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqfpSduV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so5514915e9.1
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746700497; x=1747305297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCD/xrhh7lmsv0m28M2TFBr3CCN+yhJ+7aC75XpUxc0=;
        b=rqfpSduVzIwxiGLRblAFbGJW7jqAYmbz35uTd2AeMJQZop9AhUKFA6Jqa378MBVG54
         4oatq5qVgG3iy/VKnzPePzWqXsqp0XipJO4L3LjsDTzVeapyGTTYLSIkNUT/N9zfJ8/U
         iVl3B5KAfOUeOTRrB0Q7GExtmqAL/Zn1OT1GyCaN29r8T4rG/u1MRXyVWO6kY86NB3yu
         bkTqycFGaiQSjxLb68scBicX+norFVYZl2K2CK+vqIsvIm+Lkl4rkkXWkhDAZ1ZkmWY1
         RVp5/i1e2R9ylc8lT7R8MRAhQO78TlI4or0crPQdSRKJillRpwjsupFgIkZyBpBxkH4u
         PDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746700497; x=1747305297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCD/xrhh7lmsv0m28M2TFBr3CCN+yhJ+7aC75XpUxc0=;
        b=ILMwQKhQJJCfnMBs2nfdqag8MHMHJ45y76TsrtYqro3v3Ss+3vfOZsWgpi65kqWxz1
         3dIz1efStHoutufDRAg7tJdW/R8hVZTkOI13yDggL4wXl+AAYDp8OAtC0k72SJiozkBM
         gAf10pJl7tPtFsaXD/xxVFn+RS9MlUMVjTlgzpHQBq9t4+Fb/TIZFGqRcWYg/eQqYHLc
         McpqfG/Kr7y6CEDQc0C9PCh3XxHCwzLMzTg09d7Qsin8r15OU/Ge7f1Dxjb0Q++ckqQF
         Gct+DSu6O7dUMTUWlIG3Kib+rWAx9W5Dc1P0U0I2yFCOkqca7GotfcIiiFHus48KIN1w
         mehg==
X-Forwarded-Encrypted: i=1; AJvYcCX7knIYRWmXJx+9XQZaPEoD5DeCxtxg0kZkcOgjU5kKKyGTbmpPM2i1rTqByNRGbZgZ5TypAFIutA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHm6Vl1eO2dSaOtNwNmQdQX/tJdOM+tMFZzYQegldK6uiqqJ/
	pOWkZCGJKive7OreTEwgEZssTS0UDgj9Qs64Z1NG2yVKzDIWjD6jpdx+8EuYFAo2+38rnxnh+BN
	L
X-Gm-Gg: ASbGnctaE8F6/WxxmPOaVf0fghNVtv6J44/RPIi2x2AiYKVAloclZPDGMc+xf8PXOMN
	x8GF59z0nwnVMM5WDGdeUVZOuuuYrt3Z9FLKUau97ERxYJ/47ET9INWbwqVpgeBNYX9mlcKLvcf
	RJfQPuAR1Ydx22vp2+OF66xGhD/CkLyCKat+/RggmtRWtTz4U4XgriqbT2wukuUO09Wxn/N+Sgk
	avZqyfsYZaNcO3HK/HUssqXBiMHEMHfV1S35tpk0vni96bencvulpmDttenI0V2gBn3grzr7xtN
	ToH1lgzk5yt4w80vjzX9MYmXN+rkPDYaVyrlGXMvJipqIQ==
X-Google-Smtp-Source: AGHT+IE2ZwRPPmNDwrBPPnDKpNkj/SmmhYpil9fT1HsszQFc0vAn/mcedhnk142mhnL007orG1uNYg==
X-Received: by 2002:a05:600c:3483:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-441d44c4428mr58842365e9.9.1746700497085;
        Thu, 08 May 2025 03:34:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd32835dsm32673715e9.6.2025.05.08.03.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:34:56 -0700 (PDT)
Date: Thu, 8 May 2025 13:34:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: Fix error checking in
 genpd_dev_pm_attach_by_id()
Message-ID: <aByIzTj2t1I9Wrzw@stanley.mountain>
References: <aBxPQ8AI8N5v-7rL@stanley.mountain>
 <CAPDyKFoZiEAn8yT8a9VZqayR1=HPnMn+a51O3zUAUR3L6RXH=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoZiEAn8yT8a9VZqayR1=HPnMn+a51O3zUAUR3L6RXH=Q@mail.gmail.com>

On Thu, May 08, 2025 at 12:14:41PM +0200, Ulf Hansson wrote:
> On Thu, 8 May 2025 at 08:29, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The error checking for of_count_phandle_with_args() does not handle
> > negative error codes correctly.  The problem is that "index" is a u32 so
> > in the condition "if (index >= num_domains)" negative error codes stored
> > in "num_domains" are type promoted to very high positive values and
> > "index" is always going to be valid.
> >
> > Test for negative error codes first and then test if "index" is valid.
> >
> > Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Thanks for the fix! It looks correct to me!
> 
> What puzzles me though, if this is a real problem I am sure we would
> have been receiving bug reports, don't you think?
> 

I think it would only cause an issue for invalid devicetrees?  So it's
probably not an issue people often see in real life.

regards,
dan carpenter


