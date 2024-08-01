Return-Path: <linux-pm+bounces-11796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2384944666
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6761F246E2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5916C85D;
	Thu,  1 Aug 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ItQK+fI0"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D38BE0;
	Thu,  1 Aug 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500454; cv=none; b=MgTmtA5s+WAxjwXw0spboPrVSvmqy4/+r3b0U4HodGUTv/thmXB/wdjcaKt+Q/u9qP1AzfkwyhjqwfgQtrrSdBB/sCH+pPM9AfFWLglr8hbvu10HSMhIWNgFA4/nYQmDhas4il76AwHvQdGmbOh6ZWOcYvQ9+wQGJ4XJcm9LOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500454; c=relaxed/simple;
	bh=pxDD+VqHUK/fgNuVfTXryZFPFuOe9Elqx9CJ2loe6/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpxTafWLFT/RCaszEQO8q44sr+aVEbkrx7K37iRLnHobSaLVe+DXaX0dpJLHi+SWCpKDDps2VP/xdie9RKpVnJ8CL8CcpvmhxsWsmM7CnhND/11/4NdKjEK4o07kz/RILpQcT9PCYBcaRl4laxgdezlbXcIGlYNMKvulk7Aqw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ItQK+fI0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722500445;
	bh=pxDD+VqHUK/fgNuVfTXryZFPFuOe9Elqx9CJ2loe6/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ItQK+fI08GD1pTQ3PR7NQqWCG2Ggto5LWuHL75Ztu/qlUAQKHkATCIWOryCvSpGNv
	 OXfGHt08E7pb2nGSWfi9FXbT4Enfkt2b/UPQekb1juW3sgWqxB5iePyRe1wr4d7mv3
	 YEilLf2wws7u7RVF9jK7vQ1Iqrz396YIkZEgXH9aoNIFHPEKTWeeHVrt1eqw8YbaP8
	 5Eg2+anUn4RazRZ6g0JW2On9WVuCm33AGlLWCjI8+l3stlORjEBZ1LgqgjICqYIH71
	 RB0CIjZoAXKFX7jmOZTrMX/3q2NvfOqgtiGE4sTo3kT5lL/bh+Y5DwLnx+jb3CCSmp
	 adywNqe2Gq82w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FA4B3780520;
	Thu,  1 Aug 2024 08:20:44 +0000 (UTC)
Message-ID: <21a9fcfa-e92e-4178-bbae-0193f8b86987@collabora.com>
Date: Thu, 1 Aug 2024 10:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v7 0/6] Mediatek thermal sensor driver support
 for MT8186 and MT8188
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
 <171826604410.51825.14935271158174620262.b4-ty@collabora.com>
 <abefa449-c0bc-4b58-89b8-d4272f7774f6@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <abefa449-c0bc-4b58-89b8-d4272f7774f6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 31/07/24 17:34, Julien Panis ha scritto:
> On 6/13/24 10:07, AngeloGioacchino Del Regno wrote:
>> On Mon, 03 Jun 2024 12:50:47 +0200, Julien Panis wrote:
>>> This is a bunch of patches to support the MT8186 and MT8188 thermal
>>> sensor configurations.
>>>
>>> Since the patches of v3 were applied except those related to the SoC
>>> device trees, this series includes mainly patches for 'mt8186.dtsi'
>>> and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
>>> trees, the related definitions were also renamed in the dt-bindings and
>>> in the driver.
>>>
>>> [...]
>> Applied to v6.10-next/dts64, thanks!
>>
>> [3/6] arm64: dts: mediatek: mt8186: add lvts definitions
>>        commit: 0c598e50e6c823c1057ddad17c546e368a415d6a
>> [4/6] arm64: dts: mediatek: mt8186: add default thermal zones
>>        commit: d7c1bde38bf37a59551cfd52cfdb5bd974b17431
>> [5/6] arm64: dts: mediatek: mt8188: add lvts definitions
>>        commit: 7e3e18f2ed40ea9018590b4533fa148954a725bc
>> [6/6] arm64: dts: mediatek: mt8188: add default thermal zones
>>        commit: 2f950510411a33d98eea28c22d7880eeb48adb61
>>
>> Cheers,
>> Angelo
>>
> 
> Hello Angelo,
> 
> About this series, the DT patches were initially applied, but removed
> due to missing dt-bindings in linux-next[1].
> 
> But now the dt-bindings patches are applied in mainline[2].
> 
> Would it be possible to re-apply the dts patches please ?
> 
> [1] https://lore.kernel.org/all/ZnBn-vSj-ssrJFr2@sirena.org.uk/
> 
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> 4262b8d782a7 ("dt-bindings: thermal: mediatek: Fix thermal zone definition for 
> MT8186")
> 744ca11f52e5 ("dt-bindings: thermal: mediatek: Fix thermal zone definitions for 
> MT8188")
> 

Thanks for the reminder; I have applied those to v6.11-next/dts64.

Cheers,
Angelo


