Return-Path: <linux-pm+bounces-34976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1E6B85C27
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DC1895188
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B23126CB;
	Thu, 18 Sep 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jnvwyGBZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55945241664;
	Thu, 18 Sep 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210300; cv=none; b=UfRMD5d0bAyFeCEkeVz3DWf8Ny2W+JEO6iDm3Py9ivaXtfme6QFllr2qwuoh2lRACp2zXkCxxgJ1BxhAdcSExxpFD8Kd9+lmhW5lIt2KEU3r25AMG3KJkMvvjfzvwC7i9J5iDGB7q28K7pyhMMfE9tlA4vwHjYrts4geS4DQKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210300; c=relaxed/simple;
	bh=TLxm4ahaIJ4V2L6slJoaSY8rcZnLIWsUYo2kqnEhio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHmz+LSDFlmONYnXw6YMD+Gp+2Qz7CK25cdbnqD3F1NGRcFUmzxgVZEbRdV3wsc96l2F4lABGYRXgMG2AZHk4s3cAUcBvqmmG0AYI1C1OrzG06h/c1QLJ66Sv1Yd6rx9/huAyhqXrqrzxRWW2RtD/h3wWhkyyWs34+Ap9nO9bKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jnvwyGBZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758210298; x=1789746298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TLxm4ahaIJ4V2L6slJoaSY8rcZnLIWsUYo2kqnEhio0=;
  b=jnvwyGBZm2+eLptez7OQSkLFEFR+1nkchtnLm/Rmg7jzMyHPCjGg2Lis
   KjCilI0FxVouXykTA1e+eC8//YY1nY4/WZe3g1jupRUXtHhTxrC2m9+uh
   UdknAV+Wzy4Voz1lSATT4/h6ffd2rRRZjj55nlfyLMR/eWVbXq7hwXTI8
   I0soqbe1A0edejtiQD+cWCVBQZcjUH3cbG3MyXRi4e8Rjw5rAXAy5g2Kn
   kX+L9WsDaNL/X8cB5QQztzGYODROpN1KonDpFNHBFGr3QRRDnnFMBjS3M
   IjjmD8ncJ9BSpOVkg+MU7ZRaLMafBtzlcpQVzHkm3x6y2ltQ3z+azANI+
   w==;
X-CSE-ConnectionGUID: ml0fmOoaTYS4Bvnd20HWOg==
X-CSE-MsgGUID: +JtR0hcARAOkhn0YlKPN3g==
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="214065523"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 08:44:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 08:44:43 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 18 Sep 2025 08:44:43 -0700
Message-ID: <895aaf27-cfb7-4071-a62d-b9204c249cc1@microchip.com>
Date: Thu, 18 Sep 2025 08:44:45 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 add lpm binding
To: Conor Dooley <conor@kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <sre@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>
References: <cover.1758051358.git.Ryan.Wanner@microchip.com>
 <d8fc40a97008cb0b4001684b3c9e1cc4bf3fb706.1758051358.git.Ryan.Wanner@microchip.com>
 <20250917-zeppelin-stoppage-0d0f876df93e@spud>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <20250917-zeppelin-stoppage-0d0f876df93e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 9/17/25 12:38, Conor Dooley wrote:
> On Tue, Sep 16, 2025 at 12:50:30PM -0700, Ryan.Wanner@microchip.com wrote:
>> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>>
>> Add microchip,lpm-connection binding which allows to specify the devices
>> the SHDWC's Low Power Mode pin is connected to.
>>
>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>> [ryan.wanner@microchip.com: Add sam9x7-shdwc SoC to properties check]
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>  .../power/reset/atmel,sama5d2-shdwc.yaml      | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>> index 9c34249b2d6d..668b541eb44c 100644
>> --- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>> @@ -56,6 +56,13 @@ properties:
>>      description: enable real-time timer wake-up
>>      type: boolean
>>  
>> +  microchip,lpm-connection:
>> +    description:
>> +      List of phandles to devices which are connected to SHDWC's Low Power Mode Pin.
>> +      The LPM pin is used to idicate to an external power supply or device to enter
>> +      or exit a special powering state.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> This sounds like you're some kind of power-domain provider. Why doesn't
> that generic kind of thing work for you?

This is used by the MPUs shutdown controller to toggle external things
that need to be disabled.

In the case of the SAMA7G5EK board it is used to disable the 24MHz
oscillator and the 25MHz oscillator for the GMAC1 phy.

From my understanding this is not a power-domain provider it is just
used to toggle devices to disable when the MPU is in a low power state
and to re-enable when the MPU is in a normal power state.

Ryan
> 
>> +
>>  patternProperties:
>>    "^input@[0-15]$":
>>      description:
>> @@ -96,6 +103,18 @@ allOf:
>>        properties:
>>          atmel,wakeup-rtt-timer: false
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - atmel,sama5d2-shdwc
>> +              - microchip,sam9x60-shdwc
>> +              - microchip,sam9x7-shdwc
>> +    then:
>> +      properties:
>> +        microchip,lpm-connection: false
>> +
>>  additionalProperties: false
>>  
>>  examples:
>> -- 
>> 2.43.0
>>

