Return-Path: <linux-pm+bounces-28958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EDADECE7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C803162094
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF0286D64;
	Wed, 18 Jun 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYMRDVH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9801DDA24;
	Wed, 18 Jun 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250604; cv=none; b=GBlkff9BPlJPro+VLj70nfS2QtQ+kHqe6SIgw/KXmgJGfbS2iy6xb8PZCvUIuGfyB9eiwKLY4Weq9IQREUhpJIkWDVAdElbxuBqO8Nj0tHc8OV1MZVr5nT6Qi+7DDfYHiZ68mpsr9EUzLMlYTFWjz4/xJ9UtUBaUODuBa+lZb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250604; c=relaxed/simple;
	bh=QciY19UJ2P7XWWxP+JOrADAPN8SHguNnRsyvc6zjqsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH7617MsjeOKA8XFbaTulAJh4iWw+5VPTYzuup8SunhhVNAOsZSQ3p7Ee06H07EVL/fxwzlwfKpHMMal7XYfzbI5XCeMEDwiCFY/TSHyMgy0KrdD+3FA4vD5bwe2nlSBJ4VVL730qA7Fxbz1gK2cKiAUXUYvaq87eOO0pCX2eQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYMRDVH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8967CC4CEE7;
	Wed, 18 Jun 2025 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250603;
	bh=QciY19UJ2P7XWWxP+JOrADAPN8SHguNnRsyvc6zjqsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYMRDVH0nCysQPSpZdUUboSTRJ/FqoBKZGhCxls02NOnsNR3PspaKlwItH6xYGf00
	 KDKFopJTihOOo+Evq6GKjtKtBDIvXiOZleKRdqWj62EOHLvcP25oicGb1BiuXJ8iXb
	 fxkA4oDCfK9MnXvXYouvJiBwVE7yUj9gd0rRqQHI4Xfl8kC1lDI21tXXAF/CdZf/kj
	 Fg4pMb5okyJFqQQR1b1QRpxHcqEuBESh0wExuncx3PhMRfrWTzkaXfHQaeIW3GR5Hp
	 R7yZXL+PqWwTZz61Fx3Gqmh85Q++w/ySEG2us5a/NHZanq7ilDrGAZdMW4FOTAtCCF
	 0AtOmM3nT78pg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRs8R-000000002Ld-03xU;
	Wed, 18 Jun 2025 14:43:23 +0200
Date: Wed, 18 Jun 2025 14:43:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <djakov@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock'
 is held
Message-ID: <aFK0a8AIOl704DpP@hovoldconsulting.com>
References: <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>

On Thu, May 29, 2025 at 04:46:22PM +0200, Gabor Juhos wrote:
> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
> ("interconnect: Fix locking for runpm vs reclaim") in order
> to decouple serialization of bw aggregation from codepaths
> that require memory allocation.
> 
> However commit d30f83d278a9 ("interconnect: core: Add dynamic
> id allocation support") added a devm_kasprintf() call into a
> path protected by the 'icc_bw_lock' which causes this lockdep
> warning (at least on the IPQ9574 platform):
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     6.15.0-next-20250529 #0 Not tainted
>     ------------------------------------------------------
>     swapper/0/1 is trying to acquire lock:
>     ffffffc081df57d8 (icc_bw_lock){+.+.}-{4:4}, at: icc_init+0x8/0x108
> 
>     but task is already holding lock:
>     ffffffc081d7db10 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x28/0x108
> 
>     which lock already depends on the new lock.

Thanks for fixing this. I get a similar splat with sc8280xp and the
icc_ism_l3 driver since 6.16-rc1.

Georgi, this is a regression that prevents lockdep from being used on a
bunch of Qualcomm platforms and should be fixed in mainline ASAP (e.g.
to avoid further locking issues from being introduced).

> Move the memory allocation part of the code outside of the protected
> path to eliminate the warning. Also add a note about why it is moved
> to there,
> 
> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/interconnect/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1a41e59c77f85a811f78986e98401625f4cadfa3..acdb3b8f1e54942dbb1b71ec2b170b08ad709e6b 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>  		return;
>  
>  	mutex_lock(&icc_lock);
> +
> +	if (node->id >= ICC_DYN_ID_START) {
> +		/*
> +		 * Memory allocation must be done outside of codepaths
> +		 * protected by icc_bw_lock.
> +		 */
> +		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> +					    node->name, dev_name(provider->dev));
> +	}

The node name has already been set by the caller and the node has not
been added yet, so I think you should move this before taking the
icc_lock.

> +
>  	mutex_lock(&icc_bw_lock);
>  
>  	node->provider = provider;

With that addressed, feel free to add my:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

