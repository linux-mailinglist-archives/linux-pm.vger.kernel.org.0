Return-Path: <linux-pm+bounces-39220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEBCA568E
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 22:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CB733032FE7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04835772F;
	Thu,  4 Dec 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djqu+2Vm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E93128C2
	for <linux-pm@vger.kernel.org>; Thu,  4 Dec 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882403; cv=none; b=KTZQKQYzrSe+Bsn/alk51PFhOMjtshw5zGXsQV3xBHykikq7U7tN49afXLNOEAAalqkkobxFlC0/W2iSkMdMZ0bnXB9wve2Bf0vw3cGkY1jKQBjBHEpvPRpDRmdJfmc9PPwlYzYLMdbIWr8KMQW6UP14hEn6sUWGE5f1Wh+8VVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882403; c=relaxed/simple;
	bh=4gvVbQE7D0PuHRtcnXsG0f97rNAS/tXWI1ikykCyHu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txp6WMdlybsrFz9rXB76/PLuQ0ekW2TLMZ5iBP54LP5ZOsEGU7HowCosXiw3G2aEfppqV2y54nX87aRFn0ixGMxXdCh7Jnfhk5eBCI4iUKCrKrbCDl36fFCbvHipMi5dnAO2/s/MurKNrYaoPz/zxjy2m+yVhr3SdrA0+nn0ST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djqu+2Vm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1302444b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764882402; x=1765487202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEywpXmQqNwB/TS6CB+654YlLSBuSDJ8XZY6ihxAXlI=;
        b=djqu+2VmnFSX1eNkLgMcZSC76MyQqZJwykltkAiEH9TEDyBHxUj+wsPz+0imNjTNFh
         tArfYbDVmjQ0qhybhEQ/SvjVa0g/j+CO2nIOiMU+FM2a/a/51FRvgonQvVNoKxI2XB5b
         mjnfZeXwZLpra7NH/B9wtV2kPmMPVPvnhL6+bXNHGYUxGtsphW+Y6soTDEd13ESvp3+D
         ewgdb0+iGv5wQZwyWbRHD5Ninq8frMBqqGE8xM6Jki7K2SouOq5nTrzMTMYZJZUI7lh9
         56yvp1OJbSw6olQLmwzqwax6W94vovgJUIXIO3amNxs/L0VjFypqsbQy/FgLh5WRTHCT
         rjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882402; x=1765487202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEywpXmQqNwB/TS6CB+654YlLSBuSDJ8XZY6ihxAXlI=;
        b=qh7pT5Lkh8liDHuUf3i3CZGNzD62HklradtsIiySuGdyEGAkB9mDq+VAUf2h97F6DP
         fynM52h4KHalmEKTwIKPLs5LXOKPdj+U1uVbwhS8ENWvByiY7yakm6t06Xfkw30SuuHl
         p8lyG76Qq2a+0FoTwr+Tl5d+l5EB6fcxsXePDtJ3avzziWqibqjG3JAfSgHINcaemNS8
         DVd3FpFdzIID2jtMUYr9mDuk0kRCqWvnbj2IqQIWgeb6Kv8U7ST5ZK7aiG8GoplCgxu4
         KsSgP9E+/J7JoehhB3tEFNTrdTQxMXzC06M553NqgAT7znK4tnpZygsSmc7QoAg3cKAF
         PXVA==
X-Forwarded-Encrypted: i=1; AJvYcCV6g2R+G3pHtLNtzE7D0AG3klaBBhGEHjfojJIdtOi3UILVbJVn6RJh0hZTo2nmPi7GTKe/fIj9qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVEka+xtyHnrObEWMo3ngdp0Ik6LmV+PSYGwvN1n3QFbPKJUC
	UbHrxi8LabcVIJ+qlUD2D06hKsQrs+om5OxblSXReOIpfnS7ELHE7C3nONmQJi1CRw==
X-Gm-Gg: ASbGncuK0R8aQI8ioAUAqpRrar91aiOqqkrkO5/RQMt1X3YMZ4sPl26KWK02NOoM8Q3
	pQ3gLeaeEPAr4mcq1+SBeEutlRxDDbuic1ealAnYDaOTESQ82LliA4reTvroyDx+jlM9WKeWoo/
	og6RsifyXXt79w430jWpK199+Jf9oSprmrW0W22hwmm5b1rL1Pu4w6YEDSKhp60aOERb0ZKDQBF
	b4SLWmCaSsr6VWyuoEk6ugn2RUESBs30Nu773zkrsgOpWJxtr2OnuF/4SFEyrgXVQYaBOHU1qfR
	nHemQKOJ6f3Y/kXIE6FH26YXtsReZlsEu3vEDB6M+bEm1J78QXLK4jfEOh+TDshPacDVz18IN7E
	nMhGniiglYuw22pBEoXeUxEbSyngTeWyFfLAM53ms0/8qjW5KIjk6feGhdfcoeUaOzTRCF5saZd
	WwQYJesoiOtWsnosvrOC0kKNQr2/t1bfgO/2XEnNkgWOEbe1vIS1b/Y3PrEwA9LEJq5BueIDlLV
	I04Ehe3uiEGmw==
