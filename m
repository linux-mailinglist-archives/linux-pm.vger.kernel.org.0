Return-Path: <linux-pm+bounces-11009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0B92F1A7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 00:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1901C20DF8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA0016D326;
	Thu, 11 Jul 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vpq4bz06"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DF54903
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735472; cv=none; b=hFzJSQEZx02U56oosEMUsTyMPXByOjEApT/jj7K2bdd7FHBHeZDxvdkxdK+YOa6+3bLz2NzwiEjiCKGUB+0teIPTsHlW5U8ggwfpJq5SVAOQbbhLEqdCri/SSaic3yW04S4q6FcoRZQTM+rdG6xDvP4HJNj0KYTlG95ld2L42i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735472; c=relaxed/simple;
	bh=jTtojrs415LsZjpQ0Vn2QfRq+QwuphR8j59Tynk8jgQ=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dM6k4JsnMMI2+z8SPLWzGSuHvXoX7YgbbZpmegySO+mmxVENo1/WqSNR4qPMfg0X1v4AjYRSdajYHQjw27bYSVCaYg4Z4pY2rpX49xE9IHWOpJYlQ/gZNhfWY0f8aT6O7m2XjDbG1H1u9BNaBUROLMsFZLtP5UQ3FhkJqsVPzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vpq4bz06; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720735467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=buTfwAwTuTr+XL/Sjd9SAC3T4TE2wTRulcsG9043rJ4=;
	b=Vpq4bz06ckPCogcsR9ZB3WivafiENm7Nebvc/Kjzv0bZwzHZuIIolYGX2ose415uVm1KOr
	AzrXop4O9gLQBn3+mKKZUvgK2kcXw1p18Zvnd2cOnLkjDT51yu4iA/OpfN9I7NxsaMSt5l
	ocnY7h+aJWSkxIKQOQn1GxMAgUYzO1w=
X-Envelope-To: rui.zhang@intel.com
X-Envelope-To: amitk@kernel.org
X-Envelope-To: daniel.lezcano@linaro.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: andy.tang@nxp.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
Message-ID: <4572255d-282a-4e26-85bd-8bd83b845c89@linux.dev>
Date: Thu, 11 Jul 2024 18:04:22 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Amit Kucheria <amitk@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, Yuantian Tang <andy.tang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Designing a thermal policy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi All,

I'm working on adding some thermal zones for the ZynqMP, but I'm not
sure what I should set the passive/critical temperatures to. I've done
some looking around the tree, but there seem to be as many thermal
policies as there are SoCs. While the thermal policy I select will be
specific to the ZynqMP, I think the decisions are common to most SoCs.

My goals
========

I would like to achieve the following goals for in-tree trip points, in
order of priority:

1. Provide safe defaults that can be used without modification (agnostic
   to e.g. the size of the heatsink on any particular board).
2. Achieve as much thermal margin as possible.

Additionally, I also want to determine good trip points for my specific
hardware, if they happen to be different from the above.

The Hardware
============

All ZynqMP parts have an absolute maximum junction temperature of 125C.
Additionally, for extended/industrial parts, the recommended maximum
operating temperature is 100C, and for automotive/military parts the
recommended maximum operating temperature is 125C. Xilinx has the
following to say about these values:

> Stresses beyond those listed under Absolute Maximum Ratings might
> cause permanent damage to the device. These are stress ratings only,
> and functional operation of the device at these or any other
> conditions beyond those listed under Operating Conditions is not
> implied. Exposure to Absolute Maximum Ratings conditions for extended
> periods of time might affect device reliability.

So, as I interpret it:

- Extended/industrial devices may not function properly above 100C [1].
- Extended/industrial devices will be damaged if operated above 100C
  for extended periods. However, it may be acceptable to tolerate brief
  excursions (such as the time taken to shut down).
- All devices will be damaged if operated above 125C.

Additionally, there is some uncertainty in the temperature measurement
using the internal sensors. Below 110C, the temperature is accurate to
within 3.5C. Above 110C, the temperature is accurate to within 5C. So
a measured temperature of above 96.5C could indicate an actual
temperature of 100C. Similarly, a measured temperature of 120C could
indicate an actual temperature of 125C.

Complicating things is that there is no way to determine what
temperature range a device supports at runtime. The only way to tell
what temperature range a device is in is to look at the package marking.
I think the easiest way to solve this would be to set trip points
appropriate for extended/industrial devices and have userspace update
the trip points for automotive/military devices on boot. I don't know if
this counts as an ABI break, since previously Linux would only shut down
when the hardware failed (typically above 125C). The alternative (using
automotive/military trip points by default) would leave
extended/industrial devices prone to damage.

