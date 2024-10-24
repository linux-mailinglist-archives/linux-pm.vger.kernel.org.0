Return-Path: <linux-pm+bounces-16386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968A9AE6DC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C6B23359
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA11E0E06;
	Thu, 24 Oct 2024 13:38:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C531DF970;
	Thu, 24 Oct 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777127; cv=none; b=AJz+6Cl8yzRXMYfqDM0sTk0OZQIQFLYWSqrWj0BqubnnTmb83+Ie9pMmI/axSHXl3dHPUUZqFgen1xZHTJuec0Hf/JNBXRZBFJuR86CCCd7YT0faJuVf6kPkGRPikT4VC1hBzy6hCdGSYgQVO7Hn7l6Y0Y4Dlv6I/gO9OMercn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777127; c=relaxed/simple;
	bh=PLP3SSlJbV0fpQiLAsOnkvolvtL5D+C1h1JS6kuCogA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPCLGHz584OaWpSMyfW4PfYBGw18tAzjZHrNWHCxgx7GrfL4l2szIokXytsElESl2LLoR4q+BoUV6lLvibwkfu4nFKwxiOjv2Q7nmgKxyMdm3rrq9Fr/bsZtt5a2SST+4/qjjwPMf6ezri1Wev+W3tQ2FCtn8SxoFV7vSsgmIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3FA3339;
	Thu, 24 Oct 2024 06:39:13 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04733F71E;
	Thu, 24 Oct 2024 06:38:42 -0700 (PDT)
Message-ID: <5e1aef31-4157-4094-a419-27810c172ce6@arm.com>
Date: Thu, 24 Oct 2024 14:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] thermal: core: Eliminate
 thermal_zone_trip_down()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <1807510.VLH7GnMWUR@rjwysocki.net>
 <d2239ab1-ae95-4b51-9cc5-8aac9eb67970@arm.com>
 <CAJZ5v0j-T_ynbMsMrVndSHwCJP97A1-PX-p-NNskopO=i0xtpw@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0j-T_ynbMsMrVndSHwCJP97A1-PX-p-NNskopO=i0xtpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/24/24 13:33, Rafael J. Wysocki wrote:
> On Thu, Oct 24, 2024 at 12:32 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 10/16/24 12:33, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Since thermal_zone_set_trip_temp() is not located in the same file
>>
>> nit: s/not/now
> 
> Thanks, will fix when applying the patch.
> 
>>> as thermal_trip_crossed(), it can invoke the latter directly without
>>> using the thermal_zone_trip_down() wrapper that has no other users.
>>>
>>> Update thermal_zone_set_trip_temp() accordingly and drop
>>> thermal_zone_trip_down().
>>>
>>> No functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/thermal/thermal_core.c |    8 +-------
>>>    drivers/thermal/thermal_core.h |    2 --
>>>    2 files changed, 1 insertion(+), 9 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -565,7 +565,7 @@ void thermal_zone_set_trip_temp(struct t
>>>                 * are needed to compensate for the lack of it going forward.
>>>                 */
>>>                if (tz->temperature >= td->threshold)
>>> -                     thermal_zone_trip_down(tz, td);
>>> +                     thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
>>
>> minor thing:
>> won't that be too long line?
> 
> It is longer than 80 characters, but this is not a hard boundary - see
> "2) Breaking long lines and strings" in
> Documentation/process/coding-style.rst).
> 
> Well, you can argue about the "hide information" part, but IMV this
> line just looks cleaner the way it is than when it would be broken in
> any way.
> 
>> IMHO we can add somewhere earlier:
>> struct thermal_governor *gov = thermal_get_tz_governor(tz);
>> and use it here
> 
> That would have been harder to follow than the current code IMO.

fair enough

