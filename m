Return-Path: <linux-pm+bounces-23487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7863AA502E0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB83B6BD0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1F24A067;
	Wed,  5 Mar 2025 14:52:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10D241132;
	Wed,  5 Mar 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186323; cv=none; b=jJKVeaLrd5cp4N3JS2geIPTz6V0MayTjDAGOoK1pxhzSQYVpTh4sCf3tf9HG/HOpKk5Wj0mth4QB5u3/xASmbLrwvMnzIE7DsYYnhCCIYKvx3MiESE8CyN3KDSSX/gdTh5VZ7vCrTqmSgRU7PMvsrqHQXO5f7OSKx+/5TvtZwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186323; c=relaxed/simple;
	bh=knYV42bhXwD1ks5Zmll1o+tHVVCzKfXDlss+8WojsR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFeKTMu/aKzBz7cHjTcQA5ps9Y7qs/Q+GXu1c8wVzux+2plkvRNoz+X7ud9ZIwhrPgcKlgwlc0URtoT+jC5md/tebz/RfrJf2DCJFTu2bjiGH1fltlRuuhn/rjXsMMDJLnQ7Wtd+3fgXHM0BBTiHJZlcfiFU+WytK+eH0U77yVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76BFFEC;
	Wed,  5 Mar 2025 06:52:14 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F12B3F673;
	Wed,  5 Mar 2025 06:51:59 -0800 (PST)
Message-ID: <1796a9c5-4eb4-4120-a1fb-be773aace202@arm.com>
Date: Wed, 5 Mar 2025 14:51:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Laxman Dewangan <ldewangan@nvidia.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250303122151.91557-1-clamor95@gmail.com>
 <20250303122151.91557-2-clamor95@gmail.com>
 <08f305fa-0dbe-4ed9-bec5-cf8b5bbecfdb@arm.com>
 <CAPVz0n0G+0_f3MONV0Y-tYAb1KOwkUNiY2Pms8CZ6ZGtxRmFFA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAPVz0n0G+0_f3MONV0Y-tYAb1KOwkUNiY2Pms8CZ6ZGtxRmFFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/25 10:03, Svyatoslav Ryhel wrote:
> ср, 5 бер. 2025 р. о 12:00 Lukasz Luba <lukasz.luba@arm.com> пише:
>>
>>
>>
>> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
>>> This implements a mechanism to derive temperature values from an existing ADC IIO
>>> channel, effectively creating a temperature IIO channel. This approach avoids adding
>>> a new sensor and its associated conversion table, while providing IIO-based temperature
>>> data for devices that may not utilize hwmon.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>>> index 12e6418dc24d..4bc2cff0593c 100644
>>> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>>> @@ -30,6 +30,9 @@ properties:
>>>      io-channel-names:
>>>        const: sensor-channel
>>>
>>> +  '#io-channel-cells':
>>> +    const: 1
>>> +
>>>      temperature-lookup-table:
>>>        description: |
>>>          Lookup table to map the relation between ADC value and temperature.
>>> @@ -60,6 +63,7 @@ examples:
>>>            #thermal-sensor-cells = <0>;
>>>            io-channels = <&ads1015 1>;
>>>            io-channel-names = "sensor-channel";
>>> +        #io-channel-cells = <1>;
>>>            temperature-lookup-table = <
>>>                  (-40000) 2578
>>>                  (-39000) 2577
>>
>> Do we really need this change in the DT?
>> Won't the code in the thermal driver that registers a new iio device
>> would just be enough?
>>
>> I agree with Rob that it looks odd.
> 
> Building tree will complain on missing cells property if you try to
> bind it. It is not in required category anyway.

Fair enough, then I will leave it to DT folks.

For me it's looks OK-ish, assuming you add this property with the
comment describing it like Rob asked.

UUIC it will always be only 1 channel - with that temperature,
so shouldn't harm much the design in DT.

