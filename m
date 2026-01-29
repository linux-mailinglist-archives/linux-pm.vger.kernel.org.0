Return-Path: <linux-pm+bounces-41735-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOeNNBrWe2klIwIAu9opvQ
	(envelope-from <linux-pm+bounces-41735-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:50:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D770B5147
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACF9F3003BD4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F083366824;
	Thu, 29 Jan 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huk3KOUf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974A36655A
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723413; cv=none; b=njzJ+FSFzNAxUKv6x+CXw17RmLyr1BfAYeLs7b8fuLwRSipJJuMH/oYz9azFu6LGtepFT9/x/TmghFOi7EJB/Jq3nGlpzjSc3cuKrUUjSJj/RioxbfhU/GKKVQe/kQ1l0APrK7bL1FqRRiMH4qye5ddj12q5j0FM1OivD0E3Y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723413; c=relaxed/simple;
	bh=cd9mN9FTxtobZucZUadzh1p8mFgy/n/xbH66wjlpJfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r8CB4Juzbm7WXCDSkiyFHDJa2QCxY8KmM29BH9jKXGTPbGdbymZvfEVzm31VMQTFPV1rxrkG+ZSPMAXVyJ4SMLuZC3eP41yqi6hKAi3pitghZ9XL5cgMXTOq5NmRNylpu0vgwgeIepWVbHqOSyWoIiVDhNwXnzIGrTJRUVaozr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huk3KOUf; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b704f08e73so883818eec.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769723410; x=1770328210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnFZtFlF7N4pN1jjAdwC3X0D7hes9W8LIgmymlTg2eQ=;
        b=huk3KOUfDbcdpXfAWGGv6beIQ5dOPJY5+TBosOp8hreoJpMmGitXBTi0K+iE+xx3dT
         tqovgNb85G6lpxL9BquSaCZx6MY2l0exNt5rOYkPq0S2JqTAUTEGoIkOcJR0619gqnHw
         jcV1iJbccxtSUadRbk9hYXvXuiCeOdHlQK2X2HZn7n5vTDwKrI6kWbnoFeLvnYcwIHO3
         31co32Hx6oDMTGxVu/gtQpGNh3I2XesVspNq3Rl54pUYDiotrJDqeL+yGROPkpSVeUJz
         AnEDcoAWBODIGChlmVXblU9sO/0aZ5hQ368ECHUMSOumGXXoC22g/KfZ3hIGa9WnVH3P
         QyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723410; x=1770328210;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnFZtFlF7N4pN1jjAdwC3X0D7hes9W8LIgmymlTg2eQ=;
        b=sDWaPHdyUhWlgCuS78qhascSFfZNyYt+6b2tz+SVMbGeqWPVayrjkOM77l4ufpc7at
         1feagO9mhq7gktkWWYM9HrUvy+zKWlHjDVr+1XbgJ5SMKvsVQgNQV/zPKlfAURtzdJgM
         VMrfrBkafkGJp1aBnkQdt6BjM5iZEMFZBw/+fLEK6FTzYdzqqqE55Ht5p+t9tJnlvZmT
         PRETioUW36zHSSkc7bVb1/PBAG9VtfzRv9qff9PTkNuUqvJbiHALq2rOQmQQHWjca7gu
         xs0bFkBQKfnEDgAfNfV8Bon57ZA+Jike5du4uLOnHHPkKyMi4LNRBhx3Z+SiB6RzccWz
         cEzg==
X-Forwarded-Encrypted: i=1; AJvYcCW0NSlbzS7DL/IXige52fhQHfrNHi6K4pIHjElEeBD+sl2a9nFd50jTbTKDVaIFe9EE8AihcAMWqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMLgWXSOu0fUAjsvU99nPFuivg4XJ0xGkm5tIrswJY3qctNHs
	zuwpqZ37g7RCNQ1mWhTH2g0KoLPIxxyxNIgjtCoIrCdy1uyShqXg7PScEAiNgx+0RA==
X-Gm-Gg: AZuq6aIxwVZ3tGwfUL/IctFya9Na8lEU5/JmbypL1IWLRZsksqxz+2afDwlwhktSnwt
	LkSfmKqiiclnsiPG1mFFdrEpfn49QnaV/iIAgJrNIey7xG0BK1z5WteumvzCkpyujDTRJiTXe7Y
	Ff+F7qxM2EqKeZTs17/8QrRUcFTQTe4q40RcII7GjE2hhXrYqNoHnSLu/fXRKZOyP2iIhyeWcz0
	EkYATRsW5xJ7SPFh1cm1uHqHF8D956ZU3JTDvKoXfPc5cwkFuO3PlhELm0HFSVEGcNHKcYx2FW9
	n+1mJr868Ve94MbVoPd2GSPtlGigtVbxglqdLmemPim7BwKjxc0de1/LLgns0ACWEbwg/hU948U
	dCJqb6EHcbN2IWIbFAuXpdLp+j60j+Go0auBROxwaV7P7OJnxSBnYgJfsAHYa0bGnTgNalgqT/T
	LDltqCPgsfyhWlsa4jCUy3bbE0gC3GNf1jI18xWEwzLqSvqBaWE/KHjqXqTkqUesS5+0qDYJVHX
	0gfEhZNBfPslg==
X-Received: by 2002:a05:7301:678d:b0:2ae:5022:fe7c with SMTP id 5a478bee46e88-2b7b178aae9mr2039688eec.1.1769723410111;
        Thu, 29 Jan 2026 13:50:10 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:2ca3:c2a2:3ff7:e16e? ([2a00:79e0:2e7c:8:2ca3:c2a2:3ff7:e16e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abedcasm8528777eec.21.2026.01.29.13.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 13:50:09 -0800 (PST)
Message-ID: <b6cccee7-1acb-49ab-8970-a828aa86f056@google.com>
Date: Thu, 29 Jan 2026 13:50:07 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 "rdbabiera@google.com" <rdbabiera@google.com>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
 <20250514194249.GA2881453-robh@kernel.org>
 <b4a22161-8cab-4d76-a4b0-4bfd0d79cdc1@google.com>
 <z2wrzts6cgunxs5tc764izvrfi4i2d637zpt6tj5f4piry6j66@cke2yxhih6dg>
Content-Language: en-US
In-Reply-To: <z2wrzts6cgunxs5tc764izvrfi4i2d637zpt6tj5f4piry6j66@cke2yxhih6dg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41735-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email]
X-Rspamd-Queue-Id: 0D770B5147
X-Rspamd-Action: no action

Hi Sebastian,

I hope you're doing well!

On 6/23/25 3:08 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, May 20, 2025 at 01:10:25PM -0700, Amit Sunil Dhamne wrote:
>> Hi Rob,
>>
>> Thanks for your response!
>>
>> On 5/14/25 12:42 PM, Rob Herring wrote:
>>> On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
>>>> Extend ports property to model power lines going between connector to
>>>> charger or battery/batteries. As an example, connector VBUS can supply
>>>> power in & out of the battery for a DRP.
>>>>
>>>> Additionally, add ports property to maxim,max33359 controller example.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne<amitsd@google.com>
>>>> ---
>>>>   .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
>>>>   .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
>>>>   2 files changed, 38 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> @@ -181,16 +181,16 @@ properties:
>>>>   
>>>>     port:
>>>>       $ref: /schemas/graph.yaml#/properties/port
>>>> -    description: OF graph bindings modeling a data bus to the connector, e.g.
>>>> -      there is a single High Speed (HS) port present in this connector. If there
>>>> -      is more than one bus (several port, with 'reg' property), they can be grouped
>>>> -      under 'ports'.
>>>> +    description: OF graph binding to model a logical connection between a device
>>>> +      and connector. This connection may represent a data bus or power line. For
>>>> +      e.g. a High Speed (HS) data port present in this connector or VBUS line.
>>>> +      If there is more than one connection (several port, with 'reg' property),
>>>> +      they can be grouped under 'ports'.
>>> 'port' and 'port@0' are equivalent. So you can't be changing its
>>> definition.
>> Noted!
>>
>>
>>> I'm not sure showing a power connection with the graph is the right
>>> approach.
>> I want to provide some more context and rationale behind using this design.
>>
>>  From a hardware perspective:
>>
>> The max77759/max33359 IC has Type-C port controller, charger, fuel gauge
>> (FG) ICs. The Vbus from the connector goes to/from the TCPC and connects
>> with the charger IP via circuitry & from there on to the battery. The FG
>> is connected to the battery in parallel. As it can be seen that while
>> these IPs are interconnected, there's no direct connection of the fuel
>> gauge & the connector.
>>
>> For this feature, I am interested in getting the reference to the FG. As
>> per graph description: "...These common bindings do not contain any
>> information about the direction or type of the connections, they just
>> map their existence." This works for my case because I just want the
>> connector to be aware of the Fuel gauge device without imposing a
>> specific directionality in terms of power supplier/supplied. This is
>> also the reason why I didn't use
>> "/schemas/power/supply/power-supply.yaml#power-supplies" binding.
>>
>>> We have a binding for that already with the regulator binding.
>> I haven't explored the option of using regulator bindings. But in my
>> case I am interested in fuel gauge and unfortunately, they're modeled as
>> power_supply devices.
>  From hardware point of view there is no direct connection at all
> between the fuel gauge and the connector. The usual hardware
> connection is
>
> connector -> charger -> battery
>
> With the charger potentially supporting reverse operation to provide
> energy from the battery to the connector (with "battery" I assume
> a "smart" battery, so the raw cells and some kind of fuel gauge).
>
> Thus the following example should properly document the hardware
> connections:
>
> ---------------------------------------
> typec-connector {
>      /* ... */
> };
>
> charger {
>      /* ... */
>      power-supplies = <&connector>;
> };
>
> fuel-gauge {
>      /* ... */
>      power-supplies = <&charger>;
> };
> ---------------------------------------
>
> It means instead of the direct graph lookup for the fuel gauge,
> you would need a function walking through the graph build by the
> power-supplies phandles. But it also means that the DT properly
> describes the hardware instead of adding random graph connections.

I would like to revisit this thread.

I have tested the hierarchical power-supplies approach you suggested 
while working with the charger [1] and fuel gauge [2] drivers currently 
being upstreamed. Unfortunately, this approach introduces two blockers 
for USB PD compliance (with the first one being the most critical and 
relevant to bindings):


Issue #1: Deterministic Probe Ordering and Feature Deferral
Early in the boot cycle, the TCPM is the first to probe (based on the 
power-supplies hierarchy). Without a direct phandle in the connector 
node to the fg devices, the TCPM is "blind" to the system's battery 
topology. If a power adapter initiates a Battery Status/Battery Caps AMS 
before the FG driver has registered its power_supply object, the TCPM 
response indicates no batteries as the TCPM doesn't have a complete view 
of the FGs in the system at that time.

Issue #2: Violating Sender Response Timeout
Iteratively traversing the power supply tree to resolve the hierarchy 
(Connector -> Charger -> FG) is computationally expensive in the context 
of USB PD. In testing, this traversal frequently exceeds the Sender 
Response Timeout (27-33 ms). While caching psy references helps 
subsequent requests, the failure of the initial request triggers a soft 
reset by the adapter. This results in an inconsistent and unreliable 
charging experience upon first plug-in.

While I have thought about how we can mitigate these issues if we still 
must have to go with the above approach, I strongly believe that TCPM 
having actual references to the fg/charger phandles seems to be the 
appropriate way here. Are there alternative methods you would suggest 
that allow the TCPM to (1) know a priori that an FG device exists to 
manage deferral, and (2) meet the <30 ms response window without direct 
phandles?


[1]
https://lore.kernel.org/all/20260121-max77759-charger-v4-0-694234c8ded1@google.com/

[2]
https://lore.kernel.org/all/20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be/


Thanks,

Amit

> Greetings,
>
> -- Sebastian
>
>>> Perhaps the connector needs to be a supply. It's already using that
>>> binding in the supplying power to the connector case.
>> Want to clarify, in this case you mean
>> /schemas/regulator/regulator.yaml#*-supply$ right?
>>
>> Adding to my response above, the reason I don't want to impose a
>> directionality in terms of supplier/supplied is that in case of USB Dual
>> Role Port they're dynamic i.e., when USB is source, the power is
>> supplied out of the battery (battery/FG will be supplier) and in case
>> USB is sink, battery is supplied power. Whether the connector port is in
>> source or sink role is determined on a connection to connection basis.
>> Also, the knowledge of the supply direction is of no consequence for
>> this feature.
>>
>>
>> Please let me know what you think.
>>
>> Thanks,
>>
>> Amit
>>
>>
>>> Rob

