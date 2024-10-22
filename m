Return-Path: <linux-pm+bounces-16248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F2F9AB2D5
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0211F24003
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF621A2C04;
	Tue, 22 Oct 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POSvmcxe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6713957E
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612483; cv=none; b=epDCJUDxNN+BHOjoIsrcoyunQMYF92zvKeXSE6FS4d5gg1BSKYinSj3EujvwtoA9eY7uphe1XvheqTafFCWe7E2iZ4hsYjLx9hgzhmipOEx9JjTUMSnvbmzeq4jcOEnx/oTi+06OHx72o9Bhnli+riONY71yTfRaCCzVfS68WA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612483; c=relaxed/simple;
	bh=62NNQJJ7A3DiuVr30S0NvM8u/vEh06OgwsxSudEBY+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lqohwie34wQMpwbnBZLXP7ozYoGL4Plx3tnQ4Mti90nkaS4JLrxOQ5HiqVG3poWwXdQtZ70ZL5botyHA6zSFEd3DXT9E0GQ1F1DVDW1rCXQPyJJvUAtaPeoIDRzRCisDM7NnOKLky+LmOf09PmVmL+ECN62/cXgZpYncqEFIayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POSvmcxe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314b316495so56464715e9.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612480; x=1730217280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOgoGaX/0/14yPta5AUXfcWrIsji8gX2pljYL0Iu//Y=;
        b=POSvmcxeVLZEQc27hYtnEBa4MbOwE5XEEPVnwbV/y8MURktcUMdvRttheyfnXyyiyO
         YSRVlcs8smM9V/71zFXcNNbYi+3rtYOP9YhHj0vpIfgshaRMWptnXldZXSZrTIPXX7cA
         h2m+PIkN7Vkd8ogGQ8HNTqGASBZ4WfGWc3BuECo70DLkWEll2ct/oOc/Na2r3Ts8LvAn
         JsKJT/5bP5/McQn+w3Va8yfcic/PKgVDMSsOoH5OG+mFAvORh6fipNxZxulqccGRamqZ
         zChhA/XcCZtTN7ipz1w2q/nKoS/hcw/hPHzTT05DYkE7xtQzDlNIE9zduckikZZdM4ZM
         Yzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612480; x=1730217280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOgoGaX/0/14yPta5AUXfcWrIsji8gX2pljYL0Iu//Y=;
        b=P9kahtZ0d7bBRxbW5+uQl6K136EqKoSvh2StDgZpz61IkwOhNkxcigGcCY+Nlnk3hA
         8PJqIPZCo1GBB2rCSF5Efw1pj1GwouLD6QZWoIwtf/HW8AEEDGRVE3uqICCKznaEUcsa
         hzRjCESO7e3/NuEya/Dbr2r6d2wE9911AWioWttm9SMLsG1kgasUQwSuc7c15BRwW156
         NApW6iKlKM8b3DRKJmZamk4inH1qp4mj6z5RhEMAK0bohjv9Ab6Lu10BEMrV7rBjlEev
         HAW57qMAric15R16SJPtys0XIxxFBvEsiPQ6ZH9ckUrT6cA4pjHDdoxhlQshIiTyrzSS
         wI0Q==
X-Gm-Message-State: AOJu0Yyav4SFyCuxPPHWxW1uVGAJKVvAFZpS7lP5cibGmQhLBihmVJpo
	XPi91AhU2viLFl8Cl8u1rYoDx9SXVr9vbyjuFyyB+XXbrb7V2xcrAW23BI2GBpA=
X-Google-Smtp-Source: AGHT+IHEyv7b+dIOLK51w4OQoLuXX+Qs1IRZBFRkMgNvWmbOWzQVKoeNoUpUqmE3JBoxdTY2yOULyg==
X-Received: by 2002:a05:600c:35cd:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-4317ca915a7mr28575315e9.1.1729612479923;
        Tue, 22 Oct 2024 08:54:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3173sm91199105e9.33.2024.10.22.08.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:54:39 -0700 (PDT)
Message-ID: <854974d9-fc56-4a40-977c-9ce90b783338@linaro.org>
Date: Tue, 22 Oct 2024 17:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Add thermal user thresholds support
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, lukasz.luba@arm.com
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241022155147.463475-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Please note, I did not fixed the locking issue assuming it will be fixed 
when the series is applied as stated in v5.

As soon as the series is merged, I will send a couple of changes, one to 
fix the memory leak and the other one to fix the warning reported by syszbot

Thanks

   -- D.

On 22/10/2024 17:51, Daniel Lezcano wrote:
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
>    V6:
>    
>      - Added a comment in the parse_threshold_get() function to clarify
>        how the size is computed (Lukasz)
> 
>      - Changed comparison to check against non zero value in the
>        __thermal_zone_discover() function (Lukasz)
> 
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
> Daniel Lezcano (5):
>    thermal: core: Connect the threshold with the core
>    thermal/netlink: Add the commands and the events for the thresholds
>    tools/lib/thermal: Make more generic the command encoding function
>    tools/lib/thermal: Add the threshold netlink ABI
>    tools/thermal/thermal-engine: Take into account the thresholds API
> 
>   drivers/thermal/thermal_core.c                |   9 +
>   drivers/thermal/thermal_netlink.c             | 236 +++++++++++++++++-
>   drivers/thermal/thermal_netlink.h             |  34 +++
>   drivers/thermal/thermal_thresholds.c          |  36 +--
>   drivers/thermal/thermal_thresholds.h          |   2 +-
>   include/uapi/linux/thermal.h                  |  27 +-
>   tools/lib/thermal/commands.c                  | 177 ++++++++++++-
>   tools/lib/thermal/events.c                    |  55 +++-
>   tools/lib/thermal/include/thermal.h           |  40 +++
>   tools/lib/thermal/libthermal.map              |   5 +
>   tools/lib/thermal/thermal.c                   |  17 ++
>   tools/thermal/lib/Makefile                    |   2 +-
>   tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++-
>   13 files changed, 681 insertions(+), 64 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

