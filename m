Return-Path: <linux-pm+bounces-617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B3800D04
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 15:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D314B20D79
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F53D974;
	Fri,  1 Dec 2023 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTHCJ7J9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B11B2
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 06:18:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so788740f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2023 06:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701440321; x=1702045121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8RrO4FoaaaGIpKIBlp822IXgDc5MJ5eKrP15AFu5kg=;
        b=cTHCJ7J99/TsOegq/UGpX/0kbiX9MUzGt8CH6CO0EYTGr6MoItj9i/d3Aag7zWCCX4
         05mHkG2CzVPOZgC8sUM5I/raAxb55nNqWcJ9miNBR4dF1CiQFQHHSHNGpL1mig6JnQoI
         /NF1rRqcTGr4pTC7eFYUiFSGgB3/CbvTGQvyOWSXDIAXSvgilRsqNkRuGFfklwqmvxrN
         JGK6M5xyRS5DLuKp0EPbgnHhFighdiNLrk3w7I2z+SEMnMs6xbuU2GhekD8YfuvN/mPo
         /7JTfsoDso1XwBM55/ItScXdzy7aSAGlrNK6qbs0UHxyIsWmpYRs5DpScdnnTk4G+NZq
         IsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440321; x=1702045121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8RrO4FoaaaGIpKIBlp822IXgDc5MJ5eKrP15AFu5kg=;
        b=lwtxYRCQss9idJPb+dAvokwpXF2+RHfhUzz4e2WiVpgVMvLWMbJjIcD7EIy8iPCj+o
         zk+vfu+jLPGAILbfvLROCKHoV+s14Qa6amQctPBFAH/CzZ+VS3X0xakjnD9FZSWmszVi
         rmB8nzpiBZQvaJ3D7zdA1ORzSSRk5zfop+DMAA+5ezfKH8zGnEmmG65kUzCVYA18uRvX
         Y8Hj/QXThZ4pMsr5S4TQKZaofrBWJ/0MifdloM0jexc1FzTRwsX/hDaaXfLzYjp0Jd3n
         aGCcr499/gnUUq8//0GOFnWmZntBQPS6dpNux8396+2W/Mx1aEuaK6M3uyddZhqVi5l3
         BXLQ==
X-Gm-Message-State: AOJu0YxVZk6RZw+QZskSdFz+6udUjPTfXNUiE6/+Yt3bdBuEyziUEqAr
	NhwwRbU6zTQGce8ss9dIC+urPA==
X-Google-Smtp-Source: AGHT+IHMUF2faRD2dFneu9yNKGe5qaYqtfmIN0GyHsqaVing5+iOVR0d06qFIrv0e/2B9h13AGOB+g==
X-Received: by 2002:a5d:5253:0:b0:333:3117:c476 with SMTP id k19-20020a5d5253000000b003333117c476mr371163wrc.263.1701440320859;
        Fri, 01 Dec 2023 06:18:40 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:cafc:3e65:338f:2bec? ([2a05:6e02:1041:c10:cafc:3e65:338f:2bec])
        by smtp.googlemail.com with ESMTPSA id x13-20020a5d490d000000b0033333ebd106sm926966wrq.75.2023.12.01.06.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:18:40 -0800 (PST)
Message-ID: <ce110f25-5431-4c80-b037-add7fd7461bd@linaro.org>
Date: Fri, 1 Dec 2023 15:18:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Add support for device tree thermal zones
 consumers
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
 <09de3b1b-b725-46b8-97a6-55776fd5ca45@linaro.org>
 <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <99c1fd8f-4b17-4d4a-87a5-6a65745632fe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Angelo,

