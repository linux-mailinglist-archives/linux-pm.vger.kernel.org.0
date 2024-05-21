Return-Path: <linux-pm+bounces-8026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2448CB007
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE421F23D1B
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324967F48F;
	Tue, 21 May 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3xlynVtL"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491257F49A;
	Tue, 21 May 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300434; cv=none; b=ffXyTj8X3OLfER71Va7Mo5xADUlhf7JJlZOvuFDWvy3VsXUeDn66ixeDSzJOoRyxA2EIPOBurWiTtCbNZKYMqjieEIs2qTrLvXvcevQfqTGbfVWfb4Gr0KkA0CHnn+9bh8ozA9nXZztXsGMIpDzplQlrzRM8B+DEMHYuc/PEad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300434; c=relaxed/simple;
	bh=iTN3E5ypFW2x3wB6NHVZYf1hyLZUS+jIFYgdjtTDJqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzA07z+2BYV1tLIL1hLydM7M0ms/sB12eF+6f7HZkHAN7mZ8jwmVigQ1BtnSsOx5e3lmiBkf3CQT0eTcqsEKpX4o4hxvmBsII0eGTMsIDcHE5wege2VGwNmP3/czU5hnsM3dczRhjhj1GOIgIkiiuISNbXLZLcTHDLeGgdvYL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3xlynVtL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716300423;
	bh=iTN3E5ypFW2x3wB6NHVZYf1hyLZUS+jIFYgdjtTDJqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3xlynVtL435a2SCnL+Q3GSN/PrLLC9nrQnIuenQ6eQpMYp5K2ChKdI2osrnTy5d35
	 h8U1BNl0bkizSNvOmW6MTLZHwp1iWtnoTHUsQVy6Gh0jTyVk/LdT8nc1yqRJTD63h2
	 fsJ3x3nz8oAFTriEZBz7eIk3BI638Z07n5A7AOd+Yv3ZKoVhWTqTy0WH7dRyNKjJu7
	 YTPYIr8SGFOOgNCXUU7/es6PEkhIdQSjGocf6rgaQ7fnlvn6ZTTx131WXNc0S9NaIc
	 i9rdptpBZXmz+K2loULI/VqZ0NRK2hSRMlKbRQVjvwCQABAj2i/oBU9H5dGG64Fo7s
	 90QMBUH1WPN1A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6169E3780029;
	Tue, 21 May 2024 14:07:03 +0000 (UTC)
Message-ID: <f1cc27e1-1aa1-4495-8773-44a1f605be47@collabora.com>
Date: Tue, 21 May 2024 16:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: mediatek: mt8188: add default
 thermal zones
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Julien Panis <jpanis@baylibre.com>, Nicolas Pitre <nico@fluxnic.net>,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <20240402032729.2736685-16-nico@fluxnic.net>
 <aab10d22-b1a1-45e9-85bc-a4334aa6c497@linaro.org>
 <02ac5b07-08fe-4abd-8db8-141f4e47f68a@baylibre.com>
 <26f1f9a6-46fa-4f86-ba46-eea454ba902f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <26f1f9a6-46fa-4f86-ba46-eea454ba902f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/05/24 13:31, Daniel Lezcano ha scritto:
> On 21/05/2024 13:10, Julien Panis wrote:
>> Hello Daniel,
>>
>> On 4/4/24 17:16, Daniel Lezcano wrote:
>>>
>>> Hi Nico,
>>>
>>> a few comments about this description.
>>>
>>> On 02/04/2024 05:25, Nicolas Pitre wrote:
>>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>>
>>>> Inspired by the vendor kernel but adapted to the upstream thermal
>>>> driver version.
>>>
>>> [ ... ]
>>>
>>>> +    thermal_zones: thermal-zones {
>>>> +        cpu-little0-thermal {
>>>> +            polling-delay = <1000>;
>>>
>>> Except if I'm wrong, the driver supports the interrupt mode, so it not necessary 
>>> to poll constantly when there is no mitigation. You can remove the line and 
>>> everywhere else.
>>>
>>>> +            polling-delay-passive = <250>;
>>>
>>> As little CPU, 200ms or 150ms may be more adequate.
>>>
>>>> +            thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
>>>> +
>>>> +            trips {
>>>> +                cpu_little0_alert: trip-alert {
>>>> +                    temperature = <85000>;
>>>> +                    hysteresis = <2000>;
>>>> +                    type = "passive";
>>>> +                };
>>>
>>> You may want to add a 'hot' trip point in between, so the userspace can be 
>>> notified and take an action before reaching 'critical' (like unplugging a CPU)
>>
>> There's no "notify" function in the driver.
> 
> The trip point crossing is always notified to userspace in the core code. It is not 
> driver specific.
> 
>> Do you think it's worth adding such 'hot' trip point, though ?
> 
> Having this trip point would allow generic trip point handling in a userspace 
> daemon to do an action.
> 
> If the userspace does not take care of this event, it won't hurt.
> 
> 
> 

Hello Julien,

I'll push two series tomorrow to add most of the power domains (all but the
img_vcore ones, as those require a bit more work), the two vdosys and, more
importantly, support for the GPU in both panfrost and the MT8188 devicetree.

Actually, if it's not tomorrow, it's going to be on Monday - though I'm not
sure why you feel like you're blocked by not having the GPU node in there.

Cheers,
Angelo

