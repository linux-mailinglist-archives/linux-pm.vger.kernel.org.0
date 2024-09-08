Return-Path: <linux-pm+bounces-13848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8A9705B1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6708C282DA6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E534676410;
	Sun,  8 Sep 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pclr3fWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA5F9F5;
	Sun,  8 Sep 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725783242; cv=none; b=EhhRpltLvhYK6rOMaNI3OUjtMfZqrOnBJ+wuE0D2+50FO0SdhtNyQIc4/aTiiE3lcyRsn3KAV2gR5b1Mj4FRj9wejsNsfMV3dZUtEQccAHFHI977ZGKTKd0yxZyKartAOcXDZ0kT0ep+lg4OD3b0P1ks1MckZg5P75Ha7gnpAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725783242; c=relaxed/simple;
	bh=lk3y3r9rCVBETAKY3ZTOr+TpiAyeqn8OZ0JuF1RrzBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaphcUv2brAgMBhdjLuG2XX+F48WKPXAVoKVtTAC5OuDXXGSHvkv6195ELnPhhSkU7HeFY++vUOA0VYieSXWVZT8RNEkhPYwIysYmMjCsoj4405n5kd/yyfILChajYQv6vlkV1q5GOq50BnvWcmdPtchQo5qnNB9xyD8WVdKj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pclr3fWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA59EC4CEC3;
	Sun,  8 Sep 2024 08:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725783242;
	bh=lk3y3r9rCVBETAKY3ZTOr+TpiAyeqn8OZ0JuF1RrzBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pclr3fWNCXyFvmnW7/dKCy75j6qc38ImoqMgkG1VKgZVu6ir2YWdCkVJSGVutF1h/
	 7Z+pwlL/HL/pO4puQt6uGk82kbye2biFWZIrjSePMKFNcsbfa+g6MnFuOZmf8H8kn6
	 dpcReWjafb+rcFGUdGNfJiG4fWSQl5WDZrVyOlS2ff/4PynEeBYETKI5QLRr3nDGKz
	 SGDB8SWqQPaheNsS3Dz8Dmi38VmBnYZpC4IMPsqyPbK5gS+b1UYOecahBx7RRATE/A
	 X4v+f2smG7vP0Yl3N7iJsRwJe8dHCqG3TE8liCxab+JXSE0Av8gOonotjfxgPPsqYZ
	 Xt8yru/lucckw==
Message-ID: <77d41268-30e3-48a5-b611-40f586586ffb@kernel.org>
Date: Sun, 8 Sep 2024 10:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: Add documentation for Photonicat PMU
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "\"Conor Dooley,\"," <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-9-bigfoot@classfun.cn>
 <dbc6af20-886a-46fb-a16c-dbcb5861478c@kernel.org>
 <cd0b36f4-f31d-4a65-868c-72b3c7021f14@classfun.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cd0b36f4-f31d-4a65-868c-72b3c7021f14@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2024 16:27, Junhao Xie wrote:

>>> +
> [...]
>>> +  local-address:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 1
>>> +    maximum: 127
>>> +    default: 1
>>> +    description: CPU board address
>>
>> Address of what? In which notation? It's part of this hardware.
>>
> 
> Photonicat's MCU protocol documentation says it supports multiple hosts.
> But Photonicat only uses one.
> Is it necessary to remove local-address and use a fixed address?

I don't understand what this "address" is for.

> 
>>
>>> +
>>> +  remote-address:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 1
>>> +    maximum: 127
>>> +    default: 1
>>> +    description: PMU board address
>>
>> Eee, no. Your board knows its address. You do not have to tell it.
> 
> I will remove remote-address.
> 
>>
> [...]
>>> +
>>> +patternProperties:
>>> +  '^leds-(status)':
>>
>> That's not a pattern.
>>
> 
> I originally wanted to keep it for extensions, but it didn't seem like a good idea.
> I will move it to properties.
> 
>>> +    $ref: /schemas/leds/ariaboard,photonicat-pmu-leds.yaml
>>> +
>>> +  '^supply-(battery|charger)$':
>>> +    $ref: /schemas/power/supply/ariaboard,photonicat-pmu-supply.yaml
>>
>> Why two nodes?
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +      serial {
>>> +          photonicat-pmu {
>>> +              compatible = "ariaboard,photonicat-pmu";
>>> +              current-speed = <115200>;
>>> +              local-address = <1>;
>>> +              remote-address = <1>;
>>> +
>>> +              supply-battery {
>>> +                  compatible = "ariaboard,photonicat-pmu-supply";
>>> +                  label = "battery";
>>
>> Nope, drop label.
>>
>>> +                  type = "battery";
>>
>> No, there is no type property.
> 
> There are two supplies here, one is the charger and the other is the battery.
> Is it necessary to change to use different compatible ones like
> ariaboard,photonicat-pmu-battery and ariaboard,photonicat-pmu-charger?

Are the devices different? Why do you even need the type?

> 
>>
>> Missing monitored battery.
>>
> 
> I will add it.
> 
>>> +              };
>>> +
> [...]
>>> +
>>> +              watchdog {
>>> +                  compatible = "ariaboard,photonicat-pmu-watchdog";
>>> +              };
>>
>> These are seriously redundant and useless nodes.  There is nothing
>> beneficial from the nodes above - they are all empty, without resources.
>> Drop all of them.
> 
> How should I describe these devices? Using mfd_cell?

You mean drivers? MFD or auxiliary bus.

Best regards,
Krzysztof