On 01/12/2023 10:52, AngeloGioacchino Del Regno wrote:
> Il 30/11/23 14:22, Daniel Lezcano ha scritto:
>>
>> Hi Angelo,
>>
>> thanks for your proposal
>>
>> On 15/11/2023 15:48, AngeloGioacchino Del Regno wrote:
>>> Add helpers to support retrieving thermal zones from device tree nodes:
>>> this will allow a device tree consumer to specify phandles to specific
>>> thermal zone(s), including support for specifying thermal-zone-names.
>>> This is useful, for example, for smart voltage scaling drivers that
>>> need to adjust CPU/GPU/other voltages based on temperature, and for
>>> battery charging drivers that need to scale current based on various
>>> aggregated temperature sensor readings which are board-dependant.
>>
>> IMO these changes are trying to solve something from the DT 
>> perspective adding more confusion between phandle, names, types etc 
>> ... and it does not really help AFAICT.
>>
> 
> I honestly don't see how can assigning thermal zones (like we're doing 
> for other
> consumers like clocks, etc) to a node can be confusing?
> To me, it looks like a pattern that is repeating over and over in device 
> tree, for
> multiple types of consumers.

Because there is no need to add anything. Everything is already available.

Add a phandle in the device node wanting to access the thermal zone, get 
the thermal zone device node pointer name and use 
thermal_zone_device_get_by_name(), but see below ...


>> Overall I'm a bit reluctant to add more API in the thermal.h. From my 
>> POV, we should try to remove as much as possible functions from there.
>>
> 
> Cleaning up the API is always something that makes sense, but I don't 
> see why this
> should prevent useful additions...
> 
>> That said, the name of a thermal zone does not really exists and there 
>> is confusion in the code between a name and a type. (type being 
>> assumed to be a name).
> 
> That depends on how you see it. What my brain ticks around is:
> A thermal zone is a physical zone on the PCB, or a physical zone on a chip,
> which has its own "real name", as in, it can be physically identified.

What I meant the thermal framework does not really have a thermal zone 
name, just a type. So it is possible to find several thermal zone with 
the same type like "acpitz"

> Example: The "Skin area" of a laptop is something "reachable" from the 
> user as an
> externally exposed part. This area's temperature is read by thermistor 
> EXTERNAL_1,
> not by thermistor "SKIN0".
> 
> Same goes for "big cluster area", "little cluster area", "cpu complex 
> area", etc.

Today that is solved with a configuration file mapping a specific 
thermal zone to a name but still fragile as we can have duplicate 
thermal zone types.

>> There could be several thermal zones with the same types for non-DT 
>> description. However, the documentation says we should create an 
>> unique type in the DT and that is what is happening when registering a 
>> thermal zone from the DT [1] as we use the node name.
>>
>>  From an external driver, it possible to get the np->name from the 
>> phandles and call thermal_zone_get_by_name(np->name).
>>
> 
> That'd still require you to pass a thermal zone phandle to the 
> node(driver) though?

Yes

>> The hardening change which may make sense is to check a thermal zone 
>> with the same name is not already registered in thermal_of.c by 
>> checking thermal_zone_get_by_name() fails before registering it.
>>
> 
> Yes we can harden that, but I don't see how is this relevant to thermal 
> zones
> device tree consumers (proposed in this patch)?

Putting apart the fact the change you propose is not relevant as there 
is already everything in. My comment is about the current state of the 
thermal framework.

  - A thermal zone does not have a name but a type

  - We use the thermal zone DT node name to register as a name but it is 
a type from the thermal framework point of view

  - We can register several thermal zones with the same type (so we can 
have duplicate names if we use type as name)

  - We use thermal_zone_device_get_by_name() but actually it checks 
against the type and as we can have multiple identical types, the 
function returns the first one found

All this is a bit fuzzy and confusing. So if you add these mapping 
between thermal zone nodes and names, that will be even more confusing.

Ideally, it would make more sense to cleanup this in order to have 
something like an enum type describing the thermal zone (battery, cpu, 
npu, gpu, dsp, ...) which would be used as a type of thermal zone and 
then an unique name (cpu0, cpu1, modem0, modem1, gpu-bottom, gpu-top, 
gpu-center, skin, ...).




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


