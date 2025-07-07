Return-Path: <linux-pm+bounces-30261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A5AFB0B3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806201896BFE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E11291C31;
	Mon,  7 Jul 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nyz3P/mV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640D202996;
	Mon,  7 Jul 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882768; cv=none; b=JoMOk5FP4AgPNHUl0ya4kxumsKiDNMoPXRNubIZlNeUCKSFSpcmWFDePcEAsdmHXzYp0/6SKG3OfsTZ3z1+F24PCPQIyZ2/kxDDdI6T6KvWMCsUN0ibhcaUu57Uy8TfsbgaoMDS0IygKwNVlzWzJE4p5EfBqM3mxQf0ntZYaZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882768; c=relaxed/simple;
	bh=T8iIMPb9brgtZdi72SAWfhA8roPO7vUHjVTHHnOQNVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvE8ynq4IWgbfi2LC4xnm05WJ1BqF12s3MLqMU7GjvH3uEJZfTlgUJ7e7hzlCG3gfNGKUYr4WYlNTBGqjLbWnAlxgTbLc9ckiFbGnjjKKq6WHi9CyJro4KPi3QoswmEzBNqbcBukpn9dLhjCxQ+htNV9HPb0GqKHJQXoo6YiC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nyz3P/mV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751882764;
	bh=T8iIMPb9brgtZdi72SAWfhA8roPO7vUHjVTHHnOQNVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nyz3P/mVFjxZfpeCi+JHgh8VJSn0xoox1dJhCSYXuFxwdM0sNvNwafLR/zAZnTyb5
	 G312aUFagNYKNK6E1I1kbqOBbGEQkEaPk40y50SsokLo9okJt1SW3p3dOjBTz8bjv2
	 Wky154Wu8MeJEVP0vKR5wGEm2/jwK6+2GqTN0ztwuL7vAUWf4ynz1JywSUZ+P8mrze
	 6w8T8cHr3PtE+/HkwOM7xpiDiZ/Mj812jWdPqEYXBopHPpm4vjZUl1FlU/tTZY1Euk
	 7RxWXNpMj991IsirfIg5/V1rgvS+ANZm9yFs7dZ88Ag05O5oT3IDfGNEQODCHAOFaZ
	 EgqL5tUpvw0nQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BAA017E07C9;
	Mon,  7 Jul 2025 12:06:03 +0200 (CEST)
Message-ID: <90a3191f-882d-4302-afd5-e73e751b5b95@collabora.com>
Date: Mon, 7 Jul 2025 12:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/16] dt-bindings: net: mediatek,net: allow up to 8
 IRQs
To: Frank Wunderlich <linux@fw-web.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Frank Wunderlich <frank-w@public-files.de>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250706132213.20412-1-linux@fw-web.de>
 <20250706132213.20412-3-linux@fw-web.de>
 <20250707-modest-awesome-baboon-aec601@krzk-bin>
 <B875B8FF-FEDB-4BBD-8843-9BA6E4E89A45@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <B875B8FF-FEDB-4BBD-8843-9BA6E4E89A45@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/07/25 09:30, Frank Wunderlich ha scritto:
> Am 7. Juli 2025 08:31:11 MESZ schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>> On Sun, Jul 06, 2025 at 03:21:57PM +0200, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO).
>>
>> Because? Hardware was updated? It was missing before?
> 
> There is no RSS support in driver yet,so IRQs were not added to existing DTS yet.
> 

That's the problem. It's the hardware that you should've described, not the driver.

In short, you should've allowed the interrupts from the get-go, and you wouldn't
be in this situation now :-)

>>>
>>> Frame-engine-IRQs (max 4):
>>> MT7621, MT7628: 1 IRQ
>>> MT7622, MT7623: 3 IRQs (only two used by the driver for now)
>>> MT7981, MT7986, MT7988: 4 IRQs (only two used by the driver for now)
>>
>> You updated commit msg - looks fine - but same problem as before in your
>> code. Now MT7981 has 4-8 interrupts, even though you say here it has only
>> 4.
> 
> Ethernet works with 4,but can be 8 for MT798x.
> I cannot increase the MinItems here as it will
> throw error because currently only 4 are defined in DTS.same for MT7986.
>>>
>>> Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
>>> LRO.
>>
>> Although I don't know how to treat this. Just say how many interrupts
>> are there (MT7981, MT7986, MT7988: 4 FE and 4 RSS), not 4 but later
>> actually 4+4.
> 
> First block is for Frame Engine IRQs and second for RSS/LRO. Only mention total count
> across all SoCs is imho more confusing.
> 
>> I also do not understand why 7 interrupts is now valid... Are these not
>> connected physically?
> 
> 7 does not make sense but i know no way to allow 8 with min 4 without between (5-7).
> 
>> Best regards,
>> Krzysztof
> 
> Hi
> 
> Thanks for taking time for review again.
> 
> First block are the frame engine IRQs which are max 4 and on all SoCs.
> The RSS IRQs are only valid on Filogic (MT798x),so there a total of 8, but on
> MT7981 and MT7986 not yet added as i prepare the RSS/LRO driver in background.
> We just want to add the IRQs for MT7988 now.
> regards Frank

Again, it's not the driver but the hardware that you're describing.

As long as you are fixing the description of the hardware, even for all three,
I am personally even fine with breaking the ABI, because the hardware description
has been wrong for all that time.

Just don't send those as Fixes commits, but next time you upstream something you
must keep in mind that in bindings/dts you're describing hardware - the driver is
something that should not drive any decision in what you write in bindings.

We're humans, so stuff like this happens - I'm not saying that you shall not make
mistakes - but again please, for the next time, please please please keep in mind
what I just said :-)

Now the options are two:
  - Break the ABI; or
  - Allow 4 or 8 interrupts (not 5, not 6, not 7)

and that - not just on MT7988 but also on 81 and 86 in one go.

Not sure if the second one is feasible, and I'm considering the first option only
because of that; if the second option can be done, act like I never ever considered
the first.

Cheers,
Angelo

