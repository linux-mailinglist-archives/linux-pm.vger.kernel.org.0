Return-Path: <linux-pm+bounces-10267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874591D57D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 02:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC81C20CA1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 00:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680CA94D;
	Mon,  1 Jul 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA/Ycq4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E88F66
	for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719793059; cv=none; b=WDvd9oK8Z/hwBrCMEyPcf95XqnhTD/z70OOS0UsT5si+LBurYZ3foIIBT0Lz7vEkU9V1iIOJrcqSlTt1xP+eG5LgPc8G9tD4wrhYzFytEaSiNOx235SbxZt2IMDH7mtQApbozZftGcMj0++mAxek99V/aV1JJ9GXE+1k2TPUxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719793059; c=relaxed/simple;
	bh=QaN9gni6DBgvdeYW+GJEmKIW3k11vr5L6sk+8si7MuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMeJ+kzuWkurppvvwSdLQTaS3E+zmbGoNWd0K2lE+6yhGpbJNGeRI7TwU06FCiy6PTvi9+eT9fAgYrY0ayveeQZibNNOA3vzVKmLFtL6tNK0jYAB9Wkw/P/wS/lkVO/1/2T5rYQOk0YX6eUV1iaiz+EONIq61AG7uwP9+7jbEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hA/Ycq4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719793056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM4N7GR2BG5LIn+6MSOyJKM/XymBQm17tFxWvcJSyZA=;
	b=hA/Ycq4lYB3jAe1veP9l7BC/jlss001jr1CZOlCJWi3onWgJc34PhBroL42gzErutJCWxZ
	3pbxB1grt5Qqw/UomSTjezssuOtpXJtV2r+a720f2Lwd5/l+bqz6+VN7K99M/9rmT3NuMj
	k9VDckmvhYaIT9sdKctvAHlgLuUtvu8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-97zcMIYLN92bjLK9cBEmng-1; Sun, 30 Jun 2024 20:17:33 -0400
X-MC-Unique: 97zcMIYLN92bjLK9cBEmng-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6c9b5e3dd67so1475165a12.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Jun 2024 17:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719793053; x=1720397853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM4N7GR2BG5LIn+6MSOyJKM/XymBQm17tFxWvcJSyZA=;
        b=HOeiXIZPnH3VS6J+DuWLCu6scMW7Lqzld9qUh4eyfrW/Q1N4hjxkZBGv3tm52Yo/Jo
         tK4HcpRUF3ZDmfI2+fWlTPY9prl5CMTMMNhiqk3TSR0/ZDWVVIlacO8++smJcQk99WE9
         y8R7+batdg7A5IA/mJeP7pufq9rXVB64vg2DrFtPjfxXJiOUwc6r9pdveFX4xoSYM8I2
         7d2ZXF+WEMk095sl38Y3wzq0plOM9wd5Hl3yIQKqR/lVeEabIj1xaDme3CgyLXYidiMJ
         VqVdiosbim/CWKe8vCtb0VQ7JiG2uT9Nb21dJlc7pCxeBr+5y/RWcmIeB9EexuLrSPYP
         gCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc++94A3Wafpcu0nIWj1dx4EBf1nVEjgWYq2vbnlBRLqU22YuM/gB7xhzbUGbgTTCjmklnoCFaCLdS5+OCC14AASVNl+p5jZ0=
X-Gm-Message-State: AOJu0YwFYvT0+DSpxRIJU+Qrk/yV8n4y7lh3rxqX+WjoWbulXUdUcUtI
	vJYP2CJgAftE/HEph3vFvSf8fUrSRq5IYIpkMcXEDBACltaNTeqMtJ4xr+pyZttWfej50Otl5EK
	/e0gURn4pnL3Hdl78xhgBrsj511ZDiQ4yXFSMZSnpzD5vM4NDhg+2Ozjj
