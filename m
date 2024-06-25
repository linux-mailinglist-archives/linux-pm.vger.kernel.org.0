Return-Path: <linux-pm+bounces-9936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5910916158
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2362815BD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809E1487E3;
	Tue, 25 Jun 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JQgg1H47"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7214831E;
	Tue, 25 Jun 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304355; cv=none; b=WtzEX5FITpNJkxbwvYAQ7se1uGb+/eQxc9KfpACV2yKsQzLM/nJ7VPzPHQ48cM8+GBL5b/AKF7M5RS1e4fqI8R+SCxlthxh9z8uK35cTYeOJ58d47wcvF8bH5jm0qkZZE9EmoCAMHbXNsT8Z8usH/rQez3F5VHu9sQHKhyZ/9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304355; c=relaxed/simple;
	bh=hi3MSzsE8nwxCxFsphtLi2390SmR1eVJsA70Ej66c/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or7uStE8nEazMnayfYURmtHac3QzXu3nK8ZvLCxTuc0mNSeEvloGl3k3K7sRCiUHittFAo0DMJ9JEumsX2FKBAZQIeg2GzqZRrH91HCaf5oYcU/Qgj+ambY/OuG+8zZDp1MiJk5eTj4cmbK306XtrKNu5ud2c+NIGMwN137lAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JQgg1H47; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719304352;
	bh=hi3MSzsE8nwxCxFsphtLi2390SmR1eVJsA70Ej66c/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JQgg1H471/eyWzk12iOuyhV+nOj3YKnA13h9EuESkv8cHr1d88Xp6y3NI+CoBrnqB
	 zIGXMh+ADemAqOCuZeMjhc7hd22M87WllhIGQnITdrmUlf+X1p5e+BES1t4WUeSBNg
	 MuseE456LrBeSN/rrQJhymIAYXLOYdsZLnX8bKcmEBpoUkDYhAyFOJMr+WGNtXz6l3
	 gFCrHntDw317dKhswm9wnlsKQFYLOFpkRlGshtabuY/+Qs61o54itTx3D+r1PAmlf4
	 X3LhJfMYQqLXY3acCgVqPxBsXl3IkkMGHaAhJMpDLRMQ5NrKj87owcX7b3j2G9YOSc
	 ixID8iBYdOYDg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31E95378045F;
	Tue, 25 Jun 2024 08:32:31 +0000 (UTC)
Message-ID: <f7b4cd98-1acf-4f6b-a7e0-57419abadba1@collabora.com>
Date: Tue, 25 Jun 2024 10:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: broonie@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, keescook@chromium.org,
 gustavoars@kernel.org, henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com,
 djakov@kernel.org
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/06/24 10:57, AngeloGioacchino Del Regno ha scritto:
> Changes in v6:
>   - Fixed build with clang (thanks Nathan!)
>   - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>   - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
> 

...

> 
> AngeloGioacchino Del Regno (7):
>    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators

Mark, I assume that this series is ok from your perspective, since this has got
your acks and r-b -- but in order to pick the soc/mediatek stuff I need all of
the dependent bindings to be in as well .. and this includes the regulator one!

The main issue here is that the main soc/mediatek dvfsrc binding
dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
does use the others, so I can't pick this one without the others being present
or the validation obviously fails.

So... gentle ping :-)

Thanks,
Angelo

>    dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
>    dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>    soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
>    regulator: Remove mtk-dvfsrc-regulator.c
>    regulator: Add refactored mtk-dvfsrc-regulator driver
>    interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect
>      driver
> 
>   .../interconnect/mediatek,mt8183-emi.yaml     |  51 ++
>   .../mediatek,mt6873-dvfsrc-regulator.yaml     |  43 ++
>   .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  |  83 +++
>   drivers/interconnect/Kconfig                  |   1 +
>   drivers/interconnect/Makefile                 |   1 +
>   drivers/interconnect/mediatek/Kconfig         |  29 +
>   drivers/interconnect/mediatek/Makefile        |   5 +
>   drivers/interconnect/mediatek/icc-emi.c       | 153 +++++
>   drivers/interconnect/mediatek/icc-emi.h       |  40 ++
>   drivers/interconnect/mediatek/mt8183.c        | 143 +++++
>   drivers/interconnect/mediatek/mt8195.c        | 339 +++++++++++
>   drivers/regulator/mtk-dvfsrc-regulator.c      | 248 ++++----
>   drivers/soc/mediatek/Kconfig                  |  11 +
>   drivers/soc/mediatek/Makefile                 |   1 +
>   drivers/soc/mediatek/mtk-dvfsrc.c             | 545 ++++++++++++++++++
>   .../interconnect/mediatek,mt8183.h            |  23 +
>   .../interconnect/mediatek,mt8195.h            |  44 ++
>   include/linux/soc/mediatek/dvfsrc.h           |  36 ++
>   include/linux/soc/mediatek/mtk_sip_svc.h      |   3 +
>   19 files changed, 1666 insertions(+), 133 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>   create mode 100644 drivers/interconnect/mediatek/Makefile
>   create mode 100644 drivers/interconnect/mediatek/icc-emi.c
>   create mode 100644 drivers/interconnect/mediatek/icc-emi.h
>   create mode 100644 drivers/interconnect/mediatek/mt8183.c
>   create mode 100644 drivers/interconnect/mediatek/mt8195.c
>   create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
>   create mode 100644 include/linux/soc/mediatek/dvfsrc.h
> 




