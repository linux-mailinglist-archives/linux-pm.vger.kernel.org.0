Return-Path: <linux-pm+bounces-27137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2AAB6D0E
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40E4169DE3
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13527978D;
	Wed, 14 May 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XjL04Znn"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817B18BC0C;
	Wed, 14 May 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230316; cv=none; b=aNTv75zYEHpdyJN+eNCZ9yvv4Ug/YauGUaYNHtrLKkN15OiFvACc87DFiWqnCSHFWwd8k1sYux6iazdGz73hlr4UcgtjmYXe5yFGBWICrxuvqwxMumjD+y8Gh/pCMU58EydQ4B/GdadONOsAJfFc9STacsY+AExKRfnegjM+zUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230316; c=relaxed/simple;
	bh=bB5rVOkZWWCkarXDIzHRAxzDsnnjJj5znI8/OdBZc/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atIrPg1rufg4HJUynZVSnNNHdecNTIuXnreSsWAXuGgs7Fs/hqP+HKqfeYFpPZSPFIWUGT4+Pfq+gvLYP1iayAhC1Gle+2L/qcmNP2qUSrxdYlYR2SOlk+G+eU/Y6I8h/BYJzc189La0Dt5uGjLAW7GrGX37qlf5glCIfXg7WuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XjL04Znn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747230312;
	bh=bB5rVOkZWWCkarXDIzHRAxzDsnnjJj5znI8/OdBZc/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XjL04Znn+duXifSpO3JVXeTJTwdoNk98bmvDozvd8NPLVotoRJrqpNGw45HGkv6QA
	 JiRYgv6BgbHCYKdbHVfpm70o2j1NZ9+z9gQVJkzdd78lu6R+1kW4CEALffdz5tlM9x
	 Gh/c0qsuDAdc92v42YW9G0lD7kkdqLXmZxvhjOiYuc/C0ejOrQjPr1PWwg18zJEVMt
	 vHKmfTkFKEZ+pQUQuVAI2ySIj8pZn6ZBWpNonVolNQJEL7Mbg9UQM+xNia1QMGqag2
	 o7c3ts0sZ9fGpA/42EeVar7XqJ3nheRi8HeGqmQ5MbXvYEYDQOBB5vhYHFl4p5Dk8m
	 GhlVAyyKeGYfA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 123C517E07C9;
	Wed, 14 May 2025 15:45:11 +0200 (CEST)
Message-ID: <825f9c5c-79e8-42f4-b489-854e58211fca@collabora.com>
Date: Wed, 14 May 2025 15:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
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
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/05/25 10:19, Julien Massot ha scritto:
> The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
> Add the corresponding property to the binding to fix the following
> dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
> 
> Fixes: 9bc8353be720 ("arm64: dts: mt6359: Add #sound-dai-cells property")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


