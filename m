Return-Path: <linux-pm+bounces-27754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D550EAC7119
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 20:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2593BCE3E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349D28E5EB;
	Wed, 28 May 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lY9RG/+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2C28C85B
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457758; cv=none; b=Q80dmFxb7hLDpyOrjA/IFzCsG8qU1aaNdU/IrtGyiCvCjBlrbkVToxeRoo8r1xndjPPblW/DJ4/1mvYHbQx9T9WBaP4b4wRHHS6GL/l/ot0kxS9leGuduBsu4oUhZIHHFsbE6CUgWOSpRIAIJ5qcmIp1/IDZNf1HzeyYU4Av1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457758; c=relaxed/simple;
	bh=0wEAblScT3Tn0syVJfG0tTwG1D/tnAHVu9ez28S8eI0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NTPWgYJI9ruRj6hvMoqVZvYXwIUtuTHwMKV6yL9788XpmhzT741Ez0f1UsSyi7rCQMWMhJ5ouWVq8TSuW2BpX327LmNnOQNT2ao4gASNNTafDI1gR3zWE1KZ4GhNOhLW1xoMolfBI90SW511WRVrBQNRilMpMUnzZHrft3pUttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lY9RG/+t; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4064950cae4so17773b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748457755; x=1749062555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/id1cw/2XOGpn9mnUKbEKyu15ax9JW7xw71uWNwiEC8=;
        b=lY9RG/+t8KnHHveGmFZUq28zEpsC6O9GHvHdi8+s7gYnVJ8FAretIYUjyYV1I7j0Gs
         HKt56Dmb7/1kmbHP1C/etWlDQvEQHZB91eAPXWgJqAlyUeIAWBVeASlDDf4RKbceK34g
         QT1a2wnVrjbIRh/Q6F3I9TIqIEMftpoBRaGl9IvXv95dL7gAEJMGHdmlsdPtABQCmZ3C
         vEmoi2yXGpriMOv5nYgsTjLya/qm2oVV5yykfUEDsyzZ55/C1Mh7u2JxqwGmdYIGc+L7
         P0kdueMH2IAQmFmW7xN81oB2rC7cdPLzsq8e9rlzXkl9ALj9S/OQE5ibsAmcS6cknC6F
         zH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457755; x=1749062555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/id1cw/2XOGpn9mnUKbEKyu15ax9JW7xw71uWNwiEC8=;
        b=FytoaHlya0Mm2tCWw5hjwTEHiTE5o08IuAFzePsDERwUEP/1ikFuwYkGdL4Aw4oCCI
         60ndTnp5WHCacUgn/ZAiZwQ9LNd5d2eCuDEWES5V74u+xq4+EczYMHqhBCoMUXjyULGw
         YGJj+EQYI7UJW4oM2qWbFtbdsetytgAK6v8PZ/mjbEHGW+9z8id1Ho3UUK65C/n4XM8g
         rli1txllvRpErFKzzBUxRONKpNnTLHGjpi3u1fmncm3YXX4foaCQLOiWmCqRl8nZjal+
         1Ts3SegSG89Cdm/R5fN2ijbBvXSf36bcE8BhEcU1aBYUl5vPDWt4dEzR2Iuj2BfMu7PY
         +dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0o0s3U8d+JK8msln3W6jBAViF14vbcwpYpizYGIsjEY13VsL/UHA5UlZupK1qtA1klUIGsRRZCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+tNNPfCjldLJeG7bCqNCKtS94vvbJwP0OzgqSAOg7UVPNAfB
	cgnr75BQyCsepLcbQl4AqI6wsNKu0UDaAbAiKVxi59XTlmsn9Ew9rVL077lr+UJxWw==
X-Gm-Gg: ASbGncsJBuUxIrRqCjO16TY6nJ5yJbTxcyzuyAWBClhA8idEZk6y+gWhXXid+NntFT7
	t/2zcjqBhOghOX6NFZbIaJ+4WhFZ/t+vAq3mcEMP4Ct80383B52HHy3jUAKiTgKWW68sWTQVCO6
	m7o5W26wgr0mgcVxH/xqngNPo0Qm31OWWKBSFVUHyjSb9n0L5/7wjObI2Th+PSpi8mFbpzdaxU/
	k7xH1NuLSvmKZ6z3ceXp26DeRHDuyMJI210hqiJsDKB3sSsEtacklMQIu91S6B0Er5FNttcepMB
	yUAzGt2JOpTwO+zmI7hYPYCw7NQh0NmYErAi6dA9zw1N9vI58X5aOCl+13Q6/73hzDJGHhaRX18
	iQ6mJNT1r7f1al/wJko4KNIHx1Zn7e+RcQg==
