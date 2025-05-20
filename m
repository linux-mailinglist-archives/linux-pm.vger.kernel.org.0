Return-Path: <linux-pm+bounces-27435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC1ABE47F
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C3D7A1DC1
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287B288503;
	Tue, 20 May 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7RnoFCy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FEC286D6A
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771830; cv=none; b=Tef87l88Ubxb+Ph5CyLFrneOJ22Lb+myQQIM3eRdKKsNHkVjV9PD8mTTPPePMvA8r/Xamv5ayPn8LK6WtJmImtStRKiWDNGkbDzI7lMhPPMImmHg4jyEvtvCvgBD7Q49qvralA8W+RCVRDA8dfxfN5xRUYPOdT9Qt4xk0A+6KrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771830; c=relaxed/simple;
	bh=17Oo7t3drcmTUprT7YAGKDrd3hI3NBO5nbodblx74cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejECwh8LwBBDhFBu9DNE30+EFAgw0bIZenGFl+gOErJZ9oCngHDwfByFIzaHi8MSeXYXvRPT4Z73qZr+F4a1BlHz1twstwDTW3lKblT6rDZSMaBa2QKGeF2kk01yfg/VKDzWWrm+8514uAZtZjtSYAJyHIkkKpCMuD0ON4YLD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7RnoFCy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so3645584a12.1
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747771828; x=1748376628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+KhD19TGWdJCr6+1OZ/eYxZVtdk3nOv6YbmASHwaj4=;
        b=P7RnoFCy5D17T6Ielpfz02tldjKtnHtSe6A3fkzMNRNzcP/jH8v2/shtvgeAOJrr25
         kYwJ5gta8ZjVQ0aajeFw5efi7r1jrdHDwsx5RIguG0TFNPCykxFw7ZlW9FHEZWQ0iNZ8
         3XHPk8I/LT4s1UoTpwcqHPIPpUv19L0cuYjV1QsxSA/6i61iZkWXRysbrsDjBMSwZOUP
         0RF/S/oLg0+VE5CDTwla9OImFzIj8sOXm7usUzDvPom7sEmsWuY7DEBTHQzWVnN2f0Q2
         EbRMXb8cIPoeF4J8JxuCILZ3E4vzNMoe8g+eGhBHn6GlTbrFxj3vGJ9E5e+fZlGhDmdc
         iEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747771828; x=1748376628;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+KhD19TGWdJCr6+1OZ/eYxZVtdk3nOv6YbmASHwaj4=;
        b=q8LDpZOEJ50opJrTwvduu1X4LyAbMmL3m8igauEwgIDPbpauf3yjTbc8LovYDvUkxo
         4vRqfxVjJzHgK0ynUzRddoeIScTmF7PGXzobhkPbzVuJUjymcezBTZnEOJ3covfI1O5n
         373K15syph8b9g8Luum5ePsqjmtT1hZKvXpnohv/tklxLnB5xZn4xMyQuREdW7A67BRu
         a8z8CETavmPHDGjhnfOaLiPFQLvc0LcH0RawtkK8UzR0kAqAojKJduphA34ntuvSzIW+
         qmZ0iIiTD23jvrnvCKxWFBLdd1l1MWatIloLtJNjOxBneOBHdgwlBdP/jzzU+gAUiCCm
         QLxA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5RQ9QdzyqlWZAMVyeEfFPuCs4fniujZKddVttTjj87RM5sDvmf1NRtbYNoNXqAOtmAce4FZ9YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXVl6YZp2B2u16ur7RUQyE6/4J/cY4mXlP5IKGXSHozqrnJ5+
	hyE35A4ZOqDBwHrC61GcaYMCHvrqv0YSESXPEHr/KT4N3sG5LeVM2jNmuSJ4MpQHxA==
