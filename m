Return-Path: <linux-pm+bounces-29265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93864AE3A99
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6A1647CF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338524337C;
	Mon, 23 Jun 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MTBpNLRk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4423815B;
	Mon, 23 Jun 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671150; cv=none; b=crFRHtraf+OIkPbYrC/ojB0J3ox9uA8ODcPZN0o5y1IUFZXfz8D7rjAFeVDS96UIdtvcYIBrMa0oS2R16OayjPfqn2+y/6iUgRNchjWFxl2U3mjsf+1C20EtqRPpoF62OBTq13wOUbghwT4PbMnjsuV6LZqB/hxjnL4rcTI/sUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671150; c=relaxed/simple;
	bh=36tf2K/9hUByUZGrXncX4bNZ2l5rw2ra9GVPJ2PLCa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se2u6iPTaJLar63Tqju9VzVkSoawZN+Sc+LaRhigKi6JT+zOP4ojLLuIRXRcgfsPsKzXBC2nBcjwLBmKAQjf9/KYBdhfJ9Nnf1GGgxYigXcwCR5iOTTw7AcjdsV0TtcO0sMTzz+Rh9aa9h6whx8zwzy6T1YAe03s+g7WHSWAp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MTBpNLRk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750671146;
	bh=36tf2K/9hUByUZGrXncX4bNZ2l5rw2ra9GVPJ2PLCa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MTBpNLRkEKEkVz5HWfPsaefWPF4KLf5W0VPAu0pSafLVBQ50mxtEzmfJwnPadjE4m
	 yo8PWJFEbbMoebAU+WCvR6UBobF1hZM6pMMo1iEfX0sw8zVm4JEjzmQFF0JdkuOzGE
	 h50nJ2XnOrBEunWptBVlVo9vCeJLQiKv+Vb13C2lk/Ej8ICx28iqexYbxpIDrQ3XUs
	 7OGgftAlLQRi2py9fggXQfhW3bW4Tb6y2/WGYXYN3TCXXbAUfnGUfkbcc8xjSutNa4
	 Mj5tSy/DMvjqJNVlFi9axNTVDTlCDRD3sZXtBxVVRcnXE7qRNibXxxbVNqgbzXxTDP
	 4XnKqxEcx2WiQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 30C4D17E05BD;
	Mon, 23 Jun 2025 11:32:25 +0200 (CEST)
Message-ID: <df51b1ce-a205-4e4c-90a0-e827f87a44a1@collabora.com>
Date: Mon, 23 Jun 2025 11:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] dt-bindings: net: dsa: mediatek,mt7530: add
 internal mdio bus
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
 <20250620083555.6886-4-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250620083555.6886-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/06/25 10:35, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Mt7988 buildin switch has own mdio bus where ge-phys are connected.
> Add related property for this.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


