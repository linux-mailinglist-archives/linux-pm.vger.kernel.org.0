Return-Path: <linux-pm+bounces-12637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164B959B19
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C845282965
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019519F46E;
	Wed, 21 Aug 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiZzbWix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B9199FD7
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241374; cv=none; b=shTm0sz6MJO8lPvFTOUgQciiI+sKpsscEl2mhHlF7ntl2YV55owaqsLxPPXeIPHGfPICjyDAfhrPBRX5UsszS6d4IxDKff+o0jKWiDZuYf6uNLp4jc8k6Z9xGxdoKXJoyCidTUZHic/R6+98zDjNGL5NVUxHRqGphiBdDVN/N2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241374; c=relaxed/simple;
	bh=X3QTt06ZPlEFG0ggW40B36+MBYRU68cM/AweCMu3aS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS4vl3x7/0339HxLMFD4YJqcOJ4dGmOuouM0+sUyocfHTkLFR4VkE2fJkpH4C/ttdv1xPofR8ImWvIbFfz9pus9HUtp0WEkBb1SoIEHw88mxjTHTrWCA/2qd5TLA6PpubI9QDhWJtWEf0rUeOdhpD/4ou0ETNgpw/KHzUJf2GJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiZzbWix; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3718acbc87fso3569681f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724241370; x=1724846170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLRc2YOZCfMRGC9RWlW0UoA1di0uC0RC1vdzrS0l0Mk=;
        b=xiZzbWixfRtH4p1Jlj/mESVhzxpQcxhB/UQTma289BSSs6nxDM5o3n06c6myzDO3cB
         eIfSn91Ljvbz9lTEPc3Fjey6er5i9qETnOgwrnkOnDZtxtcmiwTuYtpfcalx/Zd8iP7p
         EsoUyC4vLgspp1QFR0imvcKstBh8X8JbEYK77WCuQ5djO51DXuvyDQ0NGDTDrm2yVlnb
         TJdgnhNA7GL7osVZC5O3SajQXbCvxpH/7b9Fs6FgX4ArcdUiIJnvVWJ07Jqnj911JPrG
         Uy7i/HOG57ST7Q1G6BNgZqpEvpT3z+HWGdNQHobMCBsMb6mHCYJf/eoeqdLBBDuS/DRW
         qwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724241370; x=1724846170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLRc2YOZCfMRGC9RWlW0UoA1di0uC0RC1vdzrS0l0Mk=;
        b=qpaUIswK7AfCT/5GWon9RTRaV2oK2QEEvhj2gmQPCWDbU5NC33LLb7ThYZqbbpjFti
         5MUpQu3JG+fhBUqy/8f4eHYx0T7IzPBdxlxtPf54rdIE6qGzwlYJEzM+ZlPBfkJRKRO1
         kBMCp6EHbVdL+ciX1PZ22HE9z2Px9DDnKDdW3/Y3Mm8gV7Kz5pA2d76+A95Fhg043k6f
         y7LsSf4ez2fi83NY12CqrpgogC2P5jtLWOVwSSgqGmj33STNdbPt31FB1XZY8qEolwps
         gCwfh6NEK0WDJYvh6WQpkrHKSXCLvASNBJqkJxZamE4KlRgf+FaFJGRCiwdFEJEkUUc4
         DYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVEIJrn6PYjY8Kbv6au//4w70cXZ5KRgZ7tcsXdBE2bJs0s+ZpZuW5Daevocku/WQsyCN4Ljn+/FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+oc61JkL/KkSZIHpVzxVGRKsXeymiEB9ttMCJqwGIiQjhyY6
	2ci3oM+CqGt5U4fG8tSFALJ5IUi076nqgUSM0xQIqUasdp7m5i4CC8+MNO1UDfGHhNuQWHLv0h2
	S
X-Google-Smtp-Source: AGHT+IGw6cpMHi9itIY0JNP0g0swHOu8yw9cp+tSN4XfqU/gzjfG1u2zLD0W70uTXB5NGbUwMZ5ywA==
X-Received: by 2002:adf:e802:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-372fd5769c1mr1284058f8f.13.1724241369999;
        Wed, 21 Aug 2024 04:56:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718984980dsm15517785f8f.40.2024.08.21.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:56:09 -0700 (PDT)
Message-ID: <4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org>
Date: Wed, 21 Aug 2024 13:56:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <10527734.nUPlyArG6x@rjwysocki.net>
 <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
 <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 13:11, Rafael J. Wysocki wrote:
> On Wed, Aug 21, 2024 at 1:01 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/08/2024 17:52, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Because the trip and cdev pointers are sufficient to identify a thermal
>>> instance holding them unambiguously, drop the additional thermal zone
>>> checks from two loops walking the list of thermal instances in a
>>> thermal zone.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I'm wondering if the thermal_instance 'tz' field could be removed too ?
> 
> It is used in a debug printk in __thermal_cdev_update().  If that
> message can be dropped, then yes, but that would be a separate patch
> anyway.

Yes, I don't think it is really worth the debug message here


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

