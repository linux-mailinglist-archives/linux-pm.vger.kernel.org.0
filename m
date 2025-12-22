Return-Path: <linux-pm+bounces-39813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB6CD7201
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037523019BF4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5B27603F;
	Mon, 22 Dec 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe66iKA7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68065661;
	Mon, 22 Dec 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436388; cv=none; b=VY8uNqhyfKwYi6coAD9fdo6WS9Fw+Tfjyz65E/OZ+sceu+nxjjLmLDqwh92YBYi//LJFh/mi0qUNxTdLPDTe52FYsRQ4TYa6Bkf3b9K8uP92BCCEluJ4ln3CaTKHIqo7g7Kg88NflpzzUwdlSiAgt4Pmzhw1rG0lhZPZ+Six05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436388; c=relaxed/simple;
	bh=2RBv3OtmPUQILKSmp4Q0ix+BvAl1QjorxEod4NKRr+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1RWZ9VHkQLrpPPie1tYyMFjq+ZVw6Fmv5i+2lZq76eWP4SSgoLz8SRtjWNZAmL+udXC4afq1fdFd03ojzqeTOoZMrbZNlERfximWKk+biO8fqQWu0eZP62jGUDTas6l5q+n8DK2tGO/UMwGDVXhotXIpZjXPq8d1r/4J3w4Pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe66iKA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF3C4CEF1;
	Mon, 22 Dec 2025 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766436388;
	bh=2RBv3OtmPUQILKSmp4Q0ix+BvAl1QjorxEod4NKRr+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xe66iKA7tkcZTcng66uVrkLYMUxL7Cv03RDri/iEZv73H2d8MhcK90Tgj/cfmNthl
	 HODj+lEcW5F6M6+5nPHs+9NViV4JRd6P0/pkKQXav+A4bLIYQef9zVSxnxrQG2Xwzc
	 cObi6sSIW6ZrdV9ci9TCwdUjowxUxPHm+u/Q83eYBDseqQXc6S5VWpPPohz/r4io3F
	 9SwPevL4D1eIqXP5Wm1qNb4cWM/QzJM47q7LKDQzaVNP1ymljsCL7yE9A3QefpSPLQ
	 06v8p7wGa+aI/pEMMQioIzh7Nrh4KlwuJ4TNn0YQOQaUeC10A/0PwmnTb8rLUU35K4
	 obwV13aFlwnjw==
Date: Mon, 22 Dec 2025 14:46:25 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Brian Norris <briannorris@chromium.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v1 16/23] hwspinlock: omap: Discard pm_runtime_put()
 return value
Message-ID: <o54twe6xkpqn35khexdj7sbdzsi7i7lsqo4h66y5l5dsymmvrv@uvjxuvpizdcm>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <883243465.0ifERbkFSE@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883243465.0ifERbkFSE@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 09:24:19PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Failing driver probe due to pm_runtime_put() returning a negative value
> is not particularly useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel
> has been configured with CONFIG_PM unset.
> 
> Accordingly, update omap_hwspinlock_probe() to simply discard the
> return value of pm_runtime_put().
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
> 
> ---
>  drivers/hwspinlock/omap_hwspinlock.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/drivers/hwspinlock/omap_hwspinlock.c
> +++ b/drivers/hwspinlock/omap_hwspinlock.c
> @@ -101,9 +101,7 @@ static int omap_hwspinlock_probe(struct
>  	 * runtime PM will make sure the clock of this module is
>  	 * enabled again iff at least one lock is requested
>  	 */
> -	ret = pm_runtime_put(&pdev->dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_put(&pdev->dev);
>  
>  	/* one of the four lsb's must be set, and nothing else */
>  	if (hweight_long(i & 0xf) != 1 || i > 8)
> 
> 
> 

