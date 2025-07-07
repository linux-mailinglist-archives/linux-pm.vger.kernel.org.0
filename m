Return-Path: <linux-pm+bounces-30256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39FAFAF89
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7713E3BE631
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAF28D8E8;
	Mon,  7 Jul 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hnItabx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A528CF7C;
	Mon,  7 Jul 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880156; cv=none; b=X+jyR+JobfkhDXZYw2MXbZEYfO556L9JMOydnt1eLdCXzuUNTbi8b1CMtOKzVMoH2FxjS+vVH2jEBI2l1e01qPKAazgMLRlxyJL3t0v38wTCqnSaH1lU0bJoGlcpg3ZbHXN29H2FNOUAeLktwIcDos5VYz5OO7BVb1pk41xy7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880156; c=relaxed/simple;
	bh=kaWeX7KKkf1DeQg7+StlJB5g41RBud8WpmRtSGs7VWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FBbmxa9SBENtPIJ9zxwo1N8YXRWq7MGswTuylx7HLaJyEUfM7jf+WDguBy/xdQ/Rl8z0iOKyEDbEkNjj5B6wE4bRi+G34E1CeeSV661hvX3/FFD8LUUL/8owQzqynfkttWiQ1RCY6Mr9f+Rauy784fSZFPf8uix/Yz8L2aukCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hnItabx9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751880152;
	bh=kaWeX7KKkf1DeQg7+StlJB5g41RBud8WpmRtSGs7VWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hnItabx9D+lF43Q0vxGNVa8XbTRVhlY3oAf3P61KfeTQXFEPJ9Yklj4hA/F4vD6JF
	 iKk/2QgWf1iMcb35g16EozKH6Ck/gOG1/yI1BE3daKt9aYHAaYTqf22REp0Te/TdGa
	 zfPNUgv+4vEy2xv4BNt6fdcVXkIhKbUmmzC0ulxsakNNjTLOcnJg/QsgOhy16W3AbS
	 z8HQXjioQZbx5WJETw8JTc1RStFiTbY1smY7dg40fhm4e0SYX0UQhCDPkCOg6LFxFx
	 RL6eAZfqVzqrRco6IUTUO8zEt5Qb20uc5cCgYxrcuLbZ2RUzUvQ4oVElqFq3gl9uis
	 BNIPgPhXcDvBw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDED317E04AA;
	Mon,  7 Jul 2025 11:22:30 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Johnson Wang <johnson.wang@mediatek.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20250706132213.20412-1-linux@fw-web.de>
References: <20250706132213.20412-1-linux@fw-web.de>
Subject: Re: (subset) [PATCH v8 00/16] further mt7988 devicetree work
Message-Id: <175188015088.67037.6051435285718584853.b4-ty@collabora.com>
Date: Mon, 07 Jul 2025 11:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 06 Jul 2025 15:21:55 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series continues mt7988 devicetree work
> 
> - Extend cpu frequency scaling with CCI
> - GPIO leds
> - Basic network-support (ethernet controller + builtin switch + SFP Cages)
> 
> [...]

Applied to v6.16-next/dts64, thanks!

[07/16] dt-bindings: interconnect: add mt7988-cci compatible
        commit: bd9e0f5d90959d2d07986084fbd58042b62aa549
[08/16] arm64: dts: mediatek: mt7988: add cci node
        commit: 0cbdb6d04689f8c05074e348c8e0a42b229ef9a3
[11/16] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
        commit: b5a4ad957114b59a74b3e3f598ae0785dd86cd32
[12/16] arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
        commit: bc51660cd5fd2d0ee9a65b59e0c65e2d1b65975a
[13/16] arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds
        commit: 5a40efb8c9d26e51db8acc61e920c3eda9407c02

Cheers,
Angelo



