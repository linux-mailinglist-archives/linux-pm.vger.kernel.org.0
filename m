Return-Path: <linux-pm+bounces-24252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44EBA6754F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B8218896EE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61C20CCF3;
	Tue, 18 Mar 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0yMaarB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467120C488;
	Tue, 18 Mar 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305036; cv=none; b=eSVfo4pfsYYcDF7LujXTxrYqb9lcYp17qS0b7TPj7zergGGRNYGAcLYzyCyB30mLzu66DoaCNtGNV6l4KJGj4JiB2/8FnFhVmgzgsEf/7vVmy66ycciVsSt2/3PhfwQzmbD7ivEL+Spw63OfxJX/XQPNb0qgqKlVOvKpuuVD5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305036; c=relaxed/simple;
	bh=gLiS5E5/j41dAF2u1/PRS3kABwQBMosBY3vftDyMJT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGqAf+jRHmNFpg+73wLcD1RxXjtwJU+qqcjfy49MCfYExNXs5oHd2AJYzr92vlq/IAfcZQFKlrJqYTjulGZJVZxVfi1Xno5o05GyK6NYAjsvtOW7kFG0RyNK5ghhdsO4M6F4U76iK4+tyArnSBPgO+fwP4ZD2Iq9e710QIjDfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0yMaarB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bf251025aso49129261fa.1;
        Tue, 18 Mar 2025 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742305033; x=1742909833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4aQ/USEziwqIOaBZZu1tr4dqrJ+/dAALL9yIUU01u8=;
        b=i0yMaarBvKZFatIbaAMpjJj3CxtYWdpmGnvLjiTDbOnSkvmGim/881X0d+GNu09sX7
         SzAFOP/HbOLM7JsKsoJd9ioCMkRhYpVSRr/gEeUu6Dj9gxEIor3pZUGfMlc7yVKmUbSU
         UEnEM3tmX9vGki+bgPSTG7lTff8tUddr8L75Iw0VlZnAtBUeDS3HorKmSOWogtgOOtsV
         Pp5Ui7evSP45WDFrqKxdSz6nQYmQISpHIoEkYapgm4kQZSRthdxI/W5VVwIDknHx7Hga
         I2nnus6YOnE3WDrpY0C4Zd2zElNOyMy+W6ql4kKVZO7fO0xrBSTTt0hB7LlHZIu750w6
         ihrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742305033; x=1742909833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4aQ/USEziwqIOaBZZu1tr4dqrJ+/dAALL9yIUU01u8=;
        b=s62dlWBob48Av4hZnrG66kOPh9I6LF7ijqaJDBm5/RmX9Htx6fVxqOw/sny3SEvN1O
         tlew8VRMyGqPFqxYqtNfz3XwgUEYc7NR+SfBrBUrjFEAS4D0Gbf3PZh1YQcWtap0WAlX
         SzPk0+Pz99m7fu46Gz4J8qdkAluNDQJjkvDRi83E+z4nXO/mlyEiERGQ3tF5AABKSzEM
         Ug8//PbkuoWW9+/Jg4K9VfzSXCDd0HwGEZBCWZpVX6/RWhO17H93U+cG6bQjskk3XL1i
         8+7jDGfqat84ROgWvWBLScMJfMK7mSNm8hrQjRR8m6m+8UXq1T71cSVYRTTJeH8dST+x
         k9lg==
X-Forwarded-Encrypted: i=1; AJvYcCU37GF+AqiRl+tgUeSSdCB7soUf7Hem4TpfxTvgQffdeQW/0RwXlM0MhdkDujEMjdrN7+OODCi0vPI0IUc=@vger.kernel.org, AJvYcCUZAJrstJrZOL7xbNZVzQGkV3NqSmPsL+J7QYHlHT0o9HchuhaDd4ZBr+c22m+5qI8EauDmdaynOxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+q60jQoYOW99JJNV0Zfvr0NKWQU8VYgonoZXZWkfbTpLVnG4B
	1ZnpRgZaSjE2QtUFveMS55Dz4/GLsIXUmJLnT/ep/i75Zn/6haDF
X-Gm-Gg: ASbGncvvhq+wG3nuMzw8GX+uFpGoLnfpIfWNipXzT/y1n/QCVwBDWkVMVeQUBEbKDQ8
	Ovwf490NVYnahOGnVh9Xt3HcdgtKfr/i8qgAL8Me+67X6rMV00jKc5EKrJZM5qDwZ+bdkCDJeP5
	7fbb7dFEIklPHfLGwr6ZwrOXZc3n66EFyMXo3gMyStB1hz+dqZi8+hQQVg8eUFLpyTGANEm17z9
	rqMFPs82ZIApq7Rl7X0zqHVQHWkewfXkkUQEv+HHlyIikJTgr/sEdSPcPiqdMgQC/AmhuDZfN6G
	sVZeBhVWJtibErTdpYbq/7s2DWSwanw+3sd63UMA4aTpYS5peAymjqBxZQ==
