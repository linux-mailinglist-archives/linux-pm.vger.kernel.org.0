Return-Path: <linux-pm+bounces-9083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889A9071A7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE311C241C0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56A1448E6;
	Thu, 13 Jun 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q37b+m3c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C617FD;
	Thu, 13 Jun 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282326; cv=none; b=jCy69fFwQ5AVyN/BEOxKFb1aay4AROnW2fwajkk/DXJgwlrdviIFuXen0AmiCgwPcQY63c5tQ66cbYwrAwaJemKdPcBCJEFaluqcewbP6EldSUvrxOWGBeplop6NZFJZQsOSSs1oLjYazvWU14sbaMpBjZcelC282OlGG/JUyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282326; c=relaxed/simple;
	bh=bVrAo3lut/CIVb44EOV8RxgsTq/ZgAXk3P1KnkNPkkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbQkKJjThaC3vprzafzju+fvX5KdCF0MjhfZZS8quAfuqke9cpsjRFFernncf9m0XgyzJmQSJL4sLWBeLcCR7SqAxEMmHXd+JISSkPWmyn5yuIF+rnS33LafJ+ObR5RvrZMQNlG5vhIjHBmpOv3S9+Jd6tEEPde2LcYB1X1alAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q37b+m3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C4CC32786;
	Thu, 13 Jun 2024 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718282326;
	bh=bVrAo3lut/CIVb44EOV8RxgsTq/ZgAXk3P1KnkNPkkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q37b+m3ceQJYNsCBts8Dvz7UEkDRhKkWNQYjcD1nD+65btWlVfreATdZq/zeGmL5y
	 RV/M/bL6mO1pH3NqGekvInRDVioIyXJcb95e4flYZ/08SG6IKHNO+HjscfhF0Nn1JP
	 bxs3dqhBzLvNrlgg+R2Wx6MCa5Q00ZE+zZuTOd9+fpkcBAI9sJxKa7kgsSCVlhyHKV
	 wBFj8BKSIZSF8hG4kagJi8Pw2COxgf9vGAG50VyLkPn2J72B66BUQGAzqtabAR7VxG
	 86zBRzVYmqL0Q8nnP9jI+Kg4LVWrl92UEW6JJHzNPmUojHFf/3yF54oBrq35/K643f
	 rqRYCNgQA8KFQ==
Message-ID: <d5b593f6-1764-43f0-9697-78d586239c23@kernel.org>
Date: Thu, 13 Jun 2024 15:38:38 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 11:57, AngeloGioacchino Del Regno wrote:
> Changes in v6:
>   - Fixed build with clang (thanks Nathan!)
>   - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>   - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
> 
[..]
> 
> AngeloGioacchino Del Regno (7):
>    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>    dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
>    dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>    soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
>    regulator: Remove mtk-dvfsrc-regulator.c
>    regulator: Add refactored mtk-dvfsrc-regulator driver
>    interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect
>      driver

Thanks Angelo! I have picked patches 2 and 7. Patch 2 is also available
in my icc-mtk stable branch. Feel free to pull it to resolve the schema
dependency for patch 3.

BR,
Georgi

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