X-Google-Smtp-Source: AGHT+IHs3twkSqT8CkQpqljahoHzRiFkiwtOJeHfFHvri9IID3VQA+sC09W4Uev9RI0/erZOqB2v6g==
X-Received: by 2002:a05:6808:4496:b0:406:6e89:49ba with SMTP id 5614622812f47-4066e894caemr38806b6e.33.1748457754629;
        Wed, 28 May 2025 11:42:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:c0c2:d38c:e9e8:866d? ([2600:1700:4570:89a0:c0c2:d38c:e9e8:866d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-406654736d7sm276312b6e.36.2025.05.28.11.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 11:42:34 -0700 (PDT)
Message-ID: <9376817c-30f1-4ca1-afde-60ebdfd93f53@google.com>
Date: Wed, 28 May 2025 11:42:24 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
From: Amit Sunil Dhamne <amitsd@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, peter.griffin@linaro.org
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
 <20250514194249.GA2881453-robh@kernel.org>
 <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
Content-Language: en-US
In-Reply-To: <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/20/25 1:10 PM, Amit Sunil Dhamne wrote:
> Hi Rob,
>
> Thanks for your response!
>
> On 5/14/25 12:42 PM, Rob Herring wrote:
>> On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
>>> Extend ports property to model power lines going between connector to
>>> charger or battery/batteries. As an example, connector VBUS can supply
>>> power in & out of the battery for a DRP.
>>>
>>> Additionally, add ports property to maxim,max33359 controller example.
>>>
>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>> ---
>>>  .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
>>>  .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
>>>  2 files changed, 38 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> @@ -181,16 +181,16 @@ properties:
>>>  
>>>    port:
>>>      $ref: /schemas/graph.yaml#/properties/port
>>> -    description: OF graph bindings modeling a data bus to the connector, e.g.
>>> -      there is a single High Speed (HS) port present in this connector. If there
>>> -      is more than one bus (several port, with 'reg' property), they can be grouped
>>> -      under 'ports'.
>>> +    description: OF graph binding to model a logical connection between a device
>>> +      and connector. This connection may represent a data bus or power line. For
>>> +      e.g. a High Speed (HS) data port present in this connector or VBUS line.
>>> +      If there is more than one connection (several port, with 'reg' property),
>>> +      they can be grouped under 'ports'.
>> 'port' and 'port@0' are equivalent. So you can't be changing its 
>> definition.
> Noted!
>
>
>> I'm not sure showing a power connection with the graph is the right 
>> approach.
> I want to provide some more context and rationale behind using this design.
>
> From a hardware perspective:
>
> The max77759/max33359 IC has Type-C port controller, charger, fuel gauge
> (FG) ICs. The Vbus from the connector goes to/from the TCPC and connects
> with the charger IP via circuitry & from there on to the battery. The FG
> is connected to the battery in parallel. As it can be seen that while
> these IPs are interconnected, there's no direct connection of the fuel
> gauge & the connector.
>
> For this feature, I am interested in getting the reference to the FG. As
> per graph description: "...These common bindings do not contain any
> information about the direction or type of the connections, they just
> map their existence." This works for my case because I just want the
> connector to be aware of the Fuel gauge device without imposing a
> specific directionality in terms of power supplier/supplied. This is
> also the reason why I didn't use
> "/schemas/power/supply/power-supply.yaml#power-supplies" binding.
>
>> We have a binding for that already with the regulator binding.
> I haven't explored the option of using regulator bindings. But in my
> case I am interested in fuel gauge and unfortunately, they're modeled as
> power_supply devices.
>
>
>>  
>> Perhaps the connector needs to be a supply. It's already using that 
>> binding in the supplying power to the connector case.
> Want to clarify, in this case you mean
> /schemas/regulator/regulator.yaml#*-supply$ right?
>
> Adding to my response above, the reason I don't want to impose a
> directionality in terms of supplier/supplied is that in case of USB Dual
> Role Port they're dynamic i.e., when USB is source, the power is
> supplied out of the battery (battery/FG will be supplier) and in case
> USB is sink, battery is supplied power. Whether the connector port is in
> source or sink role is determined on a connection to connection basis.
> Also, the knowledge of the supply direction is of no consequence for
> this feature.
>
>
> Please let me know what you think.
>
> Thanks,
>
> Amit


I wanted to follow up on my previous responses. Please let me know if
you have any further questions or concerns.

Thanks,

Amit


>
>> Rob