X-Received: by 2002:a05:6a20:8422:b0:1b5:fd58:30e8 with SMTP id adf61e73a8af0-1bef6140771mr3102502637.18.1719793052829;
        Sun, 30 Jun 2024 17:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV87JbqD0DsihOx5ZuGLa4+/4zwRBogo0J72ZOMm/cMfn9jliB3oM03TcsWl+71BSax9Qkzw==
X-Received: by 2002:a05:6a20:8422:b0:1b5:fd58:30e8 with SMTP id adf61e73a8af0-1bef6140771mr3102480637.18.1719793052446;
        Sun, 30 Jun 2024 17:17:32 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535d1fsm51606915ad.144.2024.06.30.17.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 17:17:31 -0700 (PDT)
Message-ID: <fb6ec18c-143f-4fb2-8ca6-c3e425864e63@redhat.com>
Date: Mon, 1 Jul 2024 10:17:20 +1000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
 <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
 <47a261e0-006d-4c64-9c9b-bc73797b8d6b@redhat.com> <ZoEk2mfQkIhLuh-8@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZoEk2mfQkIhLuh-8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Catalin,

On 6/30/24 7:26 PM, Catalin Marinas wrote:
> On Sun, Jun 30, 2024 at 10:39:04AM +1000, Gavin Shan wrote:
>> On 5/29/24 11:34 PM, Jonathan Cameron wrote:
>>> In order to move arch_register_cpu() to be called via the same path
>>> for initially present CPUs described by ACPI and hotplugged CPUs
>>> ACPI_HOTPLUG_CPU needs to be enabled.
>>>
>>> The protection against invalid IDs in acpi_map_cpu() is needed as
>>> at least one production BIOS is in the wild which reports entries
>>> in DSDT (with no _STA method, so assumed enabled and present)
>>> that don't match MADT.
>>>
>>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    arch/arm64/Kconfig       |  1 +
>>>    arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
>>>    2 files changed, 23 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 5d91259ee7b5..e8f2ef2312db 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -5,6 +5,7 @@ config ARM64
>>>    	select ACPI_CCA_REQUIRED if ACPI
>>>    	select ACPI_GENERIC_GSI if ACPI
>>>    	select ACPI_GTDT if ACPI
>>> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
>>
>> ACPI_HOTPLUG_CPU depends on (ACPI_PROCESSOR && HOTPLUG_CPU). It needs to be:
>>
>> 	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>>
>> Otherwise, we can have compiling error with the following configurations.
>>
>> CONFIG_ACPI_PROCESSOR=y
>> CONFIG_HOTPLUG_CPU=n
>> CONFIG_ACPI_HOTPLUG_CPU=y
>>
>> arch/arm64/kernel/smp.c: In function ‘arch_unregister_cpu’:
>> arch/arm64/kernel/smp.c:563:9: error: implicit declaration of function ‘unregister_cpu’; did you mean ‘register_cpu’? [-Werror=implicit-function-declaration]
>>    563 |         unregister_cpu(c);
>>        |         ^~~~~~~~~~~~~~
>>        |         register_cpu
> 
> Ah, I thought that in addition to the warning for unmet dependencies,
> kbuild would also leave the option off. I need to add SUSPEND=n and
> HIBERNATE=n to my build scripts.
> 
> The fix matches what x86 does, so I'm ok with it.
> 

Ok, thanks for your confirm.

>> Since the series has been queued to Catalin's "for-next/vcpu-hotplug" branch, I
>> guess the easiest way would be to fix it in place with Catalin's help.
> 
> I wasn't planning to rebase the branch unless there's something major.
> Since the doesn't happen with defconfig, it's doesn't affect bisection
> that much, so my preference would be for a fix on top of this branch
> (and with a Fixes: tag since the branch is stable).
> 

Sure, I've posted a fix, applicable to branch 'for-next/vcpu-hotplug'.

https://lists.infradead.org/pipermail/linux-arm-kernel/2024-June/939690.html

Thanks,
Gavin


