Return-Path: <linux-pm+bounces-16063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1179A5E9D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63D71F21374
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B351E201D;
	Mon, 21 Oct 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckU33si2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90A1E1C10
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499288; cv=none; b=EWtma/VHjrNCk4lWjTq7KCteg2FOvOxoA0TZu15KQP5yUzrw0ZI6ZsRbXG2JQ0t5YiiwGJvKTaLqElZvueEDIL0DGQbuOztCOQV6SAIiR+mAjt5U5LRzrDW9te+kmBuFmllfQ15cuXIKqpJUgoR8UcsMuzKZYyx/xghzxzb9vvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499288; c=relaxed/simple;
	bh=RyFSHD4FW/K7f3oOKNqStAr3Ak3EdwTmN4DhNQzz5IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGGwkz8T9urhvl7hzEdL4xMQIarTiUGIWyNrkNiZoLgFliUHbs+UQlZ+0buInmJMqXERkguMSLOgDrRX1O7x6J2rTx/cQf8gRnKPdnzdbMo2H5iqXz2xmBzUWzRec4rTZWiCWkGjR80MtAHmY+3cufwJ68l/NY6lkzLcbNPegeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckU33si2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159c9f617so39115775e9.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729499284; x=1730104084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjgASv4G4hAf2f6HnJ+z9y7neW1u/UOwi7m7Gcqb3aI=;
        b=ckU33si2xSmoaa9/kgR7ZH9vJ0MPf36Pb+DnDkxm/kHXIpniD8ANqySV6MfmCGgXYQ
         12+TlJYi3iaInmsf3TrhPRfpvUgyrXqcZ9y78sQspJZoO84UqEuo5N/Sfzb49Tco/El7
         tjlykn7hjiwumlaPVsGJzvc7q7oT6AXeIJ5yjJzlMMrEWPjymKkUDAk3LHPaWkBXKK2U
         jEjZfv+xWEt4amfJdn/TBhWbHBf0fRcky0LyXwmWLxX8L5HPuecmeYgdG+m43B5H/PWT
         U9oqJeomCfcaFF/11bVjhDj2u8K7iVG/aapvtopllqo2meOO+jGNGW2naom9zpY+2iG2
         4mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499284; x=1730104084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjgASv4G4hAf2f6HnJ+z9y7neW1u/UOwi7m7Gcqb3aI=;
        b=MATDAI5TZSbSynVJLlpepZC8OVkz/v/BK8Tiols7viW/+YZwKlh4q9ApZ/5WfdLcQ0
         O47uy2iCFFaROivHAL80CO8NflYtBxWjshXExlzYGqRjOgOPQIrKLCL0SAXwzfA/e+y4
         uBqhvs4GZcKghVVw4sH2WmMNmktWs/ZxZKcg9DItat2DH7an47JoKk0ixrAEcVhIxxvF
         yDeXH4bjbrd0hIz9TCXBbvX3Xa3BbnVxeyHyy4ivcABKWU5mLpcS5mSV+QAtz73WWgNq
         yAKYXjwguAQCJLQrPCt/HRj42/GQeo8GRH1uIJ+8xbkzOc9O+1/6CiFEm2obW1+FFOUS
         u1KA==
X-Gm-Message-State: AOJu0YwA8Ei5EAdxcB0vb72JnAis1BwMUUz1fJHOuNU0yivm9LOh7kS3
	REr2c7ZeXm4T5L7r5qSUGb1qZpAdbzsNS6gZBthweBml9YeTdHBv2XChc4PUvPeSZCnJVAeE3H9
	3
X-Google-Smtp-Source: AGHT+IH6034bNIUCWzWu3k/RKSa1N+1ng3RG2llJnafXvGtoxevm8XYt06v+7JwdGmDOERScGT4SRw==
X-Received: by 2002:a5d:67d1:0:b0:37d:238:983 with SMTP id ffacd0b85a97d-37eab6ed4e6mr6864989f8f.22.1729499284524;
        Mon, 21 Oct 2024 01:28:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm49307265e9.45.2024.10.21.01.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 01:28:03 -0700 (PDT)
Message-ID: <af8d8c7d-2f98-4607-a096-f85a9390489d@linaro.org>
Date: Mon, 21 Oct 2024 10:28:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add thermal user thresholds support
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

as there are no more comments and I think I took into account all the 
feedback, is it possible to merge this series so I can get rid of 
monitoring its status ?

Thanks

