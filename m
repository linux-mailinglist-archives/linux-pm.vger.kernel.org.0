Return-Path: <linux-pm+bounces-10081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34AF9199B7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 23:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C8628169C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC1192B7C;
	Wed, 26 Jun 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMmmKen0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9916A928
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436916; cv=none; b=BJ4d9IUjV4t2MX3U/klmUam5SNnlGdhukarZqChSY7e8uVi+wOoZ4VwSlx76SDXDPUJab+QJ2egerCdttH9Zz8tr66OmSnu77J4UdyzXXX38+Qdhp2X9+MzTdD7jG1J++JQw91lEVw7Qfh/boD+W0cRmM6sOFoe+GNi/8uXWbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436916; c=relaxed/simple;
	bh=zbZoopFTLIvFftf+fXFccnyGERhP2b8BhdXKLf7uRtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZOpujHNOP4DB8CGdqGLNhlWp9aKH6Puxb/T10vECT/7/T5NOxNojGcB19b8GtoF1PIP/FcAIP6krx9BGihthOb8SzKCKnhg57CgYhYWeaCwmowkJj+dXxW7nm0MEzmisQsdCppPpWnv0Qi/MslLzy/lrX6qICpJbZyqfrQiUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMmmKen0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so7174975e9.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719436913; x=1720041713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAsN5gm3+IljWITvRwxMr4HpRiJ5obqmyq+hfjnkwM=;
        b=tMmmKen0JvafbQVXk5NU1BIFV2BZgRheUIynOcqfQM1z2gasoJDCiSg1/ZXl8gY1ZO
         AxR0gD7LtDEP493D+TkkcvNAnC5PtQ/YnA0Gz/5qOmzxo028zUGpX94OPePrTVh4BdgO
         7cHdnHymfIX3dxRKJG3VI+fDE7rfDdZ+f2t0PtVodQznUFo8w6VspLIcAlc8cYILxd7u
         s3wPByldVuxhjdZQ8ta2bFHHtzRqEqipoafVmhZIr2Ctx1fkb2PsA0PEvWQhYiM7Ihes
         uyzpglrp4ZUaGjy1NLM9yTfO9WNH4n9X/nttjOzCKqr2p37ZSrHIF/4sngvyASrrQx0k
         b7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719436913; x=1720041713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAsN5gm3+IljWITvRwxMr4HpRiJ5obqmyq+hfjnkwM=;
        b=PDOv3o5AYaYjqBIGyQJ46f4dz56TDOh5q6OaAf+g2IwzOoAhQ7hDLv27YLsl+Twzx3
         uTtqkZaPQQa8Z+YISWspQGeijE6j47xjdIzwTfgtJqylqqxjb1PfQoSwP8csraeUUbGh
         TTW7K9YCY4PYMSbVgTilDxptH+UYJZtCwyCMiDtSIK54obZLeJxazPgi4F5vxs9UOcvE
         Lpc22GHkRNVrplZqZspLjTYmiFAtGmUW7fdaAKSrXDqPa7YuNsRwiBPOWOB9CUr0xAnB
         gcMqLT/vmpaXJ9K6OThi+Yo2as5iuhWaOfCimtGmGFzfi5rAdhhN9/HO0HHtT2hepLsb
         9AOQ==
X-Gm-Message-State: AOJu0YzHpV1IU0FrEMAzAAPHPChuBmT0HppkM6HoODsQjyWpGcV8TpBr
	o9YH27qKk7KlCGpVlp+9/H7KNIbGhGmhRkrMylxbqu+PPO5beeKucv+/1Fu8fF0=
X-Google-Smtp-Source: AGHT+IGa0W4d+4IxZJjif0fqJZcxjy78nOB9xrBOMlBxed8egvM3iNEUL04Vk6RD5OPGb9punkr8HA==
X-Received: by 2002:a05:600c:692:b0:421:7ab8:59c with SMTP id 5b1f17b1804b1-425630fced7mr7924415e9.10.1719436913213;
        Wed, 26 Jun 2024 14:21:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c824eef1sm37032485e9.14.2024.06.26.14.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 14:21:51 -0700 (PDT)
Message-ID: <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org>
Date: Wed, 26 Jun 2024 23:21:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trip points crossed not detected when no cooling device bound
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2024 12:38, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Jun 26, 2024 at 8:50 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> after experimenting different setup I noticed there is no longer trip
>> crossed notifications sent to the userspace when there is no cooling
>> device bound to a thermal zone.
> 
> I think I've seen those coming for zones without any cooling devices,
> so it seems related to the setup.
> 
>> git bisecting leads me to this commit:
>>
>>
>> 202aa0d4bb532338cd27bcc64c60abc2987a2be7 is the first bad commit
>> commit 202aa0d4bb532338cd27bcc64c60abc2987a2be7
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:   Tue Apr 30 17:45:55 2024 +0200
>>
>>       thermal: core: Do not call handle_thermal_trip() if zone
>> temperature is invalid
>>
>>       Make __thermal_zone_device_update() bail out if update_temperature()
>>       fails to update the zone temperature because __thermal_zone_get_temp()
>>       has returned an error and the current zone temperature is
>>       THERMAL_TEMP_INVALID (user space receiving netlink thermal messages,
>>       thermal debug code and thermal governors may get confused otherwise).
>>
>>       Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing
>> notifications at init time if needed")
>>       Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>       Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>       Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>>    drivers/thermal/thermal_core.c | 3 +++
>>    1 file changed, 3 insertions(+)
>>
>> -
> 
> Oh, I see where the problem can be.  If the zone is polling only, it
> will not rearm the timer when the current zone temperature is invalid
> after the above commit, so does the attached patch help?

At this point, I went far when bisecting another problem and I ended up 
screwing my config file. So I had to generate a new one from the default 
config. Since then the issue is no longer happening which sounds very 
strange to me.

I'm still investigating but if you have a suggestion coming in mind, it 
would be welcome because I'm failing to find out what is going on ... :/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