X-Google-Smtp-Source: AGHT+IHnjdg9J5Dv3DjKTAgPlUY1x6NH1Rmw5oo9i+e3bENd1vNzyqMp5aLbF57/RFRsp96OPvtSGQ==
X-Received: by 2002:a05:6a20:12ca:b0:347:9ae1:cffb with SMTP id adf61e73a8af0-363f5db7158mr9697293637.24.1764882401346;
        Thu, 04 Dec 2025 13:06:41 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:d11d:bcc2:2743:bf88? ([2a00:79e0:2e7c:8:d11d:bcc2:2743:bf88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf817c3e6c3sm1857768a12.17.2025.12.04.13.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 13:06:40 -0800 (PST)
Message-ID: <19e501f4-da1b-4a91-8681-da78922bc302@google.com>
Date: Thu, 4 Dec 2025 13:06:39 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759
 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
 <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
 <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>
 <20251125-amorphous-bobcat-of-whirlwind-afdab1@kuoka>
 <7ad91325-e881-461d-b39e-6ff15d98b3c5@google.com>
 <076777c3-b238-4d1d-a11b-602027348ee4@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <076777c3-b238-4d1d-a11b-602027348ee4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/2/25 5:00 AM, Krzysztof Kozlowski wrote:
> On 26/11/2025 00:48, Amit Sunil Dhamne wrote:
>> On 11/25/25 1:56 AM, Krzysztof Kozlowski wrote:
>>> On Sun, Nov 23, 2025 at 06:34:05PM -0800, Amit Sunil Dhamne wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 11/23/25 1:28 AM, Krzysztof Kozlowski wrote:
>>>>> On 23/11/2025 09:35, Amit Sunil Dhamne via B4 Relay wrote:
>>>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>>>>>>
>>>>>> Add bindings for Maxim max77759 charger device.
>>>>>>
>>>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>>>> ---
>>>>>>    .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
>>>>>>    1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..71f866419774
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
>>>>>> @@ -0,0 +1,36 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Maxim Integrated MAX77759 Battery charger
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Amit Sunil Dhamne <amitsd@google.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  This module is part of the MAX77759 PMIC. For additional information, see
>>>>>> +  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
>>>>>> +
>>>>>> +  The Maxim MAX77759 is a dual input switch mode battery charger for portable
>>>>>> +  applications. It supports wired and wireless charging and can operate in buck
>>>>>> +  and boost mode.
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: power-supply.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: maxim,max77759-charger
>>>>>> +
>>>>> This should be just folded into parent node, no need for separate
>>>>> charger device or is just incomplete.
>>>> Thanks for the review! You are right, the binding is incomplete. This
>>>> charger block actually listens on its own I2C address, distinct from the
>>>> main PMIC.
>>>>
>>>> I will update v2 to include the reg property. I will also add the
>>> AFAIK, the main (parent) device schema does not reference children via
>>> any sort of addressing, so reg here would not be suitable.
>> I agree that currently nvmem and gpio devices (which are children of
>> PMIC device) are not referenced using any address. But I was guessing
>> that's because they share the i2c client id with the PMIC and sharing
>> its address space (implied).
>>
>> The charger device while being part of the MAX77759 PMIC package has
>> it's own i2c client id and address space that's why I proposed "reg".
>> The underlying assumption I made was separate client id implies that a
>> "reg" property required. But maybe that's incorrect.
>>
>> I can understand the argument against having a "reg" property. As the
>> i2c client id will remain same for a max77759 charger device (as it's a
>> chip property and not a board property) it will always remain a
>> constant. I will drop the "reg" proposal.
>>
>>
>>>> standard properties `constant-charge-current-max-microamp` and
>>>> `constant-charge-voltage-max-microvolt` to configure the hardware
>>>> limits, as this charger device does not manage the battery profile
>>>> directly (that is handled by a separate fuel gauge).
>>> Well, still, what's the benefit for the bindings to have it as a
>>> separate child? Kind of depends on your example, which is quite small -
>>> one regulator and supply. Grow the example with battery and other
>>> independent resources (if they are) to justify it. Or show arguments why
>>> this is re-usable.
>> The primary reasons for keeping the charger as a distinct child node are
>> to model the hardware topology for the power supply subsystem and to
> You do not need children for that at all.

Actually what you said makes sense. I will fold the charger's schema 
into mfd/maxim,max77759's schema.


Thanks,

Amit

>> house the OTG regulator provided by the charger block.
>> The charger needs to be referenced by the Fuel Gauge (which handles the
>> battery profile) via power-supplies. Additionally, the charger block
>> provides a regulator for USB OTG VBUS, which is cleaner to represent as
>> a child node of the charger rather than mixing it into the top-level
>> PMIC node.
> Sorry but argument that you need a child device to be able to construct
> a phandle is just wrong. You can create phandles on every other way as well.
>
>
> Best regards,
> Krzysztof

