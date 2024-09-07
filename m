Return-Path: <linux-pm+bounces-13838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1CB9702B2
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973031C21A64
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42515DBB6;
	Sat,  7 Sep 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="ED2ZPh7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F81E4AE;
	Sat,  7 Sep 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725719284; cv=none; b=SB6EZTKDQR1Q/VRDugY17un2mK+vEMlgNzjXY2T8k6ciCWFS5Xft0EUOB4d0vE8YbVHSg/5h7bc7BL0WMm9JG3FgCptvYBs/lb+o0qi2ONc+Mdsc2SCwepDaxUBrk/N7KZA1EwjOiKEWtch1UReDzZxK3Ugo3nqmPWjP+yZ4RZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725719284; c=relaxed/simple;
	bh=e5dX7QksYM5QgGDSKhEO2HZhpOjniPBi8ARplLhfpfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DsvfzwlBpLouHYu6+oR8m5W69iqYiJcFSVZ1jIxwQ07GgXttwPvUDsLPGsnsKkCFrznY9pX4NxiL6TnI0WCvk3/4K36qli6RlvuDIVotClH06StRhizca5RMoY2fmsCljHdIkyshvlaZPCtUIZ+eIPgotwJtgTV+LG8ylA96kCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=ED2ZPh7x; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 81D3378A01;
	Sat,  7 Sep 2024 22:27:41 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 81D3378A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725719267;
	bh=pXuvREj+1sdfcnTVSFVdtNeed2YvMG01TbfaFiPG+Ec=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ED2ZPh7xAnWkoiSr/Tx8HAW02FcKkQ5sX5Hsn5+y1d+Foo+MQVS+UPFczjyTjIme1
	 C+uR0opV7ZQ7daW9p3cPJOC9zu6rh8zXawTRqAsFCqXLFycy12FcpcFDx6nLEpfQ4F
	 AV+vPQdx0m2xlgozPrPYOEeFtJo3lPi7v//ruhrQ=
Message-ID: <cd0b36f4-f31d-4a65-868c-72b3c7021f14@classfun.cn>
Date: Sat, 7 Sep 2024 22:27:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: Add documentation for Photonicat PMU
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-9-bigfoot@classfun.cn>
 <dbc6af20-886a-46fb-a16c-dbcb5861478c@kernel.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
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
 Chukun Pan <amadeus@jmu.edu.cn>, Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <dbc6af20-886a-46fb-a16c-dbcb5861478c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 17:51, Krzysztof Kozlowski wrote:
> On 06/09/2024 11:36, Junhao Xie wrote:
>> Add device tree binding documentation for Photonicat PMU MFD, LEDs,
>> hardware monitor, power off, power supply, real-time clock watchdog.
[...]
>> diff --git a/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ariaboard,photonicat-pmu-hwmon.yaml
[...]>> +  label:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Label for hwmon device
> 
> No resources here. Fold it into parent binding.
> 
>> +
>> +required:
>> +  - compatible
>> +  - label
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +      serial {
>> +          mcu {
>> +              compatible = "ariaboard,photonicat-pmu";
> 
> Drop, no need.
> 
>> +
> 
> Messed indentation.
> 
> Entire example is redundant. Merge it to parent binding.
> 

I will fix them.

> 
[...]
>> diff --git a/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml b/Documentation/devicetree/bindings/leds/ariaboard,photonicat-pmu-leds.yaml
[...]
>> +properties:
>> +  compatible:
>> +    const: ariaboard,photonicat-pmu-leds
> 
> Your compatibles per device do not make much sense. You organized
> bindings per drivers, but that's not what we want.
> 
>> +
>> +  label: true
> 
> Drop

I will drop it.

> 
[...]
>> diff --git a/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml b/Documentation/devicetree/bindings/mfd/ariaboard,photonicat-pmu.yaml
[...]
>> +description:
>> +  Driver for the Power Management MCU in the Ariaboard Photonicat,
> 
> Bindings are for hardware, not drivers. Drop it everywhere and explain
> hardware.
> 

I will edit it.
Maybe the following looks better?
  The Power Management MCU in Ariaboard Photonicat, which
  provides battery and charger power supply real-time clock,
  watchdog, hardware shutdown, status LEDs.

>> +  which provides battery and charger power supply, real-time clock,
>> +  watchdog, hardware shutdown.
>> +
>> +properties:
>> +  compatible:
>> +    const: ariaboard,photonicat-pmu
> 
> That's the only compatible you should have. Drop all others.
> 
>> +
[...]
>> +  local-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 127
>> +    default: 1
>> +    description: CPU board address
> 
> Address of what? In which notation? It's part of this hardware.
> 

Photonicat's MCU protocol documentation says it supports multiple hosts.
But Photonicat only uses one.
Is it necessary to remove local-address and use a fixed address?

> 
>> +
>> +  remote-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 127
>> +    default: 1
>> +    description: PMU board address
> 
> Eee, no. Your board knows its address. You do not have to tell it.

I will remove remote-address.

> 
[...]
>> +
>> +patternProperties:
>> +  '^leds-(status)':
> 
> That's not a pattern.
> 

I originally wanted to keep it for extensions, but it didn't seem like a good idea.
I will move it to properties.

>> +    $ref: /schemas/leds/ariaboard,photonicat-pmu-leds.yaml
>> +
>> +  '^supply-(battery|charger)$':
>> +    $ref: /schemas/power/supply/ariaboard,photonicat-pmu-supply.yaml
> 
> Why two nodes?
> 
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +      serial {
>> +          photonicat-pmu {
>> +              compatible = "ariaboard,photonicat-pmu";
>> +              current-speed = <115200>;
>> +              local-address = <1>;
>> +              remote-address = <1>;
>> +
>> +              supply-battery {
>> +                  compatible = "ariaboard,photonicat-pmu-supply";
>> +                  label = "battery";
> 
> Nope, drop label.
> 
>> +                  type = "battery";
> 
> No, there is no type property.

There are two supplies here, one is the charger and the other is the battery.
Is it necessary to change to use different compatible ones like
ariaboard,photonicat-pmu-battery and ariaboard,photonicat-pmu-charger?

> 
> Missing monitored battery.
> 

I will add it.

>> +              };
>> +
[...]
>> +
>> +              watchdog {
>> +                  compatible = "ariaboard,photonicat-pmu-watchdog";
>> +              };
> 
> These are seriously redundant and useless nodes.  There is nothing
> beneficial from the nodes above - they are all empty, without resources.
> Drop all of them.

How should I describe these devices? Using mfd_cell?

> 
> I finish the review here.
> 
> Best regards,
> Krzysztof
> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

