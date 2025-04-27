Return-Path: <linux-pm+bounces-26296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FBA9E2A6
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 13:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79414189EFAA
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470E1FBE8C;
	Sun, 27 Apr 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKP5Tt05"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0519DF6A;
	Sun, 27 Apr 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745752630; cv=none; b=RDL03QAhpQ5norJdnXE08EZEcYYcqIX1HVOQxRjFKe8ff6/NURWi5uECPoBvbuIz4aQ0so4GQ6e+wnuDBoUVH6dLsTEwNHSkSp4Yh80xGSwnTakx48erbnoSZWv+cvWd0eiQN2XjCRR4Kx5/T1ZTp5xg0FN9gfswSaAz2eCpFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745752630; c=relaxed/simple;
	bh=rkhZUEwWXJ/N6FREpqQufEaA5Y1nH3+YIjEGrosEqcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3YeIXB/BXafjhGkiF/UrleeENsUWDI2TmHzhwiT54KN9rQLSOKAeh4JbxUMAuwKEqWE7iY5sv9IpfT2QGUQd713ZkFbRabI7eSRwc+Q4BZc3b8RakdUqTfXXfO4i8dN3NPZwag6+Psv37iZd1YohqjNfQq/SRlXtvLs12dw/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKP5Tt05; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so19892175e9.2;
        Sun, 27 Apr 2025 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745752627; x=1746357427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGmp9NGnRNxBdMLP1eepi4IepO3o7vm+4R4IFyFlnQY=;
        b=gKP5Tt05mcznD8C6/0cE/2S/BKONLe0thhjuN1fB+U0oohAY0nmMd7UH2Rl3CTbio+
         xqFVvZzaAonYFMG9cCJppXXhPvZ8gxklsS0HM1j67gMpFJcSpMZLtGTVmrgzDqNpZl5W
         xrhXOA/hIsQw/hH+/sUzUwsjABjnYAGNbkHRXls1IbJf7y3lkB/okKpqQ2JAdDWeJ1r8
         V5jbbY8ZwKwfa4qw1T58NlwRWTZjg2pM5eSJ8rvTHS8mIoDw+JxaeLS/houpg3A9OMPE
         mzZfJTHSWVS9Mw803At0qdP/GxvYpFmHqQaYRPN7S32C4VNyH/zPtiNrgLcUJxOZHtA5
         wG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745752627; x=1746357427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGmp9NGnRNxBdMLP1eepi4IepO3o7vm+4R4IFyFlnQY=;
        b=VGC3jznc2bmxPWFn8gEod9vRP8qhrJoam2jOoTY1lmNT2nU0Oxfhr9FpI87n54ZRaL
         TNWAdmSAMxKVbknhMWHHUwInrMMZGNjyEG2bf3z89XB1p2i0gWOKRHfU2N3BsHH7D065
         /qJHNYWG9t1kJLj+9liiNSDvjmdU5iHZyTNJrY+xlsXmGLmCucxS7PusaVkGiYGSJUer
         OKyqUIRDfLRiHE1mLl4tJlgH0WEbRtVuyjYf9Pa+f+WcchYe/0IDqOUKmUJwzIMSOQpO
         UVL9gtEuQmWQDc3riI5mVHThOpbuABH5f+1Vk7v7wVi42djC8U1GlAzemNY6gIOYv4e/
         US6w==
X-Forwarded-Encrypted: i=1; AJvYcCUIEseEiwKwAVesnodi9g9WPJDaypC9QdlWUvKMwm55UN670pbv2gi/abCgLgelN1V14TsZJqFTFbzuKKU=@vger.kernel.org, AJvYcCV0m6KwISuEB2DSqNZgUhDif9336P/ayBHTtbviaAd/UNCHRoYDAZNnmklGbQnDMKUol/LbMLiggB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/MBhtLrLqKDfFD0gQZBvIy378EFNjuCYjwD2Qn1nrX7pJ7MTT
	ql37U24TzEZR3kMriMVl/49KOjzo/jwl9h+vB2usEVcobuP5fl0o
X-Gm-Gg: ASbGncuoYmms0Ln0QDKw1dGA03KRy5PhbcoSQRvplCgVxYhkP3hgMMDC70BkDE0aZY+
	Q2KZ6LG3F1ayDvPEHJ19arQklbUnx+S1t8rr1sT5jHkYOBpJKFVyNvqM9BnMetMIAhW5azfpHB9
	5n001rwTmfmIIMLfx0+a1dLZIFjIE/s4vcr9xiafb/nyi1TNeNYrigb/fQhzoaEU10iKbInDbSd
	29RyB098oV9WVuHw1YTBr+VwiLO4mG47XPjuwrDgXH0BtqL4cRsM2uW8FVc3SGzmWyJQU7nLmLu
	dXR9D/4pfYBRhHy6kSYworHoU7UgQMdMreOQLwlBizIPJXGabhx1hUjbXYjIoF55j3YFnRKpyuI
	kXL0=
X-Google-Smtp-Source: AGHT+IEtLdDJXQe2gEMGDKHyLjLk8LaiPDEZlffLP7VJ66TMYmCmrciNnhBXXsIWurPpeI/nLX66nw==
X-Received: by 2002:a05:600c:3d05:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-440a65c5643mr72649475e9.2.1745752626520;
        Sun, 27 Apr 2025 04:17:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d1e19e1sm120832795e9.0.2025.04.27.04.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:17:06 -0700 (PDT)
Date: Sun, 27 Apr 2025 12:17:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
 <cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
 <lihuisong@huawei.com>, <yubowen8@huawei.com>, <cenxinghai@h-partners.com>
Subject: Re: [PATCH 1/4] PM / devfreq: governor: Replace sscanf() with
 kstrtoul() in set_freq_store()
Message-ID: <20250427121704.51e3af2a@pumpkin>
In-Reply-To: <20250421030020.3108405-2-zhenglifeng1@huawei.com>
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
	<20250421030020.3108405-2-zhenglifeng1@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 11:00:17 +0800
Lifeng Zheng <zhenglifeng1@huawei.com> wrote:

> Replace sscanf() with kstrtoul() in set_freq_store() and check the result
> to avoid invalid input.

Isn't this a UAPI change?

The sscanf() version will ignore trailing characters.
In this case it is actually likely that value might have a trailing "Hz".

	David

> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/devfreq/governor_userspace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index d1aa6806b683..175de0c0b50e 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
> +#include <linux/kstrtox.h>
>  #include <linux/pm.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> @@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
>  	unsigned long wanted;
>  	int err = 0;
>  
> +	err = kstrtoul(buf, 0, &wanted);
> +	if (err)
> +		return err;
> +
>  	mutex_lock(&devfreq->lock);
>  	data = devfreq->governor_data;
>  
> -	sscanf(buf, "%lu", &wanted);
>  	data->user_frequency = wanted;
>  	data->valid = true;
>  	err = update_devfreq(devfreq);


