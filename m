Return-Path: <linux-pm+bounces-36449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6823BEF570
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 07:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D353E353C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5429BD90;
	Mon, 20 Oct 2025 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Nrob7+NA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B62C0291;
	Mon, 20 Oct 2025 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936367; cv=none; b=DlMxO6QPbiXLnHW6CUWtgUudJtQeE1m4R2VfJhUgs1htYxPAlR5g5sbUAThu0rT5Y1+vgGT4+3QqUrshAo3tda7pfl/qRhD3DGwNOjDZjWH6fmb0qjCjsODyQh3UhgSp/5viB/nAR5Dw6/KD6fOELHAOUdC4t2fADDuK4XLEBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936367; c=relaxed/simple;
	bh=vSIq+NH5wIwo7vzrtPrvY4BIsOV58rjN6kpb4ApRPgo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivMjgGs9hBtQeIrOMig712suvopadh0NHg12PaHXd5c0BrKbpzUvuNGXajBh/KCIAZkSJM4kB1DaCuQr7FEwKv8/TP/OO/IP6zXOi+8Uty5iQjjcnUi9Ig/MpTOwzZRkZZ2Q3t1bfrTQCdaLeYmFBy8VHEYyZrls6Lx5/fiEfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Nrob7+NA; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760936353;
	bh=DpbVwuJ0hNCZpya/CMtmT6R12p5giGePJ0QvCPe4sSo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Nrob7+NAjKQVjBkY33IqV3fgoMf2VLvzlLz0T20165tSnAu1yfQAbjafJsCafDd0S
	 K0SX+4dqWGGZhnxCmUJvFcXFK09Q7Bd6m4fax9OZDVzKrspmOd1cbwFanHYv+8xQa+
	 JmSpLg0AieK5LJXEC4o30fKXlbiAUpcAckX7ENf0=
X-QQ-mid: esmtpsz11t1760936349tfb6addd4
X-QQ-Originating-IP: OhogqkvT3TOqQzaOd3wS30RTmN/HDzTlS9mVV7AHJGs=
Received: from = ( [14.123.254.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 12:59:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13248711578599925219
EX-QQ-RecipientCnt: 13
Date: Mon, 20 Oct 2025 12:59:07 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <2EE2D63A9E55C55A+aPXBm6t0llG63Knv@kernel.org>
References: <20251019191519.3898095-1-aurelien@aurel32.net>
 <20251019191519.3898095-2-aurelien@aurel32.net>
 <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
 <aPXAyeDC7YXAketm@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPXAyeDC7YXAketm@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MQmnsueoXmdVJwwoFhEhDcflIxvtTejZwN5zaSPlOxsGMGjUAaTSgg2n
	JdjXUFg2p3ZthiYF8n6uZFW/+dhNNalgSdsO2gZadHI2GzP6SJMj1v0s6YnVBy2pZMPWLv6
	k4fz6BwZuyH24COGGZHhnAJ8p/0cx86PyqE0V62Y2K+DQdMN7Gf/10Ogr+roHETNCruyER3
	QOrSbf/nFPmN9qPV+qVNAjuPKbmbK2Kws9k4/Q+lrl4h+dSRLwhf16ihDMRzmp4pR2MuiJi
	sHALHysdlRk2x+88jk96MUvZRmOklzoKfZDOk1ibs1hz9/VIQFWhaV61lpfY4XMs8R/DmWZ
	sV5etKan3p9HTGODfgTV4qogU5+QUUPgRDci9pRqiD+tqHfPUKUnb3yC7VHdnPBLcFoARAA
	dcDXdJh90RbCf8n3bIvYtcEcqmS+QO8UrKSBWnb5/LBcdZ0Dshd5OqGHGAv3GcD3+bzjmGM
	H07YeYHyICiyykVuWKJSbtqCFKEcsQbEtmWkKFDtQa02sVUUwypn/2d7ZWR8W8DfRL/vXZS
	DblGIDbN5d5WNG8dvZG7twqheSae7iInDkRPSkW5RLuXux1QwhUMndDU3Byq9SgyX+KrnNa
	wfGvPaZQNsvx0ii9zvagY6vjK8Hd3qljfEz9z27HTU279PFacY4uVD8ZaYfRpHuku06t2Q2
	P5ColJrWTRH5RaSUd1Oj4xy1jGHfim45c0UCoQs+sQjBHCrD9EqEXz75MS40fnikBZmnKuB
	WVknHvcpBz15ztEn3tFtkHqQ/v18n3dBjo+Wg7BRmp7dpcRrz9tqFHdZ8nitp3vrtZpLl1T
	D+kDtuO1PbVQjuUenbS7fTM7pYHW12wIJ4kbhseOa5OO+k651SsuZmT5yZxKOevbAZJIlCu
	oT8E+0F7bEBg/SEZoNaURjeTsrY+FHwBgfS17bRxIVPjtc1bxYcIEATvmHRI5C7VEG0fc+k
	6Pb2oVuDw1LjusPzBX9+vAUeu9+wPQ6B0wYxQQBQzsgWR0dV2fYlTqkUylXhpiQYDsIW4bH
	Je0zxyNVPXngwfnQJABSF3SzcohXJnUnSSHc4UQ44fQWKN4vgSmLBUXpprKqMekt9Evb7bf
	/S4jovHooEj
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Mon, Oct 20, 2025 at 06:55:37AM +0200, Aurelien Jarno wrote:
> Hi Emil,
> 
> On 2025-10-19 22:53, Emil Renner Berthing wrote:
> > On Sun, 19 Oct 2025 at 22:34, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > >
> > > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > > chip, which is commonly paired with the SpacemiT K1 SoC.
> > >
> > > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > > done directly through the regmap interface. Reboot or poweroff is
> > > triggered by setting a specific bit in a control register, which is
> > > automatically cleared by the hardware afterwards.
> > >
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > ---
> > > v2:
> > >  - Rebase onto v6.18-rc1
> > >  - Use dev_err_probe() to simplify the code
> > >  - Fix indentation of patch 1
> > >  - Collect Acked-by and Tested-by
> > >
> > >  drivers/power/reset/Kconfig              |  9 +++
> > >  drivers/power/reset/Makefile             |  1 +
> > >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> > >  3 files changed, 98 insertions(+)
> > >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > >
> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index 8248895ca9038..063202923d95d 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >         help
> > >           Reboot support for the KEYSTONE SoCs.
> > >
> > > +config POWER_RESET_SPACEMIT_P1
> > > +       bool "SpacemiT P1 poweroff and reset driver"
> > 
> > The driver code looks to be written to work as a module, but here it
> > says "bool" not "tristate".
> 
> I have just tested to build it as a module, and it indeed works that 
> way. I'll change that to tristate in the next version.
> 
> > > +       depends on ARCH_SPACEMIT || COMPILE_TEST
> > > +       select MFD_SPACEMIT_P1
> > > +       default ARCH_SPACEMIT
> > 
> > If it does work as a module I'd prefer "default m" here.
> 
> Do you mean "default m" or "default m if ARCH_SPACEMIT"?
I think it's "default m if ARCH_SPACEMIT".
because only SpacemiT uses P1.

                    - Troy
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

