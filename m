Return-Path: <linux-pm+bounces-40894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FFD22355
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 03:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01209301C5D2
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63F283121;
	Thu, 15 Jan 2026 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3nj12qmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E72765C3
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445920; cv=none; b=cwVtK9IveQN231ShKEcLV67K2rwfGp6/zEW3qDe5rljvoCUwmsPYAv9WATbFbEE6sqPWxKLMYFyVlpBhVliMP3BiWGfJjPK7BvQHvhW/MS3fOLOO11xvUokbjJ/yCWpcsiWix2VgGpqKVzzOwWbLOU8HDaGS1bQ7MXCG0C1uTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445920; c=relaxed/simple;
	bh=U36MjnGwIqmX426S+4zCEmT2xMyM2BYEy7olv+4fZwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vERAhlMOwWA2r74Dl0Up4vLzPLHcjqd5Syp8cLYT1ghb4JqTOaZ41g32JhxO2/s1pRqlKvlMKa49C9c3sfjkReDNKJyvPlV7MM9SUM7lbGWQT5VfOvagSaoKSpmywz+M4wSW+/DcRUwagjIXnD5v0zkjTx606CjRv4yPJZHdGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3nj12qmz; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso1077788eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 18:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768445918; x=1769050718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oljdS9Pzn8PfMd2uvF2pcJrzI3Sx8TSvOAxEtyq9iI=;
        b=3nj12qmz9XdreoBpSgI1yXCveFCm6M+Sj0KBuJGHk/i4+/CjnKC+gvXICwfGUGwZpV
         qx8PJgxuWYLN/3jyoLBf36n7QTkn2MbMYXMcVa09pfrMUAVDr2yS8/f31fnPXEZf1ARV
         UNlzPf9791ZLG8o2L/EpR4v1yNP6EuLI15ApBuj+sA6tc3jiEGQQDdHoR0G0nkw/Cng5
         YzyPHH4EbIvVpjHISBBxFySPR4HFkBcgr4yqNJQe/vXnBh+JHRug/7fLvEklYnjVDdcj
         witE+EnJnkhKlDh3go2UJaDlW5DyC84W9MsyXTMmBexPszZ5BKCkBYtBtusMb+cuh2R9
         tC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768445918; x=1769050718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oljdS9Pzn8PfMd2uvF2pcJrzI3Sx8TSvOAxEtyq9iI=;
        b=PxwF4GmfYonVMe+Vy1ezUr5GOWPbYWQe9J2Ksze9aBnQrtNlAkCl5aVz3S9G46hH5M
         4jif3jmrZktL7KRGLAOdAIKDmgDXUp+24fUVrY/XLIVfONTtMoAButbCsT25XCVFhNGr
         a01XUmA4e7nie40OSRlNqo6/dWgBlCatgmE5hMikPjTouWCStKD7wZOMwKlRqYyNCzab
         H2P2tOFlD2AbvQLoJOlLhGiqDCgO5N9oWMZqR5s5iQi63nFQ0BV0bRUwxyq4tk8abQY3
         K3A30qDcY3TbP8SaDEnPaP5DBqpqQfcC1bDhzxTnNTX06eFKEgvf8ptIGYxTa6fAoR57
         WkRA==
X-Forwarded-Encrypted: i=1; AJvYcCWhpz5n6QT1dfzWVb+SDPAVbO5gSQu822ImbeZnPOTxrGwxrq7q7zce6NJYi6g8e6QY2T7HDHjvGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtnM6rRZoCAxTEgao3/YIBcCXBPaspAAJXrXMyA6ilkQkAa2D
	ltesEsouqxjAiz/aGnFDO1h59Glr+Je4o8W8G/uvM6CvfKv85KWNOO45IuqeeYKb1g==
