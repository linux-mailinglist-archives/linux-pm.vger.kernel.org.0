Return-Path: <linux-pm+bounces-38654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24068C86F93
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 21:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6B4EB133
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C833B6C8;
	Tue, 25 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxKW3oOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B133A70E
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101617; cv=none; b=luoHXvJRfz2kMQFv3iVoH2laL12MWgTwF6jrola1yQQEM6Y376zm/pvaQkYSFRA43oIl27IYTmwCu1lIIg626/c1h9vXxwEQwLArxWo/4yzOfsIlpk6d2GOVIfjgZPD6OxTRrpU8GclxW7a40rtGcSPMR9IwZyup0eAvMGuCBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101617; c=relaxed/simple;
	bh=89CYleDV3lSw4EhOz1KbzHaBTT/MlUH9EZ2vYE5n4hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvQZuT0tuJFwnhSttiVVpfOXFO1bTSMdffZM3sMJjdQmOetEZ6iVLAWA1jkcwvbZPRIUu/wm7DOr7QaIZqVVW7cWHn7pwbVp2ZaczRpvO9toOoaqcxx0UD6ac61X1iPKGg26DHZDvLXE6DOWLqVyPrW/JN8Yk5pnP0gIapdJCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxKW3oOW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29555415c5fso65988795ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764101615; x=1764706415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfK2UtCRp3qKogO3H5nzh+puMsdKQP2QnVSL7A2UN44=;
        b=VxKW3oOWAtVSdaZiFCUPsvxPV7erJbX7v+fhDsUrRrkFeUlUUUqALw8IjCrvuoiFw2
         NZ+bBuUFYdMmzOkd8r/pWCX1vYRtn9fMxUXdP66SO1VgUPfHLRaT71ns2IdVyieXKOj5
         hziaOPm8Unjb1ROGgGAfOaBz56eEgJH9qzlSckTi40gPgwP7VN6b/I1p//rc5OTzQWda
         Aos6CIaFox/B2wtHLzctvY6LMXwFt9OSTybQvkHbyte1c1s7ExKqYWNRlwc0hPSRWCsZ
         duPsh4RWMZePK1ENh5P7vGItv5xO6IcVkAPfTI/8QztARVKiUyvyED/s66Wjy40xbcz7
         lXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101615; x=1764706415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfK2UtCRp3qKogO3H5nzh+puMsdKQP2QnVSL7A2UN44=;
        b=Dsf10bWjt4QWec98Bu5ytxF2zjbLQWliMCrJQJlRUJbcG7JaRoY69FZX1GMWnyHUT/
         oIIEa33k42Sx/p5V/V7CFTYwt6+ri0956EKpI9hpZcWnXgAhGJCSJbXtgUtTKpTLb3fj
         gqBlDA/2oaTixYI2bK/3AS5hAz6hBEIKSOlugSNuZoEpdYzgw+Eg0IyBjeUBEQVNP9QT
         pXiXCFlxb67c1xxY/HRIYoZ23yr6tvSH/7raPaTESK8W14V2AtA+yrAYctamlo28cQrD
         I7DLizoB/9I69sZ/+P02KeNzZTrdgAMZVYv91u2eyWyTQExVYsbFusz8rPsnJYHiaeTY
         gBrg==
X-Forwarded-Encrypted: i=1; AJvYcCWeR+Tfrm1G2jM0NOk5AT3xgchSyAeU5X2Un2yzduvhDfnbfy1f9FBRA/gs0jlOdFZeV/UkuY/mZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvXkAHdPqI2vk7zZN/dvhzoEA2ejw8JY6+RujYKCGCL47JgP+
	rUsMjdJZJCrkp09VpNrLRKpV/oaBMVUFdkKnukZPl5WmzCgPU8zdH362fDciPPwBgw==
X-Gm-Gg: ASbGnctPtua7pS8CMaNGgjEDdguwRG64FYlR4sNvisUxwIzK/flvqptqClFHxFDq6Cm
	gxFBeUZMSONgBsMlNzDC89BfITd8POmThes9mnxirvcooXKcO+TM8Pp18luVhzfvEb5RAC8TZB/
	Gx95yW6GhGTg8EH/bqEzz8n8/gN2FYRUCfkNuNHTUvaZBdrDAMP2hJtbWAqFuiT9JxWAVQ5j8KR
	XsT0GpCxkaHHEwPBNgqiS1gJkVYCHjvYGrK4Gyg9OlPtp/jTFd7MFwKNQkj/GmojWMNxoXtQ9pG
	RAFQr7lO0C6D6QTn43oAIRKh9vPM/JfKZL4/mQ4Y9Ux+sJ0+DhWCnyh9XW05j1Sveuz7fk0cBeS
	DEjO17RgkeRX0XdE/Yq/7yWLahdxCwF2IfGuZ85ad+kkghaJ8UkTpNCOzzHPvweJDLjmwNP9TT+
	ig0Ey84BMLab1uWSUkFAwLiTmgStguDaE4CS/iGi+sGHGwS0yMC5myVuAUDs6zWf+DCxZws+SYU
	zwAjGsZRcZNkQ==
X-Google-Smtp-Source: AGHT+IG9kG01ZIUmMJzmeQwMlH61r7mcmKmX15F17Yg0ycZqophUcVw0eG5SWVAXcyDMCqwBRpETuA==
X-Received: by 2002:a17:902:e545:b0:295:8c80:fb94 with SMTP id d9443c01a7336-29b6c6f1516mr170593005ad.59.1764101615123;
        Tue, 25 Nov 2025 12:13:35 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:744c:4262:57e5:31a7? ([2a00:79e0:2e7c:8:744c:4262:57e5:31a7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075c6sm175965955ad.17.2025.11.25.12.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 12:13:34 -0800 (PST)
Message-ID: <adc2d6ec-e666-4dd0-aaad-7ef014efafb6@google.com>
Date: Tue, 25 Nov 2025 12:13:32 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply property
 for VBUS in OTG mode
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
 <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>
 <20251124-rook-of-exotic-innovation-fedcc5@kuoka>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20251124-rook-of-exotic-innovation-fedcc5@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 11/23/25 11:53 PM, Krzysztof Kozlowski wrote:
> On Sun, Nov 23, 2025 at 08:35:50AM +0000, Amit Sunil Dhamne wrote:
>> Add a regulator supply property for VBUS when usb is in OTG mode.
>>
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
> How is the pin or supply called in the datasheet?

The pin that supplies the VBUS power in OTG is referred to as Vchgin in 
the datasheet.

>
> Best regards,
> Krzysztof
>

