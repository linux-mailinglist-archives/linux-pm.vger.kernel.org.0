Return-Path: <linux-pm+bounces-25698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC169A935D8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241B43AB9CF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549B26FDA1;
	Fri, 18 Apr 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeueT/YR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19ED26F44E
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971052; cv=none; b=CAnzkVfbkV3Jj88a/xadfV5/TYQsz95V7JfoZN9EMYc4KX9auttYN9x06NFLzwCJsrkac11fqzjX+KybMBrROw11DINCdDHaMUJpAhQDx15X6IPTw3Dp6dSnemVHaelss/ljRCbk6lDPO1y7yiBAUMSskOVEHRp7SuYoo6NQhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971052; c=relaxed/simple;
	bh=oxo8zJvG+XexDH4GV9ba7u6yzdBoFEqWEzjIqCoHiyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUVDvGL9pm0LJ1pqwXS0K3zyTMDFpFbiPDHmE4Yu08YuhyHiIgYO2r/5Y11+3gohr3Vx3QoCtiKwg+GSXTNc4xHOZYOyi81QQZkIR6RcssdqghE5cBTId98Frdc0wT0RxpnMZ00ViNpXSMD5Ht74u+bUp8ZZZ18P7Gsl5tx0s5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeueT/YR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1606085f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744971048; x=1745575848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozue1u0UD/lMowwm+i9KBTDQgenusJImLUvjM+8MVbc=;
        b=AeueT/YRylIPJ4g7w6ZwgV6AQL7LGieRpYSklr8yT3XahUT6A+CLnlOkEHkhSbQ2tD
         5w4A/NeCYYu+iFcDCzmuvGGiekZ1mmmj4OC8qGP1PuXUwfMFWCbGqwfoCsfMQQ2KBqQK
         ScLmUMDtaJgEeuGiMQcA4Gkp/MMXblHmgfCrFfVB1ULR3TShILgPmTURHMZWUCs0SMuJ
         JIlPM0M3uiCv40EnQ+ySuxnb6evXCm4/vjVLLez95dKtspZhl8yJPQqNY9ifwETSNAS8
         rFx7Aw+ZkW2uRb4tdoS4vu15aHYOFE8+M4mJGw1427BqruQPTYnuH2dzkrtil+msdrl1
         f9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971048; x=1745575848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozue1u0UD/lMowwm+i9KBTDQgenusJImLUvjM+8MVbc=;
        b=mlLVwGdzuASaquD8qZUl21WP3+zznkZ/skqm8TGce8dnWmOTzEDUNkq0zfiWO6nUXC
         j8ex1Yzj2cdqDViHtpJVL++BGCb+OCJjVl3zsqNbHMYht8ltaF1V2/e0K/ozpGBJu6so
         Eg6KoNGI9ZXRnoMxSTWHqWlc5Bd0XDwRHxK9550LNLurO+aRFFHp0RIXwCSsow96pUhA
         k6i6mTzTDx1anGziEvTbmp+tf2H/Ww05DY2NbZCZLg6bXgpoMhaqq0TXrfCWCoFgEYd6
         mU6H4B8u15RKCN8nEhZqmkoCgDjmKWBFt/DAMHaExjpRt9Log0KkJCLBOZ2WX74AYTaX
         SBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGT597ilKVyxsoNsVNS1EjJNWzKadrw5gJIUtTxBiapER3cP/+UKOID5Me8NWQf/RzJLaWdV1DvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8UC77nBucB9cVyHOYLNQHaufAmACuUmna5KmHeQm4ruY+QL5
	d0Hw4axlVKaWzl+38qTUqPspbw9YC2QcbUyL2X2S9c95S1Gl8rtFyRAdMH4K84M=
X-Gm-Gg: ASbGncswibzitbKoOTUQVgpjyW0Tu1cQUhofy5k30GUDApNQQiPcqdSa9vrPRKCSbcz
	xWP1yn14ofnW/+v+cfFz28hsLE1iRhZ3I2Dw8EKtdq8E3qbRqzfPyXtcRLnu9CxeBXy7Kfffh6H
	oCXagNkkO+rUqmMmIHmqu+uBOo1thUv2Jvj5XoPTCSZhfsLDUux3HQyTR1IyRRSMpaKIm/3so6m
	+gJVytjaob7Dg1Dg6xx0ZgDMZzPC4lwSw0W7J10+pEOv+QLCQZ5rEm2E9+V/k3VzBm8P9kugbP3
	tKwSn44XbeLbKf2fOzv2uzisYY0wSwGxZkQc1emJlVosSDT9FL5fFQp11iN44vACpu4IyR5KlsT
	Ka44=
X-Google-Smtp-Source: AGHT+IGMO5NilTQ/i8XjooFiGASJrvfFcSDr2VmmYPyU7LJt3JOcj+Z5vFGa9j6IQlSeom/a+LiTrg==
X-Received: by 2002:a5d:6da6:0:b0:39d:724f:a8ec with SMTP id ffacd0b85a97d-39efbace5efmr1565326f8f.44.1744971048079;
        Fri, 18 Apr 2025 03:10:48 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d69bbsm16142205e9.34.2025.04.18.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:10:47 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:10:45 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vsprintf: remove redundant %pCn format specifier
Message-ID: <aAIlJaZlBxympZDx@mai.linaro.org>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>

On Tue, Mar 11, 2025 at 10:21:21AM +0100, Luca Ceresoli wrote:
> There are two printk format specifiers for clocks: %pC and %pCn, and they
> print exactly the same string. Geert confirmed the intended reason for
> having two was that %pC would act as a default, like some (but not all)
> formats do. However there seem to be no advantage in having two instead of
> one, especially now that there is no other %pC specifier since commit
> 666902e42fd8 ("lib/vsprintf: Remove atomic-unsafe support for %pCr").
> 
> Definitely having two without properly documenting they do the same creates
> misunderstandings [0].
> 
> Since %pCn is used in a single place, replace it with %pC and remove %pCn
> to simplify such format specifiers implementation and avoid
> misunderstandings.
> 
> [0] https://lore.kernel.org/dri-devel/f8df2b5e-b005-4ada-8108-159b2b94a72e@nxp.com/
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Applied, thanks


