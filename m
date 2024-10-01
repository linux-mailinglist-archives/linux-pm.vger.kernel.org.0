Return-Path: <linux-pm+bounces-15026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD898C18D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2232B2393A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07261C9DCB;
	Tue,  1 Oct 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IsRCdtlk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B645;
	Tue,  1 Oct 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796368; cv=none; b=mGZ0AuJzQoHuM9PejuY5QP4gQooH4WG+TdvEi9BDVStWk0dZB4nNqN1f8E1Ep6Uy8ipQpktGxyye6nBeUkFScjTdqVompceUjRnHEnV+l9UNeKfzVM1khfRAJehV/t0iBi/IZbUe4ZQKYuBUJed8jN7NcVptNestcD/MotNsNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796368; c=relaxed/simple;
	bh=+YZZSxfbdyiIr93tIMUZDxqaYcghUxhFXzEBtAfe9Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KO6SYNQfkuGY/Y33xFzaMGeWP2McpihAovPxVgW/3SdQFJG2HtNvM6nBWkajzZN5o//9CqzVE5rkF8HgFdwWIGnj8G0Q/mN0OdzjP8j9OvDn3qg4EBTteP5z1nsFcdcat70RorInKYx4hHByM4Zz1x2XhSBI2fTmHNUTvGgdjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IsRCdtlk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727796364;
	bh=+YZZSxfbdyiIr93tIMUZDxqaYcghUxhFXzEBtAfe9Sw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IsRCdtlkZPMbwZhF685OXK4Jrwj57OtfDIQHj1ZDuS1AA3K5BX0ZP7O0HY8uDgHna
	 Ej9yVcpiofM61HL21cd/KWYTTG2XmHoQIbJw7PznJ8mJQbT2GCInkt4SLh65yLIgyv
	 vD+5Sf3esOwjR3PIhtzxULPXDsWeHX2eyLV10QW1jsAqU5tQqLu8lQPTPBjFcp7j5m
	 8UvMF9Z1ApUljwa9IkHvwwYMrbP+eaKpqnMiDV4++YPNdyqvuwhp4adlvQkxPvIQpn
	 ShnMZmveHuhDrVOB1oV5YCJHVEmEqyhf+jw1fB1Pd5B9trw/EdBfFOdrAeLh50tW50
	 phIwzx9zBxqhA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B21417E0FDC;
	Tue,  1 Oct 2024 17:26:03 +0200 (CEST)
Message-ID: <a3089f16-bc43-4ee0-b313-94e5a37cb449@collabora.com>
Date: Tue, 1 Oct 2024 17:26:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] regulator: dt-bindings: mt6323: Convert to DT
 schema
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241001104145.24054-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241001104145.24054-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/10/24 12:41, Macpaul Lin ha scritto:
> Convert the MT6323 regulator binding from the old text-based format to
> the new DT schema style. The property "regulator-name" has been added
> as required property to reflect current usage in mt6323.dtsi.
> 
> Examples have been streamlined and relocated to the parent schema file:
>    mfd/mediatek,mt6397.yaml.
> 
> Update maintainer and submitter information with new entries from MediaTek.
> 
> The reference document cited in "mediatek,mt7530.yaml" has been updated
> to point to this new DT schema file
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



