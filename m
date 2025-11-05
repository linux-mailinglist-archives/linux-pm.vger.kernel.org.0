Return-Path: <linux-pm+bounces-37437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717CC34ED9
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943B04F5624
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E67301482;
	Wed,  5 Nov 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="yHzR6oYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758FD2F90DB;
	Wed,  5 Nov 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335802; cv=none; b=SKEhhigssuiem9bBbnsClnSdehzJXK7L8oRGsrEI577WrpRxc7XVZtM+jmezc5T7Vq9ar981JYrM9EMhLW3A5FNvuc1DSecxIxdpGlrovFmNKi4cCIlVjqZxlml+Y5seYCCUf62x/+nL+XYUH4/vKuSOj25NAkVjB+Y0lUBwS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335802; c=relaxed/simple;
	bh=2ay3gpe+DC39Q7/4WZfpjtRkiFON/Y2iewm350cuS1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLQM7hs9M5cKfWXKipZihM9njP0fALCJnBHs6HqbQ82jJAOWcVj25dmIjcxCXSkcaskzx1HG/6zjPlnGC1c3IhN8Mpqwp0+qNaWz1QsUtkkk8JKt3Av7qiRRf8H0i+GhLgtAwaLSSxuWIHgerKrYb58OZex8Fkd6bTY3cIVdGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=yHzR6oYW; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762335783;
	bh=2kEQYPx9izy3tjn1vebxPX+DpgkknD8cSN82ocQpSH8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=yHzR6oYWpCgSinifOcI5aQQ90K2nzG4PxujeDUJ8WPf18Xt+YpAokXTFTrQlg5kxE
	 WEo/d6hjSRspJvpEdVpZ7Dr0TJcCQum8Dv3aoRarDrHX/3L74OLU3NHZ7WdE07P32t
	 j/TT725CHqjfcfIt++au3hcx57V+RoIKICHozC4Y=
X-QQ-mid: esmtpsz21t1762335782t549cd986
X-QQ-Originating-IP: COFdcai2DugJqSuJpc3w9T+h41iB4VKElqxx7YBkRS4=
Received: from = ( [183.48.244.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 17:43:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8610270425027163017
EX-QQ-RecipientCnt: 14
Date: Wed, 5 Nov 2025 17:42:59 +0800
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
Message-ID: <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105093347.GD8064@google.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MIgGCCI///JUTZf9vMBL+cj1O4cG30/f5aB285poD6O0e0mo04lrE4Ci
	hgTAGU/WyPJ7FaZbH5nzfF0UtBIDNjal22BLcnIizNln0OSFItwc4gbqZp5yw88XN/Oei7y
	OAnuP/o8Bgw/sUgpiXmWE7jVuRFSNLoakt7EU+a/ywZ36TVfv5BC2/DMQEJrQIMNDGtQpQy
	1UgpCamFqjaXBtmoaNGhjuQt63D5ME3p1ByzCOx+/Amox7mM2oFVlhGV/WnqD0P+tl05RE3
	GjwPKI3GEpsgo9RszPYQJdMmeJ/H3H6AeXkM9ldXBYEvzqGcMGvoRRSV6g8BNJWxoEyqApm
	8gde5RTWeyoz0pnw//nIPTaFL01Vabld6nYuK0T223g4OamH1IkSg7QF12z4nYCqDZnC2gZ
	H5VAe4OLUDlYqXdJMBKeochN80ciKwPAMvvjLcdFYc8gJ5ggltZ+b4pKgAQ2ia0oRSA2yTr
	ooMU/tVphi3xRRdWipFSrnEdEn5FWOhs6PKdIaIeGS0w7QKN+wsecZ4oYFeIIATx94Ddo+/
	CgFQXXmfOt4YGraRi8iFzbS+ho50ZsSB298sZwWKvOdpDdsXFgNh8f1VO+K8vcV7OzQi8ix
	plhaXUEwn+oly7hKU4yADvl7CWV9IuBv93XMJt0yHAulgt3SD0Ba12siasuAxYIaqaCxFZc
	OHWjO9v2iV3tFl1LJAy706+ocopZwVSbwZ0ruehGfOgVd9O/nhKDfv/Kf49Z7CJ2VAW48lB
	gSK5HiGPSJCOxJX0dNu35u0/5GFCyALp9AuMhxIfIUVKzKcIQbFtFSCmv6IiUfJU+wi+zs6
	VFUyGY2cZjxi+h4Pux6O5KpLlJy78g3sVlRqiyH9UotIzpAzytPX+6gF8vPIdImBzu7Qjd6
	UCpRLfBwSXaDRe7OWZHIdOs2qljNJ6IdmHpYeJK/n54SaNqDlll4GBXq2uK6Q+KGmXWPkPV
	m54L6EZ7PMJ/J+PfbtDQZHHdmnxaGWNhafJ05zXoqAag1giBCHEiRbvW7Z2GwTgVDNrAO9f
	5gssc6sTD+WnhFXk3KxB/QYNdfb5lufgz7Sc8bcVyldpPa1RrqLNCKNI4bGk+hc0nPKY2cU
	ayLAY+JTeIF43vIDkmgB6IFmv7w3f2VQJFuFTzmYzg+6waF3amT8vKDDNJs7nIAzCNA71wr
	EvPOSSPuTzZTbra4hEGQU/D8IQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> On Tue, 04 Nov 2025, Troy Mitchell wrote:
> 
> > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > 
> > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > commonly paired with the SpacemiT K1 SoC.
> > > > 
> > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
dependency is here.
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > Should we apply it now? The dependency patch hasn’t been merged yet...
> 
> What is the dependency?
I point it out above.
Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.

                                  - Troy
> 
> -- 
> Lee Jones [李琼斯]
> 

