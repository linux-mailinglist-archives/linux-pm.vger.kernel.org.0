Return-Path: <linux-pm+bounces-22083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FFA35DE5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70624188F790
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6554230D1E;
	Fri, 14 Feb 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpuYzaRQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4920C00B;
	Fri, 14 Feb 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537583; cv=none; b=V/7aYeamrIwsbVarmhGyFGY+0OksLxTLD/JgvAaFppmPCnUv56DkoX9f+m47AdyiJ4nt00DvZ3c6fuIWsVTNbhYxvwOiNzB0DkCmzFx/xV4HbMSdmJlDQgnNIX0FRyTaOV3vB4O45BPxghDNJbLpNw45baWfzfVa1LWdbTo9/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537583; c=relaxed/simple;
	bh=9ejsueg7AZeHeRrozATskzwELiZK9By16Q2aGUm6HLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQW8RwPDeheCgfQdg9kKptTzJnrEVxai7PXUd2l36MSd0uIjE3nCPmGzdMNJ3GTVnPdgqP9RA9rrS1Ha5j89pjzxdbbohwvlZzJ+80ay23quUuo2Kr0MQR3ziixw3JycZVMqbvKCIrSlG1whnHXgAgx0M51w/F+wmxMaMVTYeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpuYzaRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911FC4CED1;
	Fri, 14 Feb 2025 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537583;
	bh=9ejsueg7AZeHeRrozATskzwELiZK9By16Q2aGUm6HLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpuYzaRQGKxX8p3ZBYd6f/v0skISdTN9CYpROzXUd2S/H6kPzb4aeMYNFTLX7VBs1
	 XTDmqPcd8XinL+OWrmcELEfLFd2ZpCVA/q0Nsi68l8bgXmKyS2TnkoZcVS+R5sqV3s
	 LoIYEUoT9fjpCzKHzdHwMV/S3v/IH5ybE0/DBldLwmb7Ycqm1+YOPM55Fd5Dv2h3Hq
	 qCr63M0ieVn95aa3cEyJlh3cehb7XUGv0Hqzm0r+IDlQQIIQV7qjuAAz6vtegJZ0qA
	 FYZuHLVz9SfxnE5+XOH96nqGunaIJ5c2OXk7YbCdnVA3Bqjg2QRFC2mDmyQC+D628j
	 YFG7232qNgIow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tivBw-000000000p3-193H;
	Fri, 14 Feb 2025 13:53:13 +0100
Date: Fri, 14 Feb 2025 13:53:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
Message-ID: <Z688uKdqVDaQhm5V@hovoldconsulting.com>
References: <20250214102130.3000-1-johan+linaro@kernel.org>
 <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>

On Fri, Feb 14, 2025 at 01:36:48PM +0100, Ulf Hansson wrote:
> On Fri, 14 Feb 2025 at 11:21, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The simple-pm-bus driver only enables runtime PM for some buses
> > ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> > pm_runtime_force_resume() during system suspend unconditionally.
> >
> > This currently works, but that is not obvious and depends on
> > implementation details which may change at some point.
> >
> > Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> > and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> > future surprises.
> >
> > Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")
> 
> This doesn't look like it is needed to me. It isn't broken, right?

I didn't add a CC stable tag since this currently works, but I still
consider it a bug to call these helpers unconditionally when not using
runtime PM.

[ And during rc1 these callbacks were suddenly called and triggered a
NULL-pointer dereference as you know. [1] ]

Johan

[1] https://lore.kernel.org/lkml/Z6YcjFBWAVVVANf2@hovoldconsulting.com/