X-Gm-Gg: ASbGncuU5qOyXFEuP0MvxnwwBprS3tkdg1L6dhyGpqmF9upSbDdrKS8yYkBDuRYmjaT
	MWyAu6P3l9d1izEWlrE53xu3XfF2R183ztY2k/q9QG3GlDvZx9A/sn8OmiAUlLEeXdC2G3GRmZj
	W7f2B/LKrDKxHS+CeAdkV5fj6SugCUEF+ZpmAPIprcQvNTMLwEPgofPJ4Vh1ZV1jnEeBmLAblNe
	XmIfw/NmMixn21HMZ4Fg81ondrXwgMMbMIdYyvMQ+vymhV/PFQuorIZay4aS7NJa4G+cXIGQfGD
	1u0amJA8Kl6uab6g+deCGyHuQCEkFbcXZmGvnlHPuKCxRosp2hVPA23kYxJr1DrifPdtc778I3e
	KvIee3iyoeHHDwHleHujsS54usCWpyNYsSQqKBYMWAp6ccgultfGyuUdCRQ==
X-Google-Smtp-Source: AGHT+IE/aaJHqzivD7gsDmjX9hv8lRsiGnVJAxn/l+ejoBOCUQrJanyH91/M2gPTmHWZeXIyOLokeQ==
X-Received: by 2002:a17:903:32cf:b0:22e:40d7:3718 with SMTP id d9443c01a7336-231d45ab9e9mr232041875ad.47.1747771827986;
        Tue, 20 May 2025 13:10:27 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:8:658c:7a8:df68:611d? ([2a00:79e0:2e14:8:658c:7a8:df68:611d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9530sm80833475ad.48.2025.05.20.13.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 13:10:27 -0700 (PDT)
Message-ID: <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
Date: Tue, 20 May 2025 13:10:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
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
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
 <20250514194249.GA2881453-robh@kernel.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <20250514194249.GA2881453-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rob,

Thanks for your response!

On 5/14/25 12:42 PM, Rob Herring wrote:
> On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
>> Extend ports property to model power lines going between connector to
>> charger or battery/batteries. As an example, connector VBUS can supply
>> power in & out of the battery for a DRP.
>>
>> Additionally, add ports property to maxim,max33359 controller example.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>  .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
>>  .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
>>  2 files changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -181,16 +181,16 @@ properties:
>>  
>>    port:
>>      $ref: /schemas/graph.yaml#/properties/port
>> -    description: OF graph bindings modeling a data bus to the connector, e.g.
>> -      there is a single High Speed (HS) port present in this connector. If there
>> -      is more than one bus (several port, with 'reg' property), they can be grouped
>> -      under 'ports'.
>> +    description: OF graph binding to model a logical connection between a device
>> +      and connector. This connection may represent a data bus or power line. For
>> +      e.g. a High Speed (HS) data port present in this connector or VBUS line.
>> +      If there is more than one connection (several port, with 'reg' property),
>> +      they can be grouped under 'ports'.
> 'port' and 'port@0' are equivalent. So you can't be changing its 
> definition.

Noted!


> I'm not sure showing a power connection with the graph is the right 
> approach.

I want to provide some more context and rationale behind using this design.

From a hardware perspective:

The max77759/max33359 IC has Type-C port controller, charger, fuel gauge
(FG) ICs. The Vbus from the connector goes to/from the TCPC and connects
with the charger IP via circuitry & from there on to the battery. The FG
is connected to the battery in parallel. As it can be seen that while
these IPs are interconnected, there's no direct connection of the fuel
gauge & the connector.

For this feature, I am interested in getting the reference to the FG. As
per graph description: "...These common bindings do not contain any
information about the direction or type of the connections, they just
map their existence." This works for my case because I just want the
connector to be aware of the Fuel gauge device without imposing a
specific directionality in terms of power supplier/supplied. This is
also the reason why I didn't use
"/schemas/power/supply/power-supply.yaml#power-supplies" binding.

> We have a binding for that already with the regulator binding.

I haven't explored the option of using regulator bindings. But in my
case I am interested in fuel gauge and unfortunately, they're modeled as
power_supply devices.


>  
> Perhaps the connector needs to be a supply. It's already using that 
> binding in the supplying power to the connector case.

Want to clarify, in this case you mean
/schemas/regulator/regulator.yaml#*-supply$ right?

Adding to my response above, the reason I don't want to impose a
directionality in terms of supplier/supplied is that in case of USB Dual
Role Port they're dynamic i.e., when USB is source, the power is
supplied out of the battery (battery/FG will be supplier) and in case
USB is sink, battery is supplied power. Whether the connector port is in
source or sink role is determined on a connection to connection basis.
Also, the knowledge of the supply direction is of no consequence for
this feature.


Please let me know what you think.

Thanks,

Amit


> Rob

