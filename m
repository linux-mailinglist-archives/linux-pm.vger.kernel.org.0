Return-Path: <linux-pm+bounces-36665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B520BFD5FF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A0918C3B33
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5826F2A1;
	Wed, 22 Oct 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="NtR8svfE"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC635B132;
	Wed, 22 Oct 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151746; cv=none; b=q6IzBEnQSvyvkFuExqJrBucRhhXf1vpyg7/nobVdm2xHy1wIeaB/m8+ECPSfkmdgbO+jQ2fMPQP040iutsBMZj847YMYU7RkquUio8c9q/zLtQd44B9TgX/ma7zqPCBg0QaIDgGR6CcjgcW+MJxssENfAUXZvTBUM4MDIwa2o/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151746; c=relaxed/simple;
	bh=1Rzg1NYP1bG8uFJYlhbNXfg2908d4g/zk1tZMg9XMTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQKBqVfvZgvgWG8wr6s4/yeAXWHI6cGKhh2G/rOOvw67MpVUdaRl6SRs94IsXjenicbCE2K/Ip3+qIBVdytJG0hWldZ4RaGH0/WjjSsu+hHheQ9Y/8T+TWnI62V0DW/hpuJDPKS+vgnYygVBso6Bie3R2ju/vdKDYSVoCa1/5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=NtR8svfE; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=1nnTTQGLKpg2Y4zlHS/zCgkMJs42TpDEsJXY1zhm+kM=; b=NtR8svfECruwcJup56bQs5SOZR
	GSG9JZvkRgw08/1tQ7KRuGSchIL8sCR1vKcjUnjjdfOYgJn9mJmS8T2l8weWJxj1JrPcQaMr0dom9
	rW/zi599vslZV7xW0lPrZnyZ/KIGZsFnKzThIXlB7gtYUcvCRhsul4lqlNfIoFCFm7HDxBi6ed2tJ
	0B9kuB3OPw0jwENFYVqp5XMvqqhpC4nTIlWT9CNIKNFlhG0U+rndTeod+7MZSe6Ku/FE+CnXQgk29
	zlivSvW3jiyH5mV+2MYtrBvFGDPRIsWizpmAQwMQeae9ezHZvjrkAZ5kS39/KJL6uSMhlnzv9JtI3
	+yI5AVcg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vBc11-000AgZ-0O;
	Wed, 22 Oct 2025 18:48:47 +0200
Date: Wed, 22 Oct 2025 18:48:45 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <aPkK7aEHhxKScoCN@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
 <20251021201451.1013640-2-aurelien@aurel32.net>
 <20251022004830-GYB1522542@gentoo.org>
 <aPhtd0j6iBpqiGUQ@aurel32.net>
 <52468F28CD7B50FD+aPhurJD4HTXqIGDT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52468F28CD7B50FD+aPhurJD4HTXqIGDT@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-10-22 13:42, Troy Mitchell wrote:
> > > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > > index 8248895ca9038..6577d73edbda4 100644
> > > > --- a/drivers/power/reset/Kconfig
> > > > +++ b/drivers/power/reset/Kconfig
> > > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > > >  	help
> > > >  	  Reboot support for the KEYSTONE SoCs.
> > > >  
> > > > +config POWER_RESET_SPACEMIT_P1
> > > > +	tristate "SpacemiT P1 poweroff and reset driver"
> > > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > > ..
> > > > +	select MFD_SPACEMIT_P1
> > > I'd suggest to use "depends on" instead of "select", the reason is that
> > > using "select" will sometimes ignore the dependency, considering
> > > the reset driver here is tightly coupled with P1, so I think it's 
> > > reasonable to switch to use "depends on", also refer below link
> > > 
> > > https://lxr.linux.no/#linux+v6.7.1/Documentation/kbuild/kconfig-language.rst#L144
> > > 
> > >         select should be used with care. select will force
> > >         a symbol to a value without visiting the dependencies.
> > >         By abusing select you are able to select a symbol FOO even
> > >         if FOO depends on BAR that is not set.
> > >         In general use select only for non-visible symbols
> > >         (no prompts anywhere) and for symbols with no dependencies.
> > >         That will limit the usefulness but on the other hand avoid
> > >         the illegal configurations all over.
> > 
> > Thanks for the pointer, I'll fix that in the next version. I used 
> > REGULATOR_SPACEMIT_P1 and RTC_DRV_SPACEMIT_P1 as examples, they'll also 
> > need to be fixed.
> Yes, I have said here[1].
> Do you want to fix that? If you don't have time, I can do it.

For the reboot patch series, I'll do that in the v4, but I would 
appreciate if you can do it for the PMIC and RTC drivers. I guess it can 
be a patch series with the first patch being the one you already posted.

> > Note also that without the select, a default value has to be added to 
> > MFD_SPACEMIT_P1. 
> Yes, I will add it in my patch. Thanks.

Thanks.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