Policy
======

OK, so how do we set trip points based on this? I think it's reasonable
to set the critical trip point at the recommended maximum operating
temperature. This ensures we never damage the device or operate outside
of recommended conditions. By this method, the critical trip point would
be 96.5C for extended/industrial devices and 120C for
automotive/military devices.

But what about the passive trip point? It is unclear to me how to
effectively utilize passive cooling. I have observed that even after
throttling the CPUs the junction temperature may continue to rise for a
bit. Therefore the passive trip point needs to be set sufficiently below
the critical trip point in order to allow the throttling to have time to
work.

But is throttling the CPU an effective strategy in the first place? The
CPU is performing work, and throttling it may reduce performance of the
system below acceptable levels. Additionally, many workloads are bursty,
where the CPU has a mostly-fixed amount of work it needs to perform in
response to events (e.g. processing packets or user input) and then it
can go back to sleep. If a workload can tolerate a lower level of
performance, might it not be better to perform the work as quickly as
possible and then go back to idling the CPU? That is to say, why don't
we let cpufreq handle things?

And if the workload really does require 100% CPU utilization to function
properly, then the passive trip point does nothing but remove thermal
margin. If the passive trip point is set to X, then if the temperature
ever reaches X+5, Linux will have throttled the CPUs all the way back.
On the other hand, a degraded system may be better than no system at all.

Lastly, we have hysteresis. I have no idea how to choose this. Common
values are:

$ git grep -ho 'hysteresis =[^;]*;' '**.dts*' | sort | uniq -c | sort -n | tail -5
     56 hysteresis = <10000>;
    205 hysteresis = <5000>;
    267 hysteresis = <0>;
    432 hysteresis = <1000>;
   1105 hysteresis = <2000>;

but it's really unclear to me how one would decide "ah, I should use 10C
hysteresis and not 5C" or even nothing at all.

Prior Art
=========

Here's a (not very random) survey of some assorted SOCs and their trip
points:

SAMA7G5
-------

The passive trip point is 90C and the critical trip point is at 100C.
The recommended maximum operating temperature is 105C. There is no
absolute maximum temperature. The temperature sensor is accurate to
within 5C.

This is roughly analogous to the method I outlined above.

LS1046A
-------

There are several zones, but they all have their passive trip points at
85C and their critical trip points at 95C. The maximum operating
temperature is 105C. There is no absolute maximum temperature. The
temperature sensor is accurate to within 1C over the range of interest.

This is much more conservative than what I outlined, allowing 9C of rise
between the critical trip point and the max recommended. It does place
the passive 10C below the critical, like the SAMA7G5.

RK3399
------

The passive trip point is 70C-75C (some CPUs are throttled before
others), and the critical trip point is at 95C. This SoC is also a
little unusual because some CPUs cannot be throttled and are idled
instead. There is no recommended operating temperature, although the
recommended ambient operating temperature is 80C. The absolute maximum
temperature is 125C.

It's hard to really determine how much margin is being allowed between
the (unlisted) recommended maximum operating temperature and the
critical trip point, but there's clearly at least 20C of margin between 

Stingray
--------

There is no passive trip point and the critical trip point is set to
105C. The recommended maximum operating temperature is 75C or 85C
(depending on the grade). The absolute maximum temperature is 110C [2].

This chip is a bit unusual since the critical temperature is set based
on the absolute maximum and not the recommended operating.

Tegra 124
---------

The hot (like passive?) trip point is 100C, and the critical trip point
is 103C. I couldn't find a datasheet for this part.

This one is interesting since the passive trip point is only 3C below
the critical. This only sacrifices 3-4C of margin for throttling, which
seems much more reasonable to me than some of the 

Exynos5422 Odroid HC1
---------------------

There are two passive trip points, one at 70C and one at 85C, each
throttling the CPU a bit more. The critical trip point is at 120C. The
passive trip points also have 10C of hysteresis. I couldn't find a
datasheet for this part either.

This one has a huge passive cooling range (starting 50C below the
critical level), although it's not all enabled at once. Perhaps this
makes more sense in a mobile application?

Closing Questions
=================

Are there any good references for setting thermal policy?

If you wrote a thermal policy, how did you pick your trip points?

What's the point of passive cooling?

How much margin is necessary between the passive and critical trip
points?

How do you pick hysteresis values?

--Sean

[1] Although Xilinx does produce some extended devices which can be used
    at 110C for no more than 1% of the device's life.
[2] https://lore.kernel.org/all/6e040f49-deb0-a3ac-d3ee-0b0e6751a949@milecki.pl/

