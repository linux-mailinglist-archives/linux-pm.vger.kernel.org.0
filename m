Return-Path: <linux-pm+bounces-13586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A53F96C023
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AA3B28669
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9951DEFDC;
	Wed,  4 Sep 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsxZhY4V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEA1D0495;
	Wed,  4 Sep 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459579; cv=none; b=jlp6sJwpoeNIPANdv2n+XS1tAgeFFeEqnJGEOmsyU2b/s0RYDnAk62M9Wfgb88kHE5jqyXRtJhw8F112qwi4rdy6CVMR5/q2IxtMCe2E4cfskizDZ91BNCKwMJylfAp2mia3udg7bAznBMZFwUP4Wm5U+xF3rUeF2pepRbRQwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459579; c=relaxed/simple;
	bh=oJyojKlM/C+yToRnqM61qH45uf5mvwOG2dI32gxQlVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ740AkyS+kM+X5c3Pu3aIutnr7yDAB0moQXk51ZseGAQeYTO/sbdvmvTFxJ3w5yExhxO1DuJI2/2LBxMoUzynGUfP8q2jsw9G+48A9uiMvFsdS4JzGfaj1AHbieKrMxsB6NbwAFCo7JagWDcpgsDZi0i4HvRX5dZvJTxkUi5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsxZhY4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EBAC4CEC2;
	Wed,  4 Sep 2024 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459579;
	bh=oJyojKlM/C+yToRnqM61qH45uf5mvwOG2dI32gxQlVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsxZhY4V0mf3a2d/nphDZnpSQbeATEFV2iWzKcgNiqFq3MK1wzCFozOuuM96c+hfO
	 o5xvwTy/ZprJM0nwFKHBACbxX33x87jALH/yvWjl/JpEDx0J0AyOOWfqqn5F+ganVO
	 24aZScIodimjbkN4WpJpj+dDukoEyVutGRdBOM0U=
Date: Wed, 4 Sep 2024 16:19:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6.6 1/1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <2024090420-protozoan-clench-cca7@gregkh>
References: <20240902093249.17275-1-yenchia.chen@mediatek.com>
 <20240902093249.17275-2-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902093249.17275-2-yenchia.chen@mediatek.com>

On Mon, Sep 02, 2024 at 05:32:48PM +0800, Yenchia Chen wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> commit 3e999770ac1c7c31a70685dd5b88e89473509e9c upstream.
> 
> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> system-wide PM code"), the resume of devices that were allowed to resume
> asynchronously was scheduled before starting the resume of the other
> devices, so the former did not have to wait for the latter unless
> functional dependencies were present.
> 
> Commit 7839d0078e0d removed that optimization in order to address a
> correctness issue, but it can be restored with the help of a new device
> power management flag, so do that now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> ---
>  drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
>  include/linux/pm.h        |   1 +
>  2 files changed, 65 insertions(+), 53 deletions(-)

Why does this need to be backported?  What bug is it fixing?

confused,

greg k-h

