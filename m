Return-Path: <linux-pm+bounces-3931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E855BAE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B1C1F28D8D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126DDDC5;
	Thu, 15 Feb 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="larPByc+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8613FE2
	for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982144; cv=none; b=UzTR1j5gksi7+d+0ZJk7wDeFoO91Z5iqpHIkdo/pVVGLP2cYrbp/Wad5pWmfzuXPYEYNJ+wlRC/652QZSHvsFb7Ujfs1R7Rv4EcpZXNme+0ai3iHmtT2eswhf+Qr/JXjdasDPUw1CIW6PC/JiknBd5hCFJrIezkRp6ryqWyVHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982144; c=relaxed/simple;
	bh=BhXKhCqJNBQvysbpFDfsnkfk6z+HPYMAtzZGwtrNy/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpNA9LPAz6JzczcWDuOeKXhFd/3C41fKq4VHzzZMLeMKTlRoqlDp+Ars/TtmmrtoxbKEL/oOPs1Aauu3VxfRAihmSUhXAtjcaI1JP6yrpmbH/oi8+F6F/m3RWRl6FsW1jW0b9LGSzBC9+gFD5ustUz22n3js1n/m7KCb4xEn2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=larPByc+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so473664a12.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 23:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707982143; x=1708586943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/N167FOJFNpdYOJR8JmbTnLmv+rPRAMBBcqRPboUs8=;
        b=larPByc+U9Xusuy/DDdSW96IILWwcAWUkJp3osnfbI6q0vMvUeWQ9ZqkzSUoMxdJ67
         Iko1j7b/9enY9JbDB5FRmp207ACFFpPqnffvdm/I19rktlmEijFSuHPBjtiOagBn65UE
         S7MQ1ipuc7psiNKvFsgrDSvFvr9N141Bj76NtUeflQwCPv1ILYUJrPuKsFPxfUrrdxeO
         hSNMtBjZytSgEwnTiMWondGsGsby9xP7Kz1d5mVxn0/c3of2/nVAUi+NrIlkuht5LbUZ
         9RWe4BoEa1D29IrjmtIkGHmVCTk78DO8KWxzZw08P90zdjhjNkouAlubIf0T1Uh+bvJH
         rSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707982143; x=1708586943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/N167FOJFNpdYOJR8JmbTnLmv+rPRAMBBcqRPboUs8=;
        b=k2PGmLB6rebA+GwhRvmLiabqu2hI3VjkJYnZgNEx1+CtLZ64HldGt5d9Lkv9IGLcOB
         JFU6uOZUwF6/arCBklzpd5Pu6tPArSBd/Pt3e5Bjp1Iaj2XKVa7WH8ycD1ErjLfDRNCU
         ncUA9ltV6Uw6jEtnLQ3TS9OIXzB1c2p01J2NfdPzsi8HIZSKQvthpsiNX+v8NNMS1DI/
         awqby7BIV3p4jM42eRMZkJPUc50jK3dG1GJGaviVSZLS9YMNgVtIGpvsLR1VSZ43ksR6
         /ANPirTx42HkGtPcXWaQGXMYhFLz6Vt4WomQ0KG0eYS4H+S0wbs8GQvvz3RsW7LHurbQ
         /57g==
X-Forwarded-Encrypted: i=1; AJvYcCVrtP/zAYkvvBR+WuGBfZe+V3B9OwAWx9EOxuG3cmt1/TLwLEIGqSaAkX5+PPuHBrqTv+9i4lghKHa0GS73D90VgogeupjWFC8=
X-Gm-Message-State: AOJu0YwZpjdGwNm+KxWoq8FItM8PogYTKj3E4Rtdcw1/uPMBosEyXIA3
	wZbhKJvM0cv6Nmqp5gxJjZmrLVHAdIMbdFF7m7z9fSryeUaSO/RYEbQZCUhDu3o=
X-Google-Smtp-Source: AGHT+IENUKTeBJmqX3DMQNPIa9iG7iP5kiH3qSzYdtvf1IrxAZxCxOIVo0OUJIsSxIb8WdHMtlKw6w==
X-Received: by 2002:a05:6a21:3101:b0:1a0:6a2d:65ca with SMTP id yz1-20020a056a21310100b001a06a2d65camr955877pzb.18.1707982142482;
        Wed, 14 Feb 2024 23:29:02 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id k185-20020a6284c2000000b006e02e816f13sm643169pfd.111.2024.02.14.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 23:29:01 -0800 (PST)
Date: Thu, 15 Feb 2024 12:58:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt-platdev: block SDM670 in cpufreq-dt-platdev
Message-ID: <20240215072859.edb4bjxuhcxoionv@vireshk-i7>
References: <20240209231914.199235-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209231914.199235-2-mailingradian@gmail.com>

On 09-02-24, 18:19, Richard Acayan wrote:
> The Snapdragon 670 uses the Qualcomm driver for CPU frequency scaling.
> Block this driver from loading on it so the driver does not pollute
> dmesg with an error.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

-- 
viresh

