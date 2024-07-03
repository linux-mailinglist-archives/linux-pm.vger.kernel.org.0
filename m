Return-Path: <linux-pm+bounces-10547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E29262BE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66211F21E90
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C6139D16;
	Wed,  3 Jul 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1o63krl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEF1DA32
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015236; cv=none; b=bPK/uA5+0YprEgSLcE0R3rZeYTG6lPTd1TBS95lBhRZSUpDQEFD/weCNFwDlfAg4PE16amaUFMphEg0iPy4PtRU+XrH8mwyuL+cbXkngPJgZxkNd2yTCHB8O3zoCaGOs61Q8B/9QxBvBvV1JHwr5q/HIPzJSVm13Ihh4gGcL+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015236; c=relaxed/simple;
	bh=gtHg+fhWTCT5t00ym5mQRgobrrouh6//u8ADJqModEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ldf+hMbqmoJOIW8t/9oynIyqs6s+yAVp5w+O2k2erb2etHzBFIv6kr9Wjb+eHNs/a8FtNV98oUWjDT/7vNDO5HTCmggLgrKYhWk+HTn3ZFkDm8lLSbVBK5Cs48I37pfuT0kHb+57F30g77/qWgRrEpkRaI+lmWIHWzfho7oXyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1o63krl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so428607f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720015234; x=1720620034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Umv9yiRU+omL+0ilB9pN8nKbjgKXfIcuYwrR5A3ZEYc=;
        b=w1o63krlvTm/JG9KTaGNTeIyYlEWaFFpMSxLsGZRh64YuDC0UBJRi80+wYJ5HrgQOO
         QraLHQkVWFA2OZlILXXnOkjlEX2FPRX0D0SM/ThGuuHvaKsODr+j751AXpc+hurIehKC
         J0II9MJMY/URFxJ+tEb0SEISwXCnD24+OJp+n0fCYJ+9gbbIu0AnwrffPbNC5d7Rh8Om
         hKEdP2t7DSWVGGLmWshyvLqfhwqH7cR/J1OwqsA61W1xwXQqUcmrxe5m8F6HBQzwISOJ
         UsTmvTJuiE6wLoUn3Cwi09m8k7j0wslf0QNpKmIO/ptUNDA5J4iYofdBShMQGGpBEhDb
         /Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015234; x=1720620034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umv9yiRU+omL+0ilB9pN8nKbjgKXfIcuYwrR5A3ZEYc=;
        b=vBYRlp5s2KvzL6djxYR27ZvsOBzgzjLiDmiA5diLZNXx5J805TBsZplqJTAHfvXuAZ
         4RmMbICUN3bWHRhWyCVQucwjm10wUYVZJSSyLSnCDyYGE4j91CAZo54Yyh4WtLi7QFfM
         4zfAVAzfouuGOzQZYayGn3CNXRW5ihQ/lV77WmRhMzqrbQH7qsZqou/Jpnbz8EmRd2sw
         43VY1xjIOtuTIDbaS1L0t3ih4wcAc6m1rfIE7a660NZNEw47nd0R1QTrIsu93M5u4IFr
         ItLx/cMQq2lUqczipmwVIh9qzWPCFiREow3f+2e2GUAPyKimOpT66o2cASlJFQvVVcWt
         KyTw==
X-Forwarded-Encrypted: i=1; AJvYcCWOi/b3r3ZsvyPuHgclBZSKfa9A9ZjPk4bpmiYyL9NVFEk4GZQksi3M55rwlik2oDWLIAvkpduLk1H/Ug/zwG/44Sb/dIKaT00=
X-Gm-Message-State: AOJu0Ywqb0jycj41FEPIVQXXzLwjazdWH50wt8w14MJ6pzp87HsXFUFE
	bIC3GTgeZy8bLZLfUFXHGj6hC0ZbrXDaeHbFj/iE1HerdDQPd0kO3wLo44pmdfU=
X-Google-Smtp-Source: AGHT+IGMQ9qtNvPvtq/beeHsghJ67tCO2WfXdsV6AnqIVKFFGTng3VkPBI3s0SPGnhqQieqd24h1WA==
X-Received: by 2002:a5d:4705:0:b0:367:9048:e952 with SMTP id ffacd0b85a97d-367947a3744mr1454176f8f.18.1720015233635;
        Wed, 03 Jul 2024 07:00:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0cd6e5sm16003812f8f.4.2024.07.03.07.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:00:33 -0700 (PDT)
Message-ID: <15b67ce6-3238-435d-ad28-7c06efbe9153@linaro.org>
Date: Wed, 3 Jul 2024 16:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <2764814.mvXUDI8C0e@rjwysocki.net>
 <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
 <8d91a3c1-018f-495b-83be-979b795b5548@linaro.org>
 <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12c5c133-9519-4a26-b9a3-2da1d3466e94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/2024 14:43, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 03/07/2024 14:25, Daniel Lezcano wrote:
>>
>> Hi Neil,
>>
>> it seems there is something wrong with the driver actually.
>>
>> There can be a moment where the sensor is not yet initialized for 
>> different reason, so reading the temperature fails. The routine will 
>> just retry until the sensor gets ready.
>>
>> Having these errors seem to me that the sensor for this specific 
>> thermal zone is never ready which may be the root cause of your issue. 
>> The change is spotting this problem IMO.
> 
> Probably, but it gets printed every second until system shutdown, but 
> only for a single thermal_zone.
> 
> Using v1 of Rafael's patch makes the message disappear completely.

Yes, because you have probably the thermal zone polling delay set to 
zero, thus it fails the first time and does no longer try to set it up 
again. The V1 is an incomplete fix.

Very likely the problem is in the sensor platform driver, or in the 
thermal zone description in the device tree which describes a non 
functional thermal zone.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


