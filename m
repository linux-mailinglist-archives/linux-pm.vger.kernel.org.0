Return-Path: <linux-pm+bounces-40548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6926D0B400
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1B04300A919
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BD28640B;
	Fri,  9 Jan 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyAC+vU+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452331EEA31;
	Fri,  9 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976257; cv=none; b=KEf+HM1hfFgxfnNhSLc9U8b06tiAu9Sn89Mx27mK7lzUZ8FL4ApNF2Qi5/AYtUy8Ptu9lWGrj6np/oYrjf9Zr9gUFGuTOQBbJTqiLRGMw5Yep1B6FQ9zD43QTUhxIqT31JzXM8S2z+iq1XcAUbZTonD7RdMPxXny88PrXxF+te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976257; c=relaxed/simple;
	bh=2nnt/RAhlgbAIoBNQy+A3kflDIjfGtjH4Wnd7s6M8kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOs3iJZBaDstvW4ZE3YB5LWAxsyWTcEWc+NZfkfzvqFK3Ww0FAUWvE6T/ry4jD4UtsdO2u3JbCPFTipvCwYIZx83rA4AIQ45tBGP93d1T4kuYdjuEs+gT4cdAtzNOzJXblywCT6VOCzrvvrUYMpP4tySIsF1Pw+y/g2aP4iiJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyAC+vU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41805C4CEF1;
	Fri,  9 Jan 2026 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767976256;
	bh=2nnt/RAhlgbAIoBNQy+A3kflDIjfGtjH4Wnd7s6M8kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UyAC+vU+9kTM3F3DIAqpZNoxKIwucU61mm4w4acu6wPdZG7r3KXTf8HeOpkdj4eT8
	 avvUauUPHyg68/2LA3Xl+TzZxH25duQUw1H63Je8lBAUqmDmHqpzt0tqgqDNWCMC1H
	 ds/RhaB9n3WWX56kWMvXJvqBobLFe6qmJajCyT4+OjsWEavKJa8pzRfPGafbkJEkzY
	 fm4n26h+V5sPrnpKu5jiPEjYxxBUg6xyzmFkf4W+Vis6i/rUU6u7nU7lL2GOqYAEad
	 EBuYTTXUcrYHXFNoY4X25KQSF0bFI2xj3nmJryqjMkhB0Ten4BA+rKKakvWQa1+ouk
	 gPv38Zj3aMlRA==
Message-ID: <3905bda3-169f-45d8-bdec-c199f226d45f@kernel.org>
Date: Fri, 9 Jan 2026 18:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] interconnect: mediatek: Add support for MediaTek
 MT8196 EMI ICC
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Henry Chen <henryc.chen@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
 <20251124-mt8196-dvfsrc-v2-11-d9c1334db9f3@collabora.com>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20251124-mt8196-dvfsrc-v2-11-d9c1334db9f3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 1:07 PM, Nicolas Frattaroli wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a new driver with data to register the External Memory
> Interface (EMI) Interconnect on the MediaTek MT8196 Chromebook
> SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The interconnect patches look good to me and there is no build dependency,
so i picked them. On a side note, we recently added support for dynamic
node ids in the framework, so maybe switch to that in the future.

Thanks!
Georgi

> ---
>   drivers/interconnect/mediatek/Kconfig  |   7 +
>   drivers/interconnect/mediatek/Makefile |   1 +
>   drivers/interconnect/mediatek/mt8196.c | 383 +++++++++++++++++++++++++++++++++
>   3 files changed, 391 insertions(+)
> 

