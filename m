Return-Path: <linux-pm+bounces-37463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A63C35C75
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 146F84EE5B8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D33168F6;
	Wed,  5 Nov 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="n+w05PML"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A333168EF;
	Wed,  5 Nov 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348250; cv=none; b=qAXTJxiqTHQAAsh+TF4LK/A8Jsm779dDSWgA22EZHSTMyHZccVIH/sJ3ocMQGQ/7eazieNBf/jcBa7C9J0PVjAWq3hdt/ZfWXAR0ScboxiaQ8NRx2hWM0K1ZBh1ofKF/M2dBfTosThfpCExiBiir3fsi/Ah0HMtDqd6KHaxvyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348250; c=relaxed/simple;
	bh=fS1PX7K1CZLvuV1ceRkph26bsk4KDr6Q5RfhVe8jnwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvMFQZzwnLGlM2fDgRpj2dAGwomKdlp8POsaFhmEuK8pC0+HXvmJWUo6I1rWipgaS9h84v/E0dUgm4tlCtqUXEhyWKo5K284aPEmqfc7qPMv8HAP7DEZ6dV4x7MTaIwcO0YXrsF3u9mSdQu4qt4Fg3M5i15+Zii1rs31IzThMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=n+w05PML; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762348226;
	bh=jlIuWhx6mIXtzUHR6K7f1ncyau5kdA/cogsTajBCfP4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=n+w05PML4BOLGAQa7dOeUA9NKe+BhiFe2KX360Fj1Z7z/VapX/eOSsIeW6TjFZ+O/
	 h2k5PDxGngh1sx44R7a60HGWkT6XmYTV50Ot16FgIC/tVAej7SXEFxCS2578tJvu6e
	 ZZwL7hH4NZtQpC3hRgSNlsaPl5t16DF1h4tOVILE=
X-QQ-mid: esmtpsz16t1762348225td460a432
X-QQ-Originating-IP: Ry4EBM360mmFG+DdStDU6CVzq5ZY1m2B2cjqx7WGWCY=
Received: from = ( [58.254.68.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 21:10:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1919110398043033819
EX-QQ-RecipientCnt: 14
Date: Wed, 5 Nov 2025 21:10:21 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Lee Jones <lee@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <FA1DBD9E7CCB8027+aQtMvb5Br7MgMW4K@troy-wujie14pro-arch>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <20251105100856.GG8064@google.com>
 <20251105101149.GH8064@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105101149.GH8064@google.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MG1k13TElWXsLsB0v4fOfpWJvcE5O0FZpRz+gzjvu/DkjttggPynwxWM
	BN5ZtsHKL/xkUg+gZOxE+oxdFBeGkClTTMV8WSEg1GTitdHitsDn9beH8gKzYed+Kc6q90o
	eJen1tFIauMugByOEB84jUJF7YRRYah0sue35z+iPdEwTIqkb5TxFDUgmNQG2YYcYs20PTC
	wMdrvzpzlyfOZ/gTTeu2b5aH4dKAScferfFGp+9cz2Mijg9ucWdKo88FZW3Ph0SKDVIvT7r
	fM0SUWxTtkQSQRKWODe2UrqpouBFut8warATNSCOTYsVNoIfAusUB8i8vBcH4DkVeyFvwQi
	4R+7qKCD9IKM21MLmnbmMTfRmY/bRXEkBFnYyMEi/6j2VGSt0MSwNmhqtOw9oo+iNGpX0Sm
	bKwGsekuyFjkfSoa1KM0sWLhQPPht8DhDF/prO/iytG83ecvSlPU0L5ZwTSH0AzUnHawfQD
	I0EeaIHASHC/oUIQkvB4XqZf7llYoTmbjxLTPUR+oPPboLDBm6Ti+K6b9fm9i+y9ocvkftT
	iffK1+krARfCK8cOveImkygIzntwaZq4Ob/1dL5/NWWCZKqtJbEVfRVVmNgU8gaM9kJv4rl
	isBpliiSJttZvx3e/uv5RT/9GbQTSnOIikxqSlFW3EoDbg4Q7CrAgiEd2vIj0zuVv6BFwM1
	1vV1AJLKJeROUgDav9rUeYX6czcy3NFno/awyBFC9eVcEtoaHEoSECn6hvzfQpzAqFWUV/V
	lpyJx86ka0xgcT7I3raduy9EgGf6erWadYh1RCtAsBDXN5/a0j2iDSVt+ZOorz6ug24hMU2
	mC9wL8+LXJlXKvUjYRnWALbr5Cs8Iqfe40XeTRTm8YRzsbwwz93e5A/mStnb6JLPyDLKHlO
	1RCwyKygcJH2Ct8nP5jJn+mNBCCCUKPVvkeq2+4ZBSDY3g8NuvUCZT/yUCnin+y6CNYIyzW
	XQn5Hhl4dx9S6aSHP8HaDw9MdAanQJ0dP3Awom6rfw0Lh5C+qSh2jl+RiiR5JQlFRFmHGf6
	zPvqKy75awj1eiB5uz5LcW4VbQRQvloKwV5j8zb/ERkJ2hGbTDfh29QdZ2USdzMNs1Xf8YA
	CEonbJUxpVT
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Nov 05, 2025 at 10:11:49AM +0000, Lee Jones wrote:
> On Wed, 05 Nov 2025, Lee Jones wrote:
> 
> > On Wed, 05 Nov 2025, Troy Mitchell wrote:
> > 
> > > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > > > 
> > > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > > > 
> > > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > > > 
> > > > > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > dependency is here.
> > > > > > > 
> > > > > > > [...]
> > > > > > 
> > > > > > Applied, thanks!
> > > > > > 
> > > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > > > Should we apply it now? The dependency patch hasn’t been merged yet...
> > > > 
> > > > What is the dependency?
> > > I point it out above.
> > > Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.
> > 
> > Okay, thanks.  I was mostly checking that you weren't referring to the
> > MFD patch, which doesn't represent a true dependency.
> 
> To save Sebastian some trouble, let's keep the reboot patch applied.
> 
> I'll hold off on the MFD one, which will ensure that reboot isn't probed.
> 
> Let me know when the dep is merged and I'll hoover up the rest of the set.
Okay. I'll reply this thread when the dependency is merged.

                            - Troy
> 
> -- 
> Lee Jones [李琼斯]
> 

