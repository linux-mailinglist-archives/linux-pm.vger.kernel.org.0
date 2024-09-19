Return-Path: <linux-pm+bounces-14477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEFB97CCC1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8D4B21705
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FC61A0B1A;
	Thu, 19 Sep 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLM0uJoy"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBE1A0BC6
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764954; cv=none; b=rSkOIchwzWGRhQHPkb0XZMqgSis6i3EIx4JqCy+HSMzs5VWf+SfU1KcnCToyJwnaLv9DfM2P9uiXZ2G+U4sefd+qJUTMGDYV6KeHEKQrY0sm2bJTOoYWhYFAjGRJNbAykKj1p9yrxdhHKLY6xz0BF0LD8D/fiDb/oRKO8OL6ZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764954; c=relaxed/simple;
	bh=THg8/jrkX5yEQ+5RXuablIAJD1txlNDw7HUhI224EgI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W9YnZ/I6NIYqTIok69bPVJjHU+wnaKBT0wnn5Wv2cILMczKXqYz4uOAJf3NKNMDCoOvBrYLwVy1T7mgoGf6xIcP/Ss+Tkxzz5LQXaVMcA1GawfYdXCv3GLRCMu+MLz7R/v28E1VKXKwbR6U0iqt69B11lbsNYhdBkTugOVTh17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLM0uJoy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726764951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ArjKSrgYs3n7oYvmkgqz/oQJ3jT5AZ+GCzdRL4cx0M=;
	b=BLM0uJoyqff5PeTnxBDYMWhCL6okpiRvHtvmON7KKXchPdeCXyWBq1yxFpl1R56z53JCW6
	KVU8QppISCU7tkSCAUvMgqs7DGEjqudNBPu9gwBQYk934epwtZowAyB9FVNT5CwqUqsfEU
	/EjAnxhkfspNKieukDEubhdFYQQdrrY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-XDzeVzNUPxC3sIt9X35F6Q-1; Thu, 19 Sep 2024 12:55:50 -0400
X-MC-Unique: XDzeVzNUPxC3sIt9X35F6Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a9094c973so79690366b.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726764948; x=1727369748;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ArjKSrgYs3n7oYvmkgqz/oQJ3jT5AZ+GCzdRL4cx0M=;
        b=vm8bt31ExIaK07OREcmo68dhZvKrkQaXrMSU8TRDNAHo+xGeySUsY+KN9g9m1NIQ11
         p4FiJU5JdblcKSMFggMwYAUUZohFToUwgLQ+NuVfTn+RChGZelnWeg6tyP8LpXrfceKw
         ePYR4kjpK2pgTnT77MpGTzY35DZm/EMNrGSRRgB2EeYDtVfKWMm07jCwka2351IOQ1OW
         VcUI7omVN2W32v20ooj1uXWgOuOIPQ9d9UAFSft06lowjl5+63D3+Sjdqka9BqYYL7ih
         cRc/tTRT926wy94Yx0bu2F9dsqMn1j/4L03Cea4pzPfbKJxoOJsN3yUjeSkMXTwujDZd
         k2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/sp51YqH6gjBJBcHp89HcN5SOSQQ6QCFmG+cTEFcYpj90nTaNebhdwURuIAJEShEGUiWTOjuGig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfyE5bGtn3Im2adnPOnCsm1xtHwh7Z5c9z8lZuMc6YMrJ0R68
	dYGOIRP6q0+KTZR98NbokdVDa30mg+xKlbJPEZQPZlmw8lOQdLA1+5WDYxsp/xBlS1XYx5sTOCL
	rZCOHtTzCguYGgxtfprmTB+ujBIEYn7lc3bK0xw3N/CmqSYwFL5T4KBGa
