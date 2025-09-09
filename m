Return-Path: <linux-pm+bounces-34275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54381B4FF73
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E2D1C244BF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39873353347;
	Tue,  9 Sep 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfOh/uVn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA08352FC7;
	Tue,  9 Sep 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428217; cv=none; b=LOgz/iKrOMe6/jPewcxWajUKHYTY7t2Fe78N4tyilQKKk29ghSNKrt1aXksDvUVuB2czmfG79M/TGhufaMrvwdCUqyUKKrmZBgjcORTjvzWZCbrTKA9KRc/U8F7UY++2xrHirIX3Mp9GmAEr8cLQKoZUUbq9gDyuYXZq6U92EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428217; c=relaxed/simple;
	bh=oOW/q/nXt3plb1YUm8fTu8X+dc7ZimOQs2RP9TN6Yec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3Qf3PK59KGhVu1Z9BK1SB9o0ZwvlfKsWpYwyutIkMsrBNmMpm/QP5vTu2cEnTwK/CXCTxC7Hbr3gLG4DC3aHyuR1EyJVVWTKJJdae977rZLkxakva3fbOTTQE+TIIYqd6mNTJdBm1URgEzk/KoC0PyenwcT+iiOEKj6sMf0Jmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfOh/uVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66AAC4CEFE;
	Tue,  9 Sep 2025 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428216;
	bh=oOW/q/nXt3plb1YUm8fTu8X+dc7ZimOQs2RP9TN6Yec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gfOh/uVnJxQMDBxHVa4QaA+XiK7yWaBbmp9+iWaGTcmFkeFB02wgP6j66f397fuc7
	 5VN5RqzK8PuWvSdVLwit4X0FAt876HpU1I4PZ2Umcv3kLeRyNGAHl9djOxLNRzSLmc
	 QNLBqcUMrxPzBhOHMnhERtE0zyLOqSRCKCrq1BvQPD0/b3p8/n9YcWKtcQTNevBWSV
	 /paTF/5Rb+/iNdM3iFcuobgNfHv3HWBFXqCTtY/fZwu7+YNlZcJQ5zCOXDf2nGjprO
	 JuXNCFFllglB6Wmv6F1hW6F+Zwmg1skKYolKeg+75q2/6GATUcNjZUC2fYO6yr8ufc
	 AKB/PP1AvAM9w==
Message-ID: <c288bc66-e34f-42e6-b2e7-debb8e1415ba@kernel.org>
Date: Tue, 9 Sep 2025 23:30:13 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] PM / devfreq: Fix double free in
 devfreq_event_add_edev()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aMABnic3SVnYMvGc@stanley.mountain>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <aMABnic3SVnYMvGc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

25. 9. 9. 19:29에 Dan Carpenter 이(가) 쓴 글:
> The put_device() function calls devfreq_event_release_edev() which frees
> "evdev".  Calling kfree() again is a double free.
> 
> Fixes: 430a1845c804 ("PM / devfreq: Fix memory leak in devfreq_event_add_edev()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/devfreq/devfreq-event.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 34406c52b845..70219099c604 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -328,7 +328,6 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
>  	ret = device_register(&edev->dev);
>  	if (ret < 0) {
>  		put_device(&edev->dev);
> -		kfree(edev);
>  		return ERR_PTR(ret);
>  	}
>  	dev_set_drvdata(&edev->dev, edev);

Firstly, I'm sorry that it my wrong review of patch[1].
[1] https://patchwork.kernel.org/project/linux-pm/patch/20250907113302.3353584-1-kaushlendra.kumar@intel.com/

As you mentioned, the above patch[1] doesn't be necessary.

Instead of applying your patch, I'll drop the patch[1].
I'm sorry to make the confusion.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


