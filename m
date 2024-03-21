Return-Path: <linux-pm+bounces-5178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485A8855D3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 09:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F38282B5F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3956B76;
	Thu, 21 Mar 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pRVpFsJf"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F025646D;
	Thu, 21 Mar 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009984; cv=none; b=CFH3/PPPEdQrp7nMv5Yi+L2GLCECAFgngWzfn8eFVPkQJI0gmOgjtCE5zxfW8JiN3AkyYJWx6o2ZpCjb9E56PIUlKLrDRXQglL2yyO0zSCTeHemkJucEnfA7148VPa+PvDokOYTKLPBnyca/CBOmGcx6jmjFFfrEvtu6fpQGhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009984; c=relaxed/simple;
	bh=OYKB5vkSZXRayTHG8PtislSXGdVPY2nozhkEeUlG9QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVCLeR+k8LKUeiR9NCGL2tWE5Z+Lu+ijWEYOxkifQvWgvOgnMLZHYMYqjmML8VznZmqklLYuU0gMlUpulaaagGLONZLOSaT9wiN5LCi9SqmK9XHKj25cdq+bY6z6we/Kcept67L3eUvgwKos0/tEoYPizNIDD5FmaWITf7RyRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pRVpFsJf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711009978;
	bh=OYKB5vkSZXRayTHG8PtislSXGdVPY2nozhkEeUlG9QQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pRVpFsJfZOThpCw6XP29z0mkjKLuJ7HyW4QHRzz/4T/O8APO5WDuCyUwY2xlIRUo7
	 0anoEjGURQ8gsGJJJM5XjGS0klQkLjMqUUcMrAj4Vh5TcTIjsConOef3dDVUhkabYI
	 vXx+8L2hAbgqkYEI84ybHrJEwvqrMKRu58GirLcfar6EpedIyhFlfY2+QpmzbuAE34
	 VYayZtNT3DbO1Tf2IP+u6eB+nIv+ea1V9h6dkBDrK1GxG1aNxTVzI23t6MKGoGTZVG
	 cdiV8lI4ladherX3oAX22vNEzllAlz+tGh/rMsZ8c4TNi25ooZ3pZX+mp66AuNEzOX
	 2Erhd6lsIE2ag==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE95537820EF;
	Thu, 21 Mar 2024 08:32:57 +0000 (UTC)
Message-ID: <0b5d8e55-216f-4456-b28b-8aec47b4105e@collabora.com>
Date: Thu, 21 Mar 2024 09:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] arm64: dts: mediatek: mt8186: add default
 thermal zones
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-9-nico@fluxnic.net>
 <34e75ebd-b01c-430a-a051-47489492c189@collabora.com>
 <ron9o4o3-qror-o1o9-3911-7189925o1os2@syhkavp.arg>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ron9o4o3-qror-o1o9-3911-7189925o1os2@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/24 22:52, Nicolas Pitre ha scritto:
> On Tue, 19 Mar 2024, AngeloGioacchino Del Regno wrote:
> 
>> Il 18/03/24 22:22, Nicolas Pitre ha scritto:
>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>
>>> Inspired by the vendor kernel but adapted to the upstream thermal
>>> driver version.
>>>
>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8186.dtsi | 236 +++++++++++++++++++++++
>>>    1 file changed, 236 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> index 7b7a517a41..9865926459 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
>>> @@ -13,6 +13,8 @@
>>>    #include <dt-bindings/power/mt8186-power.h>
>>>    #include <dt-bindings/phy/phy.h>
>>>    #include <dt-bindings/reset/mt8186-resets.h>
>>> +#include <dt-bindings/thermal/thermal.h>
>>> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>>>      / {
>>>    	compatible = "mediatek,mt8186";
>>> @@ -2115,4 +2117,238 @@ larb19: smi@1c10f000 {
>>>    			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
>>>    		};
>>>    	};
>>> +
>>> +	thermal_zones: thermal-zones {
>>> +		cluster0-thermal {
>>
>> Please use the names that are expected by the SVS driver.
> 
> And what would those be in this case?
> 
> I've used the names that were suggested here:
> 
> https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/#m05936e84a2efe5c431bad39c24d66c246fb8ca38
> 
> 

It's always the ".tzone_name" member of svs_(socmodel)_banks.pdata, with -thermal
suffix (drivers/soc/mediatek/mtk-svs.c).

Making it shorter for you....
performance CPUs:            cpu-big-thermal
low-power CPUs:              cpu-little-thermal
Cache Coherent Interconnect: cci-thermal
...and GPU is obviously      gpu-thermal

Cheers,
Angelo

