Return-Path: <linux-pm+bounces-23795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5B9A5AE6A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A8B3A99DE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F019F221DA7;
	Mon, 10 Mar 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVSRjMaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D11DE4F3;
	Mon, 10 Mar 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649990; cv=none; b=OWq91xRPIGcCSl548MUQy3/EKvGV8xu9pak+XQwsV1CQh6cAHsYu5fByQT9nxu9lL6K4jn88O5hBDF8XVt96dM+cMTM2Ir9P0031l7mM3xh9L48jotwP9JkUB5IuKvAHtdbfqdqGEYyAvg6IgLo1ZHf4ym3uV/mnPyY+Ph0fJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649990; c=relaxed/simple;
	bh=KQf9iSha0JbtbjGdh7EhrzxXnvcGNs8XGn5kPJBo5ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NixOtNji1xgmJYeT57jOKqOMkpPRQnfR6ExvkihmbyHlucw5zl7c0BDoCpDwg+tZip2uIm9qzwd2RDJpQCyyhGcjTNSfxZJKs9amBlEBo2W3t50rHK6XwJCH9eMbcwk2qY4Lj4N5gHuxgQjYmTHlMGMfANJZ3nMI6T2yrgPHWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVSRjMaV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223378e2b0dso70131865ad.0;
        Mon, 10 Mar 2025 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741649988; x=1742254788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=elnnj/1pigfBRoygb+Ffffjb/pLIIHjg82jUwdQKpbQ=;
        b=PVSRjMaVDREqxbtrO80OYXvVYMi0LiVpVLUbsK1BcSAB2zJ758Uw2EST7565w+Cmyl
         zdsX8oCKliVMDZnPyuIeCQdGz2mAYMfhwvvRkEwSgKtVnA6d7P/HW/FVZCysXZQQo2jr
         n0v5ke/gNuRgqHTrLM/N+CnO3AmBcXiH4tqRSzgtvU6PCODG4YTFn53og5HSsRk8aGDz
         rPkzlf6rfWoOWWI+EM3WgZhRaMTCsVT8uFEm7MpdZ6upROGoC04BVJ97jlK2Rt3K0/Ys
         XsoXpW8vh/l3cr/9ykMM2pY2FJ3lCfdoltB9G99XXPHV7QJZafMfmJRyRxujfqKqpLNf
         EVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649988; x=1742254788;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnnj/1pigfBRoygb+Ffffjb/pLIIHjg82jUwdQKpbQ=;
        b=hH01O9GGpksnm3TJ+ePrrCcuAqx+rYw+uWFX9Q97aATOjA3bqK+cttNaFmo2v39OHq
         Er2J6f5C/s8iplpwgyKqZhV8WY9dhnW+nTF2kTi1qsK3wlaefVAwIb9NCJZ65ooFDo+Q
         ev5YsipwsfBd4The++EUIw93QwcbXX7wBe2SZ4H4pJF4l3E0BmVR5ZPdAqX/Uo0y16S0
         LIhH/zh7eg0fPobymQoa46jM6TFZtkASMkllRIpOr+9sttUv6/PtK2OP7u/ehXMtRKhZ
         ByJYAcBTkQf5zbGh2XEP/zrwXhi2Maqgae8l9EqZOuXEpsdty9nCok5McaDG8wy2GFe/
         9zsA==
X-Forwarded-Encrypted: i=1; AJvYcCUVAMlMKIchHsLPR0H11eF/U2GYDV6z1BOpuOVxKojnN/O7GiEBKHNlvIxwFoJh0vaKlIYomdLvFTo=@vger.kernel.org, AJvYcCW7eHdUtLdSD5GsXHUTNeDOr6yUx16dCGH1qcoKU08xsoUExiirU+Y6HRlBGfV2lEoCCWTv8+drkDE=@vger.kernel.org, AJvYcCXykV268xYsIwyaF3PklcsOsnkh5UQXl4RkVzzXYuuiHNCFjylvkAWFvSC9UD9xnnkyhZTrbOQVVQKusBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsHzs41rz4eX1Mcd5O/O6jYAar1lTKvkGeRf+Im7bRWpeAOfm
	fgOTZmmir9dz+WoPrldjFzs5Sk6RbSU3QXBY3neF8nsYnBpFU2iA
