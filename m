Return-Path: <linux-pm+bounces-24123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38559A63679
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 17:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211E8188D1EA
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5C1B87E1;
	Sun, 16 Mar 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHGya4GO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FFA8F4A;
	Sun, 16 Mar 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143795; cv=none; b=FYXBgasrATqyQBELNhq/Qn8895mV4ICggpjYpEOaFfUgqU+3REYFMRpFaOBl3H5pzTEg3AI2ZGIHRyM/a4W//SDYyukpGKOwoJQf8RbDZo9ZHLRlsgVrVrLm6CyMbb6FtoeAdIE9GOWPC03+9vqGD6gxPbO/H3D7ePe9jQEtyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143795; c=relaxed/simple;
	bh=Qx8JZ5UXbAW4tdRKdlvaGVP1rWhm+NwDyBvCLqdgj6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4TngWprT4FtwsPqYMm3TqfnTqa6TcTqVwVEAQCZW3nwMfUtAjpI8+KzBHvAT1xcaOeZYsPDvf+SX9QCaUw0TpOJuNUJZTBwB2ukE1cjAN/Ae/vnaSW3Sfv0cqMoWPF35EHOCTg7iaFhjynyNxWS+/ZO9J+qvUlYBtMHJ00FFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHGya4GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE8BC4CEDD;
	Sun, 16 Mar 2025 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742143795;
	bh=Qx8JZ5UXbAW4tdRKdlvaGVP1rWhm+NwDyBvCLqdgj6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHGya4GOKqq/rtzPOQ4KshuGRBOK2Lx+p9a60Z2ktt2X8RMYesvdqTOAB+B2STV4v
	 2cruDw5G1lT4vl8xBe0UrXzwSaK/Ksy992DIT1/mMG5j9SxjbSLjTB5zAocD3CpPx8
	 szzstemwXooYn43nGzcrvP7yQXzgQgs7AovcZK6awvjkFhbWmHRrwyL+IjIBe9zJ7j
	 bSpRZgKQoKWz1EWpIMwhE3DutPAKnMGtHcpAiQxzVfFLOBqnWYj8p7kW/UScf9CmrJ
	 8Z8d2mctoKxnnhPchMLLE5cylqdHhr8CulFPEeR4iVepxNSQDQNN1v9lrMLEsb3HL6
	 8Y5CkzMsPM8jQ==
Message-ID: <3a33dab7-87b2-4b74-b138-e368d4cbc358@kernel.org>
Date: Sun, 16 Mar 2025 17:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
To: Amit Sunil Dhamne <amitsd@google.com>
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2025 01:56, Amit Sunil Dhamne wrote:
> Hi Krzysztof,
> 
> On 3/13/25 1:48 AM, Krzysztof Kozlowski wrote:
>> On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
>>> Add a new "fixed-batteries" DT property to connector class. This
>>> property is populated with nodes associated with battery type power
>>> supplies powering the USB PD connector. This is needed by the Type-C
>>> Port Manager (TCPM) to query psy properties which are used to feed
>> What is "psy" in terms of bindings?
> In terms of bindings this should be a phandle to a device that 
> owns/manages the battery (whose driver will eventually call 
> devm_power_supply_register to register the battery). This could be a 

So a charger? Please rephrain from putting Linux names into the bindings
description.

> fuel-guage ("sprd,sc2731-fgu", say), charger ("ti,bq24190") or a 
> platform device ("cw2015") containing "monitored-battery" property to 
> manage the simple battery.


>>> Battery_Status & Battery_Capacity AMS.
>>>
>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>> ---
>>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>>>   Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> @@ -300,6 +300,14 @@ properties:
>>>       $ref: /schemas/types.yaml#/definitions/uint8-array
>>>       maxItems: 4
>>>   
>>> +  fixed-batteries:
>>> +    description: Contains references to nodes associated with battery type power
>>> +      supplies powering the USB PD device. These batteries are fixed type and
>> What is a "battery type power supply"? If you just link here batteries,
>> then we have type for it - monitored-battery - but I doubt connector has
>> direct connection to the battery.
> Regarding "nodes associated with battery type power supplies", I meant 
> something like a fuel guage or a charger OR platform device with 
> "monitored-battery" that will manage the battery lifecycle. If I use 
> monitored-battery for this, I will be restricted to only querying 1 
> simple battery. Also, I don't mean PD connector device to be a fuel 
> guage or charger that manages a specific battery. It should just be able 
> to query any FG/Chg for the battery status to relay that info to the 
> connector's port partner.
> 
> The intent of the patchset & this change is for the USB Type C protocol 
> manager module (that consumes these bindings) to be able to get info 

The intent should be rather to accurately describe hardware and maybe
that's the problem - you focus how to bend it for your drivers.


Best regards,
Krzysztof

