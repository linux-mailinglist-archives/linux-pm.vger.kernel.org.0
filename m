Return-Path: <linux-pm+bounces-10379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E331B9247D9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F11C1F21631
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F812E1C5;
	Tue,  2 Jul 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TbW7yWji"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6385298
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947388; cv=none; b=M8SRIwl0yqV4qjvhOgTRkdvwkN7DX5Of6ApmUtjpM5b99dLw0x8PKGZdHg85+sjwnW63xCTMYA9TzunwOnfJzbwBnB6yrVvIA7Xdqwc31Vjq5UlrlGE9xAgq2f7IC6nwUJ+5zJde1hb3kwDUJyqmvbjwjZ95xWJnCPtveCBaHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947388; c=relaxed/simple;
	bh=yoJGjYSz4OqNu58CzNDNVNoOs+cu1lvky6yS4xaj54Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPEy76VcIbkC10iJjTaVniLblyHC8OJLzfWfnA7E8Zog4v4Knzgp9Zwg/eI4qdYjDTsSVdzGf1f32aj7DDmZ03Ri8cYUN/uvfMX2Fv0XpOfoZDPy9gn25GJZAKceC3FV1Ov0sN2InowBffPmm0zg1HShHcgF8OdzjgdzxNQZkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TbW7yWji; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719947382;
	bh=yoJGjYSz4OqNu58CzNDNVNoOs+cu1lvky6yS4xaj54Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbW7yWjisbGtI68gpn9U6dR9u5puJYC687+psWSUcnUMzcv1icgRIHZTvUn2MMmzj
	 l8vZa7+QoT3zCy/jbDDygkhaGEllRHwL+BgGedvSFmBNjKp++7AWUWhImgVoZPbENh
	 G9nGnl7CTgGwceqhbDXyTmDYFF0wL0Q+hJlu7ysY=
Date: Tue, 2 Jul 2024 21:09:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Subject: Re: [PATCH] power: supply: cros_charge-control: Avoid accessing
 attributes out of bounds
Message-ID: <63208f3f-7d10-4126-b94b-f03887cf20d1@t-8ch.de>
References: <20240702-cros_charge-control-fix-clang-array-bounds-warning-v1-1-ae04d995cd1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702-cros_charge-control-fix-clang-array-bounds-warning-v1-1-ae04d995cd1d@kernel.org>

Hi Nathan,

Thanks!

On 2024-07-02 07:48:48+0000, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/power/supply/cros_charge-control.c:319:2: error: array index 3 is past the end of the array (that has type 'struct attribute *[3]') [-Werror,-Warray-bounds]
>     319 |         priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
>         |         ^                ~~~~~~~~~~~~~~~~~~~~~~
>   drivers/power/supply/cros_charge-control.c:49:2: note: array 'attributes' declared here
>      49 |         struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
>         |         ^
>   1 error generated.
> 
> In earlier revisions of the driver, the attributes array in
> cros_chctl_priv had four elements with four distinct assignments but
> during review, the number of elements was changed to three through use
> of an enum and the assignments became a for loop, except for this one,
> which is now out of bounds. This assignment is no longer necessary
> because the size of the attributes array no longer accounts for it, so
> just remove it to clear up the warning.
> 
> Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  drivers/power/supply/cros_charge-control.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index 73d7f2dc0fa3..2dd8ddbd56bc 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -316,7 +316,6 @@ static int cros_chctl_probe(struct platform_device *pdev)
>  		sysfs_attr_init(&priv->device_attrs[i].attr);
>  		priv->attributes[i] = &priv->device_attrs[i].attr;
>  	}
> -	priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
>  	priv->group.is_visible = cros_chtl_attr_is_visible;
>  	priv->group.attrs = priv->attributes;
>  
> 
> ---
> base-commit: 3664706e875f84bd4e3fa25ed1c6e46934cb32cd
> change-id: 20240702-cros_charge-control-fix-clang-array-bounds-warning-b84fd0f642a0
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