X-Received: by 2002:a17:907:d590:b0:a8d:470e:1793 with SMTP id a640c23a62f3a-a902950525emr2423274566b.21.1726764947949;
        Thu, 19 Sep 2024 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh/9tSsF9buG8UKZJx/zu9CmMpi915xt+cNK2Q4LiXMEsxKhOTcGwklprismyBVMJ/E/Br9g==
X-Received: by 2002:a17:907:d590:b0:a8d:470e:1793 with SMTP id a640c23a62f3a-a902950525emr2423272166b.21.1726764947484;
        Thu, 19 Sep 2024 09:55:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e50easm752633766b.174.2024.09.19.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:55:46 -0700 (PDT)
Message-ID: <28bef0a7-bc6c-47b8-9545-e6d867922e14@redhat.com>
Date: Thu, 19 Sep 2024 18:55:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
From: Hans de Goede <hdegoede@redhat.com>
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
 <10f1c736-33e9-4e04-a31e-0f095cdd08d2@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <10f1c736-33e9-4e04-a31e-0f095cdd08d2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 19-Sep-24 6:53 PM, Hans de Goede wrote:
> Hi,
> 
> On 19-Sep-24 4:03 PM, Paul Menzel wrote:
>> Dear Hans,
>>
>>
>> Am 19.09.24 um 13:57 schrieb Hans de Goede:
>>
>>> On 19-Sep-24 1:03 PM, Paul Menzel wrote:
>>
>>>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>>>
>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>
>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>
>>>>>>> On the Intel Kaby Lake laptop Dell XPS 13, Linux
>>>>>>> 6.11.0-04557- g2f27fce67173 (“6.12-rc0”) fails to ACPI S3
>>>>>>> suspend the system. The screen turns black (as expected) and
>>>>>>> the power button LED stays on.
>>>>>>>
>>>>>>> Doing
>>>>>>>
>>>>>>>       echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>>>>>>
>>>>>>> and on tty2
>>>>>>>
>>>>>>>       sudo systemctl stop gdm3
>>>>>>>       sudo systemctl start getty@tty1.service
>>>>>>>
>>>>>>> and then on tty1
>>>>>>>
>>>>>>>       sudo systemctl suspend
>>>>>>>
>>>>>>> I see some panic messages and traces containing ktime_get or
>>>>>>> so, but I failed to save the messages. (Hints very much
>>>>>>> appreciated.)>>>>>
>>>>>>> I try to test the printk changes, but otherwise bisecting is
>>>>>>> not feasible, as it’s my production machine.>>>
>>>>> It’s not the printk changes. I tested some commits, and assume it’s the timer core changes:
>>>>>
>>>>>       $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>>>>>       daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>       9ea925c806dbb Merge tag 'timers-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>       cb69d86550b3f Merge tag 'irq-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>
>>>>>
>>>>> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
>>>>> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend
>>>>
>>>> It truns out your commit e86c8186d03a (platform/x86:intel/pmc:
>>>> Enable the ACPI PM Timer to be turned off when suspended) causes
>>>> the regression. The laptop defaults to s2idle, but due to
>>>> problems, I force it to `deep`.
>>>>
>>>> Revert on master is not easily possible due to other changes it seems.
>>>
>>> First of all thank you for reporting this so early in the cycle and
>>> for pinning it down to a specific commit. Both are really appreciated.
>>>
>>> I guess that the power-savings from disabling the pm-timer are mostly
>>> relevant for s0ix suspend. If regular S3 suspend is used the the
>>> firmware is in control of the suspend and if necessary it should disable
>>> the timer.
>>>
>>> So I think we can fix this by limiting the new handling to s0ix suspend.
>>>
>>> Can you please give the attached patch a try?
>>
>> Thank you so much for the instant reaction. Indeed, your patch makes ACPI S3 suspend work.
>>
>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> 
> Thank you for testing. I've submitted this upstream now.
> 
> I'll include this in the first pdx86 fixes pull-request over 6.11-rc1 is out.

That should be 6.12-rc1 of course.

Regards,
 
Hans