On 14/10/2024 11:43, Daniel Lezcano wrote:
> The trip points are a firmware description of the temperature limits
> of a specific thermal zone where we associate an action which is done
> by the kernel. The time resolution is low.
> 
> The userspace has to deal with a more complex thermal management based
> on heuristics from different information coming from different
> places. The logic is much more complex but based on a bigger time
> resolution, usually one second based.
> 
> The purpose of the userspace is to monitor the temperatures from
> different places and take actions. However, it can not be constantly
> reading the temperature to detect when a temperature threshold has
> been reached. This is especially bad for mobile or embedded system as
> that will lead to an unacceptable number of wakeup to check the
> temperature with nothing to do.
> 
> On the other side, the sensors are now most of the time interrupt
> driven. That means the thermal framework will use the temperature trip
> points to program the sensor to trigger an interrupt when a
> temperature limit is crossed.
> 
> Unfortunately, the userspace can not benefit this feature and current
> solutions found here and there, iow out-of-tree, are to add fake trip
> points in the firmware and enable the writable trip points.
> 
> This is bad for different reasons, the trip points are for in-kernel
> actions, the semantic of their types is used by the thermal framework
> and by adding trip points in the device tree is a way to overcome the
> current limitation but tampering with how the thermal framework is
> supposed to work. The writable trip points is a way to adjust a
> temperature limit given a specific platform if the firmware is not
> accurate enough and TBH it is more a debug feature from my POV.
> 
> The user thresholds mechanism is a way to have the userspace to tell
> thermal framework to send a notification when a temperature limit is
> crossed. There is no id, no hysteresis, just the temperature and the
> direction of the limit crossing. That means we can be notified when a
> temperature threshold is crossed the way up only, or the way down only
> or both ways. That allows to create hysteresis values if it is needed.
> 
> Those thresholds are refered as user thresholds in order to do the
> difference with the trip points which are similar.
> 
> An user threshold can be added, deleted or flushed. The latter means
> all user thresholds belonging to a thermal zone will be deleted.
> 
> When one or several user thresholds are crossed, an event is sent to
> the userspace.
> 
> All aforementioned actions and events lead to a notification to the
> userspace.
> 
> Along with the kernel changes, the thermal library has been extended
> to provide the different API to deal with the new user threshold
> netlink events and commands.
> 
> In addition, the thermal-engine skeleton uses these new API by
> flushing and adding user thresholds as well as getting the
> notification about these actions.
> 
> Overall the series has been tested with the thermal-engine skeleton
> and some selftests which are not part of this series.
> 
> Changelog:
>    V5:
>      - Added CAP_SYS_ADMIN needed capability when adding, deleting and
>        flushing a threshold (Rafael)
> 
>      - Remove the pid information to prevent leaking pid inside
>        containers. Also the information is not really needed (Rafael)
> 
>      - Renamed "THERMAL_GENL_ATTR_THRESHOLD_WAY" to
>        "THERMAL_GENL_ATTR_THRESHOLD_DIRECTION". Did not used '*_DIR' as
>        suggested initially because it can be ambiguous with 'directory'
>        (Rafael)
> 
>      - Renamed 'last_temp' to 'prev_temp' (Rafael)
> 
>      - Used CLASS constructor/destructor to get / put the thermal
>        zone's device refcount (Rafael)
> 
>      - Moved locking inside thermal_thresholds_for_each() (Rafael)
> 
>      - Reflected the changes above in the thermal library and the
>        thermal engine skeleton
>      
> 
>    V4:
>      - Fix missing stubs when THERMAL_NETLINK=n (kernel test robot)
> 
>    V3:
>      - the first patch of the v2 series has been merged
> 
>      - Modified the description to split the information between the
>        cover letter and the patch 1 description (Rafael)
> 
>      - Made the thresholds code as part of the core (Rafael)
> 
>      - Converted the thresholds into a list and directly declared in
>        the thermal zone device structure (Rafael)
> 
>      - Changed the name of the field in the thermal zone device
>        structure to user_thresholds (Rafael)
> 
>      - Added #include "thermal_thresholds.h" (Rafael)
> 
>      - Combined the conditions in the function
>        __thermal_threshold_is_crossed (Rafael)
> 
>      - Moved the function thermal_thresholds_flush() before
>        thermal_thresholds_exit() (Rafael)
> 
>      - Change thermal_thresholds_handle() to return void (Rafael)
> 
>      - Move the list field on top the of the structure threshold and
>        renamed it list_node (Rafael)
> 
>      - Changed THERMAL_THRESHOLD_* notifications to
>        THERMAL_TZ_THRESHOLD_* (Rafael)
> 
>    V2:
>      - Compute min and max in thermal_zone_device_update() but keep
>        the loop as it is (Rafael)
> 
>      - Include slab.h to fix compilation warnings on some architectures
>        with kmalloc and kfree (kernel test robot)
> 
> Daniel Lezcano (4):
>    thermal/netlink: Add the commands and the events for the thresholds
>    tools/lib/thermal: Make more generic the command encoding function
>    tools/lib/thermal: Add the threshold netlink ABI
>    tools/thermal/thermal-engine: Take into account the thresholds API
> 
>   drivers/thermal/thermal_netlink.c             | 236 +++++++++++++++++-
>   drivers/thermal/thermal_netlink.h             |  34 +++
>   drivers/thermal/thermal_thresholds.c          |  36 +--
>   drivers/thermal/thermal_thresholds.h          |   2 +-
>   include/uapi/linux/thermal.h                  |  27 +-
>   tools/lib/thermal/commands.c                  | 167 ++++++++++++-
>   tools/lib/thermal/events.c                    |  55 +++-
>   tools/lib/thermal/include/thermal.h           |  40 +++
>   tools/lib/thermal/libthermal.map              |   5 +
>   tools/lib/thermal/thermal.c                   |  17 ++
>   tools/thermal/lib/Makefile                    |   2 +-
>   tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++-
>   12 files changed, 662 insertions(+), 64 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

