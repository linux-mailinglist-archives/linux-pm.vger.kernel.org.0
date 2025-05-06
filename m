Return-Path: <linux-pm+bounces-26721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E127EAABD5D
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92EF4E5014
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2724C070;
	Tue,  6 May 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qoQQgfWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879522D786;
	Tue,  6 May 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520521; cv=none; b=VJcNj/BRXAuuvMso3KNBrY41aJJuv0OQtOyfo6MMd74t+LgVL02Sm55AMK0LzbVmjpE3w8iyLhQsRUNeBIU9IdrX7PjhRzVjq28QMk8YlatGrWAp7cDC7GhBDrT51VAg6kYABrP3G/ITUW9xjPVcXM32gJLssf4qCEp0IuR1IJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520521; c=relaxed/simple;
	bh=HZLhd08WX2+ReeodcLqzcq1Sex8u/kBBo5ZNER/2NWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGldeWq4sAVYIKfE438jLeCAvSLyyfYFfAVkJ+PiGP7zLZVMpwUxLdS7SBPcbiosp3AdsQ+3bNv5TqwYQ4muqg56yDd/uzr2lwpChYYCK12KTsAOt8hXBh72CGGkP5LLsrSvxfwnVLVtWW3ghsAEJFB4SlF+UppBrG5Ynnsxhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qoQQgfWR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746520517;
	bh=HZLhd08WX2+ReeodcLqzcq1Sex8u/kBBo5ZNER/2NWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qoQQgfWRIoHfUByG+ocpa0yYxuBh9MU+OmHRov39eBMy8q/Z8K4pR7y/9Y+shUDR3
	 jnu8+JQNgCEh7P1xGFUWKGEDFazhn3zXzCFi7r6JG8QkVUenc7+So7BHfeE8Usnhqc
	 Cg1LMhIm7bDT3E53IIP7DFmfSwZ5aTkFZfBjU8s59Lf532RAYIWJcDv0/ZFrXz27Rw
	 4PJSxK34Nh0DyhZ4Hv4qG8NB89Y0MQXKzBEmIKyMevM4C/gmgJiaJG0eLdJX8LMegK
	 KrQwmEo9aLxyV76Fl4zrP0ZF22zdZ9zvRxZkWKVYw1o23X4XhrF+pLQd4ScA5DKgeL
	 UfQK8q29KiCtg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EC9817E078A;
	Tue,  6 May 2025 10:35:16 +0200 (CEST)
Message-ID: <b0a1ecb5-4a45-498b-8632-368383a10679@collabora.com>
Date: Tue, 6 May 2025 10:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mt6359: Add missing 'compatible' property
 to regulators node
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
 <20250505-mt8395-dtb-errors-v1-3-9c4714dcdcdb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250505-mt8395-dtb-errors-v1-3-9c4714dcdcdb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/05/25 15:23, Julien Massot ha scritto:
> The 'compatible' property is required by the
> 'mfd/mediatek,mt6397.yaml' binding. Add it to fix the following
> dtb-check error:
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: regulators:
> 'compatible' is a required property
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


