Return-Path: <linux-pm+bounces-9149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678C9087AA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9521F2513A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBACC1922FB;
	Fri, 14 Jun 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nHxVw/il"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04B146D60;
	Fri, 14 Jun 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357980; cv=none; b=e/nln9TaXupiwXGDS6ufoTj1OxuoGLoRxBEjRGRl31SPF4Y/ARlPAH6Z0wSfuFmeSAChbmiPP8rlA3taZvmaYMbxqSzhKXdZ8yXgaRbFxXHsgIxObSZszz96Rwsq69XtI/YzPPI1Kl6pYNV2MlgtSqj/dy7LhuaztT/ZqHC3PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357980; c=relaxed/simple;
	bh=aHsuGDceh1SMMPY2DbZoInR++E/rZZ8+cC+vYKo1Eto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foqA0+9KITxmDCYeWFzxaJiMvTI8HdbEUj7ojKhSFf6PZCqXKeTPJwsU4P+7U6K9RePXji3VxnArhBh/5GXE5lfWhskhlI+1hnCANl4HSZzZmfsYzRACI/qkdXFJNM1glZP+Ko6HmjW1CLOnldUMFai8kYo2aMFxHOuPxzs7of0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nHxVw/il; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718357977;
	bh=aHsuGDceh1SMMPY2DbZoInR++E/rZZ8+cC+vYKo1Eto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nHxVw/il4wiHGljkF3skTUS2640bGADQVrIwyi4YEwxJFl+T2L4BcEXEFhLO+V0oZ
	 WakDFMqZ/uvmbqQqYzMEi4TrJZyJ5I2r/Hp8M60jbcMxuZfVcyQcMsScvaQZeZXFV2
	 NHQtaqWmbvBvD8sewC3A04UiRa8t5mL+IDNKlhp5Di+R5sADY/tmHDeDCNbwH8h9Jh
	 7Ht+YUmNxiHqISJSo3EgYOsFiJs2bgpflBb7qVmuKqi7jERZ8Ftpe2ARMBJZi26ARH
	 GI5l/7xszBbuzJ50Fp4SjDB8/3O3UPFS77lkFuSLxeGkqy4ue9dSqdNcNqjHLkCW7q
	 3PsFqN8EfcsEA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 132C53782139;
	Fri, 14 Jun 2024 09:39:36 +0000 (UTC)
Message-ID: <b8026db3-6893-4609-8ead-b78f9b9eb40b@collabora.com>
Date: Fri, 14 Jun 2024 11:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: Georgi Djakov <djakov@kernel.org>, broonie@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, keescook@chromium.org,
 gustavoars@kernel.org, henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <d5b593f6-1764-43f0-9697-78d586239c23@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d5b593f6-1764-43f0-9697-78d586239c23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/06/24 14:38, Georgi Djakov ha scritto:
> On 10.06.24 11:57, AngeloGioacchino Del Regno wrote:
>> Changes in v6:
>>   - Fixed build with clang (thanks Nathan!)
>>   - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>>   - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
>>
> [..]
>>
>> AngeloGioacchino Del Regno (7):
>>    dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>>    dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
>>    dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>>    soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
>>    regulator: Remove mtk-dvfsrc-regulator.c
>>    regulator: Add refactored mtk-dvfsrc-regulator driver
>>    interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect
>>      driver
> 
> Thanks Angelo! I have picked patches 2 and 7. Patch 2 is also available
> in my icc-mtk stable branch. Feel free to pull it to resolve the schema
> dependency for patch 3.
> 

Thank you Georgi!

I have to wait until Mark takes the regulator bindings and commits, then I will
be able to pick the soc bindings and driver. :-)

Cheers,
Angelo



> BR,
> Georgi
> 
>>
>>   .../interconnect/mediatek,mt8183-emi.yaml     |  51 ++
>>   .../mediatek,mt6873-dvfsrc-regulator.yaml     |  43 ++
>>   .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  |  83 +++
>>   drivers/interconnect/Kconfig                  |   1 +
>>   drivers/interconnect/Makefile                 |   1 +
>>   drivers/interconnect/mediatek/Kconfig         |  29 +
>>   drivers/interconnect/mediatek/Makefile        |   5 +
>>   drivers/interconnect/mediatek/icc-emi.c       | 153 +++++
>>   drivers/interconnect/mediatek/icc-emi.h       |  40 ++
>>   drivers/interconnect/mediatek/mt8183.c        | 143 +++++
>>   drivers/interconnect/mediatek/mt8195.c        | 339 +++++++++++
>>   drivers/regulator/mtk-dvfsrc-regulator.c      | 248 ++++----
>>   drivers/soc/mediatek/Kconfig                  |  11 +
>>   drivers/soc/mediatek/Makefile                 |   1 +
>>   drivers/soc/mediatek/mtk-dvfsrc.c             | 545 ++++++++++++++++++
>>   .../interconnect/mediatek,mt8183.h            |  23 +
>>   .../interconnect/mediatek,mt8195.h            |  44 ++
>>   include/linux/soc/mediatek/dvfsrc.h           |  36 ++
>>   include/linux/soc/mediatek/mtk_sip_svc.h      |   3 +
>>   19 files changed, 1666 insertions(+), 133 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>>   create mode 100644 
>> Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>>   create mode 100644 
>> Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
>>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>>   create mode 100644 drivers/interconnect/mediatek/Makefile
>>   create mode 100644 drivers/interconnect/mediatek/icc-emi.c
>>   create mode 100644 drivers/interconnect/mediatek/icc-emi.h
>>   create mode 100644 drivers/interconnect/mediatek/mt8183.c
>>   create mode 100644 drivers/interconnect/mediatek/mt8195.c
>>   create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>>   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>>   create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
>>   create mode 100644 include/linux/soc/mediatek/dvfsrc.h
>>
> 




