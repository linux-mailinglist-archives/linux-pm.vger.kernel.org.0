Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17332C7FBC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgK3IYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 30 Nov 2020 03:24:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgK3IYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 03:24:48 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjeTd-0006fc-T1
        for linux-pm@vger.kernel.org; Mon, 30 Nov 2020 08:24:06 +0000
Received: by mail-pl1-f198.google.com with SMTP id x17so7306447pll.8
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 00:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WC2KrYmZEQhS4bYbMRHeasgDxnYze36syp9Jw0G7Zl0=;
        b=JFIuATL/bqdVrt/ieMJ4XOra6JmoRIEcVZozvztnfi00UFBA0Rvf9lWJgYx12wn45H
         LYsZljxWBiYIkpxnEKS0lFFWYOEBK1FwEKbDxH87ZBVavY3yl+Es7noX7Qfu/nzi60qb
         3HbPQ90sAprTNo7A0m4ot8SSPBVrqJVQfKK50U+91H/ixV1+nV5hh4QwCKi9Ua4xW5Ps
         SIQNN/tBGU6z/3aSd1b7OBJVfw+RWf2YzIJHjMXFAfUevJdyrbSqCUa8J7AkYJOI4C0r
         bLutb0Pn7rOqhFEE1UlylypgFkVLAcjwVmmI3neFjx0Im3XRiqt3m8GOH8Cr0Gldc8Uz
         O8og==
X-Gm-Message-State: AOAM533d1eEDZxS1wHRQcod+2fiRZ/S7wv2xUlXEIo+sjtQIsrsRcZYt
        Aym5E1S1n1T38O3FtWUXyix7iTgEEeBNw7FWE727PGTG+lwchJD+X5oWrNQzxRN3Ti5G+7wwk4F
        65tUBLqE1tG6yZKkeui4pxCC/dwIwcxxqQsja
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr24400246pja.169.1606724644260;
        Mon, 30 Nov 2020 00:24:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzpiB/Npvx890VnGQHhXB2QM0Ikm4RSl0RFlxwAF94yhlBPWrtFx1sj/qbXacJqNEkN4/TDw==
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr24400219pja.169.1606724643869;
        Mon, 30 Nov 2020 00:24:03 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y188sm15679637pfy.98.2020.11.30.00.24.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:24:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
Date:   Mon, 30 Nov 2020 16:23:59 +0800
Cc:     Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Nov 30, 2020, at 15:57, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
> 
> [Added Srinivas]
> 
> On 28/11/2020 18:54, Kai-Heng Feng wrote:
>> We are seeing thermal shutdown on Intel based mobile workstations, the
>> shutdown happens during the first trip handle in
>> thermal_zone_device_register():
>> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
>> 
>> However, we shouldn't do a thermal shutdown here, since
>> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
>> to handle thermal shutdown.
>> 
>> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
>> ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
>> "... If this object it present under a device, the device’s driver
>> evaluates this object to determine the device’s critical cooling
>> temperature trip point. This value may then be used by the device’s
>> driver to program an internal device temperature sensor trip point."
>> 
>> So a "critical trip" here merely means we should take a more aggressive
>> cooling method.
> 
> Well, actually it is stated before:
> 
> "This object, when defined under a thermal zone, returns the critical
> temperature at which OSPM must shutdown the system".

This means specifically for the ACPI ThermalZone in AML, e.g.:

ThermalZone (TZ0) {
....
    Method(_CRT) { ... }
 } // end of TZ0

However the device is not under any ACPI ThermalZone.

> 
> That is what does the thermal subsystem, no ?
> 
>> So add an indication to let thermal core know it should leave thermal
>> device to userspace to handle.
> 
> You may want to check the 'HOT' trip point and then use the notification
> mechanism to get notified in userspace and take action from there (eg.
> offline some CPUs).

For this particular issue we are facing, the thermal shutdown happens in thermal_zone_device_register() and userspace isn't up yet.

Kai-Heng

> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/thermal/thermal_core.c | 3 +++
>> include/linux/thermal.h        | 2 ++
>> 2 files changed, 5 insertions(+)
>> 
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index c6d74bc1c90b..6561e3767529 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>> 			goto unregister;
>> 	}
>> 
>> +	if (tz->tzp && tz->tzp->userspace)
>> +		thermal_zone_device_disable(tz);
>> +
>> 	mutex_lock(&thermal_list_lock);
>> 	list_add_tail(&tz->node, &thermal_tz_list);
>> 	mutex_unlock(&thermal_list_lock);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index d07ea27e72a9..e8e8fac78fc8 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -247,6 +247,8 @@ struct thermal_zone_params {
>> 	 */
>> 	bool no_hwmon;
>> 
>> +	bool userspace;
>> +
>> 	int num_tbps;	/* Number of tbp entries */
>> 	struct thermal_bind_params *tbp;
>> 
>> 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

