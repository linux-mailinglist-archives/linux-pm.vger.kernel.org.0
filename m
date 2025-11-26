Return-Path: <linux-pm+bounces-38747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FF0C8BD9E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6143AA907
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAA342506;
	Wed, 26 Nov 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6AgJ+k+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E33128D7
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188840; cv=none; b=Y6IeetV4WO81H0p6IvaokzQxkvbeiUYEp1EXE7jYfAZgOT2RN7AAFJzzuWp93Y6EneQ5roGZVgkjQGipyq8/Pj9qXXaFoxkggpktHQFF875TtVjQYI/2aKEV0U4cfoE7uUVlr5mL/p9STQctCuGSE15/tMzEZMIxA58ZGlrIgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188840; c=relaxed/simple;
	bh=BUKUk8XbTFbg4rBCIooaYc9015FQ2fbX5halOJx9HyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJoWxeVQp/hRXZ//3dLldWhVN9b4CeG8Sz0DInoZ/AKPs3Z9F3WVyoT65G5ovxcngokEKy70Dhre/9WWRhiPz8bEYfWXss3I2GN3Lz+9Op8AQSvgrRcCOCIuUBJxKXQerkOPN3Ks9HXX5aB9YYLSph8YH1kZXimgERWHuefgrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6AgJ+k+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297dc3e299bso1730675ad.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764188838; x=1764793638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5r3za4Hd/VcLzmDqeRuo9GjhPbaMT68/WQ/4wPSlvg=;
        b=s6AgJ+k+S05B8VA8DFZWOL2d5TbrYxk6tma4DHRIF0l5l3jtDLGUrbZxPZmH09adwO
         cg8HXhneoJdVQ2K1tIYT2RJsM0oEkBUC+MNOWOY4XG2pr+GPN1zaR1DiFJ3oSYuoJR6z
         AqdGwjk0rQJs2ePWrolt5B+OIb9egoFhaZ9AZvt647nS5HsTxdmZnYWOoGythSyIDLVS
         1z0F+LDYeOR3wrfXDD5ZHnaA/Ozhn0ojJ/OU3dlzmeQJ+kC5puBYCT8H/H5Qyf5d1fAb
         6MTuupBGvBHCKxHx5eijCK+6sS6rLGq40qfzsdQrrK+lV75TU60t6RJxuJcsBeQUmUOh
         XBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188838; x=1764793638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5r3za4Hd/VcLzmDqeRuo9GjhPbaMT68/WQ/4wPSlvg=;
        b=QNB25lkA8cjJMWQ+B5a5s9JNR7f2sIr0fG+RtbgY3FsjYFWIj+zOjFkUA/p60Dm7P5
         FkVxcO8lzrAi/Seic5JImjRupYcdo7vAsPdseAA64+w3W5woUeRyC8Canv6RWyoIEIcU
         nP36CUFyTu7HgQ4srbutD+mDVjnxjMe8L8WQCdLlq18ck9iDEjcYeGEfo/0peS27fQzc
         ehitP750vKyLhTdiC91/XBRHQ5gqKskOIDn/keXFTzEni6q8WlFyC2DnRR0Dy/9pPsHk
         dLvKqKBCQaZue/sMFGB0btE9COMGONFUr1epCwXYVlwzDDtW2ENyYw27S1/6QoHAW93W
         jOLg==
X-Forwarded-Encrypted: i=1; AJvYcCVIR3ON4SjMuu4swez1rXW9Pe9CPd8uC5wFYO14b5A9RAoaRPPjF1cGeUgSlIE5cy+LKJdSjsRAZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZBXHbySi4aEgWrXf8JcZhowDu0RdIj9DoOEYfB2FmvZ95JLZ
	53Y8hA5AjLgixexnvhu0phsveJvAMrKlS2EBp7UrDW0f6OL5RZoWn+bdrrdsHwBDRQ==
X-Gm-Gg: ASbGncvY6N+7nHx0i3lYB818P3w9uqlXTIyAB8U9vldH5rugr8O+fcZDqC2iuk3DpnB
	tNqhsxRc6sIKmmswV7Hqo/Bh+BKvmdiZe+FgZ8Pf2mfRt9SS4g9CgwDsJXeNqVoIUylQyxJl5o/
	x20UnLZXGyHLOXKu1+uGzj7IU2JnGWls6bvRa791yB+WZsrXMXpa1HTtRm4SKrDN9hknKsYGn2Y
	9sO6zRM5sfiLD7Wtr/xasqc5DHC1k3VyxIc0RuWIiqlQPWNx9+vydEWR/61jhy88gnku4/9XpcN
	EUskuFQluOEwkK1THjJ0Xc5y/+ENtD1l9D/hRfZVsP5wnbKpA3odsq5iU86G3Jys0nJLeWJV0jE
	UZSpaS2rMyi/rxrnf4146EOsf4zjjcuE1TSNFPm6N0XleWxzrCXLmFzNIpQORYSDPLnUIUbrxNa
	CU59R7lNXxRlYxHUg1nazoeoXq2xzN9cQveBzTZPhmZPzmN14K+u1MWNvdNABRAhOOWIzvz6PBY
	Nes6aNn77WXIg==
X-Google-Smtp-Source: AGHT+IGs7j+rISQURjI4KHJiRtxo72A6EAIFd8qUy73nZRmTVJ6HUMi3Fk8FYXZXKGlB3rSWFkwohg==
X-Received: by 2002:a17:902:d58c:b0:294:fcae:826 with SMTP id d9443c01a7336-29bab2fa50bmr92368305ad.59.1764188837611;
        Wed, 26 Nov 2025 12:27:17 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c116:b1c9:632d:a902? ([2a00:79e0:2e7c:8:c116:b1c9:632d:a902])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm205771575ad.75.2025.11.26.12.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 12:27:17 -0800 (PST)
Message-ID: <1be015d7-201b-4e3a-a71a-130162205e5e@google.com>
Date: Wed, 26 Nov 2025 12:27:15 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply property
 for VBUS in OTG mode
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
 <adc2d6ec-e666-4dd0-aaad-7ef014efafb6@google.com>
 <8d8201de13b4694b26812722356a3a55637406c4.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <8d8201de13b4694b26812722356a3a55637406c4.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/26/25 8:18 AM, André Draszik wrote:
> On Tue, 2025-11-25 at 12:13 -0800, Amit Sunil Dhamne wrote:
>> Hi Krzysztof,
>>
>> On 11/23/25 11:53 PM, Krzysztof Kozlowski wrote:
>>> On Sun, Nov 23, 2025 at 08:35:50AM +0000, Amit Sunil Dhamne wrote:
>>>> Add a regulator supply property for VBUS when usb is in OTG mode.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>>>> b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>>>> index 3de4dc40b791..a529f18c4918 100644
>>>> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>>>> @@ -32,6 +32,9 @@ properties:
>>>>        description:
>>>>          Properties for usb c connector.
>>>>    
>>>> +  otg-vbus-supply:
>>> How is the pin or supply called in the datasheet?
>> The pin that supplies the VBUS power in OTG is referred to as Vchgin in
> I think that should be chgin (without V prefix)

Right, it's just CHGIN. These CHGIN pins source the USB VBUS power in 
OTG mode.

>
>> the datasheet.
> Cheers,
> Andre'

