Return-Path: <linux-pm+bounces-13406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792B969A77
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4961C236CA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7A1B9859;
	Tue,  3 Sep 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/AB6W0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7951A3AA3;
	Tue,  3 Sep 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360165; cv=none; b=lXadMu24nRC45vMfBnCxlwZTKjNSnaltkhtZ2e31IOqwZ3A3kSdzS05vAWq5Op/iyCTkZW9XrF1Cn+Mk+fiKPn350DS289gFAOE4fsXAPE1PMjzjeaXB5LdgNJLmFrAZvKHHNIr4Kh1qhW5vzso74cc2HHbgBdE/++fucyzl22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360165; c=relaxed/simple;
	bh=ezxVlGdqbmTlfY+8KcIKlvZcCYG5xIM2gov7g8QDlgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCD7RcxSxc5qr4qcfLwcGas4Vv6xrGmGXqyd2dLhTIevVp/N/Yg9UjNwsra3W5CJCapEArfZ57krJ0Yw4rwQp3ah2obJ+SsY0LtgmCWzTAfiV5gpZl7bwkBzVJBPc2K8krwL0vtm8WUFkjopmXIURMYxHbBaAwCvodtuWUFD6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/AB6W0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6359DC4CEC4;
	Tue,  3 Sep 2024 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360164;
	bh=ezxVlGdqbmTlfY+8KcIKlvZcCYG5xIM2gov7g8QDlgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/AB6W0K5VYMLA3QJ0KwBaUxudD+N94DrLDpUTsYNs2S7WxNpnozPWfEotC/oOosh
	 l/Rd2bNay8EASQFjfJZeDU+NAm/97L3/lGlDaPJvvFVk3Jf/B1JT+MBUy80dvQHZKV
	 mSS4U1tfa6zBYrIJb9MKevEM0YvyKGlm2LNP1IYo=
Date: Tue, 3 Sep 2024 12:23:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Wang <00107082@163.com>
Cc: rafael@kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks
 is set
Message-ID: <2024090347-latter-collide-772a@gregkh>
References: <20240902125933.5742-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902125933.5742-1-00107082@163.com>

On Mon, Sep 02, 2024 at 08:59:33PM +0800, David Wang wrote:
> When resume, a parent device with no pm callbacks
> would have "is_prepared" and "direct_complete" bit
> set, and skip the "fib" chance to unset "is_prepared"
> in device_resume because of the direct_complete bit.
> This will trigger a kernel warning when resume its child
> For example, when suspend system with an USB webcam
> opened, following warning would show up during resume:
> 
>  >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
>  >..
>  >ep_81: PM: parent 3-1.1:1.1 should not be sleeping
> 
> The device parenting relationships are:
> [usb 3-1.1] << [uvcvideo 3-1.1:1.1] << [ep_81].
> When resume, since the virtual [uvcvideo 3-1.1:1.1] device
> has no pm callbacks, it would not clear "is_prepared"
> once set.  Then, when resume [ep_81], pm module would
> yield a warn seeing [ep_81]'s parent [uvcvideo 3-1.1:1.1]
> having "is_prepared".
> 
> Do not set "is_prepared" for virtual devices having
> no pm callbacks can clear those kernel warnings.
> 
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  drivers/base/power/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h

