Return-Path: <linux-pm+bounces-30590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B5B00361
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DD71694AE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008C2586EC;
	Thu, 10 Jul 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZMXTeP/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28385C5E;
	Thu, 10 Jul 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154400; cv=none; b=QHR6TmbpLg4IXJJ9UEQoNHzzWuL3HjUHreW9aKT9IrBxvuKvEBhtH6pXjtVseA14nizaGlTG5gF2afAebYJsC46mXPj6N7I7TgxQ3P+iQQy13FYdxTgOyKShpf880upm40+PET1bUrdTRCzFr4HRGGVZNOYZkaz/hAT//0WFLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154400; c=relaxed/simple;
	bh=OPUlVQruerq6SaJNDYI/Y8JtIqGXzYPnSz/i350i1vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcrB2ju6SKm9WWf1iY2XA5iktC/3a9r7iVrZfKeAjTjpsAx7iIFSYsP1/L9h/+IWgpvAFETeYI9Z7ifRmKoZmQ2fulBp3fJlcWG64DveQRToWm/Y/Hffsl1ja5rsLH2xUbihWeO+wbP9OZEGKn7QK/I0jVw2v8e+D5NLCinCVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZMXTeP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DCEC4CEED;
	Thu, 10 Jul 2025 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752154400;
	bh=OPUlVQruerq6SaJNDYI/Y8JtIqGXzYPnSz/i350i1vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZMXTeP/lTJtxLap/oPB7mUZss8jmjBoiRVPCT9zdYMAUAXOCv41IC+bFtzNmnzg2
	 MNYak8RMoagrAEw2NUsY6r96ZNcfViDA7OSbnFxb0Pe8WribDkAKpiodTtp+DBA+U7
	 LqTC9kPU9o5hk2bFejMvd3r5M+w7P7d5I5EXfj3w=
Date: Thu, 10 Jul 2025 15:33:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Message-ID: <2025071012-granola-daylong-9943@gregkh>
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>

On Mon, Jul 07, 2025 at 06:27:10PM +0800, Hsin-Te Yuan wrote:
> After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> w/o trips subnode still fail to register since `mask` argument is not
> set correctly. When number of trips subnode is 0, `mask` must be 0 to
> pass the check in `thermal_zone_device_register_with_trips()`.
> 
> Set `mask` to 0 when there's no trips subnode.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/thermal/thermal_of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd744725121ec7fd0d9 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>  	of_ops->bind = thermal_of_bind;
>  	of_ops->unbind = thermal_of_unbind;
>  
> -	mask = GENMASK_ULL((ntrips) - 1, 0);
> +	mask = ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;

Meta-comment, I hate ? : lines in C, especially when they are not
needed, like here.  Spell this out, with a real if statement please, so
that we can read and easily understand what is going on.

That being said, I agree with Rafael, let's do whatever is in mainline
instead.  Fix it the same way it was fixed there by backporting the
relevant commits.

thanks,

greg k-h

