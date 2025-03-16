Return-Path: <linux-pm+bounces-24128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C91A637B3
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 23:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9379A16AF78
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3D1C5F2C;
	Sun, 16 Mar 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhUySBNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8928E3F;
	Sun, 16 Mar 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164325; cv=none; b=Z9D35x9NTJgIwmgCnMMCEEhL/sUGXfZVWtgyehOsoGXfUEqqTMbC5qvOXJdfL7ZqoohQif9fMesYDJZf7e/zNr7HBt6S3CNnKNowUHphVCYpTY/GcdOqiV1Pa8gWOAHJUEgGhl1mqiMIVJjBTeDG2YGp0oJTRziKXZ5j4vANZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164325; c=relaxed/simple;
	bh=++/L030K8s8P3l7kowTlhCo+8k2FfPs905r1ovqDuq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgKQ4DWpDJz50jDDbqZMtCCax3hDb/IcECAOwTUvNIaqZI4zHvAlSVJTDx0WJoe/dq8UQxEI1zhoX44UULeRsVmn7BtwGGlD6WuS0wVAcmjpqVFNvkCQIvP9Y2ATCyus6zKbVyocR6aTm4Ege0yYjghpYNiEkRccCCsAe8xFxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhUySBNv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so57518875ad.2;
        Sun, 16 Mar 2025 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742164323; x=1742769123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xDy5g6sAXqWbdTcRppEhu8nA7CsEHIQ+vuUJcDxSUkE=;
        b=IhUySBNvcVMMRllVlRUNcH5w63m49PYc0Wiiubb/pxM28Kpg8KK/EYeNwS0umy5NC+
         YIr7nnOjoQsTMxalm96zqQVSSjaR0MX8uLA480+rnuEu/DdTeZEdmLVFhFPwb9nll+tW
         EXfD7LCzWKjIzHNv4mrDW2oTCv7n5sO1bXmvE23kKESR20FF2OmMKDBIL+fy/CexBLpq
         GdZxNrwUnHvdmpc4Q4DKxvyD/KN2YZ+bkVDgMefL0w3+qdUk+GdryqaBaU2YLmRPybdy
         UssZeo1eF7fVrGqp9wDiBC/5DXhiaDwYhUFt9jFHAfThe+LrAaomapVFuVdqXC5ArjwQ
         Ut0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742164323; x=1742769123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDy5g6sAXqWbdTcRppEhu8nA7CsEHIQ+vuUJcDxSUkE=;
        b=akTmkwLOvuJxXDRPVnKL0ruX1EpIniP1AtgMqu64Me2TKQY71ePwuSEMNy7Rnmv8jh
         TYn7SnJl3Ofllfx0gSgmwdL0Y9ceFHjWCOGPIJe42nHnKLhEjDFyv/iH+WEqxpFBhdXQ
         EblFuca2gFTbVPsnDRG8jqCNwqclDT5xnI+KWT8nrkymVSjsQwRzt9ZJwtye5PIwXMem
         0+NOj6VrQUc/pfUSueHJ3vnjHKBf0k/lcgjVVh/TKydjlvVuB+hbt11aHVS/s15d9Jns
         Wb5KJxdnnpgT7dYOH5aq4I+VKpSrKO8rAmxMnUtPPWGeirh2AdgcrdSuQAGzquNimFIZ
         6ong==
X-Forwarded-Encrypted: i=1; AJvYcCW/HfOdIby5uvM+2ocO+UBALkIwlfN0F45byE2fLrA7C+cxeOf/qlGS9IEFC/TmZhjmoQtkr0XGLcw=@vger.kernel.org, AJvYcCWkE8g215NPy9WYnF1WM4vtH4n+4rpsmwOm6isbVR2gyCaNthFl4XKu+bDpgc862tcuq+e+dOv4oSI=@vger.kernel.org, AJvYcCWqUJrV1y19Ubix7ERE2yTvP5ZzS5OIFsPlwsovomjGu5n5Bh/aDbTAW+9ZrYjMsU0McGpwSbBvplO8iug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagsM/Qa1vU9CT5d81gVQ6OlKCGGapIvCtfxAVywwXjwG4Fy4r
	MGL/VmZGij689LMNHwZbMSH5ULIL5RekXFR57RI+SsseQgHlO4Oi
X-Gm-Gg: ASbGncsSkY+TyGjIMDHI06sfJrJtgSIHhUjomjyLSxOd0onS8a2t09OZEiKGEViJEdS
	BV4MNagBrqDSOFkcIIXqdRKrOE99d92Ji/3IX3hq4Xh2myKRwopUYiea/f0vDxWeIRk7jPRBCSg
	wGgQVfM5k/Q8pNUfR6KqCKNWYabtxIXKXnGGxpcFrtBlapgdurA7nlD7+cqwuQn7NuQGvi1bAmU
	wjFZNOz5Pnu/Zkg/CZir9DTdHgydWZ6B7eipjwVcoa0beTs8+mjnm7IClh1sQYnhjnIy//pbOOg
	LSVr24F8v1Qk59j0VctzJRwftntWVfvGAEqGj1Xv6OzQCiFkvTx4mJLhAHd9qqgk62VZlfMSNTd
	+8uUrlPGwXKXgtSA7ug==
X-Google-Smtp-Source: AGHT+IEqRt02ambKckmFRQG0yplW4q06JLtDcJkJvcclCMybrxenPBYBU2JHaU8uGGgxgwaaxoGu3Q==
X-Received: by 2002:a17:902:ccc6:b0:224:255b:c934 with SMTP id d9443c01a7336-225e0b2750dmr119155495ad.51.1742164322934;
        Sun, 16 Mar 2025 15:32:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm61867465ad.249.2025.03.16.15.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 15:32:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c20483c-dfe1-48b5-89da-680597d54791@roeck-us.net>
Date: Sun, 16 Mar 2025 15:32:01 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <CAGwozwELmp7v_46wmo_bbORWMEeA-NWRjXeRML4Jd=p=huLNaw@mail.gmail.com>
 <0aec1406-00cd-44ee-959f-48b646d3dad3@roeck-us.net>
 <CAGwozwHEoTb4uC=aoSXV2AMFjpZ_7+pDbMS1c_zs_QGAzC_qdA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGwozwHEoTb4uC=aoSXV2AMFjpZ_7+pDbMS1c_zs_QGAzC_qdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/25 09:46, Antheas Kapenekakis wrote:
[ ... ]
>>> Do I need to cc anyone extra?
>>>
>>
>> You need to cc the maintainers of affected subsystems. Copying the mailing
>> list is insufficient.
>>
>> Guenter
>>
> 
> Can you tell me who to cc from platform-x86 and linux-pm?
> 

Just use scripts/get_maintainer.pl.

Guenter


