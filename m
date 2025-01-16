Return-Path: <linux-pm+bounces-20554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C93A13DF4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CC51886034
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E8622CA08;
	Thu, 16 Jan 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVgdwQkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BBB22C9FD;
	Thu, 16 Jan 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041999; cv=none; b=m+FrW6hwLGgxXl+ACtZPTVL0F9d+22dI8jFZCh1EsW/TfY19dssqxqTSAVduxv/Z5jg9o2xryH5RD39gwBe+he4/NlCJHhpfgrEFODw8LbBfr68MFz5vQegZhjD2H0MqYFGBoAKR0cIggGgbJ5FxeMT5Zliz7emWGJ+G33e42eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041999; c=relaxed/simple;
	bh=rVEjAUCNRU6cFRyeCvaJFacgkxFaKNnC2P/UV0si5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reX2j8AFxWf9/hJgCgbnGMekT92CiiDhL9nNxnQE+64E3BPHcL0TQ3c3WcCZ5pdjGBkYCQecXhTC+kFIhivlbZ/XDD1e7GhycuwaZUsh399UJf2gqCjbhAHwEHI9eJ50IxxP292Azy6alVoEXFlIoU367T6GDkdL4JpeCHuOEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVgdwQkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC63C4CEE3;
	Thu, 16 Jan 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737041998;
	bh=rVEjAUCNRU6cFRyeCvaJFacgkxFaKNnC2P/UV0si5Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVgdwQkbpbKIMO6j0hlpUDJbjA7QMbKdGTfp0KYhLZfTk3zyDkew4tNq/ebfX03I4
	 tssGQxJLqZV5QMVCIDfpRWNdQj1Mw+24n5T3NEr5akd82SirNpvwl+U1E3KhFzxYgu
	 UtWXNNRDnww1DTMxFFUM44H6PJxS83Y/svLIQSTk=
Date: Thu, 16 Jan 2025 16:39:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <2025011643-cymbal-gruffly-d83d@gregkh>
References: <20250116152152.147048-1-andriy.shevchenko@linux.intel.com>
 <2025011605-splashed-giddy-0289@gregkh>
 <Z4kmh6YHkNUGFnMK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kmh6YHkNUGFnMK@smile.fi.intel.com>

On Thu, Jan 16, 2025 at 05:32:23PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 16, 2025 at 04:24:16PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 16, 2025 at 05:21:51PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > >  #ifdef CONFIG_PM
> > >  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
> > > -#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
> > > -#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, "ns")
> > >  #else
> > >  #define _EXPORT_DEV_PM_OPS(name, license, ns)		_DISCARD_PM_OPS(name, license, ns)
> > > -#define EXPORT_PM_FN_GPL(name)
> > > -#define EXPORT_PM_FN_NS_GPL(name, ns)
> > 
> > Why not start using them instead?
> 
> I tried and they didn't produce what we want (code elimination for
> the CONFIG_PM=n).

Ok, then please say that in the changelog text.

thanks,

greg k-h

