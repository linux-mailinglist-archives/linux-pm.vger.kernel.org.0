Return-Path: <linux-pm+bounces-6915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B58AE101
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506B51C218E0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE45820E;
	Tue, 23 Apr 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVdLRpD1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CE20B33
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864644; cv=none; b=OCUOea9qBGqQhu9DdsxAWI81zju/Y7pWpRZ8ewZdwTQ/gvdtmD0dL/L3e8TlwjJvQsL/6hhNd8zrwzoJwsYqyj4B2IvnGpiTCZ8sQMW3lngCrcEYjF+lRE+t4VDJteTnTeL1hJ9RWTOA9NNU5Ggxk428TesrtqS7kDF/jPGRavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864644; c=relaxed/simple;
	bh=pz7gzIvrQzL0PZZpqwD/SlxEydE+N8siR5THURHsiGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4Xp+9BdGwep66iC4xjfj55GT441FS9JHHYcW03B7eYT+Bs0Tv+KMg5rDtwMH/sfLPU89S1fbP2PCossub3/oM5qnoli6cpMFWBsqleumlDZfszZbdotfzVjpD8RdfOCiZ7mW4hyK+/iUCVolxDeCMn4Oiz6I6uB98LnPqQ4PPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVdLRpD1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso4167764b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713864642; x=1714469442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKc+QzTvoib1CxA8D0XSIoHeT+Qz1bK9S/yhE52hQH0=;
        b=BVdLRpD1hQ2IOGHUzzDOEy9JGYMRF9ipeCn/tvBUtHiDghVxCpTCiu1wupZHQoA5Ug
         P+Gjw19Pf7NIhWqDW9KtUOyBixh/JUQ5QzUEPl5EV9uwuBVj0zCr3D1oAvoCTBhTSrrU
         y0YrQeWJYwCGjM+Zst3BwzkxRGrNG9GCFE7OEaVrkWRejQ90U7+iRhW0CjPFH/Js/o2z
         k6aoy5TvT93y9I7RT+MYLI15RBKcxvLPNW2UtIzMST/EpLFiKtJmGWJ1MiwXRFZyvmi4
         jNYELKwCSVciflOpRFG2zZ4Kyopfoj2oyqVTHHCLvKY1PKRMaGjtZlWtOliqXpMhXrPu
         OXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864642; x=1714469442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKc+QzTvoib1CxA8D0XSIoHeT+Qz1bK9S/yhE52hQH0=;
        b=j+CUUGiY9rdPCvP8NLy2Fr+wA+Q5R0dH9mdYU3hm08A9rZUqf04CcCGptY21z8rqVQ
         9GLgCotRUvyQMLaBPKTlM9zXPHnA8FU5PtEiPMSAyZBdVY7dUMs6nUp1vFoMYD3eO99T
         m9+QbzCRIx4rA6Ccyxr7jm7bgWessQwsbTu0EdZF8hD3xfiVvJCgTn2Z40lpd0AV0zuh
         zZGuOXeWgutAeHlKbStZx4f6KjyurWeKBwSlUh53mPy/Skr5fJiasng+/ZXUd/c1DwGr
         D/P1/+hpdZ5tG5eCt1jkaBHKo7pUGYjHQEqQye4jQsdUbkY6aRjn+IdQrHUFQdRLwJSC
         Z90g==
X-Forwarded-Encrypted: i=1; AJvYcCU+9sZOfnpdUMfG6vVywmKjQLxurhKMuohrRorPzEtjwHffGWQfF+sEi4u9VKY7yEIQ9frOsuy6kqdRysi6ltu/H+OvamEHpJ4=
X-Gm-Message-State: AOJu0Yz5gxq97SF+KKVWkydOwz0UlHofNbaLLVwjvqLlrlbrAzGkiKbf
	X+3rTNd1zzLOti/LeKvCQVbNGnWWeL2tyXlaUb7Iljt5Hcth/749/bELvyTzxNo=
X-Google-Smtp-Source: AGHT+IGVO1aI02fvLiFE4FbChEuQhyKSChnpIbWmrCGBshS4PSn5x5AlkPFNtjNaRGeCz9SaNDSCFA==
X-Received: by 2002:a05:6a21:81a8:b0:1a7:aa73:ca24 with SMTP id pd40-20020a056a2181a800b001a7aa73ca24mr2589099pzb.13.1713864641812;
        Tue, 23 Apr 2024 02:30:41 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id h16-20020a632110000000b005f3c5cf33b5sm8979752pgh.37.2024.04.23.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:30:40 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:00:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: dt/dt-platdev: eliminate uses of
 of_node_put()
Message-ID: <20240423093038.do3vbkvcx6yhdtyp@vireshk-i7>
References: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>

On 23-04-24, 10:27, Javier Carrasco wrote:
> This series removes uses of of_node_put() in dt and dt-platdev, which
> can be replaced with the clenaup handler introduced with
> 54da6a092431 ("locking: Introduce __cleanup() based infrastructure").
> 
> This change provides a scope-based cleanup mechanism to avoid potential
> memory leaks that can appear if of_node_put() is not used correctly.
> 
> The series is based on linux-next (next-20240422) and has been validated
> with a Rockchip RK3568 that makes use of these drivers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       cpufreq: dt: eliminate uses of of_node_put()
>       cpufreq: dt-platdev: eliminate uses of of_node_put()
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c |  7 ++-----
>  drivers/cpufreq/cpufreq-dt.c         | 21 ++++++---------------
>  2 files changed, 8 insertions(+), 20 deletions(-)

Applied. Thanks.

-- 
viresh

