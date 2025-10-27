Return-Path: <linux-pm+bounces-36915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5593C0E18E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AED0D4F4F32
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E12737E0;
	Mon, 27 Oct 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="doTz7BiH"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3E223DF6;
	Mon, 27 Oct 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572093; cv=none; b=rNFDimJxHejcoxFu1c3b/UwpFuL/a3gOtKwixO88/rr4gj0LosyKuMZDcPzE3CiuayDpjvGZt7zGvdpTsZwyBkcWisLX9IciR97Ukl83h1I6GvtmCOOokzZdwl3uLIoVQYFqS4awWuzQMMvIVXXvkgSzsqzYL/X9C6Uvf5NIaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572093; c=relaxed/simple;
	bh=9VsNKH48ReBO72Un3UkY8t0uUYfuoyWe+CVfv/ezo8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcQ/tPGpGMfpvBpnV1hW7A1HwObm0Zocg34CmyearfGQyBEWZFp8OjcvS2EKvdmdJliNgq4wzXQe5CLcuMZG6V0o7P5I38rC7QldLNT2imLpgD4qm5mMkdcHPUbaeuP1mx2OvD6tgtGCfWpnS3sQ+fyBa6wsHzyzfeY/NgKn8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=doTz7BiH; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=FCv+dqvI3maIG+5BMD6tWXqw54hjChMOqdKu2w6RxCQ=; b=doTz7BiHKAV68V9mLQoNkeTWn3
	tZG46n6g8lMx0xIYE9pVPyqG3b4TtAD4mu0u1d8tS8q+ts7yszvyHUvRUXzV6VSHh1tTxrcyYc4SX
	bqjWqvkQOExysQBvnsr5MhFJBjjpGoYNuZSsZ8ayNA0Gdo8OLmHT/7v19kTSvv6FsJP4wo37T0HUK
	1tpKyvr9XVcbwbvuHnLadItl/LE6w9lnwAZZMdYD/xa4c6eviingRVp9O69BdNYzdwkve9VqRtwOG
	yLoDE0iOvU8crVbzx1Rek6AJY0qEIcbgnvoXwc4021JdvocJMQ58kw3wCnfDP3Elq8zvXj9ko904S
	qviSGMRg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vDNMo-006zVe-1e;
	Mon, 27 Oct 2025 14:34:34 +0100
Date: Mon, 27 Oct 2025 14:34:33 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yixun Lan <dlan@gentoo.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Andreas Schwab <schwab@suse.de>, Yao Zi <ziyao@disroot.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aP906fAZZfFXp-2D@aurel32.net>
Mail-Followup-To: Yixun Lan <dlan@gentoo.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Andreas Schwab <schwab@suse.de>, Yao Zi <ziyao@disroot.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8QHwsYDlbQxQJo@pie>
 <mvmh5vk67in.fsf@suse.de>
 <aP86TltQ2uqeK6FY@pie>
 <CAJM55Z9w0pnFmVjJKJNMs1iqOxoL=YpkBu0L7NuUZ_0ipMtQAQ@mail.gmail.com>
 <20251027103147-GYA1541054@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027103147-GYA1541054@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-10-27 18:31, Yixun Lan wrote:
> Hi 
> 
> On 03:17 Mon 27 Oct     , Emil Renner Berthing wrote:
> > Quoting Yao Zi (2025-10-27 10:24:30)
> > > On Mon, Oct 27, 2025 at 10:03:44AM +0100, Andreas Schwab wrote:
> > > > On Okt 27 2025, Yao Zi wrote:
> > > > > On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
> > > > >> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > > > >> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > > >> > index 8248895ca9038..61c16f3d5abc7 100644
> > > > >> > --- a/drivers/power/reset/Kconfig
> > > > >> > +++ b/drivers/power/reset/Kconfig
> > > > >> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > > > >> >          help
> > > > >> >            Reboot support for the KEYSTONE SoCs.
> > > > >> >
> > > > >> > +config POWER_RESET_SPACEMIT_P1
> > > > >> > +        tristate "SpacemiT P1 poweroff and reset driver"
> > > > >> > +        depends on ARCH_SPACEMIT || COMPILE_TEST
> > > > >> > +        depends on MFD_SPACEMIT_P1
> > > > >> > +        default m
> > > > >> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
> > > > >> I believe that reboot and shutdown are actually essential functionalities,
> > > > >> so it might make more sense: default ARCH_SPACEMIT?
> > > > >
> > > > > I don't think there's anything preventing it to be built as module by
> > > > > default: even though it's "essential", it's unnecessary during kernel
> > > > > and userspace startup, thus I see no reason to build it in the image.
> > > >
> > > > Wouldn't it be needed in a reboot-on-panic situation?
> > >
> > > Oops, yeah, I missed this stuff. Seems systemd automatic boot assessment
> > > could switch to another boot option if one fails to boot. And if it's
> > > caused by a (very early) kernel panic, then reboot support does play a
> > > part here.
> > 
> > But if systemd is running then you've at least got as far as the initramfs,
> > and have the module available. So I don't see the problem.
> > 
> In rare case, if got kernel panic before load this module, then we
> should really fix it instead.. Besides, there is no restriction to prevent
> user to make this driver as built-in, right?
> 
> So I think this isn't really a big problem either

A possible compromise here might be to use "default MFD_SPACEMIT_P1". 
This would defer the decision to another level, but I think it makes 
sense to have all parts of the MFD either built-in or as modules.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

