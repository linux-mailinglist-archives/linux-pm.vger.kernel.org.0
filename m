Return-Path: <linux-pm+bounces-36158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98278BDD2FB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 09:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8158F4E10AB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143A31327D;
	Wed, 15 Oct 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzHhYOI7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6172609C5
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514384; cv=none; b=NvJMaGAaIedk0KgUB0Vid9Dh3yWQV+jcedBD0iAOuzOWRcZjQVm7qwUrTa9FS5XPYki0Uuxwp1eps9oTSTB0rzKusy8F7cn1tv5q0spZU/dpoFal5vaYJxpS5Jmt9BE1NvZzQeN8OG+hz3nIgYXsszixMufYBG12eDjQYQVoNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514384; c=relaxed/simple;
	bh=BC15KuwCSg0SviAD2NX9WP0PeUqiSLVuQjRMVITVnHE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UnEySM7picnhsA5aC8vshzYvFfEwgkpBNH2pFOxLKvw6SFaGNv5hVEHa/Bqdyrmgf126eJM/2tSB4AjxuwFGY+YPrmD1S2hPHVxf5OBC3c+yi6xlMUe0cNdIJQSpjl2pKbJKIjiDZLnNvUsfB714yIhub3X73wDBin4YsKl8bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzHhYOI7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-579d7104c37so7532425e87.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760514380; x=1761119180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2MNLLJ09ZFJ09dXhL/1vB6MSlJ3nz18TUtg3KkoHkI=;
        b=PzHhYOI78oHjFm7MZWikF3C2dWia5TEvAGB6Zf+sjI8zY7NICRbYjk7TUk+0AzEBJb
         Aeej+6lL7TiW8itdbiV8URhCJVb1JJg2qPGE6qSFgklAonjoAzWvinCSIcWa1QYKurL/
         AtbFt0+ShIG46QQY8FxAFlo7GJkFgaLz3rEav9MgfDrfFQZ6TmIzYVYajPoHywY+DqYw
         LYlIq8xyVimQp7efUBhlQSi66dl/QfWHmG05JRfqkSm8DdGjPRhjwIobaLz0KWKWQuT8
         yZm9vfB/4LIJCdzFSS2WW3plX0qYsm3a6aa8CVhPzpT2u+4/K03Jv0slBgvT3Tg2qiW8
         5ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514381; x=1761119181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2MNLLJ09ZFJ09dXhL/1vB6MSlJ3nz18TUtg3KkoHkI=;
        b=OXkig4HU3Wc4fUR+JAyJIx9c2RjvTMijpKW3ccIZrKtge0uFRIYEaEqbRhqRcJq3h5
         EY5gIAfiR4ovtfKf3eK4yXNh5zpKOigaXYkudGWVyEowgF1bVuPCv5Nnalt1cNvgh0lo
         DJqrfP+g2dg9ZrWXvSvxaP2YIthGIRDw1TSe+IWrSqFEA+F9ZKS3mxPKaQd8jROXtEmM
         Qg1W82i6aFwQB1utmSonQePbe1txLTCEhETg1e2G7RVktAHqmNwvf1XhU9GPBvXTx/Xa
         CN2yvdQBi6Z529OkyBfALGBT2VgxP1qcA45DEg2TlmgIbFS+K/bojvNXEwFbA8e1KJaL
         ytSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiu9mAqebRbiU/SKsaSZtcznhLk/yFUq3DWav1bqxtEwbbBSLshNOHpFVcwZV0gU+DOF97zjzn7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtfx5n03k6YHKmcw35UOf6a4Hp/SiZ2WUdG83ZJZZg4OJNRqzT
	+DIEx08wcQ1OKhgrqG+4iJfr475XhaEriUasnu8gVUgJN2G/GywLla8L
X-Gm-Gg: ASbGncs6P8v1hQriz0EMJucPRdiMgPyudnBo415z5IvCV4L2+3h+jr1xZcR24gljJVS
	+pnbF3bxAQvr+hXp8kRvg2SvAlj7+dGkj6BL6/7xjHRZBeYYHOzd9pL1gy7iWpE15gra/2At9rh
	pOOmrpTh/oJnBRRlakBwqodM7x8DNKEvZDh1ss+FXUr3Gp8taLpk1ecyRE6UzTLYoy9b3R44rZa
	jNYBGoL7TvuQKLiDRN8KaZ/o3Q4FIs5itbtuzARyIs+DwmQLwaT8qA+l5+GtnwimKb94zh0lIv9
	GSITsj240qvlIQOJW4RskpH+fdhBI9JOevZCZZwodIk4GsVVjhNS6d4PlJB5x8qh+c6idTeHQJ3
	FdudEZ0z/H0RRTJbnbFUMMmUY0kK3hHFpETOQS7gdU2OwjAFbDKitfuZHDCDy3SmEk0fUxhXg4p
	GbgkIIBYbhIdlSA6sam1scRh4=
