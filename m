Return-Path: <linux-pm+bounces-38420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CAC7E284
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB6E34E1453
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77B2D8773;
	Sun, 23 Nov 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntHHpqNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB272D7DF7;
	Sun, 23 Nov 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911484; cv=none; b=po4uSpsrsgW/BKy5SBRI5L4vPcdNRFj5VfrEBRubWXaWLJ2xxQXTVfAxRN8OQWmIJkSJ3GCOej/8wnyqSEWwZnrbZm9+mXi5lbhQBGRbn8QRIkv68qbQWQlbMYtYbruwqcdgDQeaurqUqVaSFmynjx2dIgGZrq7GBS2+Xy1OgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911484; c=relaxed/simple;
	bh=enoErcPElfCtw2cugcnsJZynNc8oh+KKwlxqkTYh4aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u45AiKcbykBbmiRmos9m3hNRCCJSH5LeZbMI1I/21gl6mRsjXw3AwHrm3IesRXgy2FdRjfSnuXvV5Sz1dlCNjKaKyCsJUoCDGzJzYP4aqjT4XKjsBwOVuaRlagjHN+e9SKNpbOPwZgBNo2HwxGL6a0/YOXvoO7gp6wro58I5qQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntHHpqNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D08C113D0;
	Sun, 23 Nov 2025 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763911484;
	bh=enoErcPElfCtw2cugcnsJZynNc8oh+KKwlxqkTYh4aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntHHpqNtuUBNW0KAk/Y0Da/5q64aQbsumD9Uy3g/nTWyl65Gq1uG06bsjqF1Xuuss
	 NX/2v6VMQ3RtW3Axauti65rbiQUkxggknepwXaeayhkjprQdggUx4V4MqC/gkvjU8T
	 tdsDoxgUj4xlpTaDRQnetTK0cIzr7g5gt5Uk6oN3rHTN7th09LrrwkOlkAnhHrDp+A
	 XyeNQJz7OVzzgEVmDPs1/2pg0ow0BxrG6bzjtNfiApq22xZi+5lY8PqZmByaC/7YjY
	 ROcqGlClGjTucaYfTaeOf2LGjbBsRXExnYLdRNipZl+e71d4YuMZjVmbB5oN0HxLSG
	 slwQWxmfuoUGA==
Message-ID: <25a5c859-357f-4e31-9b47-822d0c32ce70@kernel.org>
Date: Mon, 24 Nov 2025 00:24:40 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: devfreq: handle invalid parameters gracefully
 in simpleondemand
To: Riwen Lu <luriwen@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118032339.2799230-1-luriwen@kylinos.cn>
 <20251118032339.2799230-2-luriwen@kylinos.cn>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20251118032339.2799230-2-luriwen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

25. 11. 18. 12:23에 Riwen Lu 이(가) 쓴 글:
> Instead of returning -EINVAL when upthreshold > 100 or upthreshold <
> downdifferential, fall back to default threshold values to ensure the
> governor continues functioning.
> 
> Additionally, the validation is now scoped to the if (data) block,
> preventing unnecessary checks when no user data is provided, while the
> fallback mechanism ensures reliability with invalid configurations.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  drivers/devfreq/governor_simpleondemand.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index b4d7be766f33..7205891d2ec6 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -36,10 +36,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  			dfso_upthreshold = data->upthreshold;
>  		if (data->downdifferential)
>  			dfso_downdifferential = data->downdifferential;
> +
> +		if (dfso_upthreshold > 100 ||
> +		    dfso_upthreshold < dfso_downdifferential) {
> +			dfso_upthreshold = DFSO_UPTHRESHOLD;
> +			dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
> +			pr_debug("Invalid thresholds, using defaults: up = %u, down = %u\n",
> +				dfso_upthreshold, dfso_downdifferential);
> +		}
>  	}
> -	if (dfso_upthreshold > 100 ||
> -	    dfso_upthreshold < dfso_downdifferential)
> -		return -EINVAL;
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {

If there are wrong initialization of devfreq_simple_ondemand,
it should point out what is wrong because it makes some confusion if there are no error.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


