Return-Path: <linux-pm+bounces-24739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D785DA79A95
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF03ADEFF
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 03:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B618CBFB;
	Thu,  3 Apr 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyY9CgLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEE54F81
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651667; cv=none; b=rpnruuvngl2mQ0rwcNVQRHN6icdc4Kgqcjhk2gupaPj3oQcROAj4IsitMiKP/GyA2xM4xvRBiLF1gVd4FLrUfcEllynYjTSUt02hIjBmaj6ExbjgdBSivKzk9sv/VwFXij3EjwA0/tSgIhEXlt1irRkJ5fpctO+JBXZ4iqctBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651667; c=relaxed/simple;
	bh=4aTH+S+5/DaE7SK3f14o739lz7d4vHx+nHgg53Ilpic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL/zdyPkkmJoLvgFLml4DVwhQpbYu4OmLr6LvAUIesLp/QpMM6BRiUVwbcDkz1whwANukuhxBZ44l/X0rjeRzdKMC8hl+jpDtcydlrQVkFgakP3HBujQSu+9wRJZ8+yjeM8+wtIpTnYuuxRvp2D8kvFUELuhZhXgCInnvzj0N5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyY9CgLj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225df540edcso21507695ad.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Apr 2025 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743651665; x=1744256465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0tEj5kz4If7Ej673fi5hk/2hJig3VYxT41dAgyMOLI=;
        b=lyY9CgLjw5w/omaCCOXRmGOkLC04kzcy2leKTC+7T42kKoJTSdWKzNmOjhxgW3UxzO
         /97cz3bumayZzjInyeK17jY03f/x4aX3euSUjs0n3saU/BlKKpLEVHdZpIiqIV92Pqx+
         zcKezlq1zGycE/WtglYmo6de0b7VO3G5Ec2iIENeXiCptQvvD7/hSZajDdjKem9M+ORD
         UwdrdCwkPk0tLGrKlTyyB8vRBz3mEQKchMX6EjK3tzKja9nCZNtAz1GlpdiPLcWHjuby
         NCQxszMh9hmSQiP/677re+qjNIBv5V/KtX+aTnkgLnNmsVejO7FoNzTE2/tTjI3Al5HK
         Ixiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743651665; x=1744256465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0tEj5kz4If7Ej673fi5hk/2hJig3VYxT41dAgyMOLI=;
        b=FlzaOs6Vwicb26q3cqysL9D+49YFnw6RAu5vGs3GBddnj/g+eXRzFpzcglUReqIjgM
         GMtXA2Ns/iEn9L6AQDhi2uJo6Vt5SwPDPIa+tIZczH7tYdKsDOo5jd9fIVcHc5zawo9d
         IFmePckpM3eEjnaOc0yFu/GKgVvrIgbY5vadweca3umN5LaU2Jly9XN/fgVct1lEA80n
         LQBDY1RXdgGJ9Nz00t0Qs60BIsxU5F5hnqN3RI24rfKb6Gtje311ywkniBNRFhAFXLMV
         Io3ZShEZuadkFoUAItEZoIh4Jc+1DlIFYSFEJgbptIUOXBrej1QTE94YvXX6cnAtctMJ
         urBg==
X-Forwarded-Encrypted: i=1; AJvYcCVgHy+FjSXxikz7WMWpQ2olZi7R0CefPAlzvGjLkMJEkYKu1P8sS7nRwjkyqHtyu6xRYm2tGNasCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8xw4O5pk0pmxyEcJrCB4k4/9oZuK0JmQHi8bsd6qQ51WboS9
	VrZ+InfO4CiFkB/M6YFAEtXwkEO29PGwhwOB4NVxmYgSHUymnfGyfkAs9K69Wg==
X-Gm-Gg: ASbGncugvO816dheBBA+HnjOVpK8mOGgNflNKTOidVUHJwz38tUPzV2B4Gu6mE3PiRQ
	wiS6Fie92qh7Hl6YvDKDtqwWR2kvx46NF0yg0o9YzRdnXoFsHOFJHzOWr7Vx/2AgeE/RhY+QHL3
	Ib1SI2qoKwekxZQn6Wfw26Fa4bVfKslLuFfFK/RKuWwyVZ5t8fnCMEwHN/mFmvF1pZ6ZgdmRLVN
	YQdT/NI9hX8Fb5MUPJUhBJWmurOZ+/jJIduXiBUUGPh52GLojry5YxWeRquglp82UXtrYgmYZyV
	x8ZZkRVyC6a/FVdNx36QAg0+mYbnkN9x/tloMQqIG1Ld38kJap5hwQu+1Jxe/U1y1OK719ctH6y
	y/m5FrqYCR1QzlpR2rZPB/O0IqmdV3Kr8T8sFIg0jKe4=
