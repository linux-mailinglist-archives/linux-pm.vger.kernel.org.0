Return-Path: <linux-pm+bounces-30019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F7AF7189
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E134A54A6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6512E62A1;
	Thu,  3 Jul 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="mg0ppVZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01A2E4278;
	Thu,  3 Jul 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540513; cv=none; b=QESN74hPh8rEIuuVIGJLYNnn6F3tA7ji0Kx399NwZ2G2P2NK3Olf873Zm+dUr87J0nqjSO9Wp/sX4VupWWsAkW9BPNdDCkuH1JKxYMMzVfUO7dM3wvkugjYbFiIthOG0qmCVpgz0WyS2Gc13/556A/33lPMip2NjfPtHxn9ilNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540513; c=relaxed/simple;
	bh=cJLrkpYalhKPxKq8UM8Ce8k97L/lW0At13Qbw13iBVE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dsnlTzNZz8g0wkDef0thB9xDa6t0IGPaisVzmF7VksrYkaZOSoDRvfm+6uEvsaDBRkoLiqYW4QlntswOlGDlBo+Ds+UoXoe9x5mT52mFnuPvnvaSbMV1iYXru8bUvPyi0jv+/S/6J6uCYJV4mpclJ0RQOQJ1YmZ0AfTkmev0uHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=mg0ppVZE; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id CC90E60470;
	Thu,  3 Jul 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751540502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUOk9rg8FJKLiO2I6XaC3qKD4aR5RnkKJ8cRJENolq0=;
	b=mg0ppVZEIw2vFYZi1hGkgJFJzAXnpBgCwsBZ+eYDHO0mNLiKdLRhwZzoTD4po6PiM9nvFJ
	q0THIholsJJYhvoQrILHnJu65UtCGFkNtZDA24jOfd/E/spJoSTHi0pdax7rqLjmpS/VcA
	3IhAAhmnP1/f+bskKEhHPKQtnFk07Qc=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 7E23B3603D0;
	Thu,  3 Jul 2025 11:01:40 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Jul 2025 13:01:40 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: frank-w@public-files.de, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?Q?Ar=C4=B1n=C3=A7_?=
 =?UTF-8?Q?=C3=9CNAL?= <arinc.unal@arinc9.com>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 01/14] dt-bindings: net: mediatek,net: allow irq names
In-Reply-To: <158755b2-7b1c-4b1c-8577-b00acbfadbdc@kernel.org>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-2-linux@fw-web.de>
 <20250701-wisteria-walrus-of-perfection-bdfbec@krzk-bin>
 <9AF787EF-A184-4492-A6F1-50B069D780E7@public-files.de>
 <158755b2-7b1c-4b1c-8577-b00acbfadbdc@kernel.org>
Message-ID: <b68435e3e44de0532fc1e0c2e7f7bf54@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: f16835e3-c754-4e77-8260-ceabe9311a0a

Am 2025-07-02 08:27, schrieb Krzysztof Kozlowski:
> On 01/07/2025 12:51, Frank Wunderlich wrote:
>> Am 1. Juli 2025 08:44:02 MESZ schrieb Krzysztof Kozlowski 
>> <krzk@kernel.org>:
>>> On Sat, Jun 28, 2025 at 06:54:36PM +0200, Frank Wunderlich wrote:
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>> 
>>>> In preparation for MT7988 and RSS/LRO allow the interrupt-names
>>> 
>>> Why? What preparation, what is the purpose of adding the names, what 
>>> do
>>> they solve?
>> 
>> Devicetree handled by the mtk_eth_soc driver have
>> a wild mix of shared and non-shared irq definitions
>> accessed by index (shared use index 0,
>> non-shared
>> using 1+2). Some soc have only 3 FE irqs (like mt7622).
>> 
>> This makes it unclear which irq is used for what
>> on which SoC. Adding names for irq cleans this a bit
>> in device tree and driver.
> 
> It's implied ABI now, even if the binding did not express that. But
> interrupt-names are not necessary to express that at all. Look at other
> bindings: we express the list by describing the items:
> items:
>   - description: foo
>   - ... bar

ok, so i need to define descriptions for all interrupts instead of only 
increasing the count. Ok, was not clear to me.

so something like this:

item0: on SoCs with shared IRQ (mt762[18]) used for RX+TX, on other free 
to be used
item1: on non-shared SoCs used for TX
item2: on non-shared SoCs used for RX (except RSS/LRO is used)
item3: reserved / currently unused
item4-7: IRQs for RSS/LRO

>> 
>>>> property. Also increase the maximum IRQ count to 8 (4 FE + 4 RSS),
>>> 
>>> Why? There is no user of 8 items.
>> 
>> MT7988 *with* RSS/LRO (not yet supported by driver
>> yet,but i add the irqs in devicetree in this series)
>> use 8 irqs,but RSS is optional and 4 irqs get working
>> ethernet stack.
> 
> That's separate change than fixing ABI and that user MUST BE HERE. You
> cannot add some future interrupts for some future device. Adding new
> device is the only reason to add more interrupts.

MT7988 is basicly new because there is no devicetree there yet...only 
driver and
this (incomplete) binding.

>> 
>> I hope this explanation makes things clearer...
> 
> 
> Commit msg must explain all this, not me asking.
> 
>> 
>>>> but set boundaries for all compatibles same as irq count.
>>> 
>>> Your patch does not do it.
>> 
>> I set Min/max-items for interrupt names below like
>> interrupts count defined.
> 
> No, you don't. It's all fluid and flexible - limited constraints.

