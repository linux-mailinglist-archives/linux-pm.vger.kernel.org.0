Return-Path: <linux-pm+bounces-26022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453DA9877C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 12:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B2E7A8838
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CED26D4D4;
	Wed, 23 Apr 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GYQmfbjR"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB8275844
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404292; cv=none; b=M+7pLfm7EUf7DLDEudhhePtIZ6RtV06PYTk1EE+ZVsnWgzR+nMtBcFZvkdY9GBdx62bPieGtmmweYmekJKzH8PZSIBm3ZPNerko2/xxs/TA1RQefv9LDtOWoQMheNNIeg4ytv/4szCO7I0oDKskLAtY4QmNH1QR7bmu5zwuadqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404292; c=relaxed/simple;
	bh=2MOPD1NtJjgVsrkU9nVN0H7gbMjIGR+VdbWECswCz20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU267N7qyyzYBLKevRUiYbxohHpGvnF+forb9+s7SQhQm2ywQfxq26ArPN8fjeUth2s8TwNWL0PjzI7UoWh5wqqR00sxg4n8yfpDHAxEfk0pxJdasoGealWk5vA006OApGzS6EbqzdfhVRu44KubM0xhs23tbeuXtmSYgs7yo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GYQmfbjR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745404287;
	bh=2MOPD1NtJjgVsrkU9nVN0H7gbMjIGR+VdbWECswCz20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GYQmfbjR6TCGVUI2c8dGCF8FIN7PRJn1iy+yUvHmasoaJbM7hUjT7M+9QxCd4JyTy
	 NiF2tLE0R7BILbzvHWa/L2uNu30ZiMdF613BgqCqQQdjomjIpoSAyWPj+Yd9P28mp2
	 1gyXwpUoQz/Khb3EVDPOkhYd4EKlGDXpkYSt5O0kGa3pXAIXNJl/RWDS47VVLHR6rw
	 ITA9mkU4QjJdhQagldE/OklTC5T2gs+ZQTQdpcYELSfCw9maLHKhksH34ShfU612at
	 WjHDDhFazs09Rhkmm047l/bQ4D5mz+fWZsSyTl9eA7ac/znxZWKVYYsezb8jIkQZye
	 3K0gMPSdc9HDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F57417E0C10;
	Wed, 23 Apr 2025 12:31:27 +0200 (CEST)
Message-ID: <2ddff946-9c4c-4fb5-a8e7-b2fc413ae281@collabora.com>
Date: Wed, 23 Apr 2025 12:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip
 points
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz>
 <dcc62684-0579-4d03-a430-d4a276153ca1@collabora.com>
 <85710oso-p1pp-647q-498p-23583s7nnn45@onlyvoer.pbz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <85710oso-p1pp-647q-498p-23583s7nnn45@onlyvoer.pbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/03/25 19:30, Nicolas Pitre ha scritto:
> On Thu, 13 Mar 2025, AngeloGioacchino Del Regno wrote:
> 
>> Il 13/03/25 16:43, Nicolas Pitre ha scritto:
>>> Provide the "switch on" thermal trip point to be used by the power
>>> allocator governor.
>>>
>>
>> As far as I know, the power allocation is not supposed to be
>> SoC-global, as that does play with sustainable power values...
>>
>> Sustainable power depends on multiple factors - besides the power that
>> is actually sustainable by intrinsic properties of the silicon, this
>> mostly depends on the PCB that it is soldered to.
>>
>> Translated, this depends on the heat capacity of the copper layer(s)
>> and of the eventual additional passive heatsink, which is a physical
>> property relative to a board and not to the SoC by itself.
>>
>> ....which means.... that those nodes shall go to board specific devicetrees
>> and
>> not to the SoC devicetree :-)
>>
>> Unless I'm wrong - but if I am, please explain why :-)
> 
> I agree with everything you wrote above.
> 
> But this patch isn't about power allocation. This is about temperature
> thresholds. And temperature tolerance is rather SOC specific, no?
> 
> 

Sorry for letting this slip through the cracks - that wasn't intentional.

Agreed that temperature tolerance is SoC specific, but that's taken care of with
the other trip points, so that's not a concern here.

On the other hand, it's guaranteed that the SoC can "keep crunching numbers" at
full power when the CPUs are at 68-70°C without entering any actual danger zone,
temperature-speaking.

Remember that a machine may be designed to keep it at even 70°C for a prolonged
amount of time - depending on the cooling solution.

If you're doing this for a specific board, I'm happy to accept the addition to
the specific board (file) that you're doing this for.

Cheers,
Angelo

>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> index 338120930b..262eab8fd3 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> @@ -472,6 +472,12 @@ cpu-little0-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
>>>    
>>>    			trips {
>>> +				cpu_little0_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_little0_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>> @@ -510,6 +516,12 @@ cpu-little1-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
>>>    
>>>    			trips {
>>> +				cpu_little1_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_little1_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>> @@ -548,6 +560,12 @@ cpu-little2-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
>>>    
>>>    			trips {
>>> +				cpu_little2_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_little2_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>> @@ -586,6 +604,12 @@ cpu-little3-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
>>>    
>>>    			trips {
>>> +				cpu_little3_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_little3_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>> @@ -624,6 +648,12 @@ cpu-big0-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
>>>    
>>>    			trips {
>>> +				cpu_big0_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_big0_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>> @@ -658,6 +688,12 @@ cpu-big1-thermal {
>>>       thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
>>>    
>>>    			trips {
>>> +				cpu_big1_switch_on: trip-switch-on {
>>> +					temperature = <68000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>>        cpu_big1_alert0: trip-alert0 {
>>>         temperature = <85000>;
>>>         hysteresis = <2000>;
>>
>>
>>


