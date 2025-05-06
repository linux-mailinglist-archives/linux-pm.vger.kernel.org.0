Return-Path: <linux-pm+bounces-26720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01096AABD79
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5933A73C2
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792F247293;
	Tue,  6 May 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S75PqnQO"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336522D786;
	Tue,  6 May 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520516; cv=none; b=OE3kbTlpk5ia6g5AiVDVOfMWgFXC34WrBYCLtDsBwxwIdnoQlXNFF7KSju+UNeS9czx59IBKSz/QT5gjjqHYwfya/vvkjTQ5C+SEhrjRPxgsg8ULVQmuiXwkZldAvGzGiz36O3VoKor+VzIbqvFpz3vdSMYoWwhHBP3Ku+fOYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520516; c=relaxed/simple;
	bh=BBvdAXMVgEYi0oX9WlS56l3+uwG46FFNRdWkyntyIAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS51qejwUtBWALkLDSTBsyUqXZYdvC6p1jxoDjLaWPsm9Urnua0E2bHyufiaUwlen0DFdG2I7vzXcsWFGFBBas+enZNky3CtwtWYRXRnbLc5W+LFJwWazyH4vvPW4GSZuvbZsX42wQibz/7UltjWfr363nw9r8L6vgs0bVR2zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S75PqnQO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746520512;
	bh=BBvdAXMVgEYi0oX9WlS56l3+uwG46FFNRdWkyntyIAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S75PqnQON21L7VWvIiIoKVtbwBvSGSJicBXe9VfLej5E/hviUQSQb/dWf97hEIbLL
	 Iw6Yc2xRDhObkruFqOqgK/7Z4UZPdFNSMLF7m3wVmVOn0y9UdFulpmJAum32SuunFE
	 4qvMu62nRe/b/kzbMWexbKgACwk1TepUV5pY7ubnJp3PXFy9xWosNmboIF8FumCEnv
	 mtwme0Dve6DJbDG2Ao3XeMzrf52/DrA7LxUmadKtzO6sPB0fyD59732wCehzIx2nKV
	 zYUpmfbzDfzxjkIn8MtE0LFlQO39Lr0WVlD7CT9btgcPiJ3vUCPMd8d6yfqD9tKFzE
	 /KdO4ZeNUjKsg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B5DA917E049F;
	Tue,  6 May 2025 10:35:11 +0200 (CEST)
Message-ID: <97ceba0b-2a66-4366-8d2e-34dbef0866ea@collabora.com>
Date: Tue, 6 May 2025 10:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mt6359: Rename RTC node to match binding
 expectations
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
 <20250505-mt8395-dtb-errors-v1-4-9c4714dcdcdb@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250505-mt8395-dtb-errors-v1-4-9c4714dcdcdb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/05/25 15:23, Julien Massot ha scritto:
> Rename the node 'mt6359rtc' to 'rtc', as required by the binding.
> 
> Fix the following dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
> any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")

Your S-o-B is missing....

Cheers,
Angelo

