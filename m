Return-Path: <linux-pm+bounces-41005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4AD320E5
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E8C30422BD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901325BF13;
	Fri, 16 Jan 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="kgTCFU+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A920FAAB;
	Fri, 16 Jan 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570837; cv=none; b=XKZhFnlPMN5pM0kHiUaCbCcbGy2ZeQUcMZNvsczKQPjRbmk9w0eSPOcU+k8RDeGr/NGJz47+9vuBT0Gtph2BF4SYbLRaeCPdw4Q1iINkrRv6y289wHbYw/yQ/2s5RygFn0VE01dWKt2FV8EguissKCOD+EcpGwIjmLQh3yzhkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570837; c=relaxed/simple;
	bh=wRsPfK3Hgs7TocoZMTphfOdzcGwXquz81kzI/A5RpTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmw+90TVZ1/am9ekzSDt98rZIIiBl+sH9Zc1Y7pe7bj39INPajBU0B7j1s2BjQkFmgqdR2/6aXgdBn4NQKz1RfVe+zVLSEJ1AVXkr9mm9AdhTrKkoo3R80HzxTkRLWXiA93yQgyi6pOVJqi7pXJo5j7w+pJ9ebcg7MkrZ4aAFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=kgTCFU+r; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1768570833; x=1769175633; i=frank-w@public-files.de;
	bh=q/rqm81BnB9keHnD0B29jzFFavFXBqCbpg3qmxdknVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Reply-To:Subject:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kgTCFU+rPO9tgnPmEYNGtNb0Ltx6wUGz+g8chW6CGxLOz+mEtzOl0+X/bNYDHte0
	 53ufqfN06g5PDTRawKk6L1byyFa/pkvlq9eBVwLTgUAvMFgU4dSDgH/O6edO9u3g4
	 ZZ2Zjg27ZUGwGx7p9ask1ZbZHtIGNRrybhxAxPCMCgoe8yof9SfXFjx0BEr7AubrO
	 vJHhponCUKH0BXfKYawoIs2oY37d13xAMbEFG5S3RvJsbXDlnYNi6Bw798t1boMea
	 FzMWA8JzHLwkXSssvBLCSTdIxbw8J2HWEtYnrWDQT2YnEBj2Z/+pxl4XfAue5ROTA
	 w0lrgMD+IU4EXNXeXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.21] ([80.245.79.4]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1vEAZN0C52-00Vu9s; Fri, 16
 Jan 2026 14:40:33 +0100
Message-ID: <4d428d8b-4660-422f-af36-808704091dc3@public-files.de>
Date: Fri, 16 Jan 2026 14:40:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: frank-w@public-files.de
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for MT7987
To: Frank Wunderlich <linux@fw-web.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mason Chang <mason-cw.chang@mediatek.com>, Balsam CHIHI
 <bchihi@baylibre.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251223175710.25850-1-linux@fw-web.de>
 <20251223175710.25850-2-linux@fw-web.de>
Content-Language: en-US
From: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <20251223175710.25850-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JAZEMmry8fBh48XvkBwat+o55XMk6tYvS4dtXPXHFDHzrOonORG
 pyUAZvwgSEKynDJh+Vb2HwsnYCVAy/dnNkfpLFeye/nkQCeKDu2/aDw94E7mDtchficMbUW
 9Yl1FdAGt+y9iheE4RomisZnq7VWabrBpcelT1vWvKsemaU/q9RqLQJ6EUjLN7oln9Ehbzs
 nr7/QF97SfJu5NNa0GfrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/nVPw0Ou9F8=;IL1A7dlL0ZDytElwt8dzMXgt95b
 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

Hi,

just a friendly reminder for this series

regards Frank

Am 23.12.25 um 18:56 schrieb Frank Wunderlich:
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add thermal controller definition for MT7987.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml     | 1 +
>   include/dt-bindings/thermal/mediatek,lvts-thermal.h            | 3 +++
>   2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-therma=
l.yaml
> index 0259cd3ce9c5..a9befb523fd4 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.ya=
ml
> @@ -18,6 +18,7 @@ description: |
>   properties:
>     compatible:
>       enum:
> +      - mediatek,mt7987-lvts-ap
>         - mediatek,mt7988-lvts-ap
>         - mediatek,mt8186-lvts
>         - mediatek,mt8188-lvts-ap
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/inclu=
de/dt-bindings/thermal/mediatek,lvts-thermal.h
> index ddc7302a510a..e9780edcd26c 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -7,6 +7,9 @@
>   #ifndef __MEDIATEK_LVTS_DT_H
>   #define __MEDIATEK_LVTS_DT_H
>  =20
> +#define MT7987_CPU		0
> +#define MT7987_ETH2P5G		1
> +
>   #define MT7988_CPU_0		0
>   #define MT7988_CPU_1		1
>   #define MT7988_ETH2P5G_0	2


