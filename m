Return-Path: <linux-pm+bounces-38750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2056C8BEA6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7944E121D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B333FE35;
	Wed, 26 Nov 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGbDdCz7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C53195FC
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764190223; cv=none; b=syNQ1WMIbYpz4Ee2iAAOHMSOqvE8a9NNCd+hjMjGvPV01telK8beKdrpwzgYij7A2YbO+5vHK7pk6/497LZqOgSLGKQiJN5jDOeuSkv/w0NgCzPBdjCv+ZJ9HVI6Tk6Ctf+N5l76mLNdG+r84dlqLoCXgxFNjt6valJ8AQLGpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764190223; c=relaxed/simple;
	bh=2hcVpa9scm0PygAHV2yhPwb8b1VqKc8achD9dLmNggM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EczXdHq0Rlkbc76CF8QOBzt7BDTsb9YfOBw95RIMie2PjlMKoJ/Dc1gx2RK8iDeZAcqUbYtmeCFAwLbVDGOFK/Fs92dKKH6fjKAaEDIqNsN+VeY1S5q1AobNinIID7eR5q7OVJYcakQuOa98f2y8rn1AREudiZQFn+8TnEJlO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGbDdCz7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso2899295ad.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764190221; x=1764795021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAe7krNX/FWdcfazYkx0OEalo6w7fciX1p3CljsQHjE=;
        b=HGbDdCz7fMh9auA5giOKC+up0GbVoGyfdlmnW3fyA3Gxeb/N0VXaJ7h8z9oxYb4vjA
         g+p+ZRULTy1pYN7EVv5B4HrwMHmGfgjly+28BhEPlXXtD/KWdwSqMfXw9NDqftFHdE/T
         CXq15IsJHKr6bJHsZs8IrqaLSSTkzKPU2I82uX6u58ZouSHjfKSYxKn/4eti0kglBfqH
         6FT1XKbMuy2JP+yi2OjHZQnX1+RHfCIkvrp4b5z+VaJHg6EoexoTIpw0JsUIvp4E42Qi
         xpVhXmwS0s1ou8X0njK31DhtPHOxTRa4nDS1mJWmErhGiynAQh7U5JJC+nlAPID9A7qR
         FYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764190221; x=1764795021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAe7krNX/FWdcfazYkx0OEalo6w7fciX1p3CljsQHjE=;
        b=Tj+yguFdeyOtnVzI9m/WkWDkSjEMEuHBzS0M+LNX8HCaNJbJ5YaTn2904yEX8YBLcz
         Yt9q9ySEJiAYT3yBUdHYCpOP1gaNUc62RrKCOn4Buv9Pybcor5TfPkW3ktJHb92OAmyl
         yljgIQ3SXv4tVNm/BJgK+YrddzaZc/lmJKQJy/9xdpZz9lr2RH1UScHkcGFDge5ONeeJ
         uD20b7VfqO5F5/qaK+ghZKdAAsAGbWppa72JLqKv3c0BL/fW8QAcdIFYjtDgKm+HhioD
         7VghPSf0u/8BOSDOQqMjVMd7MvT+1+y7e6ek3OCIdlwV8XpP66+2JktrBS0p1Yb5vn6I
         F8wg==
X-Forwarded-Encrypted: i=1; AJvYcCXC3NEsC25+DyQhGI+mB9/BerzmVQTKnDKrLytZoyB1YOnQ6QURsJi/1oxEVjX3DPkaDeeI54Eg+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbOGWtmlxw2AGCVObWFftwl1YBDeaqEgSLn9qlKPhFoSfavOh
	U97fstyAbHbxFMyxt5P163yy1L9vz8GxwdpdO/ZrZwDPa2m9zyV3bx/tEku/TQONyw==
