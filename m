Return-Path: <linux-pm+bounces-42734-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGD5JJZRlGkUCgIAu9opvQ
	(envelope-from <linux-pm+bounces-42734-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:31:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F414B648
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD53D301017B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02341333750;
	Tue, 17 Feb 2026 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcd75SSJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF348263C9F;
	Tue, 17 Feb 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327868; cv=none; b=W4I7obamRQWvjRqM5jloX2Eg71JMv23Asun4LlRZIT1dOFpD2FBoENjWgcrrFq2LwYQd10Btp45WIRZ87AZZQz92pk5XGI04iLPD8WcJX7Ko5GQ1ZXKBtFKcNulOwjBbnTFl91mMparsdROHpPgQczEiXChAjdjjv+yOYBaROjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327868; c=relaxed/simple;
	bh=WehI0hiluxKI2cyEJUs/TpABynFE7fxyWvNATvSnCb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWHsbYbx9OXy/YnBgBiiYNncIFE+iY8jFUOLjuln6lHHpn6TXvS5kOfBWfdMxugnNlDcxNulo/ZDOjCEjD0YL6GSEsi/WJYyBliEUtFkXCHawQ31uOpPN0j62f00gn6LeoTiV9Fvpdd6NY7fakcBU+tw9kyxiF8NqaxLAkMtPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcd75SSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C252C4CEF7;
	Tue, 17 Feb 2026 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771327868;
	bh=WehI0hiluxKI2cyEJUs/TpABynFE7fxyWvNATvSnCb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dcd75SSJv4+Txm2cDHs9JegFaVCP59JgsRuM1LoGFE08uuFs+GrbNxQAdU7LC7B58
	 hMeBvLI2y3ZhUtTaEXKmxgJW02/3DFT1SiWc5Cpliy9fynbJMw9U51mSKCcZCyzRyw
	 dUMKABbWvnZXZ1tptvj1QQZTKuJoLAIkvgF7naVou4D5TAwn9PgZNzNCp9U0IH2r1Q
	 l3nMLk1j01YdvenrBcfLEQ53+m080MijjM6EqWSqYLqXSoHhLlLzR6DLPv2goG37eE
	 awfR52GX/PdtcblXdK80NxwpYU0fr6C3zROIfiHgL2K2jPPWAJRo6+ntDEZGjkY0hl
	 fSe4K9GT2zDew==
Message-ID: <73949a79-7262-47ea-8bc7-87e10f75065c@kernel.org>
Date: Tue, 17 Feb 2026 12:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
To: Conor Dooley <conor@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260217-vowed-botany-b1c47c7e40b8@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42734-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EE7F414B648
X-Rspamd-Action: no action

On 17/02/2026 12:05, Conor Dooley wrote:
> On Mon, Feb 16, 2026 at 09:14:40PM +0200, Svyatoslav Ryhel wrote:
>> пн, 16 лют. 2026 р. о 20:50 Conor Dooley <conor@kernel.org> пише:
>>>
>>> On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
>>>> пн, 16 лют. 2026 р. о 20:04 Conor Dooley <conor@kernel.org> пише:
>>>>>
>>>>> On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
>>>>>> Document embedded controller used in ASUS Transformer device series.
>>>>>>
>>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>>> ---
>>>>>>  .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++++
>>>>>>  1 file changed, 98 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..670c4c2d339d
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
>>>>>> @@ -0,0 +1,98 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/embedded-controller/asus,transformer-ec.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: ASUS Transformer's Embedded Controller
>>>>>> +
>>>>>> +description:
>>>>>> +  Several Nuvoton based Embedded Controllers attached to an I2C bus,
>>>>>> +  running a custom ASUS firmware, specific to the ASUS Transformer
>>>>>> +  device series.
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/power/supply/power-supply.yaml
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    oneOf:
>>>>>> +      - enum:
>>>>>> +          - asus,p1801-t-ec-pad
>>>>>> +          - asus,sl101-ec-dock
>>>>>> +          - asus,tf600t-ec-pad
>>>>>> +          - asus,tf701t-ec-pad
>>>>>> +
>>>>>> +      - items:
>>>>>> +          - enum:
>>>>>> +              - asus,tf101-ec-dock
>>>>>> +              - asus,tf101g-ec-dock
>>>>>> +              - asus,tf201-ec-dock
>>>>>> +              - asus,tf300t-ec-dock
>>>>>> +              - asus,tf300tg-ec-dock
>>>>>> +              - asus,tf300tl-ec-dock
>>>>>> +              - asus,tf700t-ec-dock
>>>>>> +          - const: asus,transformer-ec-dock
>>>>>> +
>>>>>> +      - items:
>>>>>> +          - enum:
>>>>>> +              - asus,tf201-ec-pad
>>>>>> +              - asus,tf300t-ec-pad
>>>>>> +              - asus,tf300tg-ec-pad
>>>>>> +              - asus,tf300tl-ec-pad
>>>>>> +              - asus,tf700t-ec-pad
>>>>>> +          - const: asus,transformer-ec-pad
> 
>>>>> Also, why are some of the compatibles permitted standalone? That should
>>>>> be mentioned in your commit message too. Also, other than the sl101, the
>>>>> standalone ones seem to have the same match data in the mfd driver. Why
>>>>> are fallbacks not made use of there?
>>>>>
>>>>
>>>> Because standalone compatibles describe a unique hw configuration
>>>> which cannot be grouped into something meaningful. asus,p1801-t-ec-pad
>>>> is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
>>>> for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered EC
>>>> in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
>>>> Different generations, different form-factors.
>>>
>>> I don't see any reasons here that eliminate fallback compatibles.
>>> +       { .compatible = "asus,p1801-t-ec-pad", .data = &asus_ec_pad_charger_data },
>>> +       { .compatible = "asus,tf600t-ec-pad", .data = &asus_ec_pad_charger_data },
>>> +       { .compatible = "asus,tf701t-ec-pad", .data = &asus_ec_pad_charger_data },
>>> +       { }
>>> Three of them use the same match data, so you need to explain why you've
>>> made these three standalone when all the others that share a programming
>>> model got a generic fallback. Fallback usage is based on programming
>>> model, not based on whether the devices are a physically different, so
>>> your explanation must reflect this.
>>>
>>>>> Since this transformer series seems to have multiple programming models
>>>>> for "ec-pad" devices, it calls into question your use of the generic
>>>>> fallback compatibles is appropriate and makes it seem like you should be
>>>>> using device compatibles as a fallback.
>>>>
>>>> That is redundant.
>>>
>>> I don't understand how that is a response to what I said.
>>>
>>
>> in other words you propose this:
>>
>> properties:
>>   compatible:
>>     oneOf:
>>       - items:
>>           - enum:
>>               - asus,sl101-ec-dock
>>               - asus,tf101-ec-dock
>>               - asus,tf101g-ec-dock
>>               - asus,tf201-ec-dock
>>               - asus,tf300t-ec-dock
>>               - asus,tf300tg-ec-dock
>>               - asus,tf300tl-ec-dock
>>               - asus,tf700t-ec-dock
>>           - const: asus,transformer-ec-dock
>>
>>       - items:
>>           - enum:
>>               - asus,p1801-t-ec-pad
>>               - asus,tf201-ec-pad
>>               - asus,tf300t-ec-pad
>>               - asus,tf300tg-ec-pad
>>               - asus,tf300tl-ec-pad
>>               - asus,tf700t-ec-pad
>>               - asus,tf600t-ec-pad
>>               - asus,tf701t-ec-pad
>>           - const: asus,transformer-ec-pad
>>
>> And in the driver add match to every single entry of enums?
> 
> No, I was talking about removing the generic compatibles entirely, since
> they are not suitably generic to cover all devices at the point of
> addition. So like:

Yep. Generic compatible has hardly a meaning if you already know it is
not generic enough - some devices are not compatible with it.

Each SoC/platform which pushed to these generic compatible, hit a wall
after some months/years. Apple is a nice example now.


Best regards,
Krzysztof

