Return-Path: <linux-pm+bounces-14510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0297D1C2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 09:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E287B234D4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDB3EA76;
	Fri, 20 Sep 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8CfZv+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB695475C;
	Fri, 20 Sep 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817490; cv=none; b=TBXXTKbJgmBbC0kyb6rN6gQ/RyXqBgbRdvT7q0YlIzqeffEtHeWExizowV/NgmifBYaOoPzBRmoAf9phVNaojbvhPMrcSI021T+Xn7uNo5iUI6zkUjvWuigE91H3bUMACdbrOcI7j74yyEnm/4Jv3GRYjL26TNcAEwUe6gUoQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817490; c=relaxed/simple;
	bh=m7PBRT27J+9/iK8yrsDqlPtfv2hVtsUYjoWCit4BGLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMiJ0b5JB7+pAaBOpF0bkNPCY5a8VX0S1xvyz77/Iwm+tMEse8l7f5cn5TQJYm9Pi8WNPJZdoCujRURlyNA9xQwPjX4qaQXbBt2RtZN+A2TU/BnKIoT2XWSQSUMQyxjXBtPCNPd0eGIpM3cSFNT7UPMCulz+uaalL63Ejac+9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P8CfZv+B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726817486;
	bh=m7PBRT27J+9/iK8yrsDqlPtfv2hVtsUYjoWCit4BGLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P8CfZv+B3eGpCJ6fpLODZfBGZCJWTI4cOrnApghRY3jVfi84T+nQzcj8rOR4gcUUB
	 nKX2/r0oUGaHQn/nbzXlBITh5PnqeeukhXfeXKAUvWFwDcDUxl5tlVmDnYbNENK+kt
	 BofNtmpzl8+c7X3ccNRMruofrXHcSUP6RWQ5SK3hQ00OtP3hAOGCeiketBOKsnAoFU
	 Kt6J7db/Ra9Vcl+1Xn+M6rQJ3JWKl3q2jQR2V3+KPoXOx8Lx0Y9yXT0CGJCpSiU5Cs
	 KMPjJLOuAdIOppfsMayex80G2njTULEIJZXWsiQwCftKasWAtxOrLIu/32bD83qXgE
	 3Xgj9sibirUVQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D81017E0FD6;
	Fri, 20 Sep 2024 09:31:25 +0200 (CEST)
Message-ID: <d8b90ddf-efbc-4434-9ad0-4be6942d51a5@collabora.com>
Date: Fri, 20 Sep 2024 09:31:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Sen Chu <sen.chu@mediatek.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang
 <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240918064955.6518-1-macpaul.lin@mediatek.com>
 <20240918064955.6518-2-macpaul.lin@mediatek.com>
 <20240918115151c896f33f@mail.local> <20240918115651c1475d36@mail.local>
 <2af0621d-14ac-b7f3-b28d-2df698931121@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2af0621d-14ac-b7f3-b28d-2df698931121@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/09/24 16:18, Macpaul Lin ha scritto:
> 
> On 9/18/24 19:56, Alexandre Belloni wrote:
>>
>> On 18/09/2024 13:51:51+0200, Alexandre Belloni wrote:
>>> > Changes for v4:
>>> >  - Remove "mediatek,mt6357" from PMIC's compatible string since there is a
>>> >    seperated DT schema for PMIC mt6357.
>>> > > Changes for v5:
>>> >  - Rebase to next-20240913 (linux-next/master).
>>> >  - Fix the "title" (device type) of mfd/mediatek,mt6397.yaml to "PMIC".
>>> >  - RTC:
>>> >   - Drop "start-year"
>>>
>>> Maybe, instead of dropping the property, you should add support in the
>>> driver by setting range_min and range_max.
>>
>> Looking at this even more, the driver can probably be simplified by
>> setting start_year in probe and dropping RTC_MIN_YEAR_OFFSET.
> 
> Thank you for pointing out where and how the driver should be changed.
> However, I'm wondering if this should be a fix with a separated
> patchset (bindings and the driver)? The board or SoC's device trees
> should be reviewed as well. I'll need to get someone's help (permission) inside 
> MediaTek to check those dts and construct the patch for RTC driver.
> That will take sometime.
> 

Alexandre, I definitely agree with you on the fact that the MTK PMIC RTC driver
can (and needs to) be improved, and that it can make use of some nice cleanup...

... but!

This series performs a conversion to schema, and the previous txt file didn't
say anything about the start-year property - which was not mandatory to support
at that time (nor now, afaik?), so adding support for that is out of scope for
this series.

Eventually, that can come as a series on top, adding support for that in the
binding (and, of course, in the driver).

I should be able to tackle that... most probably next week - but still, the
improvements would come as a series on top of this one.

Cheers,
Angelo

