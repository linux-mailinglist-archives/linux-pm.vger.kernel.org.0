Return-Path: <linux-pm+bounces-25178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660CA84DF8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021741B80038
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1C28F935;
	Thu, 10 Apr 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ob0aANeN"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04641DF965
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316052; cv=none; b=p7nt3uwtm0TgogM+PWdGzms8JPtlZZOzg1Z1s44ER2P/Goaus9IJdjWX9/sTY8Fc9UCM/33kt9Ym4nJhr3a0BXmURNcXJR6sZ3ENMk0cT2kSeWTh0nRSvSns0GT19tjKJPL2FTQtVCcP2PHCOFxYMDu8IoasrGc54eRaWlncqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316052; c=relaxed/simple;
	bh=8S6wO918AM55cy3ZrArkhstjLdXh9lAif8YZlrhbxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuNkgX4576gw5xyEuAdef9so0GmOTWhTBjwiT6cuLcwZoS2jf+vv6BcUsNmcKqceecvJh5KQ2QHdJubJJuEF1ZcXhrYWdXHI7WnEy1aRR6InlZD0FLRSNAFNkpCpWtbAcauABwuTK+wIHlsOwMfqOfBy1/5A/eU5NnX0mvIoJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ob0aANeN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 104B1352;
	Thu, 10 Apr 2025 22:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744315930;
	bh=8S6wO918AM55cy3ZrArkhstjLdXh9lAif8YZlrhbxqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ob0aANeN2qQA3MMf4R/7m7bafx0qMo9DtfqpvBmGLeovKxe1vC8amxsCnP4Tl36Me
	 9dOk8sn107UlSUo9vUCcgLu/sSmPj5Fk/IUWNZHzH6Lo120diNwIDEgCeqy6lfe36p
	 2Z5xhDPAvA0JzShiM92yUzAL4f/3oKaUATBJcbW0=
Date: Thu, 10 Apr 2025 23:13:42 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 1/7] Documentation: pm: runtime: Fix a reference to
 pm_runtime_autosuspend()
Message-ID: <20250410201342.GA29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-2-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:00PM +0300, Sakari Ailus wrote:
> pm_runtime_autosuspend() got accidentally renamed as
> __pm_runtime_autosuspend() whereas the intention in the patch was to
> rename pm_runtime_put_autosuspend() only. Fix it.
> 
> Fixes: b7d46644e554 ("PM: runtime: Add pm_runtime_put_autosuspend() replacement")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/power/runtime_pm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 12f429359a82..63344bea8393 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -154,7 +154,7 @@ suspending the device are satisfied) and to queue up a suspend request for the
>  device in that case.  If there is no idle callback, or if the callback returns
>  0, then the PM core will attempt to carry out a runtime suspend of the device,
>  also respecting devices configured for autosuspend.  In essence this means a
> -call to __pm_runtime_autosuspend() (do note that drivers needs to update the
> +call to pm_runtime_autosuspend() (do note that drivers needs to update the
>  device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
>  this circumstance).  To prevent this (for example, if the callback routine has
>  started a delayed suspend), the routine must return a non-zero value.  Negative

-- 
Regards,

Laurent Pinchart

