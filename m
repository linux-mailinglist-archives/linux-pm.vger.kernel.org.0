Return-Path: <linux-pm+bounces-8718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C578FF011
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062AC1C244A7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05CA1A0AE9;
	Thu,  6 Jun 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIGotSiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515261A01B7
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685429; cv=none; b=jFMFy4j7FZkY+f9Q8h0uu4YSdVRpev+1WbPjzvDk9kPpUTA4AW8+JBjET0suDlJm1t/9+larnjBmk/XurNLwwLe5ye4SYB+W9+fyBuMyU5kEoaPG2/rETfiXvBjPUrFgW4ozVKVyDuVTeFQPF6KDlZRmL9nsuGw7y1LP3Vq90ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685429; c=relaxed/simple;
	bh=ZvQ1pENygtYl6o/j4xo9oIYijYCQF5WO63/exjSZDws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnkrIEPLtXrMDQhvzlyQn2hnnIhQxxR9v5cFGxKuce01VtpCiFaq2y/6+S2abUbNbWt6ZgnkpQbHNOjMVLdNENsn/8rq0ERCgQnjOUbbNSXinq014LeDLos14a2SbD3KBf/TSG8iYWpigqaUmjcYfSK9E/+m+0QjAuOAp5x7kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TIGotSiG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eabd22d441so16565681fa.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717685425; x=1718290225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eQN39Nkp7zX3QVgBwh8fSEqWjLG+WRfJd6VENywnME=;
        b=TIGotSiGK97J3TK+yfmqtjjNklSBHm66MwWyCUGJXLj+XmQDPe65PDDJm6XcbruucD
         iHmPmpcfG0Rlm6ZVsR2+EvUYW3rZh3X2NKShJ3GkgHtMFlNry/aXUDHfX51C/bAhgAN8
         NOawqkWoe4VUw8T290hGNjFUmxBSYTnnoxuJSfmD6k2Dlsb64pWU7dxJD3YABhZFSzp5
         Wno34xAVdS3rl9Uus8ljaa9cZH3XGZKLOij4v7m8TQs9CQbcleXtNQcrdNJ6TCYCNtx7
         ThkV+eO2NurqGYQWx/00WnDlDlnjg06Hok/M2b5Kyghg/+nitVbiAAjyImR+c0BzQrGO
         ZWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717685425; x=1718290225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eQN39Nkp7zX3QVgBwh8fSEqWjLG+WRfJd6VENywnME=;
        b=UK+e3RsJTKHnMeoIfoqMuOZajdgkCefcl2G5ugFS/AosI//7CFo/gAZ53HC8ZKQEVu
         NpcotwkJ+7HZhGyhK2DwdEYARmo8fcujDJek33yzsGVLbr3qniy1Gp/JeZuQJ1HnaVsH
         rg/d0dupyntweM6v9yKmBnKRbtqu352c0dLw1wY7jVhmRbqLJGe3GCXKOQMTSJdD6lsD
         bLHJVjRQEmRA5gnluhGs6L+JMIJmhbMSYx0mjXru4PYeJJ5c9KqWkGMCzLMCyoVnX8cY
         PcsqJtvNk7ZFGrQnUocFJof5NPo0FFoRuLyqHgIZTUmZnGeeO2l+b4I3Qgkhbx1Uec3j
         XVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUa8W+TTcOLPx28SjNSrGEjuL1kQ8gVMT8gqFNNX2d590M9WWvSFk1JTXk8gKglF483fiqlVLx74UcpmKis65Hgnfun1KNU9Rc=
X-Gm-Message-State: AOJu0YwgCCs/AaGtV+EKBi0OOMNgKvCoBJKvASXYACNWUCPC2DoiQ14i
	S6eZ0vyUUG/srURWSMv5BdaR0NxVpiUwL8300RI3YMn3Sh09AAlHgPk6vPl0L7g=
X-Google-Smtp-Source: AGHT+IHwoVb1UEEad+fTat0R/+JZtULip8B74o83THglv5q5fWQXs+TEQMKY/3pMO+zjn8zJCmDeNw==
X-Received: by 2002:a05:651c:1a2a:b0:2de:ca7f:c849 with SMTP id 38308e7fff4ca-2eac7a7fcd5mr50121091fa.43.1717685425433;
        Thu, 06 Jun 2024 07:50:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6c8070ea54sm106413366b.157.2024.06.06.07.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:50:24 -0700 (PDT)
Message-ID: <90a9df3e-153f-4972-8086-13c21a574763@linaro.org>
Date: Thu, 6 Jun 2024 16:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
 <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Laura Nao <laura.nao@collabora.com>
References: <4569763.LvFx2qVVIh@kreacher>
 <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
 <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
 <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 16:18, Rafael J. Wysocki wrote:
> On Thu, Jun 6, 2024 at 3:42 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Jun 6, 2024 at 3:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>> On 05/06/2024 21:17, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
>>>> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
>>>> to fail probing on some systems which turns out to be due to the _FST
>>>> control method returning an invalid value until _FSL is first evaluated
>>>> for the given fan.  If this happens, the .get_cur_state() cooling device
>>>> callback returns an error and __thermal_cooling_device_register() fails
>>>> as uses that callback after commit 31a0fa0019b0.
>>>>
>>>> Arguably, _FST should not return an inavlid value even if it is
>>>> evaluated before _FSL, so this may be regarded as a platform firmware
>>>> issue, but at the same time it is not a good enough reason for failing
>>>> the cooling device registration where the initial cooling device state
>>>> is only needed to initialize a thermal debug facility.
>>>>
>>>> Accordingly, modify __thermal_cooling_device_register() to pass a
>>>> negative state value to thermal_debug_cdev_add() instead of failing
>>>> if the initial .get_cur_state() callback invocation fails and adjust
>>>> the thermal debug code to ignore negative cooling device state values.
>>>>
>>>> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
>>>> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
>>>> Reported-by: Laura Nao <laura.nao@collabora.com>
>>>> Tested-by: Laura Nao <laura.nao@collabora.com>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> As it is a driver issue, it should be fixed in the driver, not in the
>>> core code. The resulting code logic in the core is trying to deal with
>>> bad driver behavior, it does not really seem appropriate.
> 
> Besides, I don't quite agree with dismissing it as a driver issue.  If
> a driver cannot determine the cooling device state, it should not be
> required to make it up.
> 
> Because .get_cur_state() is specifically designed to be able to return
> an error, the core should be prepared to deal with errors returned by
> it and propagating the error is not always the best choice, like in
> this particular case.
> 
>>> The core code has been clean up from the high friction it had with the
>>> legacy ACPI code. It would be nice to continue it this direction.
> 
> This isn't really ACPI specific.  Any driver can return an error from
> .get_cur_state() if it has a good enough reason.

We are talking about registration time, right? If the driver is 
registering too soon, eg. the firmware is not ready, should it fix the 
moment it is registering the cooling device when it is sure the firmware 
completed its initialization ?


>> Essentially, you are saying that .get_cur_state() should not return an
>> error even if it gets an utterly invalid value from the platform
>> firmware.
>>
>> What value should it return then?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


