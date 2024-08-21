Return-Path: <linux-pm+bounces-12614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF339598BF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D002815C0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4A1EB119;
	Wed, 21 Aug 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v20JYVoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444681EB115
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232513; cv=none; b=D8Rpjib98McoZoGn1T/mgYEjZzf5261RhIncwZodZ8WBEwmcDnLzR33cnlpEUf2+ua6ltefh0FktzCFgkcGJ1MNrxGuLVaquD7BQ5wEMQ0ytPWbzyCA5rfJKXgP6GS7aQOJRDQaoKF6rX7g2DhcqiAV8ZU1+mppNGMK6kjG6ZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232513; c=relaxed/simple;
	bh=zvxN3FjXrci+M3Au79Tr1g8qeUHqellgUlOM5sW7eHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3Up4Aohr1HUnAlISDTLWcX+KedDR61PIQ2n3j87uEAshDsF4E9Fr+svYbQFxt+zrWt7yg9yol9EzW9CB8hDjNGUsbpVG81UkCpGzcum/23QEn4yyfJP/hmj4874GLO6akBKAVrCnlahuXwhOY1zylqFpkAALEw6czE2HSflrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v20JYVoj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so52354225e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724232509; x=1724837309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0CWM6TldwB/G7hhnmOw+urm2lfCJ/HZX3XwlbBidJA=;
        b=v20JYVojC4og6YniinoxkVQ7VoJ/JxX73HZF0JeNr6zH9EgDD/RffJAl86OzvHymD2
         2ykODtWl0PC0zPhR3rUTnI1TA6UiHgK4sb0Xf56lVZtnG+211+D4+3HEKXLtp91Nozau
         fdXjGV2mhZEvGFIhNv8OFwR47mjlbI12gnoXmpz+VcfMlrvaERcOtwomyk90fC9sD0XF
         ITn9C8GJbX8Q06DhmSOnM/KPnejYQYu135wshZW+6FaIrjIBFtSFcA3F7NpIVJSJsREi
         fJVHIL81KpmC0e/XOHpN7xcwQWMZhrbe9iMJcFwcvIFQQUJgEZ5stagfWh7Gou61L4M4
         yUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232509; x=1724837309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0CWM6TldwB/G7hhnmOw+urm2lfCJ/HZX3XwlbBidJA=;
        b=mtAknk1iIPG0sUGODmsYtPLvozX5BJGpHEg32kFFHfeihL32xcw8JsV9XidTgGngTc
         LCYUBhVPgdQ8c3+GGbP9uPUrTGoWiXdrjKPPc5al8iRzah7lOFmNJLr6nNHVO7LgV9uA
         gwkZyayl4TiwCrLrbNE66tcM9SogUNDgmhUovDrijWHHxkiXT0FeYKo6AJPOSF7VUgCQ
         K/4i5hcCMbtPDzVYBCf5Mot0wkHDS/tlY4uBtGzOBIcyAZXcpt2HmzKybDXVdzGy3y5H
         hTeNTG274Pjy86jbpw1wD0NxRMKbVUxo8VtsqsQ3u1XBNla65NQFFVgNZIS48jiylmdV
         0xeg==
X-Forwarded-Encrypted: i=1; AJvYcCU/93wPveReIrpTF//kKUlKsPLGbyq+yKAk9fhyOTrGtOJWDhETgV1wLuTivmO7wLk/vcWi1gaRYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj24G0BhEdMO8MbTc+PVK5PfxmqUWOdnMNY0WjSJP32Py3RVfI
	eiLPt/I1OC6NUOw9lbLa6hwgxxde2Di/9E7Y+mQsuc9wZtNPySWrxZbiNxH/wDU=
X-Google-Smtp-Source: AGHT+IFWiUpEdl9PpUfq5/3Hho9219oyLHvope2A385ZZW0DQ5cJnXd54/Z4h2VFYZufqAlopqs61w==
X-Received: by 2002:a5d:6349:0:b0:371:a70d:107e with SMTP id ffacd0b85a97d-372fd57f1bcmr1175058f8f.6.1724232509091;
        Wed, 21 Aug 2024 02:28:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189896c3asm15309015f8f.71.2024.08.21.02.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:28:28 -0700 (PDT)
Message-ID: <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
Date: Wed, 21 Aug 2024 11:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: "lihuisong (C)" <lihuisong@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 10:49, lihuisong (C) wrote:

[ ... ]

>> -    list_for_each_entry(pos2, &thermal_cdev_list, node) {
>> -        if (pos2 == cdev)
>> -            break;
>> -    }
>> +    lockdep_assert_held(&thermal_list_lock);
>> -    if (tz != pos1 || cdev != pos2)
>> +    if (list_empty(&tz->node) || list_empty(&cdev->node))
> The old verification is ensure that tz and cdev already add to 
> thermal_tz_list and thermal_cdev_list，respectively.
> Namely, tz and cdev are definitely registered and intialized.
> The check is ok for all untizalized thermal_zone_device and cooling device.
> But the new verification doesn't seem to do that.

If the tz or the cdev are registered then their "->node" is not empty 
because they are linked with the thermal_list and cdev_list

So either way is browsing the lists to find the tz/cdev or just check 
"->node" is not empty. The latter the faster.

Did I misunderstood your comment ?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

