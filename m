Return-Path: <linux-pm+bounces-33775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A200CB42D86
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 01:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C3C540804
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D52FE05F;
	Wed,  3 Sep 2025 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/GrbPfJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25B2EB5CE;
	Wed,  3 Sep 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942813; cv=none; b=SRdUQ7rrucrbqSJ4f1pjWOhcWcjb8+HTJi2Rxo10W04rECJH2MnnikFI7Elxlo8nvI8VeRf8mSIK3LX1izuYqnOnfR8g+rs72hDOCXnUCL/nPqyrRaSs5m3cBKc2Bs5DBV6h+PBBZn1Ny6OmzAVKe6xWCqXPCLPO0IW+wr9hZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942813; c=relaxed/simple;
	bh=2fsTRI0s62XGwnP//OHTQCGU7+WD7rrA5jzNeU4M6lY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pjnk9vp3hV0NqGA5+OtpgYqr092qUvGOTPzeO0sFgC5GEt2D/dIWfu+j4P9XXLPibuK7aPlH+av/GyJtNB22Tvt8z3zvpdF34JUz6Rus3yrib8gaRxghzFUKq5V2Zd7Ggllt0qRr5yTakzQ/0BvXdoH6k9pbHEeqSfDEN46SVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/GrbPfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3076BC4CEE7;
	Wed,  3 Sep 2025 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942812;
	bh=2fsTRI0s62XGwnP//OHTQCGU7+WD7rrA5jzNeU4M6lY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/GrbPfJgOGjoVeEFEULkY/WrpJF/tT/fFsBDaxhblrMhUkNfDN3pjV/lZbS7go07
	 vTr8xvzguB/Og4SwcemyOQyD0ayGLWI2hva68w7MnDD71Cg/pjKWmJYwpg4yjNeQDa
	 NSrUHpGWLXSUOaLTdvc071RWkpm6ZeJwUsViJ/76gQ77IjstDPzUpNRQIOnDU0J55E
	 pmDD0/0PR7hZ1lsHctmgUU05jJ8V2QHEG/Fv4Rb7t15P541j8LzdnLKvdQAuln5DAl
	 FfNNrtXIPnqfx2MBLQLp1mDPPj9qFUcJPsZchL55js3pAA407/l2Raz9bMs+AyT9zs
	 zN0TsAj8CTzTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E51383C259;
	Wed,  3 Sep 2025 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/6] Add i.MX91 platform support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694281723.1237656.10367505965534451710.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 23:40:17 +0000
References: <20250901103632.3409896-1-joy.zou@nxp.com>
In-Reply-To: <20250901103632.3409896-1-joy.zou@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 18:36:26 +0800 you wrote:
> The design of i.MX91 platform is very similar to i.MX93.
> Extracts the common parts in order to reuse code.
> 
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core.
> - i.MX91 has different pinmux.
> 
> [...]

Here is the summary with links:
  - [v10,1/6] arm64: dts: freescale: move aliases from imx93.dtsi to board dts
    (no matching commit)
  - [v10,2/6] arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and modify them
    (no matching commit)
  - [v10,3/6] arm64: dts: imx91: add i.MX91 dtsi support
    (no matching commit)
  - [v10,4/6] arm64: dts: freescale: add i.MX91 11x11 EVK basic support
    (no matching commit)
  - [v10,5/6] arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
    (no matching commit)
  - [v10,6/6] net: stmmac: imx: add i.MX91 support
    https://git.kernel.org/netdev/net-next/c/59aec9138f30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



