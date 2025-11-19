Return-Path: <linux-pm+bounces-38209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60CC6D77C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 09:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43CCA4E2864
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9A2F6924;
	Wed, 19 Nov 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oLA1GjWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30B2F5313;
	Wed, 19 Nov 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541171; cv=none; b=H6mWF3YAQF75ocJdJ6cc+fxCDMy5tuPBMPr+EYiMf39Sc1uVZ+7yljmlFNVAQt0lTANm8tpEIGPEbMVhFH7+wQIhjqFAASgwPgH7KlgRJwG12pBXEEaX252AVJCt8PT+kqt2zFVtMrZZW7Ljb3g6ojwinRyHyVQ8igt6gCNqf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541171; c=relaxed/simple;
	bh=wBrRth6jrMBMC97BugaJ+iim5MtferOSNB82gPcG4Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNxmwWD2sa8DLpUrdoLPx3tDdAQaS9awFXS+uUQ5uKQUHcRm7uvZ1jZV9DFTM+PDOvPTpkDn8mA3VcHSxDlntvZ5ZAjl5mNtqIEv8cA+1HVeyqAfmmYBd/pgGv9RfyTOzS0ucdgHHlpIzlXYJWuwo407ZlcaT6Ck4/WbsZoqVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oLA1GjWR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763541167;
	bh=wBrRth6jrMBMC97BugaJ+iim5MtferOSNB82gPcG4Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oLA1GjWRfrf4rj0OLTrqowQHNksAh/PrM1sSJPt35wSyikgWfoRMcNxUDCDoV1hXU
	 uftIdxdac2QC8SI82kX07cdKNhAN0eE+EcD4uNGnM4Wd0UW6C/PdqFzTPabR3RfM6m
	 XS4GRD/422P5XHXhQxO9dbP1UGNeyjDr+HnTQ7UZm11F7j13l5g2GjG2X+hoBI6qLP
	 l997tC0WzRCWiST4dSyYf5Cc+gjtCpwXUgDaq9++JePHAbYK4Ft7We4SGl9zSssCbx
	 4i5u6XMtcMMSlq1ouzIPhajHhUnhxrbpaig1yC2DVPmFDSI+5umhrbzxYYe/t6kqKV
	 4hqO8wC6d1qOg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA2B417E0154;
	Wed, 19 Nov 2025 09:32:46 +0100 (CET)
Message-ID: <39fba430-3841-4bf2-9fe7-44f372ff4a16@collabora.com>
Date: Wed, 19 Nov 2025 09:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support for
 MT8196
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Henry Chen <henryc.chen@mediatek.com>,
 Georgi Djakov <djakov@kernel.org>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251114-mt8196-dvfsrc-v1-1-b956d4631468@collabora.com>
 <20251119-alluring-jellyfish-of-chaos-4f5bd8@kuoka>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251119-alluring-jellyfish-of-chaos-4f5bd8@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/11/25 08:41, Krzysztof Kozlowski ha scritto:
> On Fri, Nov 14, 2025 at 05:53:55PM +0100, Nicolas Frattaroli wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Add a compatible for the MediaTek MT8196 Chromebook SoC's
>> DVFSRC hardware, introducing capability to communicate with it.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Incomplete DCO chain.
> 
> Best regards,
> Krzysztof
> 

Eh yes, Nicolas forgot to add his SoC on all of my commits, whoops :-)

Cheers,
Angelo

