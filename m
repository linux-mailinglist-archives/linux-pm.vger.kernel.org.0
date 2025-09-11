Return-Path: <linux-pm+bounces-34427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F523B5267C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F082158196C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E619C54B;
	Thu, 11 Sep 2025 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Rk/1L1ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BB1E868;
	Thu, 11 Sep 2025 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557982; cv=none; b=hfVXyivaDt6Ykb9lW/99Y23KevWHYlcO1Eoafrb19pXVbS3K2in+Eepez/4a64aLHWsLEFSmboBP9h/T8s+mdJPGY67Li6FA6wZ4or5hWi2fgUfN+nW4wB4Ho44guKZzca3NJWB5KmfIn4US8fNKt26GDYp2+eqEeZ0mcEg+zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557982; c=relaxed/simple;
	bh=vQXW0bfixkagLDo6qr+VV4crA8TEWVY6XIU4DiTbuxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJaQEsSGQoE4G5yUckpPuY3iIocRaGAyXvWjalUTz/AAkfuAwgf9IKCActQrV7gVjUOnS5lU9TmntkGd8+lXBQgyFlAgCXHfjzzEelLS+Zbpm41LML73MQ2+V4EQUcr3O2bt5hvyp9cg61JEUKhtHrMzeFx+qh4ClqpnUjn8IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Rk/1L1ki; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tbGufTgC4Ea0k5Wg/viciM/Ro45OFwFdqd/nvP2O0m4=;
	b=Rk/1L1kidUFupjgqkvtTPvK8Rsu7o7N0+j9R+zXwCY13H464HodSXrC3UHQ1sF
	goS/+VeSZuV1rDljT6JPeAvK0/ZbaHf1OqMXFbOBN0YDGuCJlp/2l0sDRgsyVkbh
	4CwXlT6yacVHPgDSg4hQlQnARDecPnvTq8W7HYkLOlJm4=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3_548NMJosrZGBA--.64549S3;
	Thu, 11 Sep 2025 10:30:23 +0800 (CST)
Date: Thu, 11 Sep 2025 10:30:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: Re: [PATCH v10 0/6] Add i.MX91 platform support
Message-ID: <aMI0PJtHJyPom68X@dragon>
References: <20250901103632.3409896-1-joy.zou@nxp.com>
 <175694281723.1237656.10367505965534451710.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175694281723.1237656.10367505965534451710.git-patchwork-notify@kernel.org>
X-CM-TRANSID:M88vCgD3_548NMJosrZGBA--.64549S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DJF1DWFWDWr1rtF47Jwb_yoW8GFyfpa
	yUCrZ8CrykXr1kXwsFgry2ga4YgwsrJF4YgFyUXrZ7urW5uF18WF1S9ayF9ry7Xr1fZw1Y
	y3W7t340va4ruaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jenQUUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgfFZWjB-SqFCQAAsH

On Wed, Sep 03, 2025 at 11:40:17PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Jakub,

Can you stop applying DTS changes via net tree?

Shawn

> On Mon,  1 Sep 2025 18:36:26 +0800 you wrote:
> > The design of i.MX91 platform is very similar to i.MX93.
> > Extracts the common parts in order to reuse code.
> > 
> > The mainly difference between i.MX91 and i.MX93 is as follows:
> > - i.MX91 removed some clocks and modified the names of some clocks.
> > - i.MX91 only has one A core.
> > - i.MX91 has different pinmux.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v10,1/6] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
>     (no matching commit)
>   - [v10,2/6] arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and modify them
>     (no matching commit)
>   - [v10,3/6] arm64: dts: imx91: add i.MX91 dtsi support
>     (no matching commit)
>   - [v10,4/6] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
>     (no matching commit)
>   - [v10,5/6] arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
>     (no matching commit)
>   - [v10,6/6] net: stmmac: imx: add i.MX91 support
>     https://git.kernel.org/netdev/net-next/c/59aec9138f30
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 


