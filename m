Return-Path: <linux-pm+bounces-10131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695691ACD8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C1128AA0B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4865B19A282;
	Thu, 27 Jun 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rtn9/wWU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8D19A297
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505836; cv=none; b=bPBiEKYr+bc/BRTueLRwe0Lsfsg80NTqUXZ7k+AlhChX2SYhfDY9REXk9qXVl+yJfoKo7tNNcyFJ2xrPtB/iw/a3vDlk5XQ1mHwNXKecT4BZgdZG/GYxPBDsdMldYc9Z4Ko7kmJ56T10H5aJZmjQNzwXmnEXP98B114+VgkkNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505836; c=relaxed/simple;
	bh=mYxL1hNMD1e8echJ7WgbgoYI3RXACt8zGI0gnw2cwuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq7DK0PyC8qJdQxka4LGFIVgruRTRJ29HU7fdysqpcbuLoX+9Wzn5807mfEoYx8t4s6BDwDAsyyroxK8KF3MSTSeLevF64fh5hbnLXkuGHrrp1cUKN0vaLhFKKWqIdp3/GJyT8Fwg5t41V77zaldgU1Enxfb6rpLZmq1y2jolRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rtn9/wWU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so66075435e9.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719505833; x=1720110633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kf7gTCUMjGC3qckO0PIhUrUOpw3vunxga2GixnZNfU=;
        b=Rtn9/wWUPDaDUXO52JYP3cW7nxw+rCqvYzk2n3W/qLyW+GvZuq5ibvPw9/djNgjZHW
         otYwIQL7tMKZlIG3dhQdySlh2lvrCE3TkP76fY+xXHV70su13ABo07+4n/eQcLMBXxe0
         BYp9+y/QUSS74rOMjpDfRSIjZeqFE+9lYr0FyOHI//7o4+9szCgAMHuZg59tkAXlPJib
         5cq9wYxo3TlkR2HiuAxYtjquNt1065XdwA65U/EW/giDgBQ3019SDEOZBuPq7+auIzw4
         rDGp1m20yRHKWKv5wcOxFbuMHouwWlsSADkdBAzd8d2jVIcRalL/VK3TobTpaq3PvIWU
         v1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505833; x=1720110633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kf7gTCUMjGC3qckO0PIhUrUOpw3vunxga2GixnZNfU=;
        b=eBr+Oz7Ib005/4xdMZMVJwhwzknDHAJLzM/YZ0Gq+jyDY4cxIgnKKN0xUo8RcPTZ8H
         3PhqsnKwdkDMqUsyJ/yBC93e/V/VaR84diTFoh2nqoeVmrjSIM4KOMcd3axjckGzzICx
         PJ+rA4mwBLLIjXKZsjJyQ1BhbZ3y3tvDfv5XpSh/LFfJK6piTlc2W9BsvB2ykEBVsxzR
         A7YEzKQI6j2j84UIwoSKTnsU1hSDU/oJkiMW/P6HluPQr6rbbeeEHQefRj9EQ+u7ui4/
         zXErNGjZQt4sjOalj2r0PmyVZtRB8PZppeZFwNPjaxlbxsAR7SGp1zT5jdarejuRFwqs
         +JCA==
X-Gm-Message-State: AOJu0Yw5UqK2Jv0DiERSRdEuJkDLGroT4pQ0byW3GKRcddif+dHQ/Rt1
	FebatUy68TGsrXH4BLGKcno6+rs5Vd1rtis6HEffKWZXOZWGsEkcsc9hCExTtGVAVxd/qpQms6l
	A
X-Google-Smtp-Source: AGHT+IEtB3n16PquDkTxYLwTUh6UKEPWACCx07LE9MS9qPk0Q/wsXyPKHN5NmiO4YUeSXwqOwZJQgA==
X-Received: by 2002:a05:600c:4f0e:b0:425:675a:d52e with SMTP id 5b1f17b1804b1-425675ad6f8mr10847805e9.2.1719505832680;
        Thu, 27 Jun 2024 09:30:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c8246828sm76576595e9.5.2024.06.27.09.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 09:30:32 -0700 (PDT)
Message-ID: <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org>
Date: Thu, 27 Jun 2024 18:30:31 +0200
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
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org>
 <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
 <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/06/2024 11:54, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2024 at 12:24 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 26/06/2024 23:21, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>>> Oh, I see where the problem can be.  If the zone is polling only, it
>>>> will not rearm the timer when the current zone temperature is invalid
>>>> after the above commit, so does the attached patch help?
>>>
>>> At this point, I went far when bisecting another problem and I ended up
>>> screwing my config file. So I had to generate a new one from the default
>>> config. Since then the issue is no longer happening which sounds very
>>> strange to me.
>>>
>>> I'm still investigating but if you have a suggestion coming in mind, it
>>> would be welcome because I'm failing to find out what is going on ... :/
>>
>> I finally reproduced the issue. That happens when there is *no* cooling
>> device bound on *any* thermal zones.
> 
> Interesting.
> 
>> Your patch seems to fix the problem but I'm not sure to understand the
>> conditions of the bug
> 
> It's probably the same as for commit 202aa0d4bb53:
> thermal_zone_device_init() sets tz->temperature to
> THERMAL_TEMP_INVALID and if the first invocation of
> __thermal_zone_get_temp() returns an error (because the .get_temp()
> callback returns an error), monitor_thermal_zone().  If polling is the
> only way in which the zone temperature can be updated, things go south
> because the timer is not set and there is no other way to set it.  No
> updates will be coming

If there is no polling delay (aka interrupt driven), the routine will 
skip the _set_trips function and the monitor_thermal_zone() will do 
nothing in this case, right ?

Even setting a label jump to "monitor:" the routine is broken AFAICT

> The reason why the presence of cooling devices can "fix" this is
> because thermal_bind_cdev_to_trip() sets tz->need_update to 1 which
> then causes the thermal_zone_device_update() in
> __thermal_cooling_device_register() to trigger and that will update
> the temperature.

IIUC, the first time get_temp() fails and then when the tz is bound, the 
update triggers a new call with get_temp() which returns a valid 
temperature ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


