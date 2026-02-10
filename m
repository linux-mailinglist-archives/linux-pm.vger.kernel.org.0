Return-Path: <linux-pm+bounces-42441-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIDwFVwVi2n5PQAAu9opvQ
	(envelope-from <linux-pm+bounces-42441-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:24:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6779911A182
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B4F1300BE0A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978B320A14;
	Tue, 10 Feb 2026 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWSjfmHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362A318BBB;
	Tue, 10 Feb 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722647; cv=none; b=SXbatCI0gjw1U7ahoZ397Yg8MlWyvVyuf9naz/B7uUSZMzoarp8IFimoCXmWvwWtJSM7/mao+Kdv1O4Axb9ckEs5q+gxhiukk+i/kTmwL9gQhKmN4vmoqfcsDjCtod1jPTW30W6WWxu953Cssnj7a6+a+6ChvWtfJTsISMLYErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722647; c=relaxed/simple;
	bh=qtWcGGNQTHx1PZZdqOK/r5p2scN0dMHiFnAM5S93qEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLcmUfDWDSfjFnb/xkZha+ZFcIkLgv8eLfrRP3GGNecldH33aLcApMg9339++T+Rrj8f229pZt44YIBDh39iLriTXVyl5PQRJ6YNAITUFLLzgE1+JuHlpEP6x3KNbcEeNEXDMUFDV7N12JhjPrWEMNXHsw5VIg4hsFajHdLz4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWSjfmHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D707C116C6;
	Tue, 10 Feb 2026 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770722646;
	bh=qtWcGGNQTHx1PZZdqOK/r5p2scN0dMHiFnAM5S93qEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWSjfmHXFsVxIOWV65MwnYtJmZpcHdVxwI2+pPTAahGC8d0JmBY0rkD587DAuFgo6
	 0lOKpu8Y0/joHB9mOR7Xz2m5tYnFS8MSpBkqOIrGIJPtkhHFKaOJY9VK5siDTI831L
	 H9uhuLiHqkKHG1evmiATieaViRF94gUEiUrojSYWy2Ra4xkMiQzl4mhWTiWj5ewwFo
	 nK8a3C72NfSqMIugtoxuvZv/+gamj+idyHNjbyRsx5Jtz0PhZvcEbruNROx7/KaWZW
	 gXT6en/jxc2VNKVQtDNd3kROFBa1sCGgx+Kcd0meVzpUK77J3L8NsRniqDJU5nsaPH
	 rQaocxRpK3mDQ==
Message-ID: <dc7acd1e-91e8-492c-8665-cb680c6164fd@kernel.org>
Date: Tue, 10 Feb 2026 12:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, Ion Agorria <ion@agorria.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll>
 <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org>
 <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
 <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org>
 <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42441-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6779911A182
X-Rspamd-Action: no action

On 10/02/2026 12:14, Svyatoslav Ryhel wrote:
> вт, 10 лют. 2026 р. о 13:04 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On 10/02/2026 11:59, Svyatoslav Ryhel wrote:
>>>>>>> +  asus,clear-factory-mode:
>>>>>>> +    type: boolean
>>>>>>> +    description: clear Factory Mode bit in EC control register
>>>>>>
>>>>>> Why would this be a static/fixed property over lifecycle of all devices?
>>>>>>
>>>>>
>>>>> Specify pls.
>>>>
>>>> Provide rationale why we need to clear it every time, not once. Or any
>>>> other rationale why we would accept that property.
>>>>
>>>
>>> Cause it is done by original Asus code and Asus did not provide
>>> schematic or any data apart from downstream source regarding this EC.
>>
>> So that's a no. downstream code which is poor quality, not following DT
>> rules at all, is never an argument for a DT property.
>>
> 
> This property indicates that this controller on every reset restores

Implied by compatible then and you can drop the property.

> factory bit hence it must be cleared. Bit is write only and cannot be
> detected. EC remains in factory mode which blocks its functions.
> 
>>>
>>>>>
>>>>>>> +
>>>>>>> +  battery:
>>>>>>> +    type: object
>>>>>>> +    $ref: /schemas/power/supply/power-supply.yaml
>>>>>>> +    unevaluatedProperties: false
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      compatible:
>>>>>>> +        const: asus,ec-battery
>>>>>>> +
>>>>>>> +    required:
>>>>>>> +      - compatible
>>>>>>> +
>>>>>>> +  charger:
>>>>>>> +    type: object
>>>>>>> +    $ref: /schemas/power/supply/power-supply.yaml
>>>>>>> +    additionalProperties: false
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      compatible:
>>>>>>> +        const: asus,ec-charger
>>>>>>> +
>>>>>>> +      monitored-battery: true
>>>>>>> +
>>>>>>> +    required:
>>>>>>> +      - compatible
>>>>>>> +
>>>>>>> +  keyboard-ext:
>>>>>>> +    type: object
>>>>>>> +    description: top row of multimedia keys
>>>>>>> +    additionalProperties: false
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      compatible:
>>>>>>> +        const: asus,ec-keys
>>>>>>> +
>>>>>>> +    required:
>>>>>>> +      - compatible
>>>>>>> +
>>>>>>> +  led:
>>>>>>> +    type: object
>>>>>>> +    additionalProperties: false
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      compatible:
>>>>>>> +        const: asus,ec-led
>>>>>>> +
>>>>>>> +    required:
>>>>>>> +      - compatible
>>>>>>> +
>>>>>>> +  serio:
>>>>>>
>>>>>> All of these children are pointless - no resources. Drop all of them,
>>>>>> it's btw explicitly documented rule in writing bindings.
>>>>>>
>>>>>
>>>>> They are all needed to be able to disable them individually from the
>>>>> device tree if needed.
>>>>
>>>> They should not be disabled from DT, so they are not valid here. The
>>>> given EC for given device is fixed/static. Does not change.
>>>>
>>>
>>> Have you considered a possibility that function may be
>>> disabled/unrouted within the controller. By the vendor.
>>
>> And then it is implied by the compatible, so no need for any of that.
>> Otherwise, if it is not specific per device, then specifying it for DTS
>> for all devices would make no sense.
>>
> 
> So you propose introduce a compatible for every single ec used in
> transformers instead of simply disable unpopulated functions? And how
> then battery and charger can reach monitored cell if they have no
> dedicated node?

Just like for other bindings for nodes without resources, fold into
parent. This is already explained in writing bindings, so you could have
just read that. I will pass with answering more questions till you read
that doc.


Best regards,
Krzysztof

