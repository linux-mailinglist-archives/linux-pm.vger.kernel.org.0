Return-Path: <linux-pm+bounces-36916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32332C0E3E9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 15:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B95004BB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2530147E;
	Mon, 27 Oct 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UxWmaxyU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237024DCEF;
	Mon, 27 Oct 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573446; cv=none; b=i8gw4AwN4WS24ltwZlLhz5LN/JSYqlQDZRjRfLoQqswLn/INDeLQ1Rlt7dHDhVqMYMlaxKT9HH5UwaN0c8x62PVgKcp0T2TYCaTTaaqYSF6T97ghHmzbR3YyuQO83pX56Ny4WdqTqUo5tc5lIdOJ4FHnYI+DflN6VWIkMlvWayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573446; c=relaxed/simple;
	bh=FMYpihiQvFiI/NsGZPv8NF/yKtgNXE0Gdue0oLn+0xQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwbRHnSxaYP5+ig+X6y3MOM00I0NrNK4LysJ0H6B3QqXaW1HIkALr38q7k9EQzM7cdCFSCWfufP5fx6l0MW1D6JR7ph7kelzdyA3n6iStPuo1L5F4OqsnQ8fiTa1cOHym9dNU47vnR//lybqD6lZ9b/2a+VUiBMsmR03nxl5jcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UxWmaxyU; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761573425;
	bh=GOXJjc2R6gLa1S92DIipgJyO9ajzHcGqwyH0ghoII7E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=UxWmaxyUPyF5729L823AUNUkLnl/a5Fqg2XtdYzmb+Ba71DDr7PEOB5xCiLb7aeHC
	 cuvEnVb/RhT8enXobX04x/lyvVD6vdXuY3QwVFfBleIGTdJBKI2WqOwUMrZFpxPU0k
	 aOI7s3+Ir8Nh9Wk+g6YwwmnjZD6sdXzqJt6ZtyUM=
