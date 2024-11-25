Return-Path: <linux-pm+bounces-18102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD89D8BED
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 19:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353E0B2B777
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B1A1C2454;
	Mon, 25 Nov 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxjdOv+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AE1AD418;
	Mon, 25 Nov 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557606; cv=none; b=mhFTLHD34WXUWi0TlzD+VryviJ5mdCnS8YLj+mfalBie3o6qYCLvE8slQ+H/KiingMSwrBtNML8pSnCzAl7754lhLXsgQ8hcZvYsFQrz4kyAPF9GKgGiMOoGn8KVqRXEiswUsnxbfAf980AQsoj8HnmtfIr7AV+NyIB44lUmzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557606; c=relaxed/simple;
	bh=r+lGtg+Csfe1Gx4njaQdu1enT/JE/8fsMpA/ZsLCBzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQXV8mrPluIXfplaTP1ccVvIWBvvkgryG203io6nETJydUzSwhdnvuxUaZ+r89c0c9rOni2uh2F1MSPKiFzFMcwtdjMmDpXsXD7CeYrzi+qWkOSV71iJPyuVBZLyDn+ATPa/LxvTU5hKgWcGlyLIFb1YLOqqqfc6mpMrF72FgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxjdOv+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E96C4CECE;
	Mon, 25 Nov 2024 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732557606;
	bh=r+lGtg+Csfe1Gx4njaQdu1enT/JE/8fsMpA/ZsLCBzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxjdOv+1TDJPJwJZFnJDfOwdp+IEnKIIHtEAGJyA2Udca+C/iM6b3gDbq9FfDbiww
	 91KxY0IF+Y81rwRwABlP5RnIgQlqj9fhcWKxBFMTlTZCsGT3zrmREcsjdmdJ5/aJRx
	 GtQyhYVGXP6iyEYUzL549/kfiz7NgZNPWQw9sjNDltzl8mtDEGe10q/xENGj8SyfRQ
	 pgeJ+wb43TNbJ/0JakhgCVrzHE36WXDPTnkycIOXCslJgtYg/n/JZXEGDUJg3J9tMX
	 hJsrsGZSqhBLW2gKSdwXR91364N3dRYbVxPX5A4a43VHbNX6qqzUJch0fcmktakE2/
	 0gkFuLt8erSiw==
Received: by pali.im (Postfix)
	id 5EB5B5DA; Mon, 25 Nov 2024 18:59:57 +0100 (CET)
Date: Mon, 25 Nov 2024 18:59:57 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	sre@kernel.org, linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org
Subject: Re: [PATCH] power: supply: bq27xxx_battery: do not update cached
 flags prematurely
Message-ID: <20241125175957.rulndmny536pd5c6@pali>
References: <20241125152945.47937-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125152945.47937-1-absicsz@gmail.com>
User-Agent: NeoMutt/20180716

cc Krzysztof, author of the mentioned commit.

On Monday 25 November 2024 17:29:30 Sicelo A. Mhlongo wrote:
> Commit 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about
> status changes") intended to notify userspace when the status changes,
> based on the flags register. However, the cached state is updated too
> early, before the flags are tested for any changes. Remove the premature
> update.
> 
> Fixes: 243f8ffc883a1 ("power: supply: bq27xxx_battery: Notify also about status changes")
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 40c5ac7a1118..b2c65fe43d5c 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1913,7 +1913,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>  		cache.flags = -1; /* read error */
>  	if (cache.flags >= 0) {
>  		cache.capacity = bq27xxx_battery_read_soc(di);
> -		di->cache.flags = cache.flags;
>  
>  		/*
>  		 * On gauges with signed current reporting the current must be
> -- 
> 2.45.2
> 

