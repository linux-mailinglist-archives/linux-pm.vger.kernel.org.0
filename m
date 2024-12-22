Return-Path: <linux-pm+bounces-19651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B49FA511
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 10:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C90C1888A60
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56118A921;
	Sun, 22 Dec 2024 09:59:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAB188714
	for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734861574; cv=none; b=fmYut7r9eBLt2FzBRk+71RIdzpUt452i+e/bgWTS/6KauJ4ZDzEpPtiGLrTXw833EDQZDPIUu7b6uzhLnhlNJp6xycllFZ9ODumV6dOtwZG1qGOq/QScmzjayUEx7D9pmW1DWLqyBZ/MScA5SeK+YWZQqLWBmJCVx8SBJ3gI8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734861574; c=relaxed/simple;
	bh=c1jEBsE0ZFcv4ZJbYf/uCmaCL4wXgSXoJOgd1V9o03U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnZmLNhb2Nu6gAVmzybkLbFvfzrWpMYwqOvv6FlcS6MTFqJjQyHMfmnIkauTV55IywcJzJ3Psn1o55/KIIhvMdZEFSaCc+vqoX3svByC3igeht2ztGD+8eeL8Bs5+DMV+RRIc1EJW4Fx+gBBQlMjblIXppsLshrQe7c3sToYThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tPIjY-000172-TX; Sun, 22 Dec 2024 10:58:48 +0100
Message-ID: <273ef7c1-3a4f-4413-9b0b-a3e0fba366a8@pengutronix.de>
Date: Sun, 22 Dec 2024 10:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] reboot: support runtime configuration of emergency
 hw_protection action
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
 kernel@pengutronix.de, Matteo Croce <mcroce@microsoft.com>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
 <dc8d1cdf-dff4-48fc-a03d-aeab9be22e44@gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <dc8d1cdf-dff4-48fc-a03d-aeab9be22e44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hello Matti,

On 22.12.24 10:38, Matti Vaittinen wrote:
> On 19/12/2024 09:31, Ahmad Fatoum wrote:
>> We currently leave the decision of whether to shutdown or reboot to
>> protect hardware in an emergency situation to the individual drivers.
>>
>> This works out in some cases, where the driver detecting the critical
>> failure has inside knowledge: It binds to the system management controller
>> for example or is guided by hardware description that defines what to do.
>>
>> This is inadequate in the general case though as a driver reporting e.g.
>> an imminent power failure can't know whether a shutdown or a reboot would
>> be more appropriate for a given hardware platform.
> 
> Sometimes it can. There are platforms where the hardware is such we know that poweroff or reboot are the way to go. In such case the driver should get the information from the hardware description (like device-tree).

Sure, the thermal framework for example has a device tree property that
tells it what the critical action should be. This continues to work as
before, but this series adjust only the default behavior when that device
tree property is missing.

>> To address this, this series adds a hw_protection kernel parameter and
>> sysfs toggle that can be used to change the action from the shutdown
>> default to reboot. A new hw_protection_trigger API then makes use of
>> this default action.
>>
>> My particular use case is unattended embedded systems that don't
>> have support for shutdown and that power on automatically when power is
>> supplied:
>>
>>    - A brief power cycle gets detected by the driver
>>    - The kernel powers down the system and SoC goes into shutdown mode
>>    - Power is restored
>>    - The system remains oblivious to the restored power
> 
> This sounds like a consequence of a hardware design as restoring the power doesn't wake up the SoC(?)

There are two thresholds involved: One when the regulator first reports imminent
voltage loss and the kernel does something about it and one when the capacitor
have been depleted enough that the CPU is powered off.

With short voltage glitches (or big enough capacitors), I run into the situation,
where the kernel gets a voltage loss interrupt, goes into shutdown, but voltage
is restored before the CPU is actually powered off. As the system isn't designed
for shutdown anyway, there is no mechanism to wake up from it and we need to
hard power cycle the device.

>>    - System needs to be manually power cycled for a duration long enough
>>      to drain the capacitors
>>
>> With this series, such systems can configure the kernel with
>> hw_protection=reboot to have the boot firmware worry about critical
>> conditions.
> 
> I am not against the change though. Just wondering if this is still a consequence of the hardware design, and if the device-tree would be proper place to indicate that poweroff shouldn't be used.

I considered this initially: add a device tree property for regulators, like there's
already for thermal zones. But I concluded that that this is a system-wide decision
and should be decided on at a system-wide level. We already have a
reboot=[warm,cold,...etc.] parameter, so this fits right in and it allows configuring
this also for non-DT platforms.

> I'm about to leave my computer behind for holidays, so I am probably not able to do a proper review until the next year. Thus this quick comment :) Also, no strong opinion so I'm not expecting anyone to hold back waiting for me!

Thanks and wishing you happy holidays as well.

Cheers,
Ahmad

> 
> Good luck and happy holidays!
> -- Matti
> 
>> ---
>> Ahmad Fatoum (11):
>>        reboot: replace __hw_protection_shutdown bool action parameter with an enum
>>        reboot: reboot, not shutdown, on hw_protection_reboot timeout
>>        docs: thermal: sync hardware protection doc with code
>>        reboot: rename now misleading hw_protection symbols
>>        reboot: indicate whether it is a HARDWARE PROTECTION reboot or shutdown
>>        reboot: add support for configuring emergency hardware protection action
>>        regulator: allow user configuration of hardware protection action
>>        platform/chrome: cros_ec_lpc: prepare for hw_protection_shutdown removal
>>        dt-bindings: thermal: give OS some leeway in absence of critical-action
>>        thermal: core: allow user configuration of hardware protection action
>>        reboot: retire hw_protection_reboot and hw_protection_shutdown helpers
>>
>>   Documentation/ABI/testing/sysfs-kernel-reboot      |   8 ++
>>   Documentation/admin-guide/kernel-parameters.txt    |   6 +
>>   .../devicetree/bindings/thermal/thermal-zones.yaml |   5 +-
>>   Documentation/driver-api/thermal/sysfs-api.rst     |  25 +++--
>>   drivers/platform/chrome/cros_ec_lpc.c              |   2 +-
>>   drivers/regulator/core.c                           |   4 +-
>>   drivers/regulator/irq_helpers.c                    |  16 +--
>>   drivers/thermal/thermal_core.c                     |  17 +--
>>   drivers/thermal/thermal_core.h                     |   1 +
>>   drivers/thermal/thermal_of.c                       |   7 +-
>>   include/linux/reboot.h                             |  25 +++--
>>   include/uapi/linux/capability.h                    |   1 +
>>   kernel/reboot.c                                    | 122 ++++++++++++++++-----
>>   13 files changed, 173 insertions(+), 66 deletions(-)
>> ---
>> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
>> change-id: 20241218-hw_protection-reboot-96953493726a
>>
>> Best regards,
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

