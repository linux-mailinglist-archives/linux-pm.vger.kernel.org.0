Return-Path: <linux-pm+bounces-20552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B92A13D90
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3479188C649
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E022ACDC;
	Thu, 16 Jan 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ANlbU5fx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96671143736;
	Thu, 16 Jan 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041060; cv=none; b=JcZpYVk7+9DsEx5Hn9SObh3TCXPMQ6cUNWSK3G42SpDijTAtfN6xNANHQtARJrv5v+Hu7A4YXLIPgulqtANl1y2qkqFnIKoxf+cVhp+GsG0N2eCmJ9z8FLFCZUP8NVGEYxI4TSPH9YB9t4nrmnU+k9Lb/oG/FaYbO2AdDLgnDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041060; c=relaxed/simple;
	bh=tLkWPx9bPpxC2a+QR0COsLjlR47Wtbj5h4IHSmiIJK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOnxCXKYwYRbi3M09bvK6pOEdKYCEAVrRxrYYuWkrbdseQLDcNcQEILjOEVQ/u7zAcqZlhucQvZjNv6YtVJqx53GC+3K3MYMKjWsHMswL4BPlk7iR1SkzHo41gM8Ufwlqsp9vSuwssHLS89+yTgVazub1Xzq2lkOEu09aN++ARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ANlbU5fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB20C4CEE2;
	Thu, 16 Jan 2025 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737041060;
	bh=tLkWPx9bPpxC2a+QR0COsLjlR47Wtbj5h4IHSmiIJK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANlbU5fxEJjYFwL2V0eZXIoAvyHqdrGuNnMd0oUJdhTNUpZz2Bp6LXtAZ5zmBwcL3
	 KIT52OR7I2P92tq7AHx6TnzSyxqvweKXWpCHkiDEtkYjCcHWFtmR5bVBrgovYf4EIq
	 kvqI+wvXx17A0hlqThCnSY/sjSjlpiydrWwgrOOM=
Date: Thu, 16 Jan 2025 16:24:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <2025011605-splashed-giddy-0289@gregkh>
References: <20250116152152.147048-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116152152.147048-1-andriy.shevchenko@linux.intel.com>

On Thu, Jan 16, 2025 at 05:21:51PM +0200, Andy Shevchenko wrote:
> The introduced macros are not doing what they intend for.
> Also there were no users of them for all this time.
> Drop them for good and to avoid possible misleading.
> 
> This reverts commit 41a337b40e983db4f0e1602308109f2b93687a06.
> 
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/pm.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 08c37b83fea8..5dae93817141 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -384,12 +384,8 @@ const struct dev_pm_ops name = { \
>  
>  #ifdef CONFIG_PM
>  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
> -#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
> -#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, "ns")
>  #else
>  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_DISCARD_PM_OPS(name, license, ns)
> -#define EXPORT_PM_FN_GPL(name)
> -#define EXPORT_PM_FN_NS_GPL(name, ns)

Why not start using them instead?

thanks,

greg k-h

