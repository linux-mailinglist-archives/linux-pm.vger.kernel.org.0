Return-Path: <linux-pm+bounces-37490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FBC38A88
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07593B4281
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599186334;
	Thu,  6 Nov 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ZZFO94vM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30441F92E;
	Thu,  6 Nov 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391054; cv=none; b=WQEl+c+gf87GR0AOAICSeVGN0rHmgktEb44g4m8oNnFivAyLzah+2/wItQsV48lWqQDRvolDvdT4vLoejBy7NFC5qGPXlrtbG0LMWOu3DXWNNEfwgi5kBDmB2SmsL1jrTfs3m/+Pc4FxlwSGftyki5hVmutEhpkWMGSgdsFqOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391054; c=relaxed/simple;
	bh=NXdLgx5++w/rfA9Dm6V03ZycL3uKzY//ob28ovmREGU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjxyNY3ho0x/G8e41CN7FnqpOf73D23LksRljSct5fDuI+pQMNQuFaMertjBpCHwFIMa4/mQAMdHkH9SLlawZKrnbwdxqvSA9DX6KFIhG810ScOs2rr7QjVAcx4cmXeYxDjWtHBvX/uAXfHBGsULzF4kP3JvNXCr0nKQGJltSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ZZFO94vM; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762391046;
	bh=vyp2Kx+dt44hfjvf5608tzCtPl9ysFpd/507p9pCYdE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ZZFO94vMkZdRiCGsPGzyw4WwW0sb8IC9loiNm//sNjLZoozb97T0J60dlIORLKP2g
	 P3dILgMC/StmRswHt1hrv8hYNAYob3v8u7tPGJ3xMElS8/JQgrwHt4t3LKYIh31T1c
	 bWNlZa1W45YQaGfwXljd4xD4ZX6NY47IXYfClgSE=
X-QQ-mid: esmtpsz11t1762391034tcbbad8ae
X-QQ-Originating-IP: l788y3NbUzY9RphsrdxIwMifswNmTWK4vbzwWT5nAzU=
Received: from = ( [183.48.244.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 09:03:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14392221022385016133
EX-QQ-RecipientCnt: 13
Date: Thu, 6 Nov 2025 09:03:52 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <751C70A7BC663B0E+aQvz-ASa-z4fvGiO@kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <aQvUgQvM48LsSzei@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQvUgQvM48LsSzei@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NMrHzUX/XDgGcXbTbgnoXRamGUBywrH2fIQFaRhhouU0+j3gEdOH8KbQ
	D/ymB7Gbb6IIOH5LVL1ydh5rO0vzGcfuE9hIAURwStdi7MjCzPQ/5zfIZP/iGIDzJJjf3Wf
	DeeGSb2GilZ71g8qith6GWDy2+3z3cjy4phxr5Qsjvvz/tcBRJbbTHzB4I/BcZTtL7mr9eG
	z7JdjaDvK03+rUIR28Afk+U3wE7LxuWWmoTAKifpDIPD9/FK7hEb3tGmGPleeLU2rW8F/RK
	Vyt2AUWzImR3DqMzp4UAL5eNwEeJYSCJD0JtxZ3MPo/IW8MgzemBFUn0EJranHfsQZmOxyN
	Ruk41TMBn7JuA0kJ9KQEQsgzALo43Bve/5PWtfQR0oPWF6aBaTbM/H2KnvD/I5eU12BGk4s
	E5ji0biq0UeEPROFm1N+/p6XPX3esHI+yxYlj+zUv2R8zc+yeoa5bJydY6+iCGRt46+Bk99
	sRcibZ9BElfkTJaEs4WA94HMvoZJdQR2any3Ebqt6lE56zruV5Df8DVGo/0g/Xubty3J+Ju
	FphmdkaErhKM0Vy+fti/UT1Ifo6fR514dT31djx0JWdpo8iBwFeTgABc81jm84xkcwmCjIG
	u03FmOrdooummfg3HiHpZg6FXew48W40QLZDBdyfHtiwidWcg9uX9YN82viryf30tU5FtaG
	8FkqxVHqnI4jM5GI3MRxEWforzkocCIoUYLiil4rkWQXcq0kiTyrCCCmQa255M5PKEKiCA7
	j8dvJcczAEorbvtYJkC6hkAeml1gL/DRPzPKYX08Vm3eQA2nEaCnxJGjfD9Iw3+cob/L17I
	Lpe0lcNaoStyPNwkzJ7Do11ET84u+SvGWyIShv+xh/qEdBeePJEzWXV/aHlhdAZIvlaxFQ/
	cfXDo1UgrqjrwpxwYe6wHlStnaWm19WfE6sQdTGQft1H6CTy8rqoXUhPTBl65JJZWRUQiWX
	Et7LHOyf61qYxuk2ecSdXPtyAl+mLbOgQW/PRC8vBggo8+9CBbt8+5Uv/VEve7ImyZXTgE9
	4fuVrq4h2Ay8hx7RVoodyXLKoQw5THQFouL6fqwxEjThe1gAj1KUCQWXgijPCsGdnb1niFA
	d6IgdSBPFPv0aEprY9LKLLuDYrmMv4yMu4q/yAi9pNlchrQo16Tkqmheo/KbdDPRgdvO53Y
	cSzM
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Nov 05, 2025 at 11:49:37PM +0100, Aurelien Jarno wrote:
> On 2025-11-05 17:42, Troy Mitchell wrote:
> > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > > 
> > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > > 
> > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > > 
> > > > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > dependency is here.
> 
> Oh indeed, I have forgotten about this part.
> 
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Applied, thanks!
> > > > > 
> > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > > Should we apply it now? The dependency patch hasn’t been merged yet...
> > > 
> > > What is the dependency?
> > I point it out above.
> > Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.
> 
> Note however this is not a strong dependency, it is needed to make the 
> reset or power off reliable. Calling non-atomic i2c_transfer lead to a 
> successful reset or power off a bit more than half of the time.
Oh really? I never had success with the non-atomic transfer.

But however, as Lee pointed out, this patch doesn’t need to do
anything special now.
We only needs to ensure that the MFD part won’t be probed.

                          - Troy
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

