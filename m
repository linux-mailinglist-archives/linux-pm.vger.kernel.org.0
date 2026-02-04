Return-Path: <linux-pm+bounces-42104-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGffLpCFg2llowMAu9opvQ
	(envelope-from <linux-pm+bounces-42104-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:44:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4398EB14F
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B505A300B9C0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163734C134;
	Wed,  4 Feb 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkNweY8d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45534BA49
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227047; cv=none; b=eA0fxMPkj3dYyEg7GcktoVzR9FNLa4DBpDjALDcONRvKXUw1HIiR730hi4ADdWaQgKcEc6Btogw0Wh5zuf3i56z8rrtZWqOYVbEwAXNfjfAg9pLtBhlG9RIijVzjYdb2FmVszi4J+2k8CAJgDQSFUQAE0YM8NZKWs05E+F9mLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227047; c=relaxed/simple;
	bh=jGXvVqbPNRfyNdjCY6p5HADCLs3mN1YVjumW8TSHVBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4JIB6O0pLG1XDs8379A9jZh1pdE0qnqTBW8jz9ejSlJUXg40zouXhLLgG/jaZrYl7hJKQu8Ba3MDeirHlPhkQ0P10v1DUTwaJgshDtkNcE/MyVYsXKLY18eZaZ4ubokkld1ya/nHw8ft/AnLC+BTbG3h1Y6YZR0jnIgvLRqGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkNweY8d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so699095e9.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227045; x=1770831845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=epZt+Y09pHufvgU+ObynUBr16JQc3dEVQrLIjJohvYA=;
        b=EkNweY8dN91/MgyhunxOsR6RFXj4uAxyotRBVNncdm6urwQUoUky2478KCmCrAnhED
         0U0vHzPHSO6/LvBcl5KcsanZriynrxHQ7ed1g8fsbmY9pRKQr7CElshKHbi9UmPYLa+E
         9TJ2Y3k5s3pHBZD83JDHJIXPokNtuStK9hO8JhifYtIMbjLZSEy7jyHn5rorodXefC9L
         HgbHcyRQYC29bjxih05MSDnuLQPokIkYut/c0gf57nzRHPtfFNbkZYJJlLRY9alkMJk2
         BKg+/UnYvnFcdvsMute4LDZ5X2RZVXb3f2LgtmtnhtXsJV9JcNLxo1oVCqSMQd+0J53q
         8lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227045; x=1770831845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epZt+Y09pHufvgU+ObynUBr16JQc3dEVQrLIjJohvYA=;
        b=PUUDLFT9mMcoeLn9cucuFlTMF30nxSojLYpYhI65A2X0NWg3l6k8MGnf4F+qOzzYvI
         WVt9oosYcm3VPvMn0Ev3ZtCQ3yerPWs/CpDtuE1LYvaWaNgLBVXEyEAvCkVh4HZiUSqz
         WGH0+4BVlZRAa9Toy7gFSgA9gPjVW7RA8F1RBYFBht559rUQUmsrKhaSQLd5sWvVADmP
         feWwlmzJbPEcIq2W0OwmlnT3pJV/mBMcV1R6Coc4YShSEK8Q5CDme4ZWY0xGCUnW5tgs
         fd7KWkphk1rp5BtM0LEqYcZzrqLbRGUqo6R7qqBK5b91yBmGCcra5LQlRNYJEk/2vFoD
         f2hw==
X-Forwarded-Encrypted: i=1; AJvYcCVYsxn9HYiKTFTd9ZqJPH3QRxENVwOoe9fKvtUXlX7z+C84h0T1O/xXsObFO/qgCsZ19OPJLpVB0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfGqX5sXbwaf6aBZd9kTeCB0txPTLJNWMmxrqIIAnS0VaCHBN
	vwOrtPUhNxPhmGusbrL5E1rt0KUNuOlm8aQyOl/UcPclxGb2NkYDx7Ez
X-Gm-Gg: AZuq6aK0l7wlSAC4umVY/cMKummrehHRO10WqfxImckHjPB7NtCir2tcRh5+MKogEPL
	bq5hijoceVdu0lIanyd+p7M3f4vwauJQ4rRohTr0XxsLsFS02XOlzIv3WQhzdn59Z2GPnLOX9Wd
	8NN8jLxFdtrOQJKzUctKMksWCHuXImtUcIw0At81tAjH1EcktddwBbYGFwmkWPppoMgqFf7fCAK
	0U+TSr0QVOUj6PHl72XHA35DX6ptTnUsjxks9ExvoQglia4AvkNDEE8rc6WocAIR/7BLm8akI0Z
	6o8kS1zhbujn9Wn4kYE5aAoyxvXdAe135aNfZgjAWVkmFgfVjwOXSzNMJS+RIYzb+jjbb8ERSv7
	x1lLRxSsUd3Msb8dvrRzc9Q4iT4JFSfZg8j9Y6LZOfDtS4Nk+WldUKcDj9tuhkmuDJnzixinTLv
	l72QJh79ncFukNgi+Z6huYpn8KlqT4aEtFjbXlwlMmvNST4a5ghhWJP4tFu/oR
X-Received: by 2002:a05:600c:8712:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-4830e975764mr58651935e9.27.1770227044879;
        Wed, 04 Feb 2026 09:44:04 -0800 (PST)
Received: from [192.168.0.29] (static-95-59-231-77.ipcom.comunitel.net. [77.231.59.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec57bcdsm44293525e9.2.2026.02.04.09.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:44:03 -0800 (PST)
Message-ID: <4b5918ac-5b8c-4839-a550-da4fb1a1f442@gmail.com>
Date: Wed, 4 Feb 2026 18:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add MediaTek MT8189 power domain
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
 <20260202064820.347550-2-irving-ch.lin@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20260202064820.347550-2-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42104-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,linaro.org,gmail.com,collabora.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthiasbgg@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4398EB14F
X-Rspamd-Action: no action



On 02/02/2026 07:48, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add dt schema and IDs for the power domain of MediaTek MT8189 SoC.
> The MT8189 power domain IP provide power domains control function
> for subsys (eg. MFG, audio, venc/vdec ...).
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../power/mediatek,power-controller.yaml      |  1 +
>   .../dt-bindings/power/mediatek,mt8189-power.h | 38 +++++++++++++++++++
>   2 files changed, 39 insertions(+)
>   create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 9507b342a7ee..07f046277f8a 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -31,6 +31,7 @@ properties:
>         - mediatek,mt8183-power-controller
>         - mediatek,mt8186-power-controller
>         - mediatek,mt8188-power-controller
> +      - mediatek,mt8189-power-controller
>         - mediatek,mt8192-power-controller
>         - mediatek,mt8195-power-controller
>         - mediatek,mt8196-hwv-hfrp-power-controller
> diff --git a/include/dt-bindings/power/mediatek,mt8189-power.h b/include/dt-bindings/power/mediatek,mt8189-power.h
> new file mode 100644
> index 000000000000..70a8c2113457
> --- /dev/null
> +++ b/include/dt-bindings/power/mediatek,mt8189-power.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Qiqi Wang <qiqi.wang@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8189_POWER_H
> +#define _DT_BINDINGS_POWER_MT8189_POWER_H
> +
> +/* SPM */
> +#define MT8189_POWER_DOMAIN_CONN			0
> +#define MT8189_POWER_DOMAIN_AUDIO			1
> +#define MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT		2
> +#define MT8189_POWER_DOMAIN_ADSP_INFRA			3
> +#define MT8189_POWER_DOMAIN_ADSP_AO			4
> +#define MT8189_POWER_DOMAIN_MM_INFRA			5
> +#define MT8189_POWER_DOMAIN_ISP_IMG1			6
> +#define MT8189_POWER_DOMAIN_ISP_IMG2			7
> +#define MT8189_POWER_DOMAIN_ISP_IPE			8
> +#define MT8189_POWER_DOMAIN_VDE0			9
> +#define MT8189_POWER_DOMAIN_VEN0			10
> +#define MT8189_POWER_DOMAIN_CAM_MAIN			11
> +#define MT8189_POWER_DOMAIN_CAM_SUBA			12
> +#define MT8189_POWER_DOMAIN_CAM_SUBB			13
> +#define MT8189_POWER_DOMAIN_MDP0			14
> +#define MT8189_POWER_DOMAIN_DISP			15
> +#define MT8189_POWER_DOMAIN_DP_TX			16
> +#define MT8189_POWER_DOMAIN_CSI_RX			17
> +#define MT8189_POWER_DOMAIN_SSUSB			18
> +#define MT8189_POWER_DOMAIN_MFG0			19
> +#define MT8189_POWER_DOMAIN_MFG1			20
> +#define MT8189_POWER_DOMAIN_MFG2			21
> +#define MT8189_POWER_DOMAIN_MFG3			22
> +#define MT8189_POWER_DOMAIN_EDP_TX_DORMANT		23
> +#define MT8189_POWER_DOMAIN_PCIE			24
> +#define MT8189_POWER_DOMAIN_PCIE_PHY			25
> +
> +#endif /* _DT_BINDINGS_POWER_MT8189_POWER_H */


