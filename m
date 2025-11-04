Return-Path: <linux-pm+bounces-37327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D01C2EBD3
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3CE3B9DEA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C2212548;
	Tue,  4 Nov 2025 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="OesQPTod"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67F1A5BB4;
	Tue,  4 Nov 2025 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219510; cv=none; b=VZ57jkE7XqvTGnVkYDmkHEjA1WeUAkFvTe443BvnnIGm3Zwuxa6r1WhOw+vWwchI2Yc50XA6QvI7iCbzvco0KfjFXizxotZt22KMv2/i87dlgjJvgCJQeAqoe+4tzFlGaktlFjZMh6XwXjVH7CR/nPawQUJfu5nUdStFIPZM5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219510; c=relaxed/simple;
	bh=cTpPT4cig9t3raQPQtj4U0kY+SvgSFfLmEaCK2rsmAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRay7ix1amC/x3Z5SbXQJA4pLjIGePysVWYyxfEj9v/NO06KsPNQ8iUdbb19V8foT18IT4hWvWi7f74/RUW6MQObluh4F8Vf5FVb+polrcd9xehKaeVlekQTSub5YmS0rWPZs747bcOA8DsHkALCrcntUZYQ71V1P8I2fTGHYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=OesQPTod; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762219458;
	bh=0hwl2OtFMXqkwgYt4ObNVkGet/D5+H7Gsx+xlg7Voxw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=OesQPTodsuo35YiXsczEWC1wTnAdRUYbpa61iB5aujdnMBOGA+n8n0cCiA861lFVx
	 C4Iprtm53EuRkPgYvc0pCKv41wzGsi/QQ88xAwadIpTCJfeAGl6O/+4EEFM1va01jn
	 jmWmM2ivLRBlGl6YamMAvv8gup3KtN2gWETlwLoA=
X-QQ-mid: esmtpgz11t1762219450t564302b0
X-QQ-Originating-IP: SNiv4Oe5sCRBWmV/7m5EOzuMnyMJ79uGdNyLs1smY5c=
Received: from = ( [183.48.246.20])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 09:24:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1834260174305305172
EX-QQ-RecipientCnt: 15
Date: Tue, 4 Nov 2025 09:24:08 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>, @kernel.org
Cc: linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OXhWvHhbOVwtp8l6XuniZAsqSKFyUEwr3bv8yUqJc8kIBgygrt0iACsy
	99mbFLhmna/9NLzh2fOs+IG8S3ENoJYAS3Kp5orGi/kyQbbNG4ZahSF11LTIuXZWtRe1lJ5
	n70ZVEzBL7XHxFuKUAEZ2jrZ2pBqxkymLOjQ2hU0CSdJPWYyJj2S3yBF8AY5j99sdHqRgF7
	RqqtVE7Zh+FkKT1XQ07lDV2ke6FPF02nfxvkjzN0qE2iCPO+9wgsVrobSVtf6bRKpiG9V+9
	amvnOPsoaO4snIgayz9TQisLIBsXJ59oV3yoMpVfIs9TtX+tHNHfaR1TRprPF48valpKuhw
	Nn9ay4UYZ0uKN8x55DZDTf1xdGJdK3yLB4AEn85lp2ROsH7KgjnacxigyFLLu9nxClnUw4w
	7Rg4lgNUBZJdmrNfw9NfVjB18dWR9bOt444miyleusr7W+igLe9Td+0AMmRwAUWBivmxtBj
	+afkZebJ4O2FusoKvb2N2WvHAcYbtehEeMno8mJBuYp5xHEsxyKwQygnAM4vRP3BS5sQmUY
	OPseknkt0qm++4mbNGo1uqrbWdOvGIXia+LrBELOD5gNFNRolUTK6FqWWmZOrb3axuvE90c
	J7HoiKbuxq+xaaMsycYvdJOKX5+WWb83BZHXbn/usICJXZc7V9X6w2TCWrw96/iEfi+vb2Z
	1pSBXDyxoi9FyOBAaZf2NCORe81NOCsAMKtK5qvtkcSLDLGnP8BVNXYZFG/3kOEm7780dC1
	0v5Srlj345S31a5HQ3a8rY58zY1MoOs3UF+uUED/NBIKaPqVeQ78DwIwAv9Ng7L0KoIxd7B
	/QbLWTu3ye4bUvMryFKpg3ET0izbnv4IlphhGTRqHwAT5wSM4f5hzD9/aYJDvU3uJFcwhnf
	MZDduaeOLxjhEsFFxdR2PHCmoghWHQn5IF2/X8BrwdvSrr9EfIkrMYQfUg7KY6Si+lWon+3
	m3145wBDo3N+D4CMsffYSp5XHqg4BV6vvllmRb/H8JKvBa9th3r6/VGxlaS30fLYPK7VTnw
	s2FoaWrtMso4HPqZ3YkJFZUPeKxpABkt8tWvNwNlzSSDSQVn0pf4PUXA7gW2XGVfvcqpnrc
	Id1ID7tNOBw
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> 
> On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > commonly paired with the SpacemiT K1 SoC.
> > 
> > Note: For reliable operation, this driver depends on a this patch that adds
> > atomic transfer support to the SpacemiT I2C controller driver:
> >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
>       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
Should we apply it now? The dependency patch hasn’t been merged yet...

                                       - Troy

