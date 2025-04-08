Return-Path: <linux-pm+bounces-24925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF1A7F4B4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD903B5585
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A572641E8;
	Tue,  8 Apr 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxFh0fsa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD738205E3E
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092441; cv=none; b=H40jGrmgLmhTL5Pw/rhp/uDi41ghyvO8tJlmro0UJT12kEiP5U0BRh1qmwZpkTHQM+O+cx2RXQaSWrNeMoRtNRvGJOL6DUPQ2pLwUKjIe+rNSz49uvKgR2UXwP9MD6aOPvfDrBZ/fdA9u7CXyCBpcI3wF3g18eG9b0S6KeGeveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092441; c=relaxed/simple;
	bh=IZTl+be6ud5vXxSsFfPgI+uEe6tuUzj3sdGtdEkb2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLKH5KNibd8NsEvGwXm40mjcLUAk5AvRD+4GQ+o/0NURgomNjnW/wm+Wprlq9mYjKrHOPstGfXKHzcfLoLiWco2WHohy+Pq3h4w4559XQDftBU8epx1c7B6a45hYbK24TLgdY/ir1a0x8bb2P4zlJp44BODIAe3vV9Kw0mBskcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxFh0fsa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so71153735ad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744092438; x=1744697238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBGLDdhiF5aE7vXhYviGOMDmTQe40kjk+O0POgM2zRo=;
        b=vxFh0fsaCkNqSDGygTp2fEehPri/aCWhqMTbRjXe5x5wvbt7vx1RxTu7VyJJgHW7Y1
         wx2Vx38Jhhs1S7/9s4RqYaS2FSfwzTUwZ8c+bGTfwhPoC1cigNFpbU+fPEAB07fiezzn
         c4CGHHB5H006UrQ32VKwOQma6rrD5hTLGjqaaY8XFgry3K/ZLxja6+g1UcZlTJ7AJqJ4
         jhA2Ws4C7T6ifcH7Qsrw4/HxHmP401dreikCPBUg/kjKxhZ+BoagDlk3Rpa23aENSjS3
         b7tDTfK3egqCEpK0z+tpOw3M1g6itiHr4V9qmBZFOP7HbEwdoBXaNIzk/TZkoWkkTzFg
         8Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092438; x=1744697238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBGLDdhiF5aE7vXhYviGOMDmTQe40kjk+O0POgM2zRo=;
        b=stG7UmgCY+gdlgSY3RUfA8Bcz4Z0/HrG1CR0zQR1lr3F7Js6WdAaCnvqtYuM8JvohC
         MGb9X+Ds/j1tez1duiht89SVXD707UsfNH1wUOpXgFAtJbZ6Zb+eMYM/akX5gKfogFJa
         8jgzQcggvSx78yn3OkESo+xhG93trTC0hG8ySxHLjQI84qOnzJ3rsL3tOHgcsrmLAE7r
         vjB7IZ3668hXhnWwKGT65BwSWCs9s3ehOsxnFb4/x9TaC7ZctFJBAJr8wNl6K9e2btlV
         YlBmS7LLbZdEpg2paiio7AlyyyqslDw+tRsjEk6pLXl9ItcLDQE8UfX333KEHAE9FQ1E
         OeJA==
X-Forwarded-Encrypted: i=1; AJvYcCUCvHnZgcH1Qan/r5TOrtjdEAb0pI2SHOo3Wyd51TLZHXrMVUP1lVEZnEVZvrC76Ulu/TE/jpv77Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJ0xpYnbCDka/bWwU7CsO2mEgyKxeUDYE5+hXDwmvsXLLrURW
	+Xyua8fKKBR+9PMUYmPh2ZvgSBNoLa91tcre4J+40QJva72Zduf3J5KPA3dWWVY=
X-Gm-Gg: ASbGnctLbu7Vc9TylmxA+7y1YmTQeFchI/gsi3bKF1UGALda+gRJMu5Sj2KYgrlSGu0
	sGWyHeKPGHqeRoteksDGrNfcQrsPPOjEoWBbjpx2M0B6wthm9A96uWSOuyHXMqDFrtZGrpgn6Jq
	J03Lo5ehpkHG53JJy7Fg5vA4sgL2WBDGP8fx7Afiq4Kdx94ur1m1tW8xB1IcQBsfnkBlQKatot9
	lFly0tnf1Oiy3RIU9Qi7iRcdCBcst1umuj70ZNTE6E+qSwrOBUzkfNGcj738S/9xfYUnaHdIsIw
	VrhO2b59sPTsL2D2DXhsX94hRmKdIuf/1yyR8oB/P5l3DQ==
X-Google-Smtp-Source: AGHT+IE8Cg6jbtSztbs1iW4jULwFaA3/Qy5eM7ju9iiy7eB85QPmdcFakGFBd2iR9jdJ7oTsswsgPw==
X-Received: by 2002:a17:902:f683:b0:220:be86:a421 with SMTP id d9443c01a7336-22a8a0a37b5mr241406085ad.38.1744092437914;
        Mon, 07 Apr 2025 23:07:17 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727eesm91813665ad.224.2025.04.07.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:07:17 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:37:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
Message-ID: <20250408060715.r3tentoom6r4rkzt@vireshk-i7>
References: <20250404164219.166918-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404164219.166918-1-mitltlatltl@gmail.com>

On 05-04-25, 00:42, Pengyu Luo wrote:
> SM8650 have already been supported by qcom-cpufreq-hw driver, but
> never been added to cpufreq-dt-platdev. This makes noise
> 
> [    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
> [    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt failed with error -17
> 
> So adding it to the cpufreq-dt-platdev driver's blocklist to fix it.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2aa00769c..a010da0f6 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -175,6 +175,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sm8350", },
>  	{ .compatible = "qcom,sm8450", },
>  	{ .compatible = "qcom,sm8550", },
> +	{ .compatible = "qcom,sm8650", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Applied. Thanks.

-- 
viresh

