Return-Path: <linux-pm+bounces-24079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A1BA6237E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 01:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F25420AA4
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9ACA52;
	Sat, 15 Mar 2025 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00AEhJey"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622E10F1
	for <linux-pm@vger.kernel.org>; Sat, 15 Mar 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742000202; cv=none; b=Kv4GPvi6rD9MzRsNPOP9TdLmdtVyVJUrU9hXIp8ES9uKcI3uNLSZTbFQRuQ8C6MHGrJUn/0F3NY1Svoz+Z37vb2jY5ziqRWW2F7kRwvGHWBPfOms5l5ScX7XUTNO5B2nbm/9dFe1/lFYu8kXCeKPiwu75doqlcCHa48PRYa0nqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742000202; c=relaxed/simple;
	bh=dFv//A/N53hUD/dKk0EKx9Sd5ho6SwDR5GWOeJGznwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaftdHRZ4UptqsG/dmShXKxfF363FbR36f3GW/IeQJS9vfIX2swyfxGJEZ6FnFm5Nfuxt2KZqXiesKTtK5uVCAXHTbohge9Al0XWQkgqJe20twMsJsDhOxpYK03th7MAqXcFPujXHNy65MXcrxK+bf5LSj0KgWqqbjorDkvU0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00AEhJey; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so69058835ad.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742000200; x=1742605000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlPzh6p1/5lGDsISw1+G4tFXT2WVaPLY/RSip+CLZfo=;
        b=00AEhJeyHoC7TUYh0Es8UhYq8q/4iGYgJSXNWRgqPBTcNiAKtibh5POQA35s/4Xqcj
         NKe703McvRb69PzQbFBJhfsu7LkfGBI7ibXbBtfb1QN4k05wz6SqNMyklkqRD8Wsn/il
         CGrJdnAVXBE1OvBSzC6GkLSl4KB0RKaTs60+p8eCXpFKkM9+g78pMf73aCxnkaJ4VEAO
         knpqzaw3NMNcdbAEIQr7wmRPqptGaSn9ZJfpTIOBORK/euDt7SBp+OQpuXLxr6hDTmiz
         A3oTZT/y5R6WlEgq7krBNkIeGVLMOy9PzQjbfTsQRUxI0X6lmflPO1VqPKzherZpjJpq
         CY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742000200; x=1742605000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlPzh6p1/5lGDsISw1+G4tFXT2WVaPLY/RSip+CLZfo=;
        b=N1X6V0kb9G/v7swNDt7Jzn+7gc3ncex3OgN+XUIf6jk821ahFHPYDsDXfyAn+9ndfF
         dQ0Q4cyEJ2QAVDpET2ptQuVCX5RSj7q0RXQz2peCe0kLQOadPT2W3X0mCmEOp2OuFthq
         d8qVLtaV2RCTwKlgLg92+Y2ZcAChYIhHvOAELv9TKbpQceveoYy/tDk34NveYSYNSa5f
         VjQkzGNUAAclvFTYq2nBLzsn/DCDnYMZhUJdCEVoSS3lQAiz1xp/0/X/NFW7tShZz6Al
         KRvRrpicUzUrgpQZecOBkfe/xRXY/1fkkTWxKjGfxvCO04EvrVLFsIXzTNemsDiGEBB7
         ZKgg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+8mV9mn/eBEDU7cqUGLxaFAXPBYvLYti+DJ4oQTvSDEB6+wRCQUPIxcUFuqeIbOHwKMdAStuvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ysygO9VwlCz6dvM7OTPuUea/Cqg5bhs96AYGi6qQcz/vjWUx
	Nr/DdwODJUOhVzPQSG4ahXbIUrJOLRhnYjnDJh0au5LPMWnxvurJAIwzheMofQ==
