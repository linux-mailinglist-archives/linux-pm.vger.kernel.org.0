Return-Path: <linux-pm+bounces-31259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB8B0D536
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849D3188FFAB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213428D84F;
	Tue, 22 Jul 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SP8EGeyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B64CE08;
	Tue, 22 Jul 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175075; cv=none; b=jUDoG2RNCRuY/iNTL1DnqsO2MQrV0cG+eGl2saeu4sHrOnRuZ81Hi7NtlCiiLlSUxnxsVpqUOMZtm7fFtNVg8loUA8aTeYaxWMmOeF2aGqmbst2dNcshvlBXuIThcSm2BetGLepvqxYo2qtOtlmMhzIm7tKslLEIIq60/neA5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175075; c=relaxed/simple;
	bh=+jviNUvxy5BMeCnPL5e7+yknqDsmCSGYBxWz44Poq0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLHLFtO1yRfMvTbD5wqeMTnPPYgzL+hRKnOSnMMUPafYWvDoB7DxA3mSUzaDqAmvcOdeogBvc1WKGgczO4J9axU6BI/SJv+gqPK1cMGEKF0vDgrjqQJYhzDq1pwd/hoAvtdRTY1U3mozOnFkfDXdyuCNufCRLT30/nbE2AAJ8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SP8EGeyp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753175070;
	bh=+jviNUvxy5BMeCnPL5e7+yknqDsmCSGYBxWz44Poq0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SP8EGeypDs2nSDG1wCfpzlGIP+kBfhH7TVL950c8QzunAiXm/tmUp9LSotrcwCuqw
	 kXUuMTDonD+nBAcMbgAMsmRuEa0ZvQuLvHq10oxAXhbWHm3MxwBM05Y0sIHmvPhphL
	 mM3tLF3lBCCAmwE7utZU4nk9vLkb/DEF0HEaf3B8OLAhmEg4oNbPAOjLkJaWtM9iHP
	 OBGZQdbWA4LQ/cHOKgT+z8Dpv0dVEUIVRVEj3lM6IenQTio189dzUPGZ/xTKJWnUVu
	 5ltzRZWjJNZaXd+dhDOFF3yFxdb/eKpfuP4yzgRFWwTzO098miY8CKceMXuvkJdxQc
	 jocwBfrNCkLpQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A8DA17E0DD0;
	Tue, 22 Jul 2025 11:04:29 +0200 (CEST)
Message-ID: <24c65ecf-ab89-4970-b2ae-00185259d359@collabora.com>
Date: Tue, 22 Jul 2025 11:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for
 MT8196
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20250721081459.16278-1-laura.nao@collabora.com>
 <20250721081459.16278-10-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250721081459.16278-10-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/07/25 10:14, Laura Nao ha scritto:
> Add compatible for MT8196 SoC.
> 

This is compatible with MT8186's layout - not with the others - and
besides: "mediatek,efuse" is deprecated.

Adding something to deprecated bindings is not even really permitted (unless
there's a *very* good reason to, which you definitely don't have in this case).

Also, this commit has no description - repeating the same as the title adds
no information and doesn't help at all.

NACK.

Regards,
Angelo

> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 32b8c1eb4e80..e209a1132a26 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -37,6 +37,7 @@ properties:
>                 - mediatek,mt8188-efuse
>                 - mediatek,mt8192-efuse
>                 - mediatek,mt8195-efuse
> +              - mediatek,mt8196-efuse
>                 - mediatek,mt8516-efuse
>             - const: mediatek,efuse
>         - const: mediatek,mt8173-efuse




