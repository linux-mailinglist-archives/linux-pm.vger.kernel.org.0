Return-Path: <linux-pm+bounces-17795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C279D3018
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D37AB22DAC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A01D14F3;
	Tue, 19 Nov 2024 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1qSdKMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFD1547FF
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732052451; cv=none; b=tRmLLN7MXc02LYBhNKwBZ7F1w9mm5CHLbTgt/MYGLT3XNxvhrfCtbw8UjIqYxxrILoRSGAm3m2NKpYtH4TWkwKcXZd2AqpgUPMVh2c6s8FI19XaVL6kZYoRNpsh4oscOsxL087kISpz8Fa/crWdkU245jV5poyRkFkLb0HkHUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732052451; c=relaxed/simple;
	bh=HE3n513xHhZThcE6jVMoZF6XwhCQEWW5VGxysIXxWto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBykJUDc/Re5d6smfDZiz1abFKo03Ux8XvAzO7bsOQqJmun3wPMIxiH1A11cVA9kBNcOfjDM+H5pk8aHBuu8ReHd6xEoPktZt+v6LNyzAq4ZNJIa6deVJfo0bjq0Shy89eGZWWblAI/9GxYZ4nWIDm/6DosOsBU7mYZQdHguFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1qSdKMS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso1212265e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732052448; x=1732657248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkxeQUfNljLvLRiRZhalC+n4lyNit8qK2o0nRa/RK2k=;
        b=K1qSdKMSFk3EJ+/mZ8UxMxt7TvsHiFvKVN5P+h1MNR2YD8wt8k0pcRSXQv/dfx57Km
         Au7ku0/giiqrvxDnldqLQvSpKT7TCcyMnLMPXr8BwAq4Vt+btFg5Kv7ebShQNgaGb1My
         7XaJgv3xAQLKAFi9/TzP6aUSALygr5ka8lByTcOV0qURAQ90gVu8aOG6x72tNWrOnrEz
         3/CBq6TvDLjd2E42V8eyxqDwaOYEPg8i3GKUg/PfdH8OXY60EpKU7Om1KviLT1DA342B
         xFpRzdkzvC1yPZYXtOjdZNegamh8rEUfzvEpE7qZiPBfAdu6ckYHi0rOJv4O0QGWLHpx
         iPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732052448; x=1732657248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkxeQUfNljLvLRiRZhalC+n4lyNit8qK2o0nRa/RK2k=;
        b=eHun0sYWweiDI4nTKioKC/tTAEvIyGusEzD5R3k4hK11MqXbAwO5yw1KT8CA05jONP
         gcG5ek06aLPx3SdLP4QJxRyLXYrI7luxyqFjST9Q6K2o3hz3xHOpVE67+wCqxm9QQcLE
         Wp2ctf7ztSydtRRz7BqI6XKfXqa8dNlDElult1CcDeYqJfef/zGinaLg4aEQGb0Yzuga
         1QLSoP/KWEGNI6zPdltC/6ythzrnPrfG4mHCX4XAypQ1vjVhMwbf6773wY6Iz4oHN0Yv
         fTqp33kNRBojbXLqeVat3qWTPWPF+sgknob1y6ATZoKnEAispumN/HF5/llBYmVgnsb4
         CB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVi4Q/UDCKnk1iXIXtKLrppEGUiBSyU4YLYTBFN0UUSkUKBGdUYiknCoOUXv63Hpt0U7uBPP6rTdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvorMWD6spDoy0d6a/BIMJjuToZw6hIoxxPKh7V+KLqfCFsMUg
	pp5niRz51w0Tlw/QXac0Dcsi2z7prh6KcmmIRgHWg3HpCnVQhfdsrCGT8G4LkFI=
X-Google-Smtp-Source: AGHT+IG6bv5/VShXyjrdqEjy+T/UO+kLOX7JIB5cP3VCGPfmzISuivqKLJjNxAIIX4ocGdqh24oTtw==
X-Received: by 2002:a5d:5f91:0:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-3824cb30e45mr4340383f8f.4.1732052447252;
        Tue, 19 Nov 2024 13:40:47 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-382549055f2sm366236f8f.16.2024.11.19.13.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 13:40:46 -0800 (PST)
Message-ID: <cfca677b-bc74-49bb-a031-6f52629edd2b@linaro.org>
Date: Tue, 19 Nov 2024 22:40:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] thermal/drivers/mediatek/auxadc_thermal: expose all
 thermal sensors
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 James Lo <james.lo@mediatek.com>, Michael Kao <michael.kao@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Ben Tseng <ben.tseng@mediatek.com>
References: <20241025-auxadc_thermal-v14-1-96ab5b60c02e@chromium.org>
 <5dd2d2a3-6eff-45fb-8af8-593945235dd3@linaro.org>
 <CAHc4DNKSsrdSjqunhk+oyWw_+oKY9BgzPcqag5QrmLJqjVsE1Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHc4DNKSsrdSjqunhk+oyWw_+oKY9BgzPcqag5QrmLJqjVsE1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2024 08:38, Hsin-Te Yuan wrote:
> On Fri, Nov 15, 2024 at 12:48 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> On 25/10/2024 14:05, Hsin-Te Yuan wrote:
>>> From: James Lo <james.lo@mediatek.com>
>>>
>>> Previously, the driver only supported reading the temperature from all
>>> sensors and returning the maximum value. This update adds another
>>> get_temp ops to support reading the temperature from each sensor
>>> separately.
>>>
>>> Especially, some thermal zones registered by this patch are needed by
>>> MT8183 since those thermal zones are necessary for mtk-svs driver.
>>
>> The DT for the mt8183 describes the sensor id = 0 as the CPU. On this,
>> there is a cooling device with trip points.
>>
>> The driver registers the id=0 as an aggregator for the sensors which
>> overloads the CPU thermal zone above.
>>
>> Why do you need to aggregate all the sensors to retrieve the max value ?
>>
>> They are all contributing differently to the heat and they should be
>> tied with their proper cooling device.
>>
>> I don't think the thermal configuration is correct and I suggest to fix
>> this aggregator by removing it.
>>
>>
>>
>   As far as I know the thermal design of Mediatek's board is based on
> the highest temperature of the whole board. Also, removing the
> aggregator will break all the boards using this driver.

AFAICT, it is not a thermal design but a thermal configuration.

What is the rational of using power numbers related to the CPU but 
aggregate all temperatures as an input to the governor ?

And for example, the mt8173 has 4 banks and 4 sensors per banks, so 16 
sensors. And they are all grouped together under the thermal zone 
"cpu-thermal" with the cpu cooling device.

So if the GPU is getting hot, we cool down the CPU ?


> By the way, I heard that baylibre is working on multi-sensor
> aggregation support, which can be the alternative solution for the
> aggregator in this driver, but that should be another story and is
> unrelated to this patch.

Right.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