X-Gm-Gg: ASbGnctXsB4NuxHnIMUf32EJej5torIHhzcKbYawZ8oEjlseBIUS8jWQ0Eo+w9yCUVA
	3qaGowfgJQWNKIPvN6/6wnsTniERP7KTr6qK3hAyNo/UvUQOMlbraTKAMsJdyuc2OaVX5i7rdIi
	tqwLS1HROPM+rBooAUA8l34uhG4nDeTOwXNKIrhcq8oNe9Sozg3KZ+ovqk51DHFVPxfmCZ7DrCU
	c4pCH8jA+jAcpngFVtLx8YWwAKwi/0dy4CRKlwdrB05VsOQr5gDmtbcmm01aAsjJJvCiqkB4GMH
	7Td4xqKSp8BUoQps53/wNLtUdhnr6BCjXx/wtKmrTJDA/FXvnhgzfR0/9ZmnPxD6jCBZvix9cxl
	jDO5OJHqGv6EE0G8WKzp7kH6ZhShlCoHMhFC+754byzQq0auXxLNeqh+tRkqbsB8Ka78r0Yf/l5
	c3+6z/5tMpGJeVN0v8m++mHgF1cS3zyzQABjXcDNXsjRNCaCLHEDnUC70ddmN4WrCr3MkQ/qMMT
	BSZv3o2IchkOl8m4SEgHUt5
X-Google-Smtp-Source: AGHT+IFjQZz19LkV6uSbQD7V0osJzTvl1J8TedsGIZ78YPP9aLGTQiFmGEhYv2+QMQ+JGAYgRK90Dg==
X-Received: by 2002:a17:902:d4ce:b0:295:596f:8507 with SMTP id d9443c01a7336-29baac9f621mr97893625ad.0.1764190220828;
        Wed, 26 Nov 2025 12:50:20 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c116:b1c9:632d:a902? ([2a00:79e0:2e7c:8:c116:b1c9:632d:a902])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b12f988sm203367425ad.27.2025.11.26.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 12:50:20 -0800 (PST)
Message-ID: <3c72e1f3-7873-4f13-a5cd-0aecc5163aab@google.com>
Date: Wed, 26 Nov 2025 12:50:19 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply property
 for VBUS in OTG mode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>
 <aSbP5OanDUGhEXXV@kuha>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <aSbP5OanDUGhEXXV@kuha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 11/26/25 2:01 AM, Heikki Krogerus wrote:
> Sun, Nov 23, 2025 at 08:35:50AM +0000, Amit Sunil Dhamne via B4 Relay kirjoitti:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add a regulator supply property for VBUS when usb is in OTG mode.
> What is "OTG mode"?
>
> OTG is usually used to refer to the USB in device role, even though the
> specification actually defines OTG device as a device capable of both
> host and device roles. So the term was confusing already before.
> Nevertheless, the emphasis is always on data-role, _not_ power-role.

Thanks for the insight!


>
> Here it seems MAX33359 uses the term OTG as a synonym for "source", so
> power-role?

Essentially. The datasheet refers to the mode where VBUS is sourced as 
OTG mode.


> Please don't use the term OTG unless you really have to - it's too
> confusing. I know the MAX33359 datasheet uses it, but what you really
> do here is regulate VBUS. So please:
>
>          s/otg-vbus/vbus/

I will drop OTG term at least in the USB world and restrict it to the 
charger driver.


BR,

Amit

>
> thanks,
>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>> ---
>>   Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> index 3de4dc40b791..a529f18c4918 100644
>> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> @@ -32,6 +32,9 @@ properties:
>>       description:
>>         Properties for usb c connector.
>>   
>> +  otg-vbus-supply:
>> +    description: Regulator to control OTG VBUS supply.
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -53,6 +56,7 @@ examples:
>>               reg = <0x25>;
>>               interrupt-parent = <&gpa8>;
>>               interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>> +            otg-vbus-supply = <&otg_vbus_reg>;
>>   
>>               connector {
>>                   compatible = "usb-c-connector";
>>
>> -- 
>> 2.52.0.rc2.455.g230fcf2819-goog
>>

