Return-Path: <linux-pm+bounces-12084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83D94EED6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E541C2196F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9A17E473;
	Mon, 12 Aug 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw7Rwufo"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697317C230
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470751; cv=none; b=C0jp1/xoaDnQeGAumQ9Lj8SmB5BetFZJ0PRNWuIF0ApRxy7MB0aFq0IdVtO7IF1Fmu340NtZgDMXwOI2FbFwBiUUHUCGo4tWzi39SScJYSRNOS4RVBaWXZRq/7UdMPg2ult8NxKZo4VRNW8UAiBOJKK7dKGiUdR29Omuv2gSbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470751; c=relaxed/simple;
	bh=U+oTwlABO4oBXd7EEjBWj1WtDC61J7PYbNmt7uiSfe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ibq+q52x6JgVCHMj1BNr47XRlShwKVxKRY4rlR3A2TwYFqwN1H986oc0d9QaG3WznoitWzlX6lZzm/Vh9+LLhVgoikVoaou0w8lmvg/w6qaiTLhoOU44UFJiuz1ARzIO50ukyeW7EfjwSBNzjnG7+A+wP2GghZI6KDfLca9HdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gw7Rwufo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723470748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd85iCuzkiaHIi9ARC/ZdPTz7M5ce5CxfGu9LxDUHcU=;
	b=Gw7RwufonbwRMA6SUcr+E827UR12iTf5Xta2n1TaEN7oFVSPQ6VuchuFLP3OkB8I4N0Rj0
	UcDzGe7dJrcYJnpZrRDXrRpKubqWz9r0aXtGrnS0dys8rUYkw3I20z+DUBcDykdRt4sw8F
	SyJzpyu6fVmen6KExfm2oJBb00rokg8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-VkgINMGkPoy0V-ryfIZebg-1; Mon, 12 Aug 2024 09:52:27 -0400
X-MC-Unique: VkgINMGkPoy0V-ryfIZebg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bb90be4d87so3422081a12.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 06:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470746; x=1724075546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd85iCuzkiaHIi9ARC/ZdPTz7M5ce5CxfGu9LxDUHcU=;
        b=YzwcE9vK9P8dahXAz2Aq463GIWMBJdpFBubypBMcJD8iIHRhSIwSDtsUYrfJxNbiQM
         lyK4DOq4cS9V3OMF8ikGvOZHUcjLNjGczaqcqICxzE5dWtsIKryLvmoIm8fh6Mt8YXAD
         ph49XONZp3wbXdr8ndAC9FbXIXzt/7fE9zYr09ZujAA/LE70xzNIIlXZ9cvxJAf0nPuk
         bdrPGT0I9y5UJIELWvHQe82FnmuVtS07DChXqp7HcQUjaaw5PFkMKHEzDiBXiKt8/1H4
         8KCwJWNKMyoHNn1mHNBQbRxuMxhbDfvZlB2Gsvl4P1bNKz61twxU6zbOtye19yqFLr5F
         1P7w==
X-Forwarded-Encrypted: i=1; AJvYcCUGJEQUTKVO6V3MmIY2T0jnzZDaSOY2mx78JxYW1F0/Dn2BfDLi22dpSvwK6GY8EeaJPi4Xke49FQaiRLoikYiOPCn857sI3AQ=
X-Gm-Message-State: AOJu0YwRhskzV4DKrj0Mmk2kCA9Yk5RSeZXHKhrgc+NebzsLNnTC2oLx
	JqNAiqKv5xC69NUScgXh3Gu6IFqsJmJyFvI/ixZhO3RALHLMUS0a35vebCvUPMS3vZ0X143sF3p
	fJTewRUD8mjd/lf4HM85tY0IedDP5bYTLxT7ftuvRvSWbDXlDYX6SoAog
X-Received: by 2002:a05:6402:2113:b0:5a1:25a5:5dde with SMTP id 4fb4d7f45d1cf-5bd44c38786mr245154a12.17.1723470746022;
        Mon, 12 Aug 2024 06:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxC+wbLxyAluaepNv7rHIg3aENCbMAyBR986wmaPBQbxdXUVRX4wQrPV3+hHy+P3YyLGM58A==
X-Received: by 2002:a05:6402:2113:b0:5a1:25a5:5dde with SMTP id 4fb4d7f45d1cf-5bd44c38786mr245140a12.17.1723470745478;
        Mon, 12 Aug 2024 06:52:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd191a1e8esm2123978a12.37.2024.08.12.06.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:52:25 -0700 (PDT)