X-Gm-Gg: ASbGncuXMcJV6QhIUCRoagU3XP1GE5+Qg+o64S6TSfJDWDQza12LB30HGX81HhmYmis
	ytuhwGyUsoCz2Ds1KaMxj2Og54He89fnEi/eXAq6Q3s36GLigoFC8DxrEntfB7QT3ECoBjOgjdz
	lapTncQXUAz3bqOCCT2oP58//hT52IN/bQSVOZ9TFUQrUFX8u7T5llZqYZzUP+AIY3Glq5pOOiF
	A5cZGiH9Fxi837ncAQAglFFuLSf8RwriMz++YOm4wOE71u3nT4CiJRsYIVsPJWaN0uHY2ampxQr
	kqox3NTEYaUc6d6z1CBDwPH8pctfR4bwsQrj4aiZBCVa8sXQY97im95ojl4eJGmad5BnwezwWiE
	AcGqGIXar+k1RevLBF9SqHqsGXh3MsdaCSLkvad1vnho=
X-Google-Smtp-Source: AGHT+IGLAZyr9y6XFIkao+qhVXq299qSBu0NyjP0SxDe+I/hBmyjWfLdod7q25DFZQQHCPjxfpF0Vg==
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr50486775ad.31.1742000199456;
        Fri, 14 Mar 2025 17:56:39 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:1790:6e62:92ba:cb2b? ([2a00:79e0:2e14:7:1790:6e62:92ba:cb2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883d0sm34730585ad.10.2025.03.14.17.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 17:56:39 -0700 (PDT)
Message-ID: <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
Date: Fri, 14 Mar 2025 17:56:37 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>
 <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 3/13/25 1:48 AM, Krzysztof Kozlowski wrote:
> On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
>> Add a new "fixed-batteries" DT property to connector class. This
>> property is populated with nodes associated with battery type power
>> supplies powering the USB PD connector. This is needed by the Type-C
>> Port Manager (TCPM) to query psy properties which are used to feed
> What is "psy" in terms of bindings?
In terms of bindings this should be a phandle to a device that 
owns/manages the battery (whose driver will eventually call 
devm_power_supply_register to register the battery). This could be a 
fuel-guage ("sprd,sc2731-fgu", say), charger ("ti,bq24190") or a 
platform device ("cw2015") containing "monitored-battery" property to 
manage the simple battery.
>> Battery_Status & Battery_Capacity AMS.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>>   Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -300,6 +300,14 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint8-array
>>       maxItems: 4
>>   
>> +  fixed-batteries:
>> +    description: Contains references to nodes associated with battery type power
>> +      supplies powering the USB PD device. These batteries are fixed type and
> What is a "battery type power supply"? If you just link here batteries,
> then we have type for it - monitored-battery - but I doubt connector has
> direct connection to the battery.
Regarding "nodes associated with battery type power supplies", I meant 
something like a fuel guage or a charger OR platform device with 
"monitored-battery" that will manage the battery lifecycle. If I use 
monitored-battery for this, I will be restricted to only querying 1 
simple battery. Also, I don't mean PD connector device to be a fuel 
guage or charger that manages a specific battery. It should just be able 
to query any FG/Chg for the battery status to relay that info to the 
connector's port partner.

The intent of the patchset & this change is for the USB Type C protocol 
manager module (that consumes these bindings) to be able to get info 
(such as State of charge, design capacity, etc) from drivers that manage 
the battery/batteries in the system. In order for such info to propagate 
I need to hook up the references of these battery manager devices (fuel 
guages, etc.) to connector.

I have addressed the connector <-> battery question in the cover letter.


> If you mean chargers, the OF graph is already there for this and no need
> for this patch.

No I don't mean just chargers in this case. Also, I didn't follow you on 
the OF graph. Please can you explain further?


>
>> +      not hot swappable.
>> +    minItems: 1
>> +    maxItems: 4
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>>   dependencies:
>>     sink-vdos-v1: [ sink-vdos ]
>>     sink-vdos: [ sink-vdos-v1 ]
>> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> index 3de4dc40b79192b60443421b557bd2fb18683bf7..66c99f0131f074f1c08e31d7481f555647e3b2f8 100644
>> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> @@ -75,6 +75,7 @@ examples:
>>                                          PDO_FIXED(9000, 2000, 0)>;
>>                   sink-bc12-completion-time-ms = <500>;
>>                   pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
>> +                fixed-batteries = <&batt1 &batt2>;
> Two phandles, so two <>.

Ack. Will fix it in the next revision.

Thanks,

Amit

> Best regards,
> Krzysztof
>