X-Gm-Gg: AY/fxX4RXr7zVlJPAAODIEGWrh7sPUkzyX3BXgmf4X40EXtOK/2tFAXONLtM6YoKcjR
	7mTW3THI+bBIfGXF89RJePYBn67Yj8Y5GSDajvg92giFzLAVavz5bQSE9c8IvKCm3twII07dBeO
	d50PIJDAplJh8p9mWM+MiqGTv/TbXGAwqLKr81Re/QDTs83N0tXLrcD0gByQX/UsxLlgT5lfGs7
	VHAkiI67I5GL9+QPed/QHFEFPQ1zrVG7A5eHp920ZyCqFzaI1FyKJaJyqou6tq7E+LcRXfDK4F9
	HsdTOcbMKd59/hOXsyqF3tnqoEJjVHHxGEAjBl5yK9okubexMHjQF+yFbHYHokzwiKOYmeAAU1n
	o8gXy2GN5/PeFWS6kJUyb8RU5yYxM6bnu0HDga8TaI/B8AJmYVsn6d2u0ArP3wpDh+qvTd8QWYB
	WM6VatBrM1fFH0Bpgj2hOZORtqIc23wfBwTbWP34crDx/Lx+VLCl0Vrj3euRKG83qbdKA8rcxFR
	3VKZjAWwWjYDQ==
X-Received: by 2002:a05:693c:37cb:b0:2ae:5e50:9cab with SMTP id 5a478bee46e88-2b486b7567cmr5712880eec.1.1768445917725;
        Wed, 14 Jan 2026 18:58:37 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:f3e3:a430:9ff4:7b84? ([2a00:79e0:2e7c:8:f3e3:a430:9ff4:7b84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1775fe27dsm18746906eec.29.2026.01.14.18.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 18:58:37 -0800 (PST)
Message-ID: <2e88f394-6c84-4be7-bc41-b2eb9c5e6c41@google.com>
Date: Wed, 14 Jan 2026 18:58:35 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
 <aWD_RIPp1ULH9St1@kuha> <9f94993e-dd69-4c9e-b467-aad6031c83d4@google.com>
 <aWT1NgxDSaU7LL2g@kuha>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <aWT1NgxDSaU7LL2g@kuha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/26 5:20 AM, Heikki Krogerus wrote:
> Fri, Jan 09, 2026 at 06:16:57PM -0800, Amit Sunil Dhamne kirjoitti:
>> Hi Heikki,
>>
>> Thanks for the review!
>>
>> On 1/9/26 5:14 AM, Heikki Krogerus wrote:
>>> Hi,
>>>
>>>> +	if (source) {
>>>> +		if (!regulator_is_enabled(chip->vbus_reg))
>>>> +			ret = regulator_enable(chip->vbus_reg);
>>>> +	} else {
>>>> +		if (regulator_is_enabled(chip->vbus_reg))
>>>> +			ret = regulator_disable(chip->vbus_reg);
>>>> +	}
>>> It looks like you have to do one more round, so can drop the
>>> regulator_is_enabled() checks and just always enable/disable it
>>> unconditionally.
>>>
>>>          if (source)
>>> 		ret = regulator_enable(chip->vbus_reg);
>>> 	else
>>> 		ret = regulator_disable(chip->vbus_reg);
>> The regulator framework uses refcounting on the number of enables. If
>> the number of times regulator is disabled > enabled, a warning will be
>> thrown. Also, I don't want to call regulator_enable more than once for
>> the same refcounting reason (will have to call disable those many number
>> of times to actually disable).
>>
>>> I don't think you need the check in any case, but if I've understood
>>> this correctly, you should not use that check when the regulator does
>>> not support that check because then the API claims it's always
>>> enabled. So I guess in that case "if (!regulator_is_enabled())" may
>>> not work as expected, and you may actually be left with a disabled
>>> regulator. This may not be a problem on current platforms, but who
>>> knows what happens in the future.
>> I don't think this should be an issue in the future as this driver is
>> specifically meant for max77759_tcpci device and should only be used
>> with max77759 charger (they both exist only in the same package). And
>> that the max77759_charger driver does implement the callback. However,
>> if you think that regulator_is_enabled() is unreliable, I could track
>> the state within the tcpci driver instead of calling
>> regulator_is_enabled() and call enable/disable regulator accordingly.
>>
>> Let me know wdyt and I'll update the next revision accordingly.
> Let's go with this then as is.

Sounds good. Thanks!


>
> thanks,
>