i thought i can limit is by setting the MaxItems in the soc-spcific 
blocks below.
What reason does MaxItems have there if not this? of course if there is 
any Soc not
having a specific block it is open.But this is also the case for 
interrupts property
handles the same way before.

I only left it open on mt7988 (only set minitems because all 8 can be 
used, but 4 are required).

>> 
>>>> 
>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>>> ---
>>>> v7: fixed wrong rebase
>>>> v6: new patch splitted from the mt7988 changes
>>>> ---
>>>>  .../devicetree/bindings/net/mediatek,net.yaml | 38 
>>>> ++++++++++++++++++-
>>>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml 
>>>> b/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>>> index 9e02fd80af83..6672db206b38 100644
>>>> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>>> @@ -40,7 +40,19 @@ properties:
>>>> 
>>>>    interrupts:
>>>>      minItems: 1
>>>> -    maxItems: 4
>>>> +    maxItems: 8
>>>> +
>>>> +  interrupt-names:
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - const: fe0
>>>> +      - const: fe1
>>>> +      - const: fe2
>>>> +      - const: fe3
>>>> +      - const: pdma0
>>>> +      - const: pdma1
>>>> +      - const: pdma2
>>>> +      - const: pdma3
>>>> 
>>>>    power-domains:
>>>>      maxItems: 1
>>>> @@ -135,6 +147,10 @@ allOf:
>>>>            minItems: 3
>>>>            maxItems: 3
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 3
>>>> +          maxItems: 3

limited here to the same as interrupts.

>>>>          clocks:
>>>>            minItems: 4
>>>>            maxItems: 4
>>>> @@ -166,6 +182,9 @@ allOf:
>>>>          interrupts:
>>>>            maxItems: 1
>>>> 
>>>> +        interrupt-namess:
>>>> +          maxItems: 1
dito

>>>>          clocks:
>>>>            minItems: 2
>>>>            maxItems: 2
>>>> @@ -192,6 +211,10 @@ allOf:
>>>>            minItems: 3
>>>>            maxItems: 3
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 3
>>>> +          maxItems: 3
dito and so on

>>>>          clocks:
>>>>            minItems: 11
>>>>            maxItems: 11
>>>> @@ -232,6 +255,10 @@ allOf:
>>>>            minItems: 3
>>>>            maxItems: 3
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 3
>>>> +          maxItems: 3
>>>> +
>>>>          clocks:
>>>>            minItems: 17
>>>>            maxItems: 17
>>>> @@ -274,6 +301,9 @@ allOf:
>>>>          interrupts:
>>>>            minItems: 4
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 4
>>>> +
>>>>          clocks:
>>>>            minItems: 15
>>>>            maxItems: 15
>>>> @@ -312,6 +342,9 @@ allOf:
>>>>          interrupts:
>>>>            minItems: 4
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 4
>>> 
>>> 8 interrupts is now valid?
>>> 
>>>> +
>>>>          clocks:
>>>>            minItems: 15
>>>>            maxItems: 15
>>>> @@ -350,6 +383,9 @@ allOf:
>>>>          interrupts:
>>>>            minItems: 4
>>>> 
>>>> +        interrupt-names:
>>>> +          minItems: 4
>>> 
>>> So why sudenly this device gets 8 interrupts? This makes no sense,
>>> nothing explained in the commit msg.
>> 
>> 4 FrameEngine IRQs are required to be defined (currently 2 are used in 
>> driver).
>> The other 4 are optional,but added in the devicetree
> 
> There were only 4 before and you do not explain why all devices get 8.
> You mentioned that MT7988 has 8 but now make 8 for all other variants!
> 
> Why you are not answering this question?

The original binding excluded the 4 RSS/LRO IRQs as this is an optional 
feature not
yet available in driver. It is needed to get the full speed on the 10G 
interfaces.
MT7988 is the first SoC which has 10G MACs. Older Socs like mt7986 and 
mt7981 can also
support RSS/LRO to reduce cpu load. But here we will run into the "new 
kernel - old
devicetree" issue, if we try to upstream this. Maybe we do not add this 
because these
only have 2.5G MACs.

>> to not run into problems supporting old devicetree
>> when adding RSS/LRO to driver.
> 
> This is not about driver, it does not matter for the driver. Binding 
> and
> DTS are supposed to be complete.

if i upstream the ethernet-node now with only 4 IRQS, we have to extend 
them later and
have to deal with only 4 IRQs in driver to be compatible with older DTS. 
So newer
kernel with RSS/LRO support cannot work with older DT.
To avoid this i add all related IRQs now (from DT perspective a new 
device - there is
no mt7988 device with ethernet node in devicetree yet).

>> 
>>> I understand nothing from this patch and I already asked you to 
>>> clearly
>>> explain why you are doing things. This patch on its own makes no 
>>> sense.

i tried to explain :(
i have a working dts for mt7988 and try to upstream it in this series 
and thats the
cause i have to update the binding. Imho i cannot increase the 
interrupt-count in SoC
specific block (e.g. setting count globally to 4 but to 8 for only 
mt7988).

I added interrupt-names to get it cleaner in driver (access via name 
instead of
index). And also in Devicetree we see the meaning of IRQs without 
looking through
driver. I see really no reason for not adding the interrupt names.

>>> Best regards,
>>> Krzysztof

regards Frank