X-Google-Smtp-Source: AGHT+IEYDxjpurPTXOW71G6SyX12wDygoGfJ2GHwNa6UtiAhkrvs17fqOzsC4BMVYEpW1w8Wfj8UYw==
X-Received: by 2002:a05:6512:32d1:b0:54a:c4ad:3956 with SMTP id 2adb3069b0e04-54ac4ad3c18mr1038951e87.1.1742305032393;
        Tue, 18 Mar 2025 06:37:12 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88507fsm1657435e87.198.2025.03.18.06.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:37:11 -0700 (PDT)
Message-ID: <3e130395-8352-4de6-a82e-52594ce1d11f@gmail.com>
Date: Tue, 18 Mar 2025 15:37:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, chrome-platform@lists.linux.dev,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 kernel@pengutronix.de, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Zhang Rui <rui.zhang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-4-o.rempel@pengutronix.de>
 <ea681b76-db1c-4529-bd53-09e4bf384977@gmail.com>
 <Z9ly2eC0_r3gyToy@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9ly2eC0_r3gyToy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 15:19, Oleksij Rempel wrote:
> On Tue, Mar 18, 2025 at 01:01:30PM +0200, Matti Vaittinen wrote:
>> On 18/03/2025 11:47, Oleksij Rempel wrote:
>>> This commit introduces the Power State Change Reasons Recording (PSCRR)
>>> framework into the kernel. The framework is vital for systems where
>>> PMICs or watchdogs cannot provide information on power state changes. It
>>> stores reasons for system shutdowns and reboots, like under-voltage or
>>> software-triggered events, in non-volatile hardware storage. This
>>> approach is essential for postmortem analysis in scenarios where
>>> traditional storage methods (block devices, RAM) are not feasible. The
>>> framework aids bootloaders and early-stage system components in recovery
>>> decision-making, although it does not cover resets caused by hardware
>>> issues like system freezes or watchdog timeouts.
>>
>> We might want to rephrase this if we envision that boot reason could be read
>> from PMICs (or other devices able to store the boot reason) using PSCRR
>> interface. (Because a few PMICs can store the boot reason even for the
>> hardware initiated shutdowns like Watchdog or voltage/current protection).
> 
> ack.
> 
>>> It is primarily intended for controlled power
>>> +	  state transitions.
>>> +
>>> +	  If unsure, say N.
>>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>>> index 10782d32e1da..dbd6ae6b26a4 100644
>>> --- a/drivers/power/reset/Makefile
>>> +++ b/drivers/power/reset/Makefile
>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
>>>    obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
>>>    obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
>>>    obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
>>> +obj-$(CONFIG_PSCRR) += pscrr.o
>>>    obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>>>    obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>>>    obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>>> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
>>> new file mode 100644
>>> index 000000000000..466eca0e4f7f
>>> --- /dev/null
>>> +++ b/drivers/power/reset/pscrr.c
>>> @@ -0,0 +1,417 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * pscrr_core.c - Core Power State Change Reason Recording
>>> + *
>>> + * This framework provides a method for recording the cause of the last system
>>> + * reboot, particularly in scenarios where **hardware protection events** (e.g.,
>>> + * undervoltage, overcurrent, thermal shutdown) force an immediate reset.
>>
>> Is this contradicting the Kconfig / commit message?
> 
> There is so many redundant text, i already lost track of it.  What do
> you mean?

Sorry, I should've been more specific :)

I was just thinking that it may be hard to understand what type of 
events the PSCRR is able to detect. The commit message (which I thought 
might be rephrased a bit) said:


The
 >>> framework aids bootloaders and early-stage system components in 
recovery
 >>> decision-making, although it does not cover resets caused by hardware
 >>> issues like system freezes or watchdog timeouts.

(What I got stuck was the "does not cover resets caused by hardware 
issues" - but maybe it's just my limited reading abilities because the 
sentence seems to say also: "like system freezes or watchdog timeouts". 
So perhaps there is no contradiction here.)

Kconfig says:

Note
+	  that this framework does not track hardware-induced resets, such as
+	  system freezes, watchdog timeouts, or sudden power losses without
+	  controlled shutdown. It is primarily intended for controlled power
+	  state transitions.

Here we however have:

"particularly in scenarios where **hardware protection events** (e.g.,
undervoltage, overcurrent, thermal shutdown) force an immediate reset."

So, I was wondering if there is a way to clarify what type of hardware 
protection events are covered, and what aren't. I know this is not easy, 
especially if we allow reset reasons from PMICs to be included.

The comment was a 'nit' so if you see no good way to improve, then 
please keep it as it is.

>>
>>> Unlike
>>> + * traditional logging mechanisms that rely on block storage (e.g., NAND, eMMC),
>>> + * PSCRR ensures shutdown reasons are preserved in a way that survives power
>>> + * loss for later analysis.
>>
>> Here, the 'level of power-loss' plays a role, right? I assume some level of
>> power must be retained for the 'storage' to stay alive.
> 
> Yes, on the system I'm working on, there is designed capacity and
> voltage drop detector to do $THINGS before the system will go off. To
> get the full picture you may take a look to following patches:
> 
> https://lore.kernel.org/all/20231026144824.4065145-1-o.rempel@pengutronix.de
> https://lore.kernel.org/all/20250310102229.381887-1-o.rempel@pengutronix.de
> 


