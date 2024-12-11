Return-Path: <linux-pm+bounces-19036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784579ED0E1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814092885C6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3661D9320;
	Wed, 11 Dec 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZ0bRVNF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BD1D5CDD
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933393; cv=none; b=P2ZjJuB/XdOQ4YBFKL7RR8C7iugVU7KkRKij19q2HarnXvualcqgQ2W7b9tRp37xzA97wPjoBDyQ5U75xNoK9Fa4GL8ecaJBGgK9XN4zn6Ft/Lt+eFGkS+msmAlpCYy8gxjcoVk5xOjMkYEW6q+3dW2w+gi516RlmZpwEh/22g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933393; c=relaxed/simple;
	bh=XGft5kSYmPSIl70vfBT/bD/GbsE+KrV5nthhyezoKUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdOBSgkqmJ7GfJuUSABSRAaguj6P5B2EiUNfUhUsCWDeXqbMou+25i8lMSxrsefSQbtT8WCXXc+ybwg8AmhLf7wllg3wg6lOzIn2jNenR4GNZJ+o8tQ77ZwWhSCVNG5yradDEWRf05r8sv0qGiku9mZiCf6w9CQETYOBu6eJzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZ0bRVNF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733933390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiqy88fFJSqwSZys9TTjy96Q2qyVRBLn3wWkthGDt4s=;
	b=DZ0bRVNF8QlaHFF0RVkFJVEGwtWg7kTyNS3uS3KgRtWm+QLVA4u4St63s0gvLpihgybxNJ
	BTswzNXEQaW8l1OfIQlzz2wGlCwcLOT8WXK4AiQnJ/Krz42hHwC24YE57eNkp3nD+jnymb
	hSPP1c2VbZ6U+D5UXmKo8UcDSmkjWDU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-dJmv15_SPDGvEuCq_gOraQ-1; Wed, 11 Dec 2024 11:09:47 -0500
X-MC-Unique: dJmv15_SPDGvEuCq_gOraQ-1
X-Mimecast-MFC-AGG-ID: dJmv15_SPDGvEuCq_gOraQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa634496f58so219434866b.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 08:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933386; x=1734538186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiqy88fFJSqwSZys9TTjy96Q2qyVRBLn3wWkthGDt4s=;
        b=Nkti1K1wzKCt5gwqfuA2kk4BCymOBslD+G9ppSSTvWW7QBL6fhwY00B85jCEhAa3+M
         9ydw/Er5qN3SawEILPuA8UwJYw3p8jbUXydBHX1hu82lE/vBmmotV4NfIvMeGTswXjlE
         7J2ikCuolWU0mwga0S2bMcgjwVWflVrXVj0KHKHoQYxfBcsxSbF2ab2W5lsYRFhs9V9f
         iq6w3xcKglWOFmscrCQ8URtudaK8QJu0Rakqt5Xx5sxR52QTHyO4I6DJYOiutNlYDW1K
         pg/ALoz4PYgIwMzVW8Xeqhz1060LHt77jSGHOqkJvuMER2xfsZ/aNMmJDUd/ex5siCjT
         qTMw==
X-Forwarded-Encrypted: i=1; AJvYcCU1aH99gXY/70RygrPJxlgdK8Y0X1OJ8hSc771Jc2nJTgKCJivc/5GOKVwN6yrm4Dw+TdzMVE4m/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyorVfZ7fijELoDaVbPNX37lEYERaQb1uG5bJnXCrmAM6m5XF5M
	SqQy8F0RpEBkdJLlzduWBZX9r1dNP08AYGxKHD8eCGiCleLBlkA6rLujUP+bMchRR56CrcycV1X
	8krbirDu1oTQqmlUTlZwkmHnD6rRGsTSYB8J/DfrTBYvTrI5MnAMT39rL
X-Gm-Gg: ASbGncscuHBiG7Rl5JQ6DgSovTEv8VX37sWQLEEZT6xzC+nMbT/SWAc1HmHjs9lovUa
	cw3DKPW8n2XmXStDzwiwBvF79WjCCAh5u3KR2n7mPp+pWaxTi2LdJDpCE0E3XceGJ8ojfHsI2Yp
	cpFmQJ1rLD9K6krb0Xil/zzm43fi0AC6pdHfGkt/eWWmpvaJ70BUkeUyIJ7NLLnKObpfou7HwmO
	4fjMJFnqN2YfDeCGqeStJlIyiik5z/0Ylkh/OcR8+VftPSnULIK77nAP5gjsJ6lB0JReUlJjQLx
	iXa9sWU/7XVts+jsylQdIq/0nTwK6XrGzwW4bEbhhInLngYqMVHt1UtrLt4VFUi/OyZ0TkiEX/+
	uZ55HN1cACjmTO7rtZbFlI6m+Mfhi
X-Received: by 2002:a17:906:3191:b0:aa6:8dcb:3657 with SMTP id a640c23a62f3a-aa6c1b15193mr41552766b.36.1733933386059;
        Wed, 11 Dec 2024 08:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyQ3h5UbTOJK1kog9xHUIRGApb860SPpolw4BTXK+2SccnnUNtvQdi6c+YL50+WpBDJOUfZA==
X-Received: by 2002:a17:906:3191:b0:aa6:8dcb:3657 with SMTP id a640c23a62f3a-aa6c1b15193mr41550066b.36.1733933385663;
        Wed, 11 Dec 2024 08:09:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6ab44e881sm194686566b.26.2024.12.11.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 08:09:45 -0800 (PST)
Message-ID: <2d60bb29-59ee-4209-836e-f488bac0a657@redhat.com>
Date: Wed, 11 Dec 2024 17:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 linux-pm@vger.kernel.org
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-5-hdegoede@redhat.com>
 <f57031ce-8d5c-4601-87bc-2f1362a8de78@t-8ch.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f57031ce-8d5c-4601-87bc-2f1362a8de78@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10-Dec-24 6:03 PM, Thomas Weißschuh wrote:
> On 2024-12-09 21:40:51+0100, Hans de Goede wrote:
>> Make battery_modes a map between tokens and enum power_supply_charge_type
>> values instead of between tokens and strings and use the new
>> power_supply_charge_types_show/_parse() helpers for show()/store()
>> to ensure that things are handled in the same way as in other drivers.
>>
>> This also changes battery_supported_modes to be a bitmap of charge-types
>> (enum power_supply_charge_type values) rather then a bitmap of indices
>> into battery_modes[].
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This screams for power supply extensions.

I fully agree!

Regards,

Hans



