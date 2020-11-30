Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2192C8C17
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbgK3SFB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 30 Nov 2020 13:05:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55668 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgK3SFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:05:01 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kjnX8-00088T-8S
        for linux-pm@vger.kernel.org; Mon, 30 Nov 2020 18:04:18 +0000
Received: by mail-pl1-f197.google.com with SMTP id a17so7733292pls.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 10:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lbLV76SSgjb5FPdOwfrJn+TCFMIEr3RFqzneb1IyIIQ=;
        b=IJfhtOV/0al7DBQpShjbe+Y6PnYqqajPZUembeaB1G40E4afA6GkDVjmBCbnVTv2kN
         LFQxV5DSP2tZ8YvD1RbGYk7AgmL7Pe+Mevds9UyKfYiH6GJQEaByf/McgXvH54nCxhLs
         OzSfD6WtOB2zBD+a0NCHbUDHpG3gfDP73ga1lwgsGN7PbDb+s8cUy0ANKQRN7AotwvnE
         8CwNnHiyKECvlBR8AfBC6YaJQK+k0mtzkzECsNrXLd5ns7vTrVt7xFLlFmf+11+ellvh
         NUhW1lluCBNtkdptF04txJ3Bp5UxIQsWhZWj1sTJt1uThCazY090uUZ8JhAfXXk48Eja
         ofEg==
X-Gm-Message-State: AOAM531Ksf2dwyho6813IrfMHUxDkN6/osJG7L0YrZ/fV6Mo/IhEXsGN
        +3HNi6iAMIFnNRSqYDKoWWCQfw+fJnM5Lf530R1cI0eTZQuUgQE1UFk0nTpRTANe1ljGHde5DTN
        H3ChMUZmRB+10PR09S7jkzc6ABZye69C5niQX
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr11473pjg.218.1606759456094;
        Mon, 30 Nov 2020 10:04:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6uluUsfX5kvn92f76WVxdgYxrS0rBDPQ1vKm6bk5auzL4eTSk/2BJu4nHZ+zigodiFh1BlA==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr11411pjg.218.1606759455681;
        Mon, 30 Nov 2020 10:04:15 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a2sm17807800pfo.117.2020.11.30.10.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:04:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
Date:   Tue, 1 Dec 2020 02:04:10 +0800
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
 <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
 <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Dec 1, 2020, at 00:19, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> On Mon, 2020-11-30 at 16:23 +0800, Kai-Heng Feng wrote:
>>> On Nov 30, 2020, at 15:57, Daniel Lezcano <
>>> daniel.lezcano@linaro.org> wrote:
>>> 
>>> 
>>> [Added Srinivas]
>>> 
>>> On 28/11/2020 18:54, Kai-Heng Feng wrote:
>>>> We are seeing thermal shutdown on Intel based mobile
>>>> workstations, the
>>>> shutdown happens during the first trip handle in
>>>> thermal_zone_device_register():
>>>> kernel: thermal thermal_zone15: critical temperature reached (101
>>>> C), shutting down
>>>> 
>>>> However, we shouldn't do a thermal shutdown here, since
>>>> 1) We may want to use a dedicated daemon, Intel's thermald in
>>>> this case,
>>>> to handle thermal shutdown.
>>>> 
>>>> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's
>>>> inside
>>>> ThermalZone. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
>>>> "... If this object it present under a device, the device’s
>>>> driver
>>>> evaluates this object to determine the device’s critical cooling
>>>> temperature trip point. This value may then be used by the
>>>> device’s
>>>> driver to program an internal device temperature sensor trip
>>>> point."
>>>> 
>>>> So a "critical trip" here merely means we should take a more
>>>> aggressive
>>>> cooling method.
>>> 
>>> Well, actually it is stated before:
>>> 
>>> "This object, when defined under a thermal zone, returns the
>>> critical
>>> temperature at which OSPM must shutdown the system".
>> 
>> This means specifically for the ACPI ThermalZone in AML, e.g.:
>> 
>> ThermalZone (TZ0) {
>> ....
>>    Method(_CRT) { ... }
>> } // end of TZ0
>> 
>> However the device is not under any ACPI ThermalZone.
>> 
>>> That is what does the thermal subsystem, no ?
>>> 
>>>> So add an indication to let thermal core know it should leave
>>>> thermal
>>>> device to userspace to handle.
>>> 
>>> You may want to check the 'HOT' trip point and then use the
>>> notification
>>> mechanism to get notified in userspace and take action from there
>>> (eg.
>>> offline some CPUs).
>> 
>> For this particular issue we are facing, the thermal shutdown happens
>> in thermal_zone_device_register() and userspace isn't up yet.
> 
> What about creating an new callback
> 
> enum thermal_trip_status {
> 	THERMAL_TRIP_DISABLED = 0,
> 	THERMAL_TRIP_ENABLED,
> };
> 
> int get_trip_status(struct thermal_zone_device *, int trip, enum
> thermal_trip_status *state);
> 
> Then in 
> static void handle_thermal_trip(struct thermal_zone_device *tz, int
> trip)
> {
> 
> /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
> if (tz->ops->get_trip_status) {
> 	enum thermal_trip_status *status;
> 
> 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
> 		if (status == THERMAL_TRIP_DISABLED)
> 			return;	
> 	}
> }
> ...
> ...
> 
> }
> 
> 
> This callback will help the cases:
> - Allows drivers to selectively disable certain trips during init state
> or system resume where there can be spikes or always. int340x drivers
> can disable always.

This sounds really great. This is indeed can happen on system resume, before userspace process thaw.

> - Still give options for drivers to handle critical trip even if they
> are bound to user space governors. User space process may be dead, so
> still allow kernel to process graceful shutdown

To make the scenario happen, do we need a new sysfs to let usespace enable it with THERMAL_TRIP_ENABLED?

Kai-Heng

> 
> Thanks,
> Srinivas
> 
>> 
>> Kai-Heng
>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/thermal/thermal_core.c | 3 +++
>>>> include/linux/thermal.h        | 2 ++
>>>> 2 files changed, 5 insertions(+)
>>>> 
>>>> diff --git a/drivers/thermal/thermal_core.c
>>>> b/drivers/thermal/thermal_core.c
>>>> index c6d74bc1c90b..6561e3767529 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -1477,6 +1477,9 @@ thermal_zone_device_register(const char
>>>> *type, int trips, int mask,
>>>> 			goto unregister;
>>>> 	}
>>>> 
>>>> +	if (tz->tzp && tz->tzp->userspace)
>>>> +		thermal_zone_device_disable(tz);
>>>> +
>>>> 	mutex_lock(&thermal_list_lock);
>>>> 	list_add_tail(&tz->node, &thermal_tz_list);
>>>> 	mutex_unlock(&thermal_list_lock);
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index d07ea27e72a9..e8e8fac78fc8 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -247,6 +247,8 @@ struct thermal_zone_params {
>>>> 	 */
>>>> 	bool no_hwmon;
>>>> 
>>>> +	bool userspace;
>>>> +
>>>> 	int num_tbps;	/* Number of tbp entries */
>>>> 	struct thermal_bind_params *tbp;
>>>> 
>>>> 
>>> 
>>> -- 
>>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM
>>> SoCs
>>> 
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog

