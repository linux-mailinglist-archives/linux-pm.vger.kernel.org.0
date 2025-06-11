Return-Path: <linux-pm+bounces-28460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B0AD5014
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B82C18865E9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F3267F65;
	Wed, 11 Jun 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OaYEbMNu"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC525F979;
	Wed, 11 Jun 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634427; cv=none; b=YIjhzCtPCOghyHjzE1JEZpa27EJaltuU5xRdVptubqNDwJzh3HWdEqfPDswnGs3Ifygko2halgBhTY0m+i6VPAtpYXzGk+jdxzqQbdDy+5cngohKbn+BWskLGFoOPKIXCOtTZkbcVoHCSfE/AwmhA4T/ndnuYHUqJi7AUOBu0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634427; c=relaxed/simple;
	bh=lAO7ICT8rPi2jW/yKmCQoIc5yJNSzG6H883GDZTA6Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7BgtC3JppxyVNjtoBtc1y88awkQTOFUgBDyffwcNMKL5AiY6LVEveo1jdPCXjsYT6DYsqQuqKqs1OH7UbsNby4mMJfPdrM79Y3jh1bXx1j5Qv1oKAE15ZLlLYtdNzP5huhTtqpZ97hmryHxUvTOK3Gcx/ULDyyt4cKdPJdWd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OaYEbMNu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634423;
	bh=lAO7ICT8rPi2jW/yKmCQoIc5yJNSzG6H883GDZTA6Eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OaYEbMNudDi8ORJRv5JVQtJGvVka/LQLBHfvrTI/7GMZbfUSONdbHLFx5Sud+94ZY
	 K44xXTp7i6goU83CFlmdDpcFtQk6gvCc7vDWoSaLKCdoRZdBA4ulZppatpjbtcdtLG
	 vrlX65aGJo8JUrl337gzmeXj5k0tN3kfes5aefLkRFgKchXgflY+Z0tB6qwh4yRcZx
	 /jq8u0eqAH59fg0Gl8SwVR/NbKscxrT7QXwA9BDI8I4AVdaPNJ5jlk7Cjl5QjR+Y5O
	 OXUlGjDVYSaYIsCwwbWJ6ybsOruAea2A3NXWy/5+9C4I9CxFXkuXRLtY3MFEwQHzV0
	 7WUCcv0/qmdpQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 253A617E3626;
	Wed, 11 Jun 2025 11:33:42 +0200 (CEST)
Message-ID: <12816e74-9708-4e83-939a-347e1f6f6f5c@collabora.com>
Date: Wed, 11 Jun 2025 11:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] arm64: dts: mediatek: mt7988a-bpi-r4: add gpio
 leds
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-11-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-11-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Bananapi R4 has a green and a blue led which can be switched by gpio.
> Green led is for running state so default on.
> 
> Green led also shares pin with eeprom writeprotect where led off allows
> writing to eeprom.

This is extremely ugly from a hardware perspective and I'm sad to see such
a thing here.

Though, I don't see any other solution, so I can only give you an advice:
don't ever write to the eeprom from the kernel. Things will eventually go
south otherwise.

I would also advise to add a read-only property to the eeprom node.

Regardless (and sadly),

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


