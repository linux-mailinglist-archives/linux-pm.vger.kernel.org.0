Return-Path: <linux-pm+bounces-26722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F48AABD5F
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B8A1C22EEC
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9BB248F4E;
	Tue,  6 May 2025 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fAcvtaRC"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F2248884;
	Tue,  6 May 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520530; cv=none; b=O0KmyD2jtZ+tEhliNUoblAkhmr69nzFrtW5QgBau3Fu9wka2aUkku1Fu5LUT2b0JBrr8eWqscR3qFp1vszJTpoF5X83o2XsR+VYth9knB3OJj44nQersu+o07Ha9v6+++6Yvd3jKrDWySnbCmiIzH/P0dY+IZpoLwJCPH6lWcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520530; c=relaxed/simple;
	bh=BA1uB0bqEJgSDP4rtIOcxMMJ4yxs1wrJep5UBsDDoZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkaE9voTQCF46VjKBStxgtcDfi8cfP0d9+LTtQjRBKT0w5y6EkpekBK2TP/4QhtSwuLB1MjB0/UCkPjFQztENLRjdRrIItvKu5Oc2MxGNqx8cUXER2aD1bVv9n28o92+CCNcgQalYgmxAQQpTjH40I6v9q3EfRyfIfGP0nd77g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fAcvtaRC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746520527;
	bh=BA1uB0bqEJgSDP4rtIOcxMMJ4yxs1wrJep5UBsDDoZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAcvtaRCqtpxu1jAL/i2hRAchnLINaS+Q7R2UxugAPYhY4gG1E8uJuu+Y+Ow/qGMz
	 2yB3KnpFgVNo1HkRDFeYwcknuf6JQ2IQPt1IaW5OzBRnLCLQ9HV3H+1yWHnwLoUels
	 h56Yhj3uhKjHJXaXHDB19SX9Z4CyDpg6j3Q8iLJJxxmcYdzj3wO6V6YJibv84vm20W
	 EFH1x+3iGZOHszLIYacT3lmDZwn0I5SNVIrTbwIn5/0Awv1WURIxh2iS+VNtHqa6be
	 fyR59LYaJDY3lhWX5AC6WmdH8u0cci6w6pKijSRkSb+uWFYxt1YtGm5QCoRvViicah
	 YLkzWNhp9lZ7g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5EC5F17E09BE;
	Tue,  6 May 2025 10:35:26 +0200 (CEST)
Message-ID: <f0f7c044-c8ee-4712-94db-882cdf894653@collabora.com>
Date: Tue, 6 May 2025 10:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: Add
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
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
 <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/05/25 15:23, Julien Massot ha scritto:
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



