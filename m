Return-Path: <linux-pm+bounces-7479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FC8BAE45
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75473283957
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CB154441;
	Fri,  3 May 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dacXh2RZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47793153BDD
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744661; cv=none; b=RUAPEaAmmWfdHX0UFb+hEWqL3NGDeKHmYTgC+TkSSYGQKUO0YCWfJJijTldrUlBqT0YBmUJf4RMUWgrPM+sxwDo/pPKaQlVQF5R/wsVPY+f+G8O3+J2UBQm41IP7Nl+0tGZsq9YKPEuq0itUH9Xc8cRQYRhbG3dIPC8dA4MOfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744661; c=relaxed/simple;
	bh=c1otjCUr6/46Yb0CCCZ/Kv82KCQ+4RRahotV1mpW2bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjKNR6nSaE3Cu7saeoxZLBUgU8ls26lOPYK/ceE7TSh4tkQRN1MAVrF5z4duS+5FTLGz6GvWgzv2PEX55k+gvQl2PZNbdXBsIXimblOzbvhkYVG4RnP2s/l1zUP9n8Yw5Y2o2eLH9Ymv/F4242OcW+G9+qUJH0Bx1X84q2nkYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dacXh2RZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714744659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHAnt3kV8i2lFHc2XkUBb5R3EM8KnMK0NS1IZLqYFQc=;
	b=dacXh2RZk5iwOQ6RPxXu/5gPD0ntfCdFVoL340LGMZgc2wp7V+ohdj7c5FY4CHrgVkTemG
	ZKeBFwJVmjFaUHbMa9bXDMjBHuLHbtAyzHecLYGiEppAbUkKJrN/Jziozm6saGzd/UjiQC
	W5CBy4+4acIiNGxOw4ubPwx4xU7OlSk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-SQ2ZKrezN1a511eUmiafeg-1; Fri, 03 May 2024 09:57:37 -0400
X-MC-Unique: SQ2ZKrezN1a511eUmiafeg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-572a805f8fcso1627497a12.0
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 06:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744656; x=1715349456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHAnt3kV8i2lFHc2XkUBb5R3EM8KnMK0NS1IZLqYFQc=;
        b=wfwFaUdy4p5HXsjajU5cO6QcAS3KIqznQbAvzZXWKhuud4t6JBtqiKyA4056qlwg0n
         Uaqj3+IVCBdFvpvuf+mxNTNbknMYo/gOTPKPY6issmzlZitTVmujcSwIOevBQdfynCHu
         t5XK+gcDpLHf+Ub1viJ8b39W4M21iYD/hucpT5F2N8vn2OCknP1/i7uwqcDKERpx4z7N
         6C/2pBX3zi/pc3ognRAcj9RDfvhswAG5lUlKurL9RQ5YnB+ThWEm7r8ogtr2AwGtN18Y
         rxeOB6lE3uJU0wZso3IJ/9BL/lPFIFM5DRM6wMUT/1/qCCOf6qO9btFSM4rphD0daHtM
         csyA==
X-Forwarded-Encrypted: i=1; AJvYcCUySLxnnpG8W54p4PapWKbRUT/KOAZsyYaLTtxj1PlTeyGRsjIGDidyqG06lhIOZyTtcrVTzhLHNACdtKaNMgErGjUwHqPnU3k=
X-Gm-Message-State: AOJu0Yz0ykWl5eIqB/3lcUqiUob+e+wbbxRsSf8Y7gDTbXLuOwCXV+K+
	BqgPJDvi6EZaBiL6XXRZEZkpn5z6AFragKnpVD2chYLe6kqYrOp9SGR8LGcKve0uowuNRrrl5ac
	c/LktWtIbtVFKst+EAqtBXkkXe1QPP/lgGRJvk9i4HLOFCjk4Hyeg1KNH
X-Received: by 2002:a50:cd93:0:b0:572:4e6b:c31 with SMTP id p19-20020a50cd93000000b005724e6b0c31mr1712654edi.34.1714744656661;
        Fri, 03 May 2024 06:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsh5w9dz9XrIXDm8tg48qsQqC1SjQyRh4dvyIngfpi43NIJJn8TFScktjkZPnUKAHnLhEpw==
X-Received: by 2002:a50:cd93:0:b0:572:4e6b:c31 with SMTP id p19-20020a50cd93000000b005724e6b0c31mr1712637edi.34.1714744656304;
        Fri, 03 May 2024 06:57:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402074400b00572b2ad900fsm1684546edy.46.2024.05.03.06.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 06:57:35 -0700 (PDT)
Message-ID: <10b4ac92-dd72-445a-9727-f6e40c68b12a@redhat.com>
Date: Fri, 3 May 2024 15:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] leds: rgb: leds-ktd202x: Initialize mutex earlier
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
 platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240502211425.8678-1-hdegoede@redhat.com>
 <20240502211425.8678-4-hdegoede@redhat.com>
 <CAHp75VdSHGXuvGtPBuQSeDLTg0FjPNStcgG3-p07cfVLi_D_YA@mail.gmail.com>
 <88d18069-3327-463e-afa6-b80645dfbb7f@redhat.com>
 <20240503070322.GA1227636@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240503070322.GA1227636@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/3/24 9:03 AM, Lee Jones wrote:
> On Fri, 03 May 2024, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 5/3/24 5:43 AM, Andy Shevchenko wrote:
>>> On Fri, May 3, 2024 at 12:14 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> The mutex must be initialized before the LED class device is registered
>>>> otherwise there is a race where it may get used before it is initialized:
>>>>
>>>>  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>>>  WARNING: CPU: 2 PID: 2045 at kernel/locking/mutex.c:587 __mutex_lock
>>>>  ...
>>>>  RIP: 0010:__mutex_lock+0x7db/0xc10
>>>>  ...
>>>>  set_brightness_delayed_set_brightness.part.0+0x17/0x60
>>>>  set_brightness_delayed+0xf1/0x100
>>>>  process_one_work+0x222/0x5a0
>>>
>>> ...
>>>
>>>> +       mutex_init(&chip->mutex);
>>>
>>> devm_mutex_init() ?
>>
>> That is not in Torvald's tree yet.
> 
> Neither is this.  :)
> 
> Since we're nearly at -rc7, I think it's safe to say you have time.

Ok I'll prepare a v9 with this addressed and Andy's Reviewed-by
added.

Regards,

Hans




