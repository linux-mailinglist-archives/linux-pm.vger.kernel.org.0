Return-Path: <linux-pm+bounces-30635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8221B00E82
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126DB580281
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED32951D2;
	Thu, 10 Jul 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0Lp/Qhj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3823B617;
	Thu, 10 Jul 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185401; cv=none; b=K0dBDyQPypxKUyN1VpTReeSPEjnozgXA6GP9lZ2owIRcQmOFrv7WCz4rgVx8m8pYIFyGuzBsTL3+e0s0ov6hf4zKDfDZL3p5OpBE0WmMSMkiiKe4F6dqylL/Srah7M63dsuXpMGtAVSdrcERvWE906ZuR+sskv0hZuwSOn1fFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185401; c=relaxed/simple;
	bh=cHem7GO1bpm2QPnhafnGHzow7N5rhbfN6nvXGgTABss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=beEcH3EXS+yd5ahy9rpESxrErSHFywS6LIcttnN0A+dt84cBsePMMswRdGr/l/fbOSz9CDQmWqm1mGS1odlKBNc62l84EalSTWNx8lvOFi8BvUYU+DJD38LgOn9Tb9bRdPgHkdgtYEpzHs1aEWXaIyg7CVyzRH9Jn4NNeRdkDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0Lp/Qhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EB6C4CEE3;
	Thu, 10 Jul 2025 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185400;
	bh=cHem7GO1bpm2QPnhafnGHzow7N5rhbfN6nvXGgTABss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L0Lp/QhjolORcf2uLdp8zFhHVHLbR0Z6qPPZ5QmeiqyfD2UCo7zBMAYzpIemCiQAw
	 gcyiC4tuohiskaV7uVb+E0B11seyKbVUYQmVYcqwFIGitfjbQ1IVfpkHOOQ4WE5h1A
	 xYOriUVV1NdRRwoubiglpFMEOWUIdOwKFHuljHOOKGdz/kQjA7/7H5hQnHpA2iOAR/
	 kFebSVa3WvjI+jZ72vRxMQSRManTSnlfkkq7poXEr59I64j/2rkG3vJb9JsuLZr0Oh
	 7pFZ5h4Z/eVc8x6HikECphStLbxKFq7SXP2BSAbQ9qjlVg94bEArHzOhJ/LO/jRwmu
	 TO1P3z1TH85+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD8383B266;
	Thu, 10 Jul 2025 22:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 00/13] further mt7988 devicetree work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175218542224.1682269.17523198222056896163.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 22:10:22 +0000
References: <20250709111147.11843-1-linux@fw-web.de>
In-Reply-To: <20250709111147.11843-1-linux@fw-web.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 johnson.wang@mediatek.com, arinc.unal@arinc9.com, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, daniel@makrotopia.org,
 lorenzo@kernel.org, nbd@nbd.name, frank-w@public-files.de,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 13:09:36 +0200 you wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series continues mt7988 devicetree work
> 
> - Extend cpu frequency scaling with CCI
> - GPIO leds
> - Basic network-support (ethernet controller + builtin switch + SFP Cages)
> 
> [...]

Here is the summary with links:
  - [v9,01/13] dt-bindings: net: mediatek,net: update mac subnode pattern for mt7988
    https://git.kernel.org/netdev/net-next/c/29712b437339
  - [v9,02/13] dt-bindings: net: mediatek,net: allow up to 8 IRQs
    https://git.kernel.org/netdev/net-next/c/356dea0baf4c
  - [v9,03/13] dt-bindings: net: mediatek,net: allow irq names
    https://git.kernel.org/netdev/net-next/c/23ac2a71bdbd
  - [v9,04/13] dt-bindings: net: mediatek,net: add sram property
    https://git.kernel.org/netdev/net-next/c/c4582a31efd9
  - [v9,05/13] dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for mt7988
    https://git.kernel.org/netdev/net-next/c/588cb646ce70
  - [v9,06/13] dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
    https://git.kernel.org/netdev/net-next/c/66a44adf4c3d
  - [v9,07/13] arm64: dts: mediatek: mt7986: add sram node
    (no matching commit)
  - [v9,08/13] arm64: dts: mediatek: mt7986: add interrupts for RSS and interrupt names
    (no matching commit)
  - [v9,09/13] arm64: dts: mediatek: mt7988: add basic ethernet-nodes
    (no matching commit)
  - [v9,10/13] arm64: dts: mediatek: mt7988: add switch node
    (no matching commit)
  - [v9,11/13] arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
    (no matching commit)
  - [v9,12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
    (no matching commit)
  - [v9,13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



