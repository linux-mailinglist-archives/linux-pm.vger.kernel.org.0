Return-Path: <linux-pm+bounces-22556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40AA3DFDF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FD61890D72
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539035958;
	Thu, 20 Feb 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCEeVrFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDC1CA84;
	Thu, 20 Feb 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067632; cv=none; b=WDQEPjpqPzx6RGhOsJZp7v8v3DtrtUBZDKpcOOUno62mmMRanmWD6OXe7AYieL0XjxKJY8e/LlCvn0ZRES6zNm/ISoYTWxeo83eZOpqCsyTxNKadNkibPywyYTdn9TdKPljV+G7rd0o3QZlFPDp80uNf7Z2ZEJ9dHYR80Eizi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067632; c=relaxed/simple;
	bh=l6hNtVh2SuFZL7oYVzMnlU/JqKefg9mBjESFTWFKWPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/cpOk7i+67UsHGeP+zvwEhsJEatAVBbCLMIk9wS7srS4eGSOMfjRPHqPsKP0P+Xr/0sqb3/FUANZElvcta/o9MU8lkLcscP3F3jtpDzsMkm5LL6j6EKcCyhI3QeEW/YogDLBAcxdGK32aRLpQQGLVAnQavse/7Yid6FU0ScJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCEeVrFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACACC4CED1;
	Thu, 20 Feb 2025 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740067629;
	bh=l6hNtVh2SuFZL7oYVzMnlU/JqKefg9mBjESFTWFKWPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCEeVrFW8PGOEmpEwNkFCj+GIPpkCWgQdJ3MgUDaQ6AugO6SkVv0YICcIItn63i9g
	 g/gJ1Cp9gU56wu34B/Uj2JxFThzlFe/ibsszMoB3RrYNARJNNLVTlF744Dp/E34Csc
	 jiDfcwePCQ26D7vBoXhCLaEjgyeGYFfrzFxvzIOvHbo80kG8K2e95cvNvAgu+fYlzO
	 afDULBE6Cytsp0uEPiBoxRcD+k4FBg2L1J/esF5WAkyFKedgblGCtq/gsBdRXm4w7g
	 cLoogKIlH5DP+2YbbJMV22ylts8AMYlIQ/u2rB76bLYFc4ry6ALCdvTT5l96R88c5F
	 Lrgvdr0w9+SVw==
Date: Thu, 20 Feb 2025 16:07:04 +0000
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V2 2/4] mfd: axp20x: AXP717: Add
 AXP717_TS_PIN_CFG to writeable regs
Message-ID: <20250220160704.GC824852@google.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-3-macroalpha82@gmail.com>
 <173928137017.2164349.13619464947851022064.b4-ty@kernel.org>
 <rfn57iwagexbshg5akmo54l7un5ypcl6h655ahieyl3iz2oelg@oxv2wc4jcy5d>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rfn57iwagexbshg5akmo54l7un5ypcl6h655ahieyl3iz2oelg@oxv2wc4jcy5d>

On Thu, 20 Feb 2025, Sebastian Reichel wrote:

> Hello Lee,
> 
> On Tue, Feb 11, 2025 at 01:42:50PM +0000, Lee Jones wrote:
> > On Tue, 04 Feb 2025 09:58:32 -0600, Chris Morgan wrote:
> > > Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
> > > registers so that the temperature sensor can be configured by the
> > > battery driver.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [2/4] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
> >       commit: ab797d7faf4c28328d2e45b09991f47a9b8e08aa
> 
> Patch 3/4 has a dependency on this one. As you probably haven't done
> an immutable branch for this one, please also pick up 1/4 and 3/4. I
> just provided Acked-by to them.

Here you go: :)

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-power-v6.15

for you to fetch changes up to bfad07fe298bfba0c7ddab87c5b5325970203a1e:

  mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs (2025-02-20 16:05:09 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Power due for the v6.15 merge window

----------------------------------------------------------------
Chris Morgan (1):
      mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs

 drivers/mfd/axp20x.c       | 1 +
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 2 insertions(+)

-- 
Lee Jones [李琼斯]

