Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB61D9449
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgESKZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 06:25:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D4C05BD09
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 03:25:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u1so1702338wmn.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=awX2jX8LmUgDnV/EUVgSbcUlz7JrWITf9HWfSAf2CVQ=;
        b=xMsQmaXiJ9VvVmdReYjodGgkm8EEhzCHVGSQFm47FrlYqPR/OHZqgTVBmJL5mEVBo3
         gVBlJASFpfphtWqcb/NjT7kQtfXcs0L7ikF88YcheiyZGzWQCGSfbZQHAHr7agXMvKb1
         5sk/8ElwA8L+SGCyI6TwiA/hhvI2VabhMbqmSZ0gPMt4Zj7NdYS6HHr2U7v29rKcCaFQ
         SP628cok5ydOh9OtbOmThuVPn5iHhcIk0fw/Rqx2+iUy1GXz5FL2jzZI9IlTCsOnZCZa
         ciiO+ssSR6klZ+hjEMzS9uaMIucaT1P0dt8CKbieKf/VUuUswBK4vmNa6Hvn8JLUI7Zc
         YaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=awX2jX8LmUgDnV/EUVgSbcUlz7JrWITf9HWfSAf2CVQ=;
        b=gPhQxsk94OzwkXcpCVsdrim/tV9YICGqQ/bYAcNRBWRRLItXKvRDMe/eGBZl0oKF4O
         M4sv5ydwZuEz6VpFhdAjX5p2572KJ/TcGl1A9uhwbLEhib0nAspITfqhoveL2c39gs6Y
         M1JOG86O7mo5EyQJzBYkjX9+JFhMPXnVPdBOxUvgLzIUjWXaNV9THrQAC8zuGjxxARx0
         xzR5DiJ+Bz4F2tgh+6KLUUrJv+uxUDNzOTIgYqAKA25kxxXsjkMkwGUFpv8/DvOf0j/H
         baCiCtp+hOIOqsvYv8wow45EsBv3Rz2inbPcvTPcSBcQcAR6AR6yuhH1acKuSHDjQsdM
         JLGA==
X-Gm-Message-State: AOAM531cr5xnH+YZklK0IcDZlupg327YB3y3o1WtFq11Ync4SnObI8i8
        XcAy5hCPpYc/ZNs0h3qJFLNdCh7Jsfk=
X-Google-Smtp-Source: ABdhPJwCiCfZqap0SEdqAJlNQBrsjU/jJNF4qpGS38ljuuhN5oNUNql4zHZPXEUm3UlIetoObwQuqg==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr4499067wmc.76.1589883902079;
        Tue, 19 May 2020 03:25:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e504:4297:986:ffb0? ([2a01:e34:ed2f:f020:e504:4297:986:ffb0])
        by smtp.googlemail.com with ESMTPSA id 8sm3519290wmb.15.2020.05.19.03.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 03:25:01 -0700 (PDT)
Subject: Re: [RFC][PATCH 4/5] thermal: Add support for setting polling
 interval
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
 <c2aad548-32c2-f008-5ce4-97b76a19271d@linaro.org>
 <b74767964b028c297840aefc166e2384333afd3b.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3898cf1a-8e4c-def4-73f7-9ef4954e88b8@linaro.org>
Date:   Tue, 19 May 2020 12:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b74767964b028c297840aefc166e2384333afd3b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/05/2020 01:46, Srinivas Pandruvada wrote:
> On Mon, 2020-05-18 at 18:51 +0200, Daniel Lezcano wrote:
>> On 04/05/2020 20:16, Srinivas Pandruvada wrote:
>>> Add new attribute in the thermal syfs for setting temperature
>>> sampling
>>> interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined. The
>>> default
>>> value is 0, which means no polling.
>>>
>>> At this interval user space will get an event THERMAL_TEMP_SAMPLE
>>> with
>>> temperature sample. This reuses existing polling mecahnism when
>>> polling
>>> or passive delay is specified during zone registry. To avoid
>>> interference
>>> with passive and polling delay, this new polling attribute can't be
>>> used
>>> for those zones.
>>
>> The userspace can get the temperature whenever it wants via the
>> temperature file. The polling is designed for a specific hardware and
>> the slope of the temperature graphic.
>>
>> The userspace has the alternative of reading the temperature based on
>> its own timer or wait for (and stick to) the thermal framework
>> sampling
>> rate. Adding a notification in the update is enough IMO.
>>
> The problem with this approach is that the user can't change sampling
> interval. Those polling intervals are fixed during thermal-zone
> register. Is there any way to change those defaults from user space?

No, we can't but the userspace can decide when to read the temperature
(via sysfs or netlink) and thus decide its own sampling rate.

Otherwise, we are talking about an userspace governor, so the platform
is setup with the desired sampling rate + userspace governor.

> Kernel can start with some long polling interval and user space can
> change close to some trip.

Ok, let me rephrase it. This (big) comment encompass also patch 3/5.

I understood now the initial need of adding user trip points.

There are platforms where the interrupt mode does not exist so setting
an user trip point does not set the interrupt for the closer
temperature, hence we end up with a kernel sampling rate and in this
case adding a trip point + new user sampling rate is pointless as the
userspace can poll the temperature at its convenient rate.

If we summarize the different combinations we have:

1. monitoring : interrupt mode, mitigation : interrupt mode

There are no thermal zone update until an interrupt fires. The
mitigation is based on trip point crossed.

2. monitoring : interrupt mode, mitigation : polling

There are no thermal zone update until an interrupt fires. The
mitigation happens with a sampling rate specified with the polling rate.

3. monitoring : polling, mitigation : polling

The thermal zone is updated at the polling rate, the mitigation occurs
with an update at the second polling rate.

IIUC, the RFC proposes to add a new type of temperature threshold,
followed a new polling rate to update the userspace.

IMHO, it is not a good thing to delegate to the kernel what the
userspace can handle easily.

I suggest:

 - Not add another polling rate. If the thermal zone has a polling rate
or supports the interrupt mode, then the user trip point setup succeed
otherwise it fails and up to the userspace to read the temperature at
its convenient rate. (Note multiple process may want to get temperature,
so one should not set the rate of others).

 - Not add another temp threshold structure but add a new trip type
"user" and keep using the existing trip structures, so the notification
can happen in the handle_trip_point function. The sysfs only reflects
the setup via the "trip_point_x_hyst", "trip_point_0_temp",
"trip_point_x_type"

 - Do not use sysfs for setup but rely on the genetlink for one message
setup instead of multiple sysfs file writing. Adding a trip point will
be straighforward.


What do you think?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
