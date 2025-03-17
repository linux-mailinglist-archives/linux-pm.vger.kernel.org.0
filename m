Return-Path: <linux-pm+bounces-24216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2FA65B9C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD597ADB41
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FF1B0F3C;
	Mon, 17 Mar 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j4M9aRcf"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7131AF0C1;
	Mon, 17 Mar 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234087; cv=none; b=P8vO1Mpoz6wl5ei45H2X9GdTCn2IIPah96nfAmNVZQj8fS7IP0cSeUicspQQ5stmMHz72ART+QtF8tw3V97HkboEm59cdtswHsLinsjljQpzbRyb0nqUsTtzFzZrBkMkiLzLtrR49oKMxOUfFazpPkz1EPUdUlK6AYPi06SshQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234087; c=relaxed/simple;
	bh=vs9BPFatqmHSxEPncR3Ib1jyEqOzcqlm+rcAreK+Kp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQE0tyC0LVomY2JHQI/sSM/kO4KdP/csefNf3kPjyZOu4xR1z2qniU5u0PmFOAnJc+auqKL4b0oxyAPsWGYQk4L+4rIeif0Dj5mDSEDYy+XD5zAfnYvUNi8Cqmpsu0tUqRpr5VJmFZFK8OyEEvdAl4tLBYhH4NhzopPgaVheU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j4M9aRcf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742234083;
	bh=vs9BPFatqmHSxEPncR3Ib1jyEqOzcqlm+rcAreK+Kp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4M9aRcfsUVDA2BY3PtIMvW4v7N6hvMkatebGtvveRNQ4rtVGCP88eNg/5AAfXHwc
	 tIWBh/WOaVM9v1hqEiRZm1Ow4eLjdIQ8SROo3Hy9cPI+runxV8YTuiVIuT3BJ4XVQd
	 /Ts71+O4Pfv9h6OpP8Peqkv76nsFDcUmHJv1+GJg=
Date: Mon, 17 Mar 2025 18:54:42 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v5 05/13] platform/x86: oxpec: Rename ec group to
 tt_toggle
Message-ID: <cceb8ab7-c532-499f-925c-2c7258c29a7e@t-8ch.de>
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-6-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317155349.1236188-6-lkml@antheas.dev>

On 2025-03-17 16:53:41+0100, Antheas Kapenekakis wrote:
> Currently, the EC group is used for the turbo button. However, the next
> patch in the series adds support for the LED button in X1 devices, which
> is only applicable for X1 devices. Therefore, rename it to prepare for
> adding the second group.
> 
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index dc3a0871809cd..8836b3df0d57e 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -681,18 +681,18 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
>  	NULL,
>  };
>  
> -static struct attribute *oxp_ec_attrs[] = {
> +static struct attribute *oxp_tt_toggle_attrs[] = {
>  	&dev_attr_tt_toggle.attr,
>  	NULL
>  };
>  
> -static struct attribute_group oxp_ec_attribute_group = {
> +static struct attribute_group oxp_tt_toggle_attribute_group = {

While you touch this anyways it could be made 'const'.

>  	.is_visible = tt_toggle_is_visible,
> -	.attrs = oxp_ec_attrs,
> +	.attrs = oxp_tt_toggle_attrs,
>  };
>  
>  static const struct attribute_group *oxp_ec_groups[] = {
> -	&oxp_ec_attribute_group,
> +	&oxp_tt_toggle_attribute_group,
>  	NULL
>  };
>  
> -- 
> 2.48.1
> 

