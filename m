Return-Path: <linux-pm+bounces-28465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31680AD5010
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E43175A8D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22942620CF;
	Wed, 11 Jun 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ns1HNtIe"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A422206BB;
	Wed, 11 Jun 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634458; cv=none; b=cDUR/5pkpoztLcLy+hnmAsRBVHK2iQ/e5voCuCKSJY/XT1m09WlzPKaGqMtTq2QF121M0GLDYNnvHQubRxsR5gJfYd65oDOGtNoPb5ySw5b8KJK1Al+flJ1BA7h6Xorswnk1t3HCaqgCBIcDThRq643fs1759/3mjTza+22HoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634458; c=relaxed/simple;
	bh=FOlfdDe+uf3ideT45DVapQQIVFNVGe9nFtZmOza3q8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmzEiaCD2/Zas1oShVZDVyYNs6Atc5zEEkOXrzRff49aAhDaCgpLQAkxLtuBJpXvg8DsKp8MGkxmtVz9cbNxgM1s28fD4Lm9JeiC9Bq3lzMxi3DuOSyjiYIrADeBcBEqIMHR9So8TzTVnhrKcxI+240g5ZcNi+Pon5zu2rPvVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ns1HNtIe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634454;
	bh=FOlfdDe+uf3ideT45DVapQQIVFNVGe9nFtZmOza3q8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ns1HNtIe7ESq+ZeiqmSrYo/NHEcdKC+QqzVjHIS3QDMpTCfiSubumWM+xYBnjxTpo
	 tXpW/PpBKRTxRHtolPcqxHkLoHzTV6MQiyyELq33qdz6KcFtzM2rCeTRuXaMKlojYp
	 AW1OreTPsKpeFLJAbb5oomsTsJgOH75tY2ymMdxCa4yBNO5+0Ou1eznkmXr3uO4FbX
	 KztC2vmU25ERWtbqg5YUcrRUgl0bIOajgWLSz8G3/ua7/2HXVO8mEjlkYLt5rQ6mML
	 c3cBkWpRYSHRFZbkbqbXcx29VdWi0aGPeo8CQxivdNUlx/Ze/AERhjTUQ5OcMx++W7
	 Eec2GrqGtiRKg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6282E17E05C1;
	Wed, 11 Jun 2025 11:34:13 +0200 (CEST)
Message-ID: <c978b62a-3d5f-40ac-a0ab-13d7c81eb9dc@collabora.com>
Date: Wed, 11 Jun 2025 11:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] arm64: dts: mediatek: mt7988: add cci node
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
 <20250608211452.72920-6-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add cci devicetree node for cpu frequency scaling.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



