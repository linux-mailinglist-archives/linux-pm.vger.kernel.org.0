Return-Path: <linux-pm+bounces-19628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0905E9FA0BD
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 14:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742F1890289
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFA1F236E;
	Sat, 21 Dec 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPjAXW4O"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655A1F190D
	for <linux-pm@vger.kernel.org>; Sat, 21 Dec 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734786145; cv=none; b=l0Zo9kAKiokkepS2Qju2zadUdvXkDCH4iSmF/g8OHawf4JMZNSWYuBzGmjd776sruLTrxvmjFDx5rssGMqhMXEMztoGT9IK6oaTGVfSPD+LR3bvh7PejoKAOEfJgaYMqIhs0joIOYxO064POoKbwbMD3b+ZySN2iBiTYAFqfqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734786145; c=relaxed/simple;
	bh=SYd+XNUXTe7yQopaebA0xB/8gUiP/vhBeLZQBDOoJ9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfNk4MVTk8jtAJl+2Gg0aJA1xUErlJr1pCw6oCNsjZossN3x84ZuYWcnme6efqoYefglR2Znlones/DX3FXdQs9mEL+hrt8WNSUp63Wvo8hMdNuYwbnZunEXdgXO6OfLSiWwP4yIC1aOeH82GRVOjcB/o0h3petXjInV0M7R9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPjAXW4O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734786142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODmUub3mfJwhKv3i88+Y0tokaQGix6bo9RZrqqNY5p4=;
	b=JPjAXW4OYClr+NR3c0yiGvv9C90t/c9y885eeo+emF5LUqGJk4/GfKgOoBxJodt5Ufax8O
	igOz91aMYYoc0SgiPv9mWFngzQ+FTWLU250XBjJkbB+cPO3Bv4tkpZNrTAv27ZY8+JYpgx
	OD9Fcn3q4LVKvt2yI/c3y0MpENtGUfc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-NogHLE7zN26-Q24_oF9atA-1; Sat, 21 Dec 2024 08:02:20 -0500
X-MC-Unique: NogHLE7zN26-Q24_oF9atA-1
X-Mimecast-MFC-AGG-ID: NogHLE7zN26-Q24_oF9atA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a999so2731297a12.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Dec 2024 05:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734786139; x=1735390939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODmUub3mfJwhKv3i88+Y0tokaQGix6bo9RZrqqNY5p4=;
        b=d7cRGzaSOIR/NEmd+8xt0kjyjlW7ztNiC3DX9p3JBbr8Bi8mmnaz+wWiulVQXDOpeU
         uNl11s7M7QS0vIAq1rqGJkE8IcMMeDEKNF6k97ZPucL/DKYmm2+r1+tdWQegGtZEvIs1
         1aQZamcMIqk9H0Mo6lj8XcWeigRmnn/PqrAUPFPgJvRoyCxoHN3+heQ7cf/Ph/9oSswU
         w6evber91mFOuAyXNYBHemihUVMPoHPVB4Dl83QjqWJrvBKvD8c3Si2N0xbC4UTkr7Ru
         7Ir+sO5uNNpzJPzXJaafW5OjEOv04pb6s7zJf+yk52oERS6VaVgYpqQXn3xUc4bxA4qK
         41NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVLGwyMdMhItC9iPBYuHBqzObJL8UyY7KLzWJLmRpvFvXPwR3dfzzbEn0WPi596c+iDRK6nvKJfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF6fKjT8f0r5k77AqXzWuiJalnY2hc30dwAbDgOIYjQWlZqDj
	63uZj7mgna9tJZm+z70RaPOfC4v+Up1+z8SZyaER3/uwhiJhHTOjf0udw052oyKR1IYWzouyCjQ
	esFUYgu0JoB6/JHRpj8JMqxCK/3dPtdFkSF5yZ/oRZ32jkRkEO0Nw6oza
X-Gm-Gg: ASbGncvP70tozrbXutF9mvkIUW3YdaJG97df8RwYnzpr3vR0hVramnC0aWJsfFy78Ea
	R43+LoGnpC7X1vFAaWyN3+mzdZ31HfZRnqoyCDrUNpHoc/DgmcZeZPhz5Tvvs1s77/bu8S5Qjlc
	T6Mq6NOvZx0HSFSVwpR5sQTD2dD23iqBFvu9in6joAopVB/YwBD85xl9xs7KUsk85H9m9ujzK6A
	wgom4jNbCU8epzg6LN57Xl/C8Jvt8wCeDV6Gaf9ggK8x8i6tLAydaK7OVwMevC5E31VLyPGmcyy
	Tec3wr/Sj3YfRQi7ABHwTB6QTmZoO8pRasqrugFsac1G8zId9A/JSZZZZOiezv4kz1kJrB/kdRY
	rpKg3asA3Ao0EH1oPzRkEZgrEqf1I+7Q=
X-Received: by 2002:a05:6402:354c:b0:5d4:35c7:cd7c with SMTP id 4fb4d7f45d1cf-5d81ddfd836mr4692630a12.26.1734786139063;
        Sat, 21 Dec 2024 05:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgkaacKY1aXbt9NjWxu37CbGf6BZuj+XbF6PgxL1EAEy39FTRfluaPa0xNYlhNQz0+hM/KEQ==
X-Received: by 2002:a05:6402:354c:b0:5d4:35c7:cd7c with SMTP id 4fb4d7f45d1cf-5d81ddfd836mr4692607a12.26.1734786138672;
        Sat, 21 Dec 2024 05:02:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c6dfsm2774457a12.37.2024.12.21.05.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 05:02:17 -0800 (PST)
Message-ID: <233a3a9d-3b07-4451-935e-107bffd873f6@redhat.com>
Date: Sat, 21 Dec 2024 14:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241211174451.355421-1-hdegoede@redhat.com>
 <20241211174451.355421-5-hdegoede@redhat.com>
 <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
 <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
 <c59ed113-6a43-4807-a006-ceb5a807fb90@t-8ch.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c59ed113-6a43-4807-a006-ceb5a807fb90@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 17-Dec-24 7:49 PM, Thomas Weißschuh wrote:
> Hi Hans,
> 
> On 2024-12-17 16:18:47+0100, Hans de Goede wrote:
>> On 17-Dec-24 1:01 PM, Ilpo Järvinen wrote:
>>> On Wed, 11 Dec 2024, Hans de Goede wrote:
>>>
>>>> Make battery_modes a map between tokens and enum power_supply_charge_type
>>>> values instead of between tokens and strings and use the new
>>>> power_supply_charge_types_show/_parse() helpers for show()/store()
>>>> to ensure that things are handled in the same way as in other drivers.
>>>>
>>>> This also changes battery_supported_modes to be a bitmap of charge-types
>>>> (enum power_supply_charge_type values) rather then a bitmap of indices
>>>> into battery_modes[].
>>>>
>>>> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> [..]
> 
>> Note that merging this requires the earlier patches from this
>> series which have been merged into:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>>
>> so this either requires an immutable tag from Sebastian for you to merge,
>> or this should be merged through Sebastian's tree.
> 
> If this goes in via the psy tree, you could already make it a power
> supply extension. The necessary code is in psy/for-next.

Yes I noticed that the power-supply extension support was just merged,
that is great. Thank you for your work on that!

> Not necessary obviously.

Right I'm afraid I don't have time to work on converting this to
a power-supply extension atm, so lets go with this incremental
improvement for now.

Regards,

Hans

p.s.

IK do have hw to test this on, so if someone else were to do a conversion
to the new power-supply extension model I would be happy to test.



