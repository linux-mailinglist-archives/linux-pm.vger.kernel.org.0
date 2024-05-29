Return-Path: <linux-pm+bounces-8344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6881E8D3102
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2492928E594
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58A17997D;
	Wed, 29 May 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DN/ZQ/vU"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AD1791EF;
	Wed, 29 May 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970670; cv=none; b=d/nVvFJL/i/QRCCMbyTj/HYotZDOm3FKUPuikfUVIaReaeV5uwayLiMkKs+XWLV4fXiLP9xMrlpDEPXW34paLXF685snfyT/ABIgWNxvEvjTm0kErPGe4PoKWqygwF+VtxWn+2k8PnoGSshJQ+KCOtavlckt8qDwkkzRniGCT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970670; c=relaxed/simple;
	bh=ifalb+C1W/X8LfMDch31OTT37glgZWacewpzUz7P2ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5IBCpGYiVb9mAFU4sIN4A8l8EfB75R7OFBWp+zDEK4UKZReYb7Od/s9JC/wBagaVpmq2k3/B7KH/zA5AR0dQNxqghehxbNJkvWapfCCuwsf9MplbKiMckDv9gmfiFSwWWe5R4+21mhaaEqHbhDpxdLLTwBZB7XSvLRuFiWOnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DN/ZQ/vU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716970667;
	bh=ifalb+C1W/X8LfMDch31OTT37glgZWacewpzUz7P2ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DN/ZQ/vUahdns/OJxM9r9j/RwhYyeTwYyycbwXDc0Yx9h27RI24H/qO+eZaQIGFYw
	 w0XEv4S4WkgOtNHvzzeg6o8as2rCZvlpN/SZ3Q3sXa5Utu9+K+ZI+tRUgBv6+//e0Q
	 pekm0oPkS4b34RugoLtmdVuYCQwD/eLIK0SirrywBTw/Ta3IiGEOXHomhHaciMPS86
	 zhwAyXl63uIBmzZQy+ofSIj/WntdqejJUlnrIis30H6lSPAyqbOwxBI6Usg97b3pXb
	 W/d80uvbUDMpcCwLn91dxYixZ4d/nLL88De2qlY8YsBe0aEEOdsU8TCrhiFI/euQ0G
	 aTh7Mj11qgm1g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C72F378000A;
	Wed, 29 May 2024 08:17:46 +0000 (UTC)
Message-ID: <75826085-fd59-466a-b1de-b4c323c801c1@collabora.com>
Date: Wed, 29 May 2024 10:17:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal
 zones
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/05/24 07:57, Julien Panis ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