X-QQ-mid: zesmtpip2t1761573420te99bac9d
X-QQ-Originating-IP: x1+tmePdSRc0FAZX9Ga7DFEbiQ13Tyh9xloMBXd4/2o=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 21:56:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14346178185621163239
EX-QQ-RecipientCnt: 15
Date: Mon, 27 Oct 2025 21:56:58 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
Message-ID: <DAA41086C5EBCCFD+aP96KqT06FswX1uN@troy-wujie14pro-arch>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8QHwsYDlbQxQJo@pie>
 <mvmh5vk67in.fsf@suse.de>
 <aP86TltQ2uqeK6FY@pie>
 <CAJM55Z9w0pnFmVjJKJNMs1iqOxoL=YpkBu0L7NuUZ_0ipMtQAQ@mail.gmail.com>
 <20251027103147-GYA1541054@gentoo.org>
 <aP906fAZZfFXp-2D@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP906fAZZfFXp-2D@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: METBPFwEUDZ+Q4LaD7aOIDb5kTZzutCbw9FTL72zaXAtJYVZORmcRWZI
	4OHS4TsPLT6B34qbZwbKfpPsj5+Q3tbmLePv9sDMRmDzKV+mx6uICkfwVDn5EEBO8yteEee
	sQPvf4ghhd4cY7ysEdrvj+vb8xs760kzdo6pUs3c0GV3+vBLJVdXGXchHEJhZR2DI40C0Cu
	Y2BkKOujlhsUDbYL9zjN7BbIFiO24/4Pmga6VTiJrWCZL1Vo57i3XnMBh7dFJo2d/604y4/
	zb4ZdfMSGVNs22BfHPAxBsyJ5lRWF3qAqJh+LHwdtkXveRKSKPGLdfNSAzTMIPyyIp0lYbc
	VZwZsac015VbtIC9FfmN/ZzHWyIc9Y5HVL3ra9lsBOfrlTD0uz8Xi6B7xSnhA8o33mai7Zw
	lB5YD1RCQ3j5DTI6rKvVKtmYST8DgnvcISxSP6z25euzLkrHxMVFtr7juPreANU21i05+zh
	2xc4+74mo+cIaePnzfxUvGkMe1coZgGZgVVGs/IWj/xQbXvU7ik6Wr84O7/LftKiDMf2Pbn
	xmVkMYyPL9sXfofYEeAj955QvUqxPyi/Mqj7z+srBlUSgYFpgKS2PaRUvbDMKICfPzrTcFX
	AuT8Pr30tQLwWcjZXJsVryf2P3hyEkaaKxrT4OZTVSkFrvyFu1s+9qMscMvnEXx8nMc+aCY
	bHjtFCkPPYbvCa9R0mJf/Qfop9Whz9elrquZ058HnOJz7qE/4Zxi6BmYpQ/xl9GKzj9I02B
	OYkDRmbzuzg10pGs5foWqBxcEIUotRdlNgGkHenak0CbaHVmRWKPhgzVYOSxrbMm7CELdO+
	TRz0rFX1etXa2dPI4Eolosni7izMXMwZvXPGDySukwCo1ABtqjlUMOQIkOZtKSfEZ6YVoxd
	P1FHrWFyqO2tExusZd/Q9nxPwHNJHedDoS5yn31+hlPRCtP5l0F5y/WqX3AqPppZxPkaeyM
	NiKXQldTTcaM3/GBbXzOE0gmcmBatjR6rAZ3T0BuI0RMfcUIsi0GN1OuTooWU9wdnuFuctu
	uljw+SW/1ZVF7dSxZ1keFCD0CmeWElPLKVaKuWQeas9S+Z1iB6rpm00ljVd0Z7cKT2U3PJ+
	YfV+I356HRnSPZSFgoMhVjI6ZYmjPckQJj0uDes/GuB66IYMMQ0hSxx3cpdYq1EIlArlCUF
	q+oZ6I1pXbU4fvb84th45j9eXhNPaspidPG6
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 02:34:33PM +0100, Aurelien Jarno wrote:
> On 2025-10-27 18:31, Yixun Lan wrote:
> > Hi 
> > 
> > On 03:17 Mon 27 Oct     , Emil Renner Berthing wrote:
> > > Quoting Yao Zi (2025-10-27 10:24:30)
> > > > On Mon, Oct 27, 2025 at 10:03:44AM +0100, Andreas Schwab wrote:
> > > > > On Okt 27 2025, Yao Zi wrote:
> > > > > > On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
> > > > > >> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > > > > >> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > > > >> > index 8248895ca9038..61c16f3d5abc7 100644
> > > > > >> > --- a/drivers/power/reset/Kconfig
> > > > > >> > +++ b/drivers/power/reset/Kconfig
> > > > > >> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > > > > >> >          help
> > > > > >> >            Reboot support for the KEYSTONE SoCs.
> > > > > >> >
> > > > > >> > +config POWER_RESET_SPACEMIT_P1
> > > > > >> > +        tristate "SpacemiT P1 poweroff and reset driver"
> > > > > >> > +        depends on ARCH_SPACEMIT || COMPILE_TEST
> > > > > >> > +        depends on MFD_SPACEMIT_P1
> > > > > >> > +        default m
> > > > > >> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
> > > > > >> I believe that reboot and shutdown are actually essential functionalities,
> > > > > >> so it might make more sense: default ARCH_SPACEMIT?
> > > > > >
> > > > > > I don't think there's anything preventing it to be built as module by
> > > > > > default: even though it's "essential", it's unnecessary during kernel
> > > > > > and userspace startup, thus I see no reason to build it in the image.
> > > > >
> > > > > Wouldn't it be needed in a reboot-on-panic situation?
> > > >
> > > > Oops, yeah, I missed this stuff. Seems systemd automatic boot assessment
> > > > could switch to another boot option if one fails to boot. And if it's
> > > > caused by a (very early) kernel panic, then reboot support does play a
> > > > part here.
> > > 
> > > But if systemd is running then you've at least got as far as the initramfs,
> > > and have the module available. So I don't see the problem.
> > > 
> > In rare case, if got kernel panic before load this module, then we
> > should really fix it instead.. Besides, there is no restriction to prevent
> > user to make this driver as built-in, right?
> > 
> > So I think this isn't really a big problem either
> 
> A possible compromise here might be to use "default MFD_SPACEMIT_P1". 
> This would defer the decision to another level, but I think it makes 
> sense to have all parts of the MFD either built-in or as modules.
I think both the regulator and shutdown/reboot drivers should be
`default MFD_SPACEMIT_P1`.

Otherwise, enabling MFD_SPACEMIT_P1 alone doesn't make much sense,
right?

                              - Troy
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

