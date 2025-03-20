Return-Path: <linux-pm+bounces-24344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E66CA6AEDD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 20:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220F93BE437
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B45228CB8;
	Thu, 20 Mar 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+qHwmxS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F231EE01A
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500156; cv=none; b=EW1M09Km2SdDJ4p4z1y3KQ7uTfp90vFN9Ztanh7SaZHCgXiZSzpbF4MkZWUSd07hc6iiD+Qb5u24JCkmdPAqIgRocsLj+VGaDAZSSn14+rjOxty6cHkmew4iOVwJi2vKZf4LDpHkfJBB8D79FT/JYMt5mkqXBtUyv24pMq5Kr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500156; c=relaxed/simple;
	bh=KFQpkAFiRwi5JvgaGkgUS3XMJL1ly4AUO7zYJrorCgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir2/hUyt2v3XYURBCjV3G00x4HbqEoKw1XrqRbdQHsq+SwXH3QojcveswZd0yJVaxEqrO9mNRRUQ7EzPcev2EjkSlSCuFU06nNTWTTSrmpkNFCC12PoDGaYnHoyNRHpygUWOtdU7MZ4KKwC/PCFcOL+o7tM8A5aPvz/zxOQSa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+qHwmxS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-226185948ffso24790945ad.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500154; x=1743104954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMRUp5Qyehm/UHkEF8vmSOmZ085ovglSkPUzMHQiUvE=;
        b=V+qHwmxSsRylMh683u3emKvxWHIoiCfzb0J94EAEEx6slNleLpoQOa0wGz8bnfQFiW
         533g0RUXQ+d02JJehu12OU3dPX5/BzcU0gOovi75YSPHGhuxRTbu0NEsR85EYRWYi6Gb
         s1tc4FRq32rncn5rnYyrIbij2DWdtAnqUIPixMhf7LkaViRD2+33exE2AbA6Xi8/6Rvp
         KAJvDrFVwEq/hfHb8FWHz1mwmwfPWLqejW86PsHBkCuR7sGB+0S40tJxX0FGILYhXCCQ
         BnQe+Opx0+bD3g3ip6zx8UsPdSc5L7/+mHDGVzk+z+H8m/EyGZISyB0kYOlWFGBCrHLO
         UT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500154; x=1743104954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMRUp5Qyehm/UHkEF8vmSOmZ085ovglSkPUzMHQiUvE=;
        b=HUnjUiCd7QfWsjYG+uLrILTY+P3XkXNHkI0n/Uc6YqNmYv+lyJHgs38NpVOeeJ0Ljf
         CF/iCKceU6deXq/4RjNexxoQJT/DEs2KnMkATYB4cy8HUNn5IeOJlACE0yJ4TGFmK+oB
         xeYjv+2HRtNJdFihWWfgZmaHBh6P7kilqRk36Ki8KSNQDA0RaNx0NfbfWfj7a6EE42oQ
         8HcvVTfGe8SkZnGkx4QUl7Co/761Rr3AKwIXKZMghG31KaRQVGRw7bSURYgCvAYa0HFD
         6kPFC7IuGyAm8PjmzhREVnm5xi3A0tsoXl10oK02b5622QlJqUkhggHCdp916v0pwW6C
         vKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXig+X3O53A6tbyxQueAa/dV8E04zgJs8PEUeGBsu2exymSGICRPmj1/YHSR2j0fgmKplZSUmqGqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlyBJDmH09iCYIFgoEpOnBRNf99praOXzb3qUgFguFtz6wyBCx
	1n3/OkNw+p4e6r4T0LQUCPiq8Kt5oLAHiuh4Y7FNy/ai7FPC4doOGSlCFITEwA==
