Return-Path: <linux-pm+bounces-26232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFEAA9CDF9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0808E1BC01B0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF819CD01;
	Fri, 25 Apr 2025 16:22:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191F4A24
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598138; cv=none; b=QDVa1zJxWtV6e3EOTWvGvRRXJu4rn4mXeUYAMotSJG6ZHF2SUlGpq66oU/CLVz2VNE+xY5DgUhnD1amIHeZ2S/sEb+aWetuGtP7/XVz54nHC4vIRtLjiNcodyRnRsVLqkuZDxJgIYgf7kFZo2g63O7w1kDUPmunSobclKofBwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598138; c=relaxed/simple;
	bh=Lwl/ZpYN3ZShr7xLd2q+gTATHtLxFH5YaBYsLh28L3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPCfJCpB0vFG+cFr6+yfIHVKDY/RAVv6TzcVzhBlraJnJRdYm/YVO6j10T9dD/l8m3Fo9RaKOgLitADrfDCRndt8QBrfd5Vk94Q8iwK/35gxdy7el9PLm2vPucUZEjURHfIJgQdKvaNcd3gmeimkYIbqiq2t3bjhj8HZ/6wuKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 16D30200A44B;
	Fri, 25 Apr 2025 18:21:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A4B8DB1FCB; Fri, 25 Apr 2025 18:22:05 +0200 (CEST)
Date: Fri, 25 Apr 2025 18:22:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: James Dutton <james.dutton@gmail.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: USB4 thunderbolt device suspend/resume problems. Unplug during
 suspend.
Message-ID: <aAu2reEG9RHjRjL9@wunner.de>
References: <CAAMvbhGRBhdz2RnReoGxDRM=bTws6s4qe5kh2nUqQDMRDYBh6Q@mail.gmail.com>
 <Z9NDz7TUIEflQeee@wunner.de>
 <CAAMvbhEOLmSm97rzLKgjNV=7Uy8UspPAS1vc4W3xv5F_b6PNaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhEOLmSm97rzLKgjNV=7Uy8UspPAS1vc4W3xv5F_b6PNaQ@mail.gmail.com>

On Sat, Mar 22, 2025 at 01:38:34PM +0000, James Dutton wrote:
> > On Mon, Feb 17, 2025 at 08:44:19PM +0000, James Dutton wrote:
> > > I have a thunderbolt / usb4 10Gbps ethernet adapter.
> > > While plugged in, it appears to handle suspend and resume OK.
> > > The problem is the following:
> > > 1) Thunderbolt device plugged in. Device appears in "lscpi".
> > > 2) Suspend Laptop
> > > 3) Unplug the device while it is asleep.
> > > 4) Resume the Laptop
> > > 5) Laptop locks up, no stack trace, nothing output.
> 
> I found something that worked for me.
> I found an infinite loop and adding a timeout to it fixed my problem:
> E.g.
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6840,8 +6841,16 @@ void napi_disable(struct napi_struct *n)
>         do {
>                 while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>                         usleep_range(20, 200);
> +                       loop_counter++;
> +                       if (loop_counter > 625) {
> +                               break;
> +                       }
>                         val = READ_ONCE(n->state);
>                 }
> +               if (loop_counter > 625) {
> +                       pr_warn("dev.c:napi_disable() timed out\n");
> +                       break;
> +               }
> 
>                 new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
>                 new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);

I'm afraid that's a hack, not a proper fix.  You can insert a call
to "dump_stack();" before the "break;" to see where the call to
napi_disable() is coming from.

It seems the driver of the network adapter built into the dock
gets confused if the adapter is no longer present on resume.
It would be good if you could report this to the maintainers of that
driver and/or netdev maintainers, as well as netdev@vger.kernel.org.

Thanks,

Lukas