X-Gm-Gg: ASbGncvhC/GZgEBCy/Y7B76D6mWyC+4nddC+MnIXSw6CXHNoe0Ol70Y/lfK5MxVqRX8
	rI7Auc+Y0CkXLAnZZq+BDhd9bffU48b61wcDDYaH64weiFOHupGa3H0kfbnW7ukb5rDkCw937ux
	av3iBeQb2Ie/03r2kP/otHy+8nM4KSd2w6LPOp8lBcWtNgvnhmASl/Ep7lRc+tmFkIsfje2kX3W
	9l4x01OwCov6kTqwoKp0yiPnU17D1N6rinhHWS0xpdjLbUfYdY/8RWBra+fdY9/vgL+tvE10Dki
	HyfEjXs318gUYBTtQRX2JvnXe82hb+NKvsdRGbXImlW+Joo4SJaQjJkwT4GrDjeTcEqiyztS2TA
	DR6e1SVdPkeA+/lrQ+A==
X-Google-Smtp-Source: AGHT+IFGo0bLVGxfuoKLqoo7+fWQdDVvRcR4fony6TYLC7/NDuVpimKU0Y47Ro0I8E1s2QFK0lXuiA==
X-Received: by 2002:a17:902:e88d:b0:21f:768:cced with SMTP id d9443c01a7336-22428886828mr214386215ad.8.1741649988116;
        Mon, 10 Mar 2025 16:39:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91d4esm84610185ad.198.2025.03.10.16.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:39:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cd2b9f7d-95be-4fde-8a4f-9fbae32ff2ea@roeck-us.net>
Date: Mon, 10 Mar 2025 16:39:45 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-4-lkml@antheas.dev>
 <CAFqHKTn4hrKS0aiG1UNfZG5+mVcWEZw729pKv2YhXJtsFDCJEA@mail.gmail.com>
 <CAGwozwEbVKsx8yh7hRLHFho9eJdb5TdTVN-3jV1V0vj7-5mq7g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGwozwEbVKsx8yh7hRLHFho9eJdb5TdTVN-3jV1V0vj7-5mq7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/25 16:30, Antheas Kapenekakis wrote:
> On Tue, 11 Mar 2025 at 00:18, Derek John Clark
> <derekjohn.clark@gmail.com> wrote:
>>
>> On Sun, Mar 9, 2025 at 4:21 AM Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>
>>> The EC of OneXPlayer devices used to only control the fan.
>>> This is no longer the case, with the EC of OneXPlayer gaining
>>> additional functionality (turbo button, turbo led, battery controls).
>>>
>>> As it will be beneficial from a complexity perspective
>>> to retain this driver as a single unit, move it out
>>> of hwmon, and into platform/x86.
>>>
>>> While at it, add myself to the maintainer's file.
>>>
>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>   Documentation/hwmon/index.rst                         |  2 +-
>>>   Documentation/hwmon/{oxp-sensors.rst => oxpec.rst}    |  0
>>>   MAINTAINERS                                           |  7 ++++---
>>>   drivers/hwmon/Kconfig                                 | 11 -----------
>>>   drivers/hwmon/Makefile                                |  1 -
>>>   drivers/platform/x86/Kconfig                          | 11 +++++++++++
>>>   drivers/platform/x86/Makefile                         |  3 +++
>>>   drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} | 10 ++++------
>>>   8 files changed, 23 insertions(+), 22 deletions(-)
>>>   rename Documentation/hwmon/{oxp-sensors.rst => oxpec.rst} (100%)
>>
>> IMO this should also be moved, it doesn't really make sense that hwmon
>> would continue to carry the docs after the move. Platform/x86 doesn't
>> seem to have a home in Documentation, perhaps misc-devices? Armin or
>> Ilpo may have some thoughts here.
> 
> I looked at similar drivers and I think asus-wmi was the same FYI. The
> sensors for it reside in hwmon.
> 

One alternative would be to remove the documentation if there are objections
to keeping it in Documentation/hwmon/. I personally don't see the point, and
I don't agree with the argument above about moving it, but I would not object
either. Many of the hwmon drivers outside hwmon have no documentation, so this
would not be the first one.

Guenter


