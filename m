Return-Path: <linux-pm+bounces-21597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C69A2DAAA
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F651885B65
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 03:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7181805B;
	Sun,  9 Feb 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="P2yZHj8g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F6CA6F;
	Sun,  9 Feb 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739072699; cv=none; b=AdS3b/DB+Tj+2b+KXR+JxNoZr9z/6Q5rUz4XTmZKXcDrex5zejOnM7YmUO68mKRr4WVI/0OeC2thZAgQeHEJZAXg410Zent8nIReCm92RkdvHji7roThCuNssmTRBDk+sUMNjEOYfTJq9pVwWW6bSNWLjZuELmkEifBiTQQug1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739072699; c=relaxed/simple;
	bh=NgYomdEiHgjsfNh6JTaerLlR4aoaIx5h10Ey5hLdp0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtoWiHYVxgWH51lh6NLUvogHE8aEBwL6BG5ttWASPihtKdv2nk/r6JkKwhtEjT4gxiPvYoOQMk8kEHO7M8ruukBspGvapBQcE1skM23iEsJLHXr9MdR/TumH+kvC6F1eI5LYbcJ4O0VjbYBA4KmgOunYVbverqv7xfGsDekomOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=P2yZHj8g; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrD9d6h5rz9skP;
	Sun,  9 Feb 2025 04:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739072694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TW1GVy7OXHVjEtLYS6l4yYsrDFNRMzSuR/4sETXaIT8=;
	b=P2yZHj8g4wGOTYHaiiXbppITdF3KTYKPqs0KJKDKYHXBeZyXusB768Ei67xAj7yPuav/Ky
	0M3zocDoCY5dcyJAadj8kwNh++GnSiRYjwaKnwg7ms7CLF8css1BmXEvCzM6rTlskuXBUa
	oEAwYOHnsR7riQOowyaGbri2fV9KSQEe+0jkexIK19rOC19UfEX2iDTNPCaEEnUyRx6B90
	dNv1eHVo46dAj7G+bgyRPjxyLOmQsTblBRnQFOO87O28s7yWwlEXsYHhWzIKLnUqiE8szV
	k5CnKvPJKHx/cUG1ZyuGRHW0Iw8l9Ek+Q73f+4lkSxFnhOXMy9Kws7qjTuaq3g==
Date: Sat, 8 Feb 2025 22:44:51 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: "rafael@kernel.org" <rafael@kernel.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3] thermal/debugfs: change kzalloc to kcalloc
Message-ID: <5gjmqurpvdyb6sxpeytev7clxxrkpbjncjb623z4dg3vbaqzvm@kavc7th7svwd>
References: <dmv2euctawmijgffigu7qr4yn7jtby4afuy5fgymq6s35c5elu@inovmydfkaez>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dmv2euctawmijgffigu7qr4yn7jtby4afuy5fgymq6s35c5elu@inovmydfkaez>
X-Rspamd-Queue-Id: 4YrD9d6h5rz9skP

I wanted to check in on this. Anything I need to change?

Thanks,
Ethan

On 25/01/19 01:35PM, Ethan Carter Edwards wrote:
> We are replacing any instances of kzalloc(size * count, ...) with
> kcalloc(count, size, ...) due to risk of overflow [1].
> 
> [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> Link: https://github.com/KSPP/linux/issues/162
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  v3: fix description and email client formatting
>  v2: fix typo
>  drivers/thermal/thermal_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
> index c800504c3cfe..29dc1431a252 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device *tz)
>  
>  	tz_dbg->tz = tz;
>  
> -	tz_dbg->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
> +	tz_dbg->trips_crossed = kcalloc(tz->num_trips, sizeof(int), GFP_KERNEL);
>  	if (!tz_dbg->trips_crossed) {
>  		thermal_debugfs_remove_id(thermal_dbg);
>  		return;
> -- 
> 2.47.1
> 

