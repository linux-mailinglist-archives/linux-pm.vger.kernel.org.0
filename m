Return-Path: <linux-pm+bounces-26719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B290EAABD75
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54193A64D7
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3A247282;
	Tue,  6 May 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FwumzGi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30A23D293;
	Tue,  6 May 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520478; cv=none; b=Q9Cn8BXP8VWdqJFkATxpKwjVNWKrU5ZRudZb48h0cyH3paMlNsG51r5hIFgrba5YXaA+8u0qhR+KmlRbDR5K/s9W2NavM6Cm0ecXnvyCOEX3h8r4zxFdgZquZVF2o45RHV3a4XvK+rTsMDlXBy9Y54jqBmmHlWKQolds7GMl+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520478; c=relaxed/simple;
	bh=DXcqPBwQKvNKiwIbf3ykHJXzbpclDBX7r/K84ILDxNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKpTUvPQJyRB+GAxqdrrdk26SAAEvwEYbau0Dpj2AqU2DfMJzh35HY5c/lWVphHR16wTfcLrp1zLDwaQZXy+Pqu5E/WB6QkXXd+MeaarVtCj06m1fUB7PzfIdTfZslTS9RDr2sVtdUyTM+4/IxesxFuwBS4nEN0I9bz0gBk1vNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FwumzGi+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746520475;
	bh=DXcqPBwQKvNKiwIbf3ykHJXzbpclDBX7r/K84ILDxNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FwumzGi+5gntUjl9VTLHeo9YpRhrQFuDo/7N9XUl4Ji4ZlM+R0JP8i7XEhW9nNc98
	 LMf9g+I2IpNLAdGHe4CnfphAHfZg/6G1OkdKxGEfgnQT0p0ygBU9XisvB3ol6dwizW
	 DJgcDM5ptXRua2KjQyEIYMtMNtbdhRmHjaXkWBHdXgg2oJvf7tT/RwKjoE4qC6jF0O
	 RnnjAqdPvduITh0qLz1dpzWBTrAf+MVqhVwf/BKg3NwgQetgE8JLomv4QmDk0tAl/2
	 FjY6s3d8o8McbGb/ir81Qbj8p9Z773VrcCXIPpMQ8CdIFurN8Jzfn36VfTKCo2ncSP
	 dVMgaJqW7eipw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48EB817E049F;
	Tue,  6 May 2025 10:34:34 +0200 (CEST)
Message-ID: <cb715936-3a44-4002-8d64-565f8d31820c@collabora.com>
Date: Tue, 6 May 2025 10:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
 <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/05/25 15:23, Julien Massot ha scritto:
> Some Mediatek IOMMU can have up to five interrupts so increase
> the 'maxItems' to 5.
> 
> Fix the following dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: infra-iommu@10315000: interrupts:
> [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long
> 
> Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
>   Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a5363d8c05ef767bb251 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -97,7 +97,8 @@ properties:
>       maxItems: 1
>   
>     interrupts:
> -    maxItems: 1
> +    minItems: 1

Isn't minItems already implicitly 1? :-)

Cheers,
Angelo

> +    maxItems: 5
>   
>     clocks:
>       items:
> 


