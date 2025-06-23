Return-Path: <linux-pm+bounces-29264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91674AE3AA8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C8F3BCA4E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47723C510;
	Mon, 23 Jun 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B2AkBD2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754A219301;
	Mon, 23 Jun 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671135; cv=none; b=me4vT9LGp1qHfvU36PkQBHy55/cH11c6kAZrgaQowMXRKkLu8l5mmc+Mf01CxeePGVTomEo9dkuv6TyKRjg+0by8R9h7DlFX0SaDb3mJMH88yBEYQaEhc7J/7FyCFkuIhUY+lZNSHK5Q4tRTjkrWeu4jVQ7/kwbfZcxFR7leQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671135; c=relaxed/simple;
	bh=Uh1SmrFE3wdw/cPkwQjay39ohrqiBFdxOB2U7Xc19d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3rzRL/1BPh25pVgDQVtlz7R7EswGmiwxFPvl2GPZV4Rs7vyuaP9chGXUjC/+Y4gd0114SA4W0xpQ1D3EJucWimAejwawWlm7tEDy53+uuuk5KaSvB3fuBm4PMgsqut52BMNP9py+EB07m65SFANlzylkmhP7JArlOhl4uNRTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B2AkBD2+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750671131;
	bh=Uh1SmrFE3wdw/cPkwQjay39ohrqiBFdxOB2U7Xc19d8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B2AkBD2+MPg1Miz03CgmE94LPkTv+3zBIl2so/3V/ZZDm7qxsKOhnnN4SGNHxBCXP
	 xcgnJEfiLj4/pdM9jaw+0GvsUIkVLMxrB2RXW5BnBL/9Ad3QCfUq0jZ071XFy4xbVq
	 P8nFJTXbg428VGkr98cZfUmEeoBw7clNt8AMSZfvCFWhbO+13kply1YnVUpMpHcZR6
	 363+CagJx8mjHgkAxSFXKc2yq/7GeeGCzSx2PT3GN/jVQfza7kHozxhJyXhGwuaLc8
	 AmuB01YrL4whEGQ3JWwzFXCNmx9ejr3z+22vjZPl6tVsuwFb3Wmii62QElaPHBFg3N
	 TBFx4vB8zwIHA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6AD1E17E05BD;
	Mon, 23 Jun 2025 11:32:10 +0200 (CEST)
Message-ID: <61ed8a51-9714-482f-ae92-184a991560ce@collabora.com>
Date: Mon, 23 Jun 2025 11:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] arm64: dts: mediatek: mt7988: add switch node
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
References: <20250620083555.6886-1-linux@fw-web.de>
 <20250620083555.6886-8-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250620083555.6886-8-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/25 10:35, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add mt7988 builtin mt753x switch nodes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



