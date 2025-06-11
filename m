Return-Path: <linux-pm+bounces-28459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73832AD4FF4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924A516CD4D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F5265CCA;
	Wed, 11 Jun 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OR7Ccm7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3925F961;
	Wed, 11 Jun 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634425; cv=none; b=Dy/8iXHU0VIhZkhQFux/xLmM42SV8ykogscPNzBRkeM2Z/ywVY4QSs66Wm14/RydQG5SPVie0YA3uaBAq/FM4LgbPiazSQ/IzBNi6mVVYvz/Olrcge38YCY7jZ4o29zO9/M/b4lGOy9qWNyFp+CaPVd8YakvHtex9JUYqt1nRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634425; c=relaxed/simple;
	bh=34m+rAyPyibqJfcT7OFlHLh8GE8mK4kGKtxYmJ2ytc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk6CeYv2yUAEPetvcp/5TpOI0GGXHIUNi9DuK4ypkV30Ka5yxCny65RO5ZaUJM7CAIg5oN7LXgp/DxL/9Ox9dsUX6mCZkydl+JHtpH5+Z9UHPWa+eBZ2nkdnSt07XxiKkjgGZTp1Zv8ax63Zq7YwqEGC9TQ1VoPA/cBrNjLl6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OR7Ccm7c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634422;
	bh=34m+rAyPyibqJfcT7OFlHLh8GE8mK4kGKtxYmJ2ytc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OR7Ccm7c3ax4tuKRbAp81y0hcQ+3ZxXFk5XZj+eBT4QchyCoZO86EcMYfp994k2V1
	 gje+tgrGZkFOInv7MQCFimbMgf26iAfWcvODLUzqtHLiy2fY306uGzH4P6SfCCrF6q
	 RaviSGrsFldE1v20sn6YPF0mBGD375tUyIptIGnhr/WrDzGiXhPmb5UVfZAXY2EMZB
	 rTLgCXPGc75Fle7udyYeiiBmjccGlcqX4mc5ehRavfCct1uvHIYOVLLL0GMJ7s6ZCY
	 +omlL2cH3iVrHMzPvn/22aUY7VXOFMhIXDC62J8B2ACULR8Peri/E3X7Phm4DaGlYF
	 nyPk+ak70EecQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65F8E17E1045;
	Wed, 11 Jun 2025 11:33:40 +0200 (CEST)
Message-ID: <85fc43ec-5d2a-4976-8343-ab348835145c@collabora.com>
Date: Wed, 11 Jun 2025 11:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] arm64: dts: mediatek: mt7988a-bpi-r4: add aliase
 for ethernet
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
 <20250608211452.72920-12-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-12-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add aliase for gmacs to allow bootloader setting mac-adresses.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

s/aliase/aliases/g

after which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