Message-ID: <13d93f79-1209-4071-bf4e-a70703a9a400@redhat.com>
Date: Mon, 12 Aug 2024 15:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
To: Armin Wolf <W_Armin@gmx.de>, Andres Salomon <dilinger@queued.net>,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240720012220.26d62a54@5400>
 <148efb2f-ef26-4759-98d3-5f6687c3cf12@redhat.com>
 <c11ba6f5-5e7d-463d-9b1a-d2e56de21af9@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c11ba6f5-5e7d-463d-9b1a-d2e56de21af9@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/29/24 6:41 PM, Armin Wolf wrote:
> Am 29.07.24 um 12:02 schrieb Hans de Goede:
> 
>> Hi,
>>
>> On 7/20/24 7:22 AM, Andres Salomon wrote:
>>> The Dell BIOS allows you to set custom charging modes, which is useful
>>> in particular for extending battery life. This adds support for tweaking
>>> those various settings from Linux via sysfs knobs. One might, for
>>> example, have their laptop plugged into power at their desk the vast
>>> majority of the time and choose fairly aggressive battery-saving
>>> settings (only charging once the battery drops to 50% and only charging
>>> up to 80%). When leaving for a trip, they might want to switch those
>>> settings to charge to 100% and charge any time power is available;
>>> rebooting into the BIOS to change those settings is a hassle.
>>>
>>> For the Custom charging type mode, we reuse the common
>>> charge_control_{start,end}_threshold sysfs power_supply entries. The
>>> BIOS also has a bunch of other charging modes with varying levels of
>>> usefulness, so this adds a new Dell-specific sysfs entry called
>>> 'charge_type' that's documented in sysfs-class-power-dell (and looks a
>>> lot like sysfs-class-power-wilco).
>>>
>>> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
>>> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
>>> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
>>> Both of their email addresses bounce, so I'm assuming they're no longer
>>> with the company. I've reworked most of the patch to make it smaller and
>>> cleaner.
>>>
>>> Signed-off-by: Andres Salomon <dilinger@queued.net>
>> Thank you for working on this and it is great to see the discussion
>> to improve the code between you and Pali going on.
>>
>> One concern which I have is that work is underway for both upower
>> and GNOME to add support for
>> /sys/class/power_supply/*/charge_[start|stop]_threshold
>>
>> to gnome-control-center.
>>
>> But if I understand things correctly then these limits will only
>> be honored when the charging-type is set to custom.
>>
>> So we need to do something to avoid userspace exposing those
>> controls when the charging-type is not custom.
>>
>> I think it would be best to not have the charge_[start|stop]_threshold
>> attributes visible when the charging mode is not custom.
>>
>> Regards,
>>
>> Hans
> 
> Hi,
> 
> the documentation of the "charge_type" sysfs attribute states that:
> 
>     "Custom" means that the charger uses the charge_control_* properties as
>      configuration for some different algorithm.
> 
> So i believe that "charge_[start|stop]_threshold" attributes should not be unregistered
> if "charge_type" is not "Custom" because:
> 
> 1. The power supply subsystem does not allow that for power supplies, and i see little
> reason to deviate from this behavior here.
> 
> 2. It is the responsibility of userspace to also set "charge_type" to "Custom" when using
> the "charge_[start|stop]_threshold" attributes.
> 
> Maybe we could clarify what happens when "charge_[start|stop]_threshold" is written without
> "charge_type" being "Custom". This might help userspace to correctly switch to custom charging
> and set the charging thresholds.
> 
> Basically, we could define that writes to "charge_[start|stop]_threshold" will get buffered by
> the driver if two conditions are met:
> 
> 1. "charge_type" is not "Custom".
> 
> 2. The hardware does not support setting the charging thresholds when "charge_type" is not "Custom".
> 
> Userspace can then first set "charge_[start|stop]_threshold" and then switch to custom charging.
> This prevents any problems should the hardware have no default value for the charging thresholds
> when switching to custom charging for the first time.

Ah I did not realize this was already documented in this way. Yes if this is
already documented this way then the driver does not have to do anything.

Instead userspace consumers of the "charge_[start|stop]_threshold" user should
check (and if necessary / if they want to set) "charge_type" = "Custom" on
power_supply class devices which have a charge_type.

Regards,

Hans