X-Gm-Gg: ASbGnct6xwY0WRiYsC2JK8rx/vu5jA8yfxtThWq/U5CRZHUNLZGorzDIrXxabL+PIda
	mfqvo3Z/fM8qp18i+YaePlEDmOJv4LijpkuHujuShfMOhdaFzUd+0/GUe3HZuwcR1gageojqp0f
	kaw2l3PRIueXrXVr85TGd+2iUno7hJhLR/VsNp9qEPBaqGVLYpV7/1NUFNYPEFnwkH1ofp+Hcdx
	3g+77mRZIL4AxXRuaZTgmXd+XbCwLQkFXPh66cqpL48s3m1CmmhkHkNjvn4Xaz2m2pwPrADsHZ1
	QWImBNWZkWxxP3TcFNFKLy45NBLRXYZacSqJ6xBZdlgJrtPhKd5L6Io6+ljImHSBZftXdNpW1zk
	AAUS2O62DIsRP94tQwtw9ejwDEL8h+iIgsPPc9q9yyY8=
X-Google-Smtp-Source: AGHT+IHyrk2bDjkLhMnhglpF2WvxGIuU+CuD3iaUBnBbz39xc/6Rxc5vq7lRwV1BiFP3IbQR23VrGQ==
X-Received: by 2002:a05:6a00:4b12:b0:736:755b:8317 with SMTP id d2e1a72fcca58-73905a501e4mr1105162b3a.21.1742500153484;
        Thu, 20 Mar 2025 12:49:13 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:c50a:4138:6122:653a? ([2a00:79e0:2e14:7:c50a:4138:6122:653a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d1dasm210916b3a.106.2025.03.20.12.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:49:12 -0700 (PDT)
Message-ID: <747d9492-b3be-46b0-9e26-5ba45f2e6662@google.com>
Date: Thu, 20 Mar 2025 12:49:11 -0700
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
 <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
 <3a33dab7-87b2-4b74-b138-e368d4cbc358@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <3a33dab7-87b2-4b74-b138-e368d4cbc358@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 3/16/25 9:49 AM, Krzysztof Kozlowski wrote:
> On 15/03/2025 01:56, Amit Sunil Dhamne wrote:
>> Hi Krzysztof,
>>
>> On 3/13/25 1:48 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
>>>> Add a new "fixed-batteries" DT property to connector class. This
>>>> property is populated with nodes associated with battery type power
>>>> supplies powering the USB PD connector. This is needed by the Type-C
>>>> Port Manager (TCPM) to query psy properties which are used to feed
>>> What is "psy" in terms of bindings?
>> In terms of bindings this should be a phandle to a device that
>> owns/manages the battery (whose driver will eventually call
>> devm_power_supply_register to register the battery). This could be a
> So a charger? Please rephrain from putting Linux names into the bindings
> description.
Noted, thanks!
>> fuel-guage ("sprd,sc2731-fgu", say), charger ("ti,bq24190") or a
>> platform device ("cw2015") containing "monitored-battery" property to
>> manage the simple battery.
>
>>>> Battery_Status & Battery_Capacity AMS.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>>>>    Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> @@ -300,6 +300,14 @@ properties:
>>>>        $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>        maxItems: 4
>>>>    
>>>> +  fixed-batteries:
>>>> +    description: Contains references to nodes associated with battery type power
>>>> +      supplies powering the USB PD device. These batteries are fixed type and
>>> What is a "battery type power supply"? If you just link here batteries,
>>> then we have type for it - monitored-battery - but I doubt connector has
>>> direct connection to the battery.
>> Regarding "nodes associated with battery type power supplies", I meant
>> something like a fuel guage or a charger OR platform device with
>> "monitored-battery" that will manage the battery lifecycle. If I use
>> monitored-battery for this, I will be restricted to only querying 1
>> simple battery. Also, I don't mean PD connector device to be a fuel
>> guage or charger that manages a specific battery. It should just be able
>> to query any FG/Chg for the battery status to relay that info to the
>> connector's port partner.
>>
>> The intent of the patchset & this change is for the USB Type C protocol
>> manager module (that consumes these bindings) to be able to get info
> The intent should be rather to accurately describe hardware and maybe
> that's the problem - you focus how to bend it for your drivers.

Acknowledged!

Thanks,

Amit

>
>
> Best regards,
> Krzysztof

