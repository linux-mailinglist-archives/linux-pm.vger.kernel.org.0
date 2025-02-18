Return-Path: <linux-pm+bounces-22288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E790A3938D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 07:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3E16831C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3A1B422A;
	Tue, 18 Feb 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djvu0DZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631981E522;
	Tue, 18 Feb 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861128; cv=none; b=OH6xF3nynBFnboMVRI6t2UIgRLhAH+Dn0Qq6i+iWQa33XIahwOiG4UqgT7Ax32O6u+baSvI8nuYoFG4HLzyhRtdMKNXmkS4KP8Vmdg1I+xHbNXkFxkQt5HVRa0i5VqqQj56GYm8eVDeKXnYEaAMY8/zhcTjzc2dpZOqdAwuLqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861128; c=relaxed/simple;
	bh=JeV9NGTiS5LreF1qALXiBXoNIsC31R6+99vMmtp8aGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctcoQrRl1Z9JB1xuAhCy8Nxa6g9eFogbQbd0KbL8FMVIs+1f+pkkXU8vlGIvllGQLcuyn5kzXtOBKjJVJ2Y3igVqA6OnOQ/JPdyyVHZn8Hsd2bkVsttS0a1+Ka+fFSLVEve0Ogz6il9GTfKjCBhE0ldQo146qr8pQvHEb31ppa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Djvu0DZw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so5108828e87.1;
        Mon, 17 Feb 2025 22:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739861124; x=1740465924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqQUy+TmHlIe2lGS+cxMn2E4zLJa5hzyQ87XCzDVJCw=;
        b=Djvu0DZw2SVxetINmRH7ELr7tv9S30C6IGu62NM7opgmOq2FyM48HYqqRTIQbRXY3+
         GNHlZd738gs+cfjBxX9z3An1ldynlbvs0amfI7YHQeuXl6n+u1hfPUO9h7Wj7OWUrClV
         YkD4EiV/Uk/HQjsf/DJMhcz6LEcVHvaA9qZk2QE3ioDFlYIX1hmhhaOqwkFFXkuv/tMi
         bui4DHm/j35fAt4T2a5DZs1hmGv9EGgSwYrrFVkErK3zaSsW+qElkatZeeJZwDgxkoVx
         nId2zlM1g9nJvB6oLjyhbWtRG4N59gulkhkOpUFA5B/lIEGyy6ptD/r92foeGAVcLAPn
         NinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739861124; x=1740465924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqQUy+TmHlIe2lGS+cxMn2E4zLJa5hzyQ87XCzDVJCw=;
        b=qfBEZj9GaGI8cjOLaoRFjrtz8zIi/bwSD+KLiCxb23PFOx2IH1Rf+OHMl5+F5j5Ux7
         6nU8dqungxL+OosDwyJvFcbmRXWtL6Q38zO05LkYDmLyR+CrxGr+93jL4g43UMcCmfny
         LGyCUuYp3XbGWrdsjQL51VQ+AUyzOD+O0SQvcMORjM8KlBr4EGPnV0jTwgbuvyPYMRA5
         Ha3KgG2bcqgw17oq4G+R8TuIHvEA2F0KML0jbnPYur+Ni8M5Ov3SAcukyOSVJpr0rbiH
         0yQob5HgZTHNId3LgSf2fcWCY58jgbGoqOAuvclZsUnlL2ACA5qtbnFNW3n80jSgY6xb
         jqEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+QXV4m3ez3dUoC2SeWHCLpxcqJpBwaqV8Tfg2eHopBN4RyL20gkmBUr1ZgxiJjL0p3wkKTlt6c/cTX0fxP8w1q+6xDxHR@vger.kernel.org, AJvYcCUbQMLzklNnds7JFWssCGswGuvXTDtRQ3yDYLph+YzwxEypExpMW77uacXVAK+iKwPjOagHAGNLbFos@vger.kernel.org, AJvYcCVA0GnmYKuZ3nq3KN3YcXUCE1X1hLGpOmSLN+PNGppk9jLUSZAYzMjC+MySSKVxwNoOw0TRiixslHoK@vger.kernel.org, AJvYcCXECuciXsZQMl7zJOm0J41J/OLjlGTuAK7kzwlYuwaQMbx6GzwuDjlQyPpyh1xeecSS8p3xPMSbhGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+h2tFO7JdJSd7S6nYkzzX5c8stuVlE2x00//uTzczlX1jvsew
	Z9IKZ2DiIchZmLUNM3g548wVf7g0hUYitTgSBAMcuEeTjN8YhLwiObP/jA==
