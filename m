Return-Path: <linux-pm+bounces-2458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FB8362AE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41771C23117
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CC3A8F4;
	Mon, 22 Jan 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfMsE6Yr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2F3A1DE
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924519; cv=none; b=X19Jr6APLtocvcgskBJdc8CCqHNvnAYBjCE1+CYvSuut8uoJaGb5mMBXwdum9ontrbsFFge2O5swplOG8R1COCZs3QsZrtgyOkrrIBi5iBJNlx/KsT2QUpxv8tYW3kFcOuYt4XUlRxy29CXV1635HCHlkrwVQkMWKAVcPNUl/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924519; c=relaxed/simple;
	bh=mOu5476Nn5BP/+EF52RGXEFZliGnk2XXHNAsjGbkH/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYQb990jMCptq8f6spPElClx7XgnVtbruRNONIsUDNGd0P6MqkRpbtkREgQV8xp6cknSmz5V0i7+nJKgWMTDtMtGVzb2ml9rhx4rmtxJOwJE5z8cPvTb2wt0QxaaV6m1vmtxXtLFaPsIA3iKxRNFQ+/dWZZDIi/PcO3kDsqMhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfMsE6Yr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337d90030bfso2714697f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705924516; x=1706529316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mafzyGGj5CNasM+3Z2mj+NKeLuio3ZouOIp2Hx28IOI=;
        b=KfMsE6YrIwJTNfS2niE31cdsGrxvw+M2aiq0Ijk5vKwfoZ2zkZieEMj8W6DilC/5KP
         j23ALeziOVAp8DKbnKNVBNTMu3VmjL1gIiTZYHVnZtLWLZrWgvxlq/3NuvAPmyvuyJyX
         LX9/UH3Gt4MnXjgoK/FaM/hUt/ZfeZnV/Tt4cuFJB0ny9JEEAhU4942wjRlHKgZ/zDqF
         nUC+pCS19nYhZ/03XqLYGhNofbLYpFj1SesSOQvIcV2GrXSMRh/5iAhGly/Qs6W75cqB
         OXWxEgJSZ8x4/SIvuPDqBKVm1/DJXH3KmnClLv/oL60Vxdi5LZ26cwOzTbOEOMjol41y
         UpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924516; x=1706529316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mafzyGGj5CNasM+3Z2mj+NKeLuio3ZouOIp2Hx28IOI=;
        b=vDhn0AXcWg9mh9MKrxSqdKut5gc+EqfldXHE2SF8VV8txA9uzElBPBFEncp3l1X6Ks
         h4hcqwPCIhIh6sf8dfBfqObQjyKU+abl3vVnB7COQEktCwIoUF2xFTVx9fFdX7yIFJl5
         CXXAoaPGaPSXUa8n1H/7inG9IK7MdfXWDFrZDvpladTGfV2vBFz9cWmcLcVdNzh+dPvI
         GCYrAFBrcASgkY7pQ4jrMxxumNSjHRiSFUifAxEFKg/WkCZQlCJxyddVQdSfDv43XvVc
         t76e03XbJ5Cm5VEAws+uhEkkGj4KCPZE5W3M8AMIMJZINL0S7CY6vleXH3QEydWbGlMm
         Rihw==
X-Gm-Message-State: AOJu0YxTuiqJYPOAlMhK241qdvCVBqkdA5VnnpC8kmyIDaqm5eP8G2Lq
	xwP3lgSOPR8Pv8SukM/idG9xRHkKbRX6WTYtnaF1Q6pl+urp73R6L2L7MTe7ovQ5igFzz6TO31W
	P
X-Google-Smtp-Source: AGHT+IHYDdCFGiHYc/0mR2bMrKLJZ1weP7RYtOKBgymwNO5mom7duGY8EQKG+dLMD6MHnP7tkjodzQ==
X-Received: by 2002:a05:6000:1542:b0:339:2bbe:eed5 with SMTP id 2-20020a056000154200b003392bbeeed5mr1035670wry.230.1705924515707;
        Mon, 22 Jan 2024 03:55:15 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:371e:2a86:62f0:bc48? ([2a05:6e02:1041:c10:371e:2a86:62f0:bc48])
        by smtp.googlemail.com with ESMTPSA id a17-20020a5d5711000000b00339273d0626sm6490021wrv.84.2024.01.22.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:55:15 -0800 (PST)
Message-ID: <f0805135-6b4b-4691-ae97-d3f995e52e88@linaro.org>
Date: Mon, 22 Jan 2024 12:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] thermal/drivers/mediatek/lvts_thermal: allow early
 empty sensor slots
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-pm@vger.kernel.org
References: <20240111223020.3593558-1-nico@fluxnic.net>
 <20240111223020.3593558-9-nico@fluxnic.net>
 <9d8100dd-11a8-482f-83a1-85bfc34f1746@linaro.org>
 <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3047p728-p0pp-9qs5-qnn4-95s23qo2735n@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nico,

On 19/01/2024 17:53, Nicolas Pitre wrote:

[ ... ]

>>> +		skip = lvts_ctrl_data->skipped_sensors;
>>>    		lvts_sensor[i].msr = lvts_ctrl_data->mode ==
>>> LVTS_MSR_IMMEDIATE_MODE ?
>>> -			imm_regs[i] : msr_regs[i];
>>> +			imm_regs[i + skip] : msr_regs[i + skip];
>>
>> Overall the series look ok but this changes is hard to understand.
>>
>> Could you propose a different approach to have the resulting code easier to
>> understand ?
> 
> I'm not sure how I could make it simpler. Maybe a comment is in order
> though?
> 
> The sensor controller has 4 slots. Those slots are accessible either
> through imm_regs[<slot_number>] oe msr_regs[<slot_number>].  If, say,
> slot 0 is unpopulated then sensor 0 (i = 0) needs to address slot 1 (i =
> 0, skip = 1), sensor 1 is in slot 2 (i = 1, skip = 1), etc. Does this
> make sense?

Why not keep the sensor id = slot id and declare the ones which are 
disabled with a mask?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


