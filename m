Return-Path: <linux-pm+bounces-40437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B9D021AC
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2021E30DB48E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6E441031;
	Thu,  8 Jan 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WbEJJX9B"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336F441025;
	Thu,  8 Jan 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864610; cv=none; b=OY6vVBnAoMKAhNcHEXCk1LzxVMr/6asSUFX/i48sup18S+4cxTG15OiRr29TEJ2L+R6A6CgiKeVqmDpYyH9Gm9sOeaY1BroG0c8UycBRAi8GRIc9fQrpLhmgBqgQKyXn4zoVXzqmdJLVtkJYipCqLP/H+jlOtN1P5+n9qkB/u7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864610; c=relaxed/simple;
	bh=dsS5OrslEDAfTARqkmhtPqWZh6i14SkuduUVlsumjw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8UP+xkNu4/EW9BYAbLqsIMZLcvNJ2FZ+7zVLyDn3AcSefYmJGi3NQWcpFvNhwDbnpt+Qnz/zJL0J2Bjv8kiKIjwchW1RPMXyt8JXR/1Kke8pokECXBn7+9GoOAzPyMXLrKBePZvOuX6yEhxRDiFEHhyeqOPTTU/MStBIYFs/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WbEJJX9B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767864598;
	bh=dsS5OrslEDAfTARqkmhtPqWZh6i14SkuduUVlsumjw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbEJJX9B2vP1Nh2AXNd1NpB5kxEfnWnK0SnvfAUSKpKF5vYa+7AyWaByWIqUlyNUQ
	 A4v6brnQfBoDxagJhcuZStBRU6nr9VRB1QK2xCL+fgCrgC3RTvSPYucmdmPjb5qUgS
	 JF/qG6ncT+KR+GwDYs29LrBJ3yCWKqMdz3Qdmhj3cevIUV/okig8ug9mlhecUn7hWJ
	 xButQ4sl0+Spld7LivqZtwIGrJV1LUcW6t/BE8GQOVlOIBu7z//p4m6YgimYsaWd5X
	 P9jkVL9FGys8MdaCeWSZWKcm84r7itBNvZB1SEst3oHjgX/OFbkrrlqmAfz1hti6Ht
	 yagpkGduh+cPg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FE0E17E0CB0;
	Thu,  8 Jan 2026 10:29:58 +0100 (CET)
Message-ID: <5c798936-95be-4428-9c4e-251e1dff3001@collabora.com>
Date: Thu, 8 Jan 2026 10:29:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support
 for MT8196
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Henry Chen <henryc.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Georgi Djakov <djakov@kernel.org>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
 <20251124-mt8196-dvfsrc-v2-1-d9c1334db9f3@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251124-mt8196-dvfsrc-v2-1-d9c1334db9f3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/11/25 12:06, Nicolas Frattaroli ha scritto:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a compatible for the MediaTek MT8196 Chromebook SoC's
> DVFSRC hardware, introducing capability to communicate with it.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

dt maintainers, please, can anyone ack this patch so that I can pick it?

Thanks,
Angelo

> ---
>   .../devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml         | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
> index 4c96d4917967..5673d242afcb 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
> @@ -26,6 +26,7 @@ properties:
>             - mediatek,mt6893-dvfsrc
>             - mediatek,mt8183-dvfsrc
>             - mediatek,mt8195-dvfsrc
> +          - mediatek,mt8196-dvfsrc
>         - items:
>             - const: mediatek,mt8192-dvfsrc
>             - const: mediatek,mt8195-dvfsrc
> 