X-Google-Smtp-Source: AGHT+IF+aLQLn6pLeab1Mot3xJ/DQBJV5mL7CVD5eHdMlU/bvNw7/84AH4TtA5RPRM1hKWlLyvBvkA==
X-Received: by 2002:a17:902:ccca:b0:215:58be:3349 with SMTP id d9443c01a7336-229765ecb95mr30013415ad.14.1743651664993;
        Wed, 02 Apr 2025 20:41:04 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:33af:bd9c:23d7:88c5? ([2a00:79e0:2e14:7:33af:bd9c:23d7:88c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e483sm3887005ad.116.2025.04.02.20.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 20:41:04 -0700 (PDT)
Message-ID: <7c7cff17-2c53-4dcd-8760-50c72760de5b@google.com>
Date: Wed, 2 Apr 2025 20:41:02 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for Battery Status & Battery Caps AMS in
 TCPM
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
 <20250313-determined-wild-seahorse-f7871a@krzk-bin>
 <914a0df4-96d0-4cd4-ac87-3826fa9c1440@google.com>
 <3f65fe16-56f8-4887-bb91-994b181ce5a9@kernel.org>
 <9852e5a8-843d-48ae-90d0-7991628e93b3@google.com>
 <442bebf4-4de1-42d1-a14b-2bb509fea12f@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <442bebf4-4de1-42d1-a14b-2bb509fea12f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/21/25 12:51 AM, Krzysztof Kozlowski wrote:
> On 20/03/2025 22:11, Amit Sunil Dhamne wrote:
>> On 3/16/25 9:52 AM, Krzysztof Kozlowski wrote:
>>> On 15/03/2025 01:49, Amit Sunil Dhamne wrote:
>>>> Hi Krzysztof,
>>>>
>>>> Thanks for the review!
>>>>
>>>> On 3/13/25 1:50 AM, Krzysztof Kozlowski wrote:
>>>>> On Wed, Mar 12, 2025 at 04:42:00PM -0700, Amit Sunil Dhamne wrote:
>>>>>> Support for Battery Status & Battery Caps messages in response to
>>>>>> Get_Battery_Status & Get_Battery_Cap request is required by USB PD devices
>>>>>> powered by battery, as per "USB PD R3.1 V1.8 Spec", "6.13 Message
>>>>>> Applicability" section. This patchset adds support for these AMSes
>>>>>> to achieve greater compliance with the spec.
>>>>> Which board uses it? I would be happy to see that connection between
>>>>> batteries and USB connector on the schematics of some real device. How
>>>>> does it look like?
>>>> Any board that uses a USB Type-C connector that supplies power into or
>>> If you keep responding like this, you will got nowhere, so let me
>>> re-iterate:
>>>
>>> Which upstream DTS (or upstream supported hardware) is going to use this
>>> binding, so I can see how you are going to implement it there in the
>>> entire system?
>> This is for maxim,max33359 Type-C controller.
> Stop deflecting the questions. max33359 is not a board. I already asked
> two times.
>
> Apparently admitting "no upstream users" is impossible, so let's state
> the obvious:
>
> There are no upstream users of this.

max33359 controller has an upstream user i.e., gs101-oriole (Pixel 6) 
board. Totally agree that at the moment there are no upstream 
devices/drivers for the Fuel Gauge (that my patchset has a dependency 
on) in gs101-oriole board. gs101-oriole uses max77759 fuel gauge device. 
I see that there's an effort for upstreaming it 
(https://lore.kernel.org/all/20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be/). 
I will mark my patches as dependent on it + demonstrate the relationship 
of the devices in the gs101-oriole board. Hope that's okay?


Thanks,

Amit

>> This would property would have been present for the connector present in
>> the typec device for gs101-oriole board (that uses the max33359
>> controller).
>
> But it is not.
>
>
>> However, I will be exploring existing bindings to describe the
>> relationship for now.
>>
>>>> out of a battery while operating in sink or source mode respectively.
>>>> The VBUS is connected to the (battery + buck boost IC's CHGin/Vin) or a
>>>> companion IFPMIC connected to a battery.  In our board we have USB
>>>> Connector <-> IFPMIC <-> Battery.
>>> Which board is that?
>> gs101-oriole board.
>
> Then why this is not used? The board was released some years ago, so I
> do not see a problem in using it.
>
> Best regards,
> Krzysztof

