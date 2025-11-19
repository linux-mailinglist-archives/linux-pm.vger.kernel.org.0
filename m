Return-Path: <linux-pm+bounces-38210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF815C6D734
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 09:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EC5102D5BC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9C32C92A;
	Wed, 19 Nov 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kjsTtw1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015E32B9A7;
	Wed, 19 Nov 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541244; cv=none; b=M/ftC+BTuxmEDNk6TfLPu0v3rlEGXqdE72KTnD//uAPGPBlIGaEj6HyuX6qzIydKHSVLbsmN6Z8lOR9C/iI4qx/MiIszOhyWxmaTckY5Ru1iiofW+HkhY8w/r+SS9IfY5myfD7Uk9iFNVB96+PO5t6cKcggGbm2JTRPuL/9siq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541244; c=relaxed/simple;
	bh=1Pc5fBlhsZRdTIzwz2Wk8NOr8hOO9wcu82HCeysKRwk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gffa82Obuf/gGVv/efNowcP96G+e4VOxCwtiaK6FbuJp5oA4C3vDu5CuhOpe1VUVWwcPw/a7fWARl6QXE1O+0egQq7LxNOR06iIj11DDQSHP3sfoqbfwaKTA5wftImKFuQu9v/l7IpZJBSP8DgPmxTf8EvgMnf7ny0PW0W1dhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kjsTtw1P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763541237;
	bh=1Pc5fBlhsZRdTIzwz2Wk8NOr8hOO9wcu82HCeysKRwk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kjsTtw1PJuGX6Mv1xUUq6YRgSSs3tyKfWsV9SfMHkCQV11DsLeiF5Q1IlSWZFIOLs
	 6YRq74PzDdJTQNwRBujSx9zKpia9dAtzWgsr7jeT2f52844SwQX/y+l1/rwijtH9Qh
	 UvbuQN3vIe2CKVGeSlLiT5JZDz+LEFnYr3+azqh4KOE2K7gqlA1wnu+ZdaeuJ6YX0Y
	 Zr8epnbJMh2FlqeXhTp7IvEFA4Ukg+jsPVtV9eyg0smv3Bzeg4u/r9pJW6phmOnzQ+
	 9gJfhJB3fMF+gAPejSh8ROpDS2qSVNo/NgF96G6X8CRReXrTqxPB3xlm9JgFu/uVKV
	 FcGonuD9BQP7A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2B3717E0154;
	Wed, 19 Nov 2025 09:33:56 +0100 (CET)
Message-ID: <bb84228f-2aab-4b82-b787-37fe631007e7@collabora.com>
Date: Wed, 19 Nov 2025 09:33:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support for
 MT8196
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 <39fba430-3841-4bf2-9fe7-44f372ff4a16@collabora.com>
Content-Language: en-US
In-Reply-To: <39fba430-3841-4bf2-9fe7-44f372ff4a16@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/11/25 09:32, AngeloGioacchino Del Regno ha scritto:
> Il 19/11/25 08:41, Krzysztof Kozlowski ha scritto:
>> On Fri, Nov 14, 2025 at 05:53:55PM +0100, Nicolas Frattaroli wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>> Add a compatible for the MediaTek MT8196 Chromebook SoC's
>>> DVFSRC hardware, introducing capability to communicate with it.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Incomplete DCO chain.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Eh yes, Nicolas forgot to add his SoC on all of my commits, whoops :-)

his SoC!??!?! Ugh. I meant SoB, and I should sleep more, lol

> 
> Cheers,
> Angelo


