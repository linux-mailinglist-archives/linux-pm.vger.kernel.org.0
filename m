Return-Path: <linux-pm+bounces-14475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF097CCB9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF801F23C26
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E81A08C0;
	Thu, 19 Sep 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Ioib2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89421A0AE0
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764833; cv=none; b=CiEYt62X/zVKE5KHV8/+B0MQYg8TeJ5C00ICsbtnuu0qtxKxCPqDFojLvZavDW/Ad/5/uq6UYJJbk+dda/nlobkBOXoxF0OfuuodG0rGPOCdJjNvpXvx4UmJMl9B+ubDsfebkpM1yhSDFDvH8Mhnl7SC4kwjuYCRWf6d2RjM10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764833; c=relaxed/simple;
	bh=bn6oGPW58fPqNoeG/yyMk8vFqMKMBG4u8Nq13neeEYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZu0Tyl93/hTSz2640qE2KkvvwH2zlw2anDnR+sBLqaa4vj6nu1YTRhy/4A8gKy3hULljH5f3+F76CkW1P0XPUOUgamkDZSVt48sMp23OJ3VGnFpl1e4XswoNsosdUMFxf5cDx7eVpIA61yeeIHMX0YAyFWrsYkqYsC3E1aJHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0Ioib2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726764831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2+TSii+mHfEEe1HaRRA9cI1yQ4z2lktV77MXNOhxqM=;
	b=L0Ioib2tKCsqRrsMMp5qOmNmQeyy6pzs+xRIur5kuK+ObhlSjDL7sOIskhm4J+Da58Bf6F
	dFneOxrIdcxcw9RcfqtlA/iOaxzGOcadTe13woh/II9ZCO2yjKKpYqgyeYrV4CA3/vwidN
	wAUuOIwB1PpdGkU4v9xMGhHakAmr0zs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-P12gfYM0OquhajPV4YR0HA-1; Thu, 19 Sep 2024 12:53:49 -0400
X-MC-Unique: P12gfYM0OquhajPV4YR0HA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a7463c3d0so73423566b.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726764828; x=1727369628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2+TSii+mHfEEe1HaRRA9cI1yQ4z2lktV77MXNOhxqM=;
        b=uFWNQwD7zCXvTDETgwnYgRduFDhFVUSFsrGRV/tl5+iXfLaH5+4mflUgYs1Joi2bm+
         YCSQDWS93dODmcECJ+6tM2RC0/v6+3nOPx3lBiJ6ABnUm6Ocrl9nwiaKTJiKka5AvOPb
         0esaMzjL++AcKhCYf+/AMwFeWeIn9FWGBzDJ7L0xpBo+4EUe5nd+oPq6zIXB68fo7hfI
         0x9lsvjPshvtLqkpkyZGhRkPpXg7WrH8WPGYV4zn4bjWLUCO2FLIL3AFHrJi3cyHvxPh
         AinPBGJoKp5pz0ZATdCQoKHk0Js0TGWpXhHIDf/ij9P0udR8fU4NrJWiJ/ttav/hwKpg
         fv9w==
X-Forwarded-Encrypted: i=1; AJvYcCVW/eYsY/t/+qKtMvOaCBUM7aNzuTfcEUY8KHZNoD7aSBQa7CT/zoHJGXjqFYNN1SbTxE0DI2oklQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DW8Rc1XbVFhBvzRcDQ9TQ2ReVW3nopuFpgpfMRQc2y3mITxJ
	ZucEJff5qQjw4c2HIdySXH/hRnup2hSnLZ5InpGmho7KD6+KJvYAEAvmFxHTkLUVyUoajKi5+rU
	FiBENY+GAN9f6EfrDHF6TrDg64VQoAyYmMy9IcMAqWjhOIxNNokGKkfZe
X-Received: by 2002:a17:907:e29a:b0:a8d:4631:83a9 with SMTP id a640c23a62f3a-a90293dc171mr2515034966b.3.1726764828478;
        Thu, 19 Sep 2024 09:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEv/8VjZJXFjJAjmj7AYnAhIpGt2wAk3Kqi2ZF3yBVwUInfkzT9Qd+2XBRJvysfsZ7E4eHCw==
X-Received: by 2002:a17:907:e29a:b0:a8d:4631:83a9 with SMTP id a640c23a62f3a-a90293dc171mr2515031966b.3.1726764828086;
        Thu, 19 Sep 2024 09:53:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613315e3sm740881766b.209.2024.09.19.09.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:53:47 -0700 (PDT)
Message-ID: <10f1c736-33e9-4e04-a31e-0f095cdd08d2@redhat.com>
Date: Thu, 19 Sep 2024 18:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
To: Paul Menzel <pmenzel@molgen.mpg.de>, Marek Maslanka
 <mmaslanka@google.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
 <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
 <b3cc0791-6334-4143-90bc-d3ae04aae0de@molgen.mpg.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b3cc0791-6334-4143-90bc-d3ae04aae0de@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 19-Sep-24 4:03 PM, Paul Menzel wrote:
> Dear Hans,
> 
> 
> Am 19.09.24 um 13:57 schrieb Hans de Goede:
> 
>> On 19-Sep-24 1:03 PM, Paul Menzel wrote:
> 
>>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>>
>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>
>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>
>>>>>> On the Intel Kaby Lake laptop Dell XPS 13, Linux
>>>>>> 6.11.0-04557- g2f27fce67173 (“6.12-rc0”) fails to ACPI S3
>>>>>> suspend the system. The screen turns black (as expected) and
>>>>>> the power button LED stays on.
>>>>>>
>>>>>> Doing
>>>>>>
>>>>>>       echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>>>>>
>>>>>> and on tty2
>>>>>>
>>>>>>       sudo systemctl stop gdm3
>>>>>>       sudo systemctl start getty@tty1.service
>>>>>>
>>>>>> and then on tty1
>>>>>>
>>>>>>       sudo systemctl suspend
>>>>>>
>>>>>> I see some panic messages and traces containing ktime_get or
>>>>>> so, but I failed to save the messages. (Hints very much
>>>>>> appreciated.)>>>>>
>>>>>> I try to test the printk changes, but otherwise bisecting is
>>>>>> not feasible, as it’s my production machine.>>>
>>>> It’s not the printk changes. I tested some commits, and assume it’s the timer core changes:
>>>>
>>>>       $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>>>>       daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>       9ea925c806dbb Merge tag 'timers-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>       cb69d86550b3f Merge tag 'irq-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>
>>>>
>>>> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
>>>> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend
>>>
>>> It truns out your commit e86c8186d03a (platform/x86:intel/pmc:
>>> Enable the ACPI PM Timer to be turned off when suspended) causes
>>> the regression. The laptop defaults to s2idle, but due to
>>> problems, I force it to `deep`.
>>>
>>> Revert on master is not easily possible due to other changes it seems.
>>
>> First of all thank you for reporting this so early in the cycle and
>> for pinning it down to a specific commit. Both are really appreciated.
>>
>> I guess that the power-savings from disabling the pm-timer are mostly
>> relevant for s0ix suspend. If regular S3 suspend is used the the
>> firmware is in control of the suspend and if necessary it should disable
>> the timer.
>>
>> So I think we can fix this by limiting the new handling to s0ix suspend.
>>
>> Can you please give the attached patch a try?
> 
> Thank you so much for the instant reaction. Indeed, your patch makes ACPI S3 suspend work.
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022

Thank you for testing. I've submitted this upstream now.

I'll include this in the first pdx86 fixes pull-request over 6.11-rc1 is out.

Regards,

Hans