X-Gm-Gg: ASbGncsBJJzN0zzlLXRZdVgUWqorCS8ChPMiDToPon23MUug1jTklblhtf7GlgMvheQ
	SvYn/OYJrP86BaLpo+yN/5367lXsQPrqzYREbhSGyqRI+gVxXy7qvJ7MV5zqY/xf5IIqywulpZa
	ObO9mFsyyE+fMNW+kv7cfKBUrUyM0+LQBhP/M/J1wTI4PMp2JUBJ9c2AGD2BOO6KEwV5JM0odMn
	JlEjMrHV4UuWBD+L6rGDGAaTkjde6VFyeDwB528fpA4UWuigJPa4UA4EiQbNbk4/Hiwu9+PTy99
	FHBqEv3AOtu1CeQQtfz2qMHkAYS4chFtCCH6NVqI7RZds+55gTdHD21K1N2l4Y/mHGV55Dxb
X-Google-Smtp-Source: AGHT+IEj3If62LMKd4zu2mxufSyaNBZmRoYKgPnZLeAis7jJXTrJ3g3nqNEZsiWpXSyAKIM7D7Y5BQ==
X-Received: by 2002:a05:6512:3ba9:b0:545:2cf5:dc6c with SMTP id 2adb3069b0e04-5452fe8ff00mr3726297e87.51.1739861124087;
        Mon, 17 Feb 2025 22:45:24 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452de0b2f7sm1330302e87.97.2025.02.17.22.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 22:45:23 -0800 (PST)
Message-ID: <48b3e732-b60d-411c-a519-5e89f87eea7d@gmail.com>
Date: Tue, 18 Feb 2025 08:45:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
 <7b6d3226-4422-415a-9146-16c421463ac5@gmail.com>
 <de781a07-d209-4bbe-8945-efcb4490f604@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <de781a07-d209-4bbe-8945-efcb4490f604@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/02/2025 22:22, Ahmad Fatoum wrote:
> Hello Matti,
> 
> On 22.01.25 12:28, Matti Vaittinen wrote:
>> On 13/01/2025 18:25, Ahmad Fatoum wrote:
>>> hw_protection_shutdown() will kick off an orderly shutdown and if that
>>> takes longer than a configurable amount of time, an emergency shutdown
>>> will occur.
>>>
>>> Recently, hw_protection_reboot() was added for those systems that don't
>>> implement a proper shutdown and are better served by rebooting and
>>> having the boot firmware worry about doing something about the critical
>>> condition.
>>>
>>> On timeout of the orderly reboot of hw_protection_reboot(), the system
>>> would go into shutdown, instead of reboot. This is not a good idea, as
>>> going into shutdown was explicitly not asked for.
>>>
>>> Fix this by always doing an emergency reboot if hw_protection_reboot()
>>> is called and the orderly reboot takes too long.
>>>
>>> Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> ---
>>>    kernel/reboot.c | 70 ++++++++++++++++++++++++++++++++++++++++-----------------
>>>    1 file changed, 49 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>> index 847ac5d17a659981c6765699eac323f5e87f48c1..222b63dfd31020d0e2bc1b1402dbfa82adc71990 100644
>>> --- a/kernel/reboot.c
>>> +++ b/kernel/reboot.c
>>> @@ -932,48 +932,76 @@ void orderly_reboot(void)
>>>    }
>>>    EXPORT_SYMBOL_GPL(orderly_reboot);
>>>    +static const char *hw_protection_action_str(enum hw_protection_action action)
>>> +{
>>> +    switch (action) {
>>> +    case HWPROT_ACT_SHUTDOWN:
>>> +        return "shutdown";
>>> +    case HWPROT_ACT_REBOOT:
>>> +        return "reboot";
>>> +    default:
>>> +        return "undefined";
>>> +    }
>>> +}
>>> +
>>> +static enum hw_protection_action hw_failure_emergency_action;
>>
>> nit: Do we have a (theoretical) possibility that two emergency restarts get scheduled with different actions? Should the action be allocated (maybe not) for each caller, or should there be a check if an operation with conflicting action is already scheduled?
>>
>> If this was already considered and thought it is not an issue:
>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> __hw_protection_trigger (née __hw_protection_shutdown) has this at its start:
> 
>   static atomic_t allow_proceed = ATOMIC_INIT(1);
> 
>   /* Shutdown should be initiated only once. */
>   if (!atomic_dec_and_test(&allow_proceed))
>           return;
> 
> It's thus not possible to have a later emergency restart race against the first.
> 

Ah, indeed. I missed this. Thanks for the clarification! :)

Yours,
	-- Matti

