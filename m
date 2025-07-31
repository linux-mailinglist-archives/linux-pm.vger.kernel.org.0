Return-Path: <linux-pm+bounces-31664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F3B16CBA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD76562504
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096429CB32;
	Thu, 31 Jul 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Flxe1seK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BA323D;
	Thu, 31 Jul 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946911; cv=none; b=NLrtumKm59/5DOSHDEAq5L8m+ceN6n5tBaXrPkyfKdnOMPovWS3r7V5WsBuvzoKuQpRhT7GGv2pYjoU5xaGYlL6FjEagAGEY+p6BtEqKLITQdSyikcFTiYigeWfOO3qFrc/gdT+LlSZsGxKFTGta5WaUI58RdjWN8UdFaP8dURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946911; c=relaxed/simple;
	bh=qtZaVgHB/hhKpNwT2a4wIg9fcBK+yk7JS3AwLBOGuOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fynfGrr037Prfy779rWdS5AJMlbcHmAVxP15wTxkIew3FDNvwo4S/xCMw2fXJ67aHL7TjeLuUc5/YQtMofZS0Vdu4knGKiDaYoyZxjM01/xyiX599Aa9X2hwBFxFnHId/AJp0pnPSzUwqEcTotfGqO7DljeFGONBULLibMdEXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Flxe1seK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753946907;
	bh=qtZaVgHB/hhKpNwT2a4wIg9fcBK+yk7JS3AwLBOGuOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Flxe1seKL0nCIHgcCgIKPgBLjmpo5KOvhOo85ujPcLRGU5A96/x+g7eN3dyGVA8Oe
	 NJbwkjNyTQnnrUC31XQfujNKb+HJOAKLKsHuNf1rlh1ALFZ7i7PotWnVut8a/2s7b5
	 88GrLyct7536PeT5TDcilbsOa3MS/RZfEQpmfmW9rooO9pF3MYA9z69cf2orAxbQ+Q
	 OsbrLiYm6/Saz7Nh2Kk71rE+nOQwda8CsJkFtYTy6NMI+6yzpMobR995FDeyzTOq4l
	 YIhAWjetUrY2N2JDiIiNeRFOjp3uqYiQWeHyq6SPHlcGSfjTw5sw6INzX5q+hirh2P
	 iiQxekzhq0/8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A270117E0593;
	Thu, 31 Jul 2025 09:28:26 +0200 (CEST)
Message-ID: <f485e3a1-46eb-4239-9c66-7a212c63ad64@collabora.com>
Date: Thu, 31 Jul 2025 09:28:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8196
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-10-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-10-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> The MT8196 eFuse layout is compatible with MT8186 and shares the same
> decoding scheme for the gpu-speedbin cell.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 4dc0d42df3e6..455b96c1e1f4 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -25,6 +25,7 @@ properties:
>     compatible:
>       oneOf:
>         - items:
> +          - const: mediatek,mt8196-efuse

Oh wow wait. This is not an enum.

You broke MT8188 like that...!

Cheers,
Angelo

>             - const: mediatek,mt8188-efuse
>             - const: mediatek,mt8186-efuse
>         - const: mediatek,mt8186-efuse



