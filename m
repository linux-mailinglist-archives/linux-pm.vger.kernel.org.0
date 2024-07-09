Return-Path: <linux-pm+bounces-10805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F692AE7C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2759D28320F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 03:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1504501A;
	Tue,  9 Jul 2024 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKHrPRnj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A07A15C
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494888; cv=none; b=kKikQ+Pb63+9hjhEn5/XHVz9Zqw1FnzaQmKPmQPnuM5iEPp+A1gxJXBLX5p0obqeNFhxIUTL0Uq6gWYvo7v4RgCFLFDnIK9YhMcR7aHboe3X06qliolNNCivIWlXh6QIlUQmxgm8gltjpjBzq4EO7HZJXv51QZH0BvmZW5t9M8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494888; c=relaxed/simple;
	bh=dzRlwYxsrGJ4KIqc7+Icq4MRTAAHtMVVE8IegY0vCAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dezzm0RkiN6zJT1blR1DVtiMoKGY4l/ocvvFEDAGpQFT0DNfEeLzYnYJ4OF/pcYYnu0btj3bHJ5dhZch61qc9yhssz9LOvuI7qowhs6LvWAAcI7bK5LwHeLx6GFwt4uLmRZWG4dqlyMEz7pvUbm8WL4roVWIwy7pazyI8PWjcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKHrPRnj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d88fdc8so20241115ad.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720494885; x=1721099685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvPxOKXTY/4mtLUCkxWUWZxN49J8zpBnSU1X8IK8Sug=;
        b=SKHrPRnjc8m/Vtd9qbTbw1DgzYVKsxjHRY7FwlfEYPR8QMh2YFcggmsdx5aFkIRRCA
         IlLYAaSHEiUYm1vubQaslDgG338fk0y4X30k7A6+GyveBF+SuUis5lP+09AdMNNKnDYh
         z2seNXIHMKhrbnDDhUqgYPPpSLyBvfupzQu/q0ryr7XR43DD2MmswE7gK8ZmDhhusUJz
         TRZCjdPAjAwzTI8mTuhpGTNvK/hHylsGqeX+qxglUYbDf3v/QgDztM0G7As5UH/D29ux
         Frtq+heSH5c4dmLRVhCDP3mTV6nZQqOo5t5cZ9LB4yhd7BFe0z0tlPXVVVoIqvrszg7k
         mLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494885; x=1721099685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvPxOKXTY/4mtLUCkxWUWZxN49J8zpBnSU1X8IK8Sug=;
        b=ukbmV1i9GkG4msHrr2DOq5w1nI6OerVRj4/FRL09sG6CAqPL8msVcKrQIBlsNqcTaf
         0PXTcuKfiExzqLyuxDODFf33CfAVhxUl6jbfnzUeuW/U/TEp/Gthly50kpXUkNiVLxm0
         q/j7BU4EdF1TucZ4pM+Q8JxsSrcRe4wTYiSd1/Ooa4g0Bn+IBBuWlo3w8tjsapX0+/4L
         18gj89qrBUsfszD7KSbizRiUKug25vzMEnLOjulvozsh05y8G3mMPrC69HENhjljfhhM
         WKYgqgjPVfOlkOjCwcQA9AHohuDA8l+kbKOdZIwtSzyHm9cg/D11fWnfjgl3ogqYBqvj
         y7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWrRhQnlwAVxfxP62iGJFN5tIHgLuDEAJDa6J6tuUGJ906082EDsa137FVy1GozXuyrVgEBuO+Jt5HFWmo/kyW4+yxBfMIG3fo=
X-Gm-Message-State: AOJu0YyNBrjtkiO57cfoFKeJW3sufJfaXtts9zZJIcXCb2DxJfOcnL4q
	8Cg/MxW32DL/8rBQHFZhp/ZbfhMQeTl60JR+Zq5rn5nlqtpaetqn4UuV3STkt0U=
X-Google-Smtp-Source: AGHT+IEOBq8PuD4oFMJkLh1pFoBgqljC1pxKAEneoVV1FfRnIFMZiqDzLh38CGn0thkn3m/UL8JA9Q==
X-Received: by 2002:a17:90a:6509:b0:2c9:8020:1b51 with SMTP id 98e67ed59e1d1-2ca35be21d9mr1196347a91.3.1720494885035;
        Mon, 08 Jul 2024 20:14:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa66582sm8899587a91.37.2024.07.08.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 20:14:44 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:44:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti: fix build warning
Message-ID: <20240709031439.llqdyaoxldsevuhc@vireshk-i7>
References: <20240708171434.111623-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708171434.111623-1-rgallaispou@gmail.com>

On 08-07-24, 19:14, Raphael Gallais-Pou wrote:
> Building this driver yields the following:
> 
> .../drivers/cpufreq/sti-cpufreq.c:215:50: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |                                                  ^~
> .../drivers/cpufreq/sti-cpufreq.c:215:44: note: directive argument in the range [0, 2147483647]
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |                                            ^~~~~~~~~
> .../drivers/cpufreq/sti-cpufreq.c:215:9: note: ‘snprintf’ output between 7 and 16 bytes into a destination of size 7
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix the buffer size to avoid the warning at build time.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

