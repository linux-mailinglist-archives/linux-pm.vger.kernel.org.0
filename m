Return-Path: <linux-pm+bounces-30264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9302AFB0D9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BABB1AA3CDE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A78292B5C;
	Mon,  7 Jul 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n9KLjXG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6B292B2E;
	Mon,  7 Jul 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883148; cv=none; b=ayZYMINWuWkTyenhZe2h7E5VgtGeCQGAzWn2/DihB3alvtz5nzr89s75lEg+aUNaGyawkYe8/Y2yuKoiTL1vQcjlXtufheJrXWEheF+N0fyjY4bPziAn2sX0OpC8DaGSXL80b0NvutbyjZ5IH9VTzkYIsL2menS7Jn0qjqO5m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883148; c=relaxed/simple;
	bh=r0u0KcLgNzqStPxSo8tNTI+lkrR1NVJwDZIEcjacuXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED/la9kvfvfXguueckJ34F8lAwIw/01yNRr9mSC48FPce4zhPJvdjCESdrBltpFxjYIAkYOmD3nOFcR+EC3nMZJZDV8q3ZaT0hGzet5IdFCpVcsQUwp/zsXB0pdY07c+r7qUwKTTataHc8/RWHUqaf+4xcezcxj16BlCQmJOSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n9KLjXG5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751883145;
	bh=r0u0KcLgNzqStPxSo8tNTI+lkrR1NVJwDZIEcjacuXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n9KLjXG54zD5nFCXqGHYJz1ZCGMjNx4MjrSwYaLCagMT0d5jOA7Ql42QP/jyVKxOl
	 WyH/nVjMD6yR8Zw3Ut4FLF2g1tZ351hEXfY9ltZmvSZKEEES8iuZqdIfZF+LDll/v0
	 4Ouk3jZ5v5wN7zL6x2ZhEMNqav1VVZMP1lqs9Z67ZxMv79/JpWjsFjzH9vg9+Z+++q
	 wiXgYhxW43HUKJBV32Ms6HV+Bdqhj5mThE6+z6h3ZN8PcbndePIEjjJ7+MPJB1EBmy
	 hkutms8W7aKyUu0a6cRL9NtzFritm3VP7iTrlUZ07NkUJVoyGvcjgK0LBuZrjK7n2T
	 8+zlzF7Gj5ueQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6C9A17E0523;
	Mon,  7 Jul 2025 12:12:23 +0200 (CEST)
Message-ID: <f4d046ea-f599-4b4b-a50b-bae00f9f3996@collabora.com>
Date: Mon, 7 Jul 2025 12:12:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] dt-bindings: net: mediatek,net: add sram
 property
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-5-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250706132213.20412-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/07/25 15:21, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Meditak Filogic SoCs (MT798x) have dedicated MMIO-SRAM for dma operations.
> 
> MT7981 and MT7986 currently use static offset to ethernet MAC register
> which will be changed in separate patch once this way is accepted.
> 
> Add "sram" property to map ethernet controller to dedicated mmio-sram node.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Honestly, I was more comfortable adding the sram to the reg list instead,
but I know that you got a negative review for that. Oh well.

Please disallow the sram property on SoCs that don't have the SRAM (sram: false),
after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


