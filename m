Return-Path: <linux-pm+bounces-13674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC096D376
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD85E1F2ACB6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DA1957F8;
	Thu,  5 Sep 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fP77nZHL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D72107;
	Thu,  5 Sep 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529118; cv=none; b=mD89XmlieJ3QueFpYZI7t6Afq7HOfqWGK1D2m5c8aCd3VDuU8bPOwHDICuiC4vPa8IQTNi6z8Cq+EQv73uCREE6rf9FNOwRrIGiA0Eclq6Gfwivia0Nn1W7QXLkqQikaLXHyTAbtETPX/p//26yBEDzNkL4ko8k2h4c5gzbQsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529118; c=relaxed/simple;
	bh=05nyWH3zDvfgm6No8VHxM0pYql7MSg6Js/yn8Qs8Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq96IndvaVrQsQSSNSXqitEAAtmDbY32ZaVpo6wHL6YZW/QMPsr2YSvcqVJCiCocogNYvLPTbtlIviXWV/Q002voQcbLAlbY25a60XwOdKANO9Y0TPm3ZNA6mCTmA/wA7phMQzAqxoYUKeurF6m/8qqT3TD8me7s17syIroKFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fP77nZHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB646C4CEC3;
	Thu,  5 Sep 2024 09:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529117;
	bh=05nyWH3zDvfgm6No8VHxM0pYql7MSg6Js/yn8Qs8Bsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fP77nZHLAPM6ZraNGGjZbGuTz5aW+cgt66qS0Q97+Ej12U+wAZHbDWQYMZwKtfHvT
	 CIAqs3MPtvBPjjyoCNWsruuB5ObjjLnHBvK4K84jXwVoWnO7h5ie3pslleb36+JKaq
	 uBnTa+1sCNpgiFe7AJ63t2kq53dlraXadpB2ASMo=
Date: Thu, 5 Sep 2024 11:38:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, len.brown@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	matthias.bgg@gmail.com, pavel@ucw.cz, rafael.j.wysocki@intel.com,
	rafael@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.6 1/1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <2024090534-footage-player-10e5@gregkh>
References: <2024090420-protozoan-clench-cca7@gregkh>
 <20240905093433.4798-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905093433.4798-1-yenchia.chen@mediatek.com>

On Thu, Sep 05, 2024 at 05:34:33PM +0800, Yenchia Chen wrote:
> >> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >> 
> >> commit 3e999770ac1c7c31a70685dd5b88e89473509e9c upstream.
> >> 
> >> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
> >> system-wide PM code"), the resume of devices that were allowed to resume
> >> asynchronously was scheduled before starting the resume of the other
> >> devices, so the former did not have to wait for the latter unless
> >> functional dependencies were present.
> >> 
> >> Commit 7839d0078e0d removed that optimization in order to address a
> >> correctness issue, but it can be restored with the help of a new device
> >> power management flag, so do that now.
> >> 
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> >> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> >> ---
> >>  drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
> >>  include/linux/pm.h        |   1 +
> >>  2 files changed, 65 insertions(+), 53 deletions(-)
> 
> >Why does this need to be backported?  What bug is it fixing?
> 
> >confused,
> 
> >greg k-h
> 
> Below is the scenario we met the issue:
> 1) use command 'echo 3 > /proc/sys/vm/drop_caches'
>    and enter suspending stage immediately.
> 2) power on device, our driver try to read mmc after leaving resume callback
>    and got stucked.
> 
> We found if we did not drop caches, mmc_blk_resume will be called and
> system works fine.
> 
> If we drop caches before suspending, there is a high possibility that
> mmc_blk_resume not be called and our driver stucked at filp_open.
> 
> We still try to find the root casue is but with this patch, it works.

I think you are getting lucky as this is just changing the order in
which things are suspending.  Please find and fix the root problem.

> Since it has been merged in mainline, we'd like to know it is ok to merge to stable.

It changes the behavior of the system overall, and doesn't really fix a
bug on its own, so I don't want to, sorry.

Please find the real problem in your driver, or the mmc subsystem.

thanks,

greg k-h

