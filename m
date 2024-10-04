Return-Path: <linux-pm+bounces-15148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CE990459
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E21C222EB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286FC1D6DB0;
	Fri,  4 Oct 2024 13:30:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79933D5;
	Fri,  4 Oct 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048627; cv=none; b=jnGG6deL2RUaMxvWtjAz+FBk2+9a+N/pNIP0Kevy4rJEaOGkMfksiXy46i0GGQFyc5fkcIbY9b98VhoTyeVYhyBOT4FzCy3dmEUi9XdxCyavH6TsV9kW/xytEIVXBBdRET++5VFRkYdggnEZoVcXzxTze6gJg5KR+bu/XNp6u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048627; c=relaxed/simple;
	bh=i/0c9PLBQkRP6iwcADycVvdZKhX0l8Iuz8m6N5dPHOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmSK7qmCgSOk/jzC7ya4lBCx6Io0euOpbPXSTsT1byPnfSiqFO/9z8XgbNF5EsPRQ/SSXSb81VZXGu2g1QF2qs2J/saCImY8nIU9gvRgLCYxPQvOqMFr/YktyHw5ca28EWHKUe2fKoSYvHL+SIaqP+BIshnKq9iJU1wnf+i2Uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61072339;
	Fri,  4 Oct 2024 06:30:53 -0700 (PDT)
Received: from [10.57.77.142] (unknown [10.57.77.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A2F3F58B;
	Fri,  4 Oct 2024 06:30:22 -0700 (PDT)
Message-ID: <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com>
Date: Fri, 4 Oct 2024 14:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in
 thermal_zone_get_by_id()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
 <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com>
 <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/4/24 14:25, Rafael J. Wysocki wrote:
> Hi Łukasz,
> 
> On Fri, Oct 4, 2024 at 10:01 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 10/3/24 13:25, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> There are places in the thermal netlink code where nothing prevents
>>> the thermal zone object from going away while being accessed after it
>>> has been returned by thermal_zone_get_by_id().
>>>
>>> To address this, make thermal_zone_get_by_id() get a reference on the
>>> thermal zone device object to be returned with the help of get_device(),
>>> under thermal_list_lock, and adjust all of its callers to this change
>>> with the help of the cleanup.h infrastructure.
>>>
>>> Fixes: 1ce50e7d408e ("thermal: core: genetlink support for events/cmd/sampling")
>>> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2: Use the cleanup.h infrastructure to reduce the amount of code changes.
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c    |    1 +
>>>    drivers/thermal/thermal_core.h    |    3 +++
>>>    drivers/thermal/thermal_netlink.c |    9 +++------
>>>    3 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -728,6 +728,7 @@ struct thermal_zone_device *thermal_zone
>>>        mutex_lock(&thermal_list_lock);
>>>        list_for_each_entry(tz, &thermal_tz_list, node) {
>>>                if (tz->id == id) {
>>> +                     get_device(&tz->device);
>>>                        match = tz;
>>>                        break;
>>>                }
>>> Index: linux-pm/drivers/thermal/thermal_core.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.h
>>> +++ linux-pm/drivers/thermal/thermal_core.h
>>> @@ -194,6 +194,9 @@ int for_each_thermal_governor(int (*cb)(
>>>
>>>    struct thermal_zone_device *thermal_zone_get_by_id(int id);
>>>
>>> +DEFINE_CLASS(thermal_zone_get_by_id, struct thermal_zone_device *,
>>> +          if (_T) put_device(&_T->device), thermal_zone_get_by_id(id), int id)
>>> +
>>>    static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>>>    {
>>>        return cdev->ops->get_requested_power && cdev->ops->state2power &&
>>> Index: linux-pm/drivers/thermal/thermal_netlink.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
>>> +++ linux-pm/drivers/thermal/thermal_netlink.c
>>> @@ -443,7 +443,6 @@ static int thermal_genl_cmd_tz_get_trip(
>>>    {
>>>        struct sk_buff *msg = p->msg;
>>>        const struct thermal_trip_desc *td;
>>> -     struct thermal_zone_device *tz;
>>>        struct nlattr *start_trip;
>>>        int id;
>>>
>>> @@ -452,7 +451,7 @@ static int thermal_genl_cmd_tz_get_trip(
>>>
>>>        id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>>>
>>> -     tz = thermal_zone_get_by_id(id);
>>> +     CLASS(thermal_zone_get_by_id, tz)(id);
>>>        if (!tz)
>>>                return -EINVAL;
>>>
>>> @@ -488,7 +487,6 @@ out_cancel_nest:
>>>    static int thermal_genl_cmd_tz_get_temp(struct param *p)
>>>    {
>>>        struct sk_buff *msg = p->msg;
>>> -     struct thermal_zone_device *tz;
>>>        int temp, ret, id;
>>>
>>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
>>> @@ -496,7 +494,7 @@ static int thermal_genl_cmd_tz_get_temp(
>>>
>>>        id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>>>
>>> -     tz = thermal_zone_get_by_id(id);
>>> +     CLASS(thermal_zone_get_by_id, tz)(id);
>>>        if (!tz)
>>>                return -EINVAL;
>>>
>>> @@ -514,7 +512,6 @@ static int thermal_genl_cmd_tz_get_temp(
>>>    static int thermal_genl_cmd_tz_get_gov(struct param *p)
>>>    {
>>>        struct sk_buff *msg = p->msg;
>>> -     struct thermal_zone_device *tz;
>>>        int id, ret = 0;
>>>
>>>        if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
>>> @@ -522,7 +519,7 @@ static int thermal_genl_cmd_tz_get_gov(s
>>>
>>>        id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
>>>
>>> -     tz = thermal_zone_get_by_id(id);
>>> +     CLASS(thermal_zone_get_by_id, tz)(id);
>>>        if (!tz)
>>>                return -EINVAL;
>>>
>>>
>>>
>>>
>>
>> I wasn't aware of that helpers in cleanup.h.
>>
>> Could you help me to understand when this this
>> 'if (_T) put_device((&_T->device)' will be called?
> 
> When the pointer variable initialized via the CLASS() macro goes out
> of scope (that is, before freeing the memory occupied by the pointer
> itself).


OK, so do we still need the old code in
thermal_zone_device_unregister(), which calls
put_device(&tz->device) ?
Maybe that code can go away?