X-Google-Smtp-Source: AGHT+IECrk7yi+Pwe9pZO4hGvEmNp5pxm/s4OrGMFnEn/EkQ/+8aZDd4HdtIeMunC3aM5IGda/MJPw==
X-Received: by 2002:a05:6512:3b29:b0:58b:23e:249 with SMTP id 2adb3069b0e04-5906d892889mr7308450e87.18.1760514380271;
        Wed, 15 Oct 2025 00:46:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591c20253b1sm1336364e87.79.2025.10.15.00.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:46:19 -0700 (PDT)
Message-ID: <07bd2e21-8631-4812-9021-3d3b2dbc7050@gmail.com>
Date: Wed, 15 Oct 2025 10:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/13] mfd: bd71828: Support ROHM BD72720
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
 <20251009161847.GE2890766@google.com>
 <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
 <20251010150317.07bfdbe8@kemnade.info>
 <d2295506-bf70-4142-8537-0fdf9cb04a30@gmail.com>
 <20251013151900.3e4cc69f@kemnade.info>
 <5ef55577-b8ae-4c8d-a965-ee356c47c691@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <5ef55577-b8ae-4c8d-a965-ee356c47c691@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 08:41, Matti Vaittinen wrote:
> On 13/10/2025 16:19, Andreas Kemnade wrote:
>> On Mon, 13 Oct 2025 12:27:33 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Hi Andreas!
>>>
>>> First of all, thanks for taking a look at this!
>>>
>>> On 10/10/2025 16:03, Andreas Kemnade wrote:
>>>> On Fri, 10 Oct 2025 15:09:07 +0300
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>>> +static int bd72720_get_secondary_regmap(struct i2c_client *i2c,
>>>>>>
>>>>>> Does this 'secondary' have a specific purpose or a better name?
>>>>>
>>>>> I am not entirely sure. When I asked this from the designers they just
>>>>> told me that they needed more than 255 registers so they added another
>>>>> slave address... (I'm not sure what would have been wrong with using a
>>>>> page register). So, I assume they just placed stuff that didn't fit in
>>>>> first 255 register there. But yeah, it looks like most of the 
>>>>> registers
>>>>> there are related to the charger. So, perhaps it isn't completely
>>>>> misleading to use "charger regmap"? The data-sheet seems to be just
>>>>> using "Register map 1" and "Register map 2" in the tables listing 
>>>>> these
>>>>> registers. I kind of like using something which maps easily to the
>>>>> data-sheet, but I really have no strong opinion on this.
>>>>
>>>> just another idea: What about one regmap with custom functions covering
>>>> both these adresses? Maybe that could even be added to the regmap
>>>> functionality, maybe with a 0x100 offset for the second range.
>>>> That way the rest of the code only needs to real with one regmap
>>>> and properly defined registers.
>>>
>>> Interesting idea.
>>>
>>> I suppose you mean something like implementing custom remap_read() and
>>> regmap_write() - which would practically select the I2C adapter to use
>>> based on the register address - and then doing same thing as the
>>> regmap_i2c_smbus_i2c_write() / regmap_i2c_smbus_i2c_read() do?
>>>
>>> I suppose this would mean duplicating the functionality provided by the
>>> regmap_i2c_smbus_i2c_write() and the regmap_i2c_smbus_i2c_read(), which
>>> are static. It'd also mean we'll lose the 1 to 1 mapping between the
>>> register addresses in driver and addresses in the data-sheet. I agree
>>> this wouldn't be such a huge thing if we used offset like 0x100 though.
>>>
>> Well, you could also stack regmaps like ntxec.c is doing (but there
>> for some very weird reason). That would avoid duplicating code.
> 
// snip
> 
> If this works, then I kind of like this. It avoids using the platform 
> data and simplifies the regmap getting in the power_supply driver. 
> Thanks for the good idea Andreas!

Hmm. This morning I tested this approach. I converted the MFD driver and 
some sub-devices, and I mostly liked it. Mostly.

When adding the offset only to the addresses behind the 'secondary 
slave', the addresses behind the 'real slave' (which the MFD driver is 
bound), can be accessed using both the 'wrapper' and the 'real' regmap. 
Assuming the cache is kept in the 'real' regmaps. This is a small 
performance penalty compared to having the cache already in the wrapper, 
but it allows the drivers like the regulator driver, which only use the 
'primary slave' to just get a regmap from the MFD parent, no matter 
whether they get the 'wrapper' of the 'real' one. So, no deviation in 
these slave devices - nice.

MFD gains a tad more complexity due to the additional wrapper regmap. 
That's not bad though. MFD also needs to use the 'unwrapped' register 
addresses for the slave regmap config (ranges and max register). This 
won't get extremely ugly though as we can do some simple macros for 
'unwrapping'.

What I do dislike is the fact that the register addresses for the 
secondary slave will now be 9 bits. This will require some modifications 
in the power-supply driver, which currently stores the addresses using 
u8. The register values can still be 8-bits though, so maybe it won't 
get that bad. I haven't tested this yet.

As a result, I am not entirely convinced, but not totally against this 
idea either.

I'll be away for a bit more than a week, starting from Friday, so it may 
be I won't spin the next version until around the last days of the October.

Yours,
	-- Matti.

