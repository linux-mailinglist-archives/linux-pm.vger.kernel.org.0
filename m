Return-Path: <linux-pm+bounces-36624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54947BFA187
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 07:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C253F188264D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12C2EF654;
	Wed, 22 Oct 2025 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SegtPXpW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C62EC54E
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 05:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111738; cv=none; b=VAwfC1tjXUXMslXU7jUx06Tfg1w07SFd1m7UKq8O28h2edtqHDxrWD9N6E0kJnsd6qIZd6idGURvOuh8MwxZrOn7Ow0VQuoQfcGA1y/z0to/Stos4o0P3XaUFDJpcx2mfSrY9Ojb8N3yLiDpIaFqF6/hXTbstJrb1BjTxNMF23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111738; c=relaxed/simple;
	bh=Ip7I2oKx+cUmVaYf0SMRJxuVfNJW+zHyD80hJta800c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq7gNC866CNiwRx/dIAzsAh7XdIw9r072vrApBtj2Ez8rWDqzCT3aemI2VFUkeAZHU6E1LPTuD330cQsZ4cP5NMgNWGHmQzRhRzO79ZTzx1K1OHnkptcyMVIiDAVZx0WD53IBXj1K1L3Tzi2ZaMy/ezpjTLU3gAfl6XZtSd8usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SegtPXpW; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761111727;
	bh=2SLeXGDW3QlALU6I3vpBIG1DJuO1fm4ZApuKV65CGdI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=SegtPXpW51/lDFjLkmbFTKcp8WOg+Kx7zRr4jK74xY2ZuUyMI2ny29fqFCuXaZEY4
	 WG3VS0RsIJRtwqGwGlAzfJwFS+4hZY/i956gnHfKLolNcgXznjHv944yzDf+HKNoGV
	 KsS7gZ1UhJMiBpNiQYT2JDMB+vjh44WMIXOLusUE=
X-QQ-mid: esmtpgz15t1761111725t9381ce62
X-QQ-Originating-IP: 731FWEj5minQ81tpITCfvoBW2wAz+Y/YGXcnH39jcE8=
Received: from = ( [14.123.255.147])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 13:42:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5196498867470666752
EX-QQ-RecipientCnt: 12
Date: Wed, 22 Oct 2025 13:42:04 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <52468F28CD7B50FD+aPhurJD4HTXqIGDT@kernel.org>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
 <20251021201451.1013640-2-aurelien@aurel32.net>
 <20251022004830-GYB1522542@gentoo.org>
 <aPhtd0j6iBpqiGUQ@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPhtd0j6iBpqiGUQ@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NqN/wpVFVRYXUPmS2RiyfcIo7i7XceT881aAId2QLGZ0ZsUoydn/l2rk
	NUu0OkkYtWQt3PCCoT5S+2kyp5acUrk/LK3zef1u5leLcUPq5PW2Yz5uFGTTifdJdxIWLFC
	nEOMTOV+xExd+AaiQkXZfPZmADT+6NdAlKbnis9IR+MG0HM1ye//34tXkEwzQAPlpH5oyiB
	VU1K/t97QpWXDw+0Qy+ABht0zkzth5rSwUK9lE7PSj65nIagVtpPUwDRyyRmtHlr3OwN2/a
	zWY/Pe/8AdHNjUTLwRv1KPH59bgX8KMiVgJFSdYS3it9zgjTkyohs/eAgPYIWyJukwgAFPf
	VaEXSWuQC2HacUPf/V1ZCRyqOkZm5z26BaZ4EHB5UTW2p6QrWRDS7byFPkrBdO34aK2cdF1
	2HetV6JRHU8YgqiA9zfvRRBTgJ50LTbbomHCPYBF4QFmF1eS2MFjlLEKrtx8uTuWyYk309V
	b5zoGxfozZNXmkXPeJizirtcZB8jjGqbv9fn9YhYxzIeSllgsJpcMt6ZX7su67nHYAWakOY
	3UeH14ryjw/dS8apX1EO7CTFbyrlp1QoME9gV4pKOMjE0woeMviyO65TmIZdDWE/XxbKzh+
	HxuwT3uHGjIvs+7wXePio+BQU60/vIjQ578By5C3Plgb3TWatkHl4kJBm0D1dwD7hOxxKjH
	pGmq2hYlFQohsETyT14rudyVc27Bq19dc2mL0U5BMYhoEBv3YA/xiXRsBifLPMTBezfuSgW
	bPW/oBQdmckSw8Mqgk9vo3ccAEuOvFubdtD1oQRtHCFGJ81OyMtVOHqPlgdAh/7ZHE61TX2
	0+GeErzsgeu6KyxffnTVY148/2sJUxK0lJDQkYN0isI1ZuZjfa1qmxtYUzX26AVknx3K6Yy
	m9H6qJqeGQEQKB3FVe7AWvmSCGQxZO+jDuulwbmjeSAA1k2ofT6/JvyKjVtisopc6+ewJ3V
	WIFvhwADS3MX9rJg0Iwqv7uxWpHY1WlqX4HFFy2UP+StmKTgwewzsI4XPSAu97fTs2kf9Nk
	EqVDtNYodEohUzA2etIOi6uQ0E67Hf3Qa3DDtXU8neCTz0Rns5lcOZ7K9VXwFojQeI8egGQ
	zUv/9GAGXw6vBqA09yscmY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index 8248895ca9038..6577d73edbda4 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >  	help
> > >  	  Reboot support for the KEYSTONE SoCs.
> > >  
> > > +config POWER_RESET_SPACEMIT_P1
> > > +	tristate "SpacemiT P1 poweroff and reset driver"
> > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > ..
> > > +	select MFD_SPACEMIT_P1
> > I'd suggest to use "depends on" instead of "select", the reason is that
> > using "select" will sometimes ignore the dependency, considering
> > the reset driver here is tightly coupled with P1, so I think it's 
> > reasonable to switch to use "depends on", also refer below link
> > 
> > https://lxr.linux.no/#linux+v6.7.1/Documentation/kbuild/kconfig-language.rst#L144
> > 
> >         select should be used with care. select will force
> >         a symbol to a value without visiting the dependencies.
> >         By abusing select you are able to select a symbol FOO even
> >         if FOO depends on BAR that is not set.
> >         In general use select only for non-visible symbols
> >         (no prompts anywhere) and for symbols with no dependencies.
> >         That will limit the usefulness but on the other hand avoid
> >         the illegal configurations all over.
> 
> Thanks for the pointer, I'll fix that in the next version. I used 
> REGULATOR_SPACEMIT_P1 and RTC_DRV_SPACEMIT_P1 as examples, they'll also 
> need to be fixed.
Yes, I have said here[1].
Do you want to fix that? If you don't have time, I can do it.

> 
> Note also that without the select, a default value has to be added to 
> MFD_SPACEMIT_P1. 
Yes, I will add it in my patch. Thanks.

                  - Troy

Link: https://lore.kernel.org/all/6DB8C5F20B3FAC2E+aPhfoRXlJtJymlB5@kernel.org/ [1]

> otherwise this makes the default values on the 
> regulator, rtc and reboot drivers useless.
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

