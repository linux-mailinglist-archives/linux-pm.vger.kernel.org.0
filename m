Return-Path: <linux-pm+bounces-16458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15A9B048C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9A284DCA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D701F757F;
	Fri, 25 Oct 2024 13:51:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D01F7569;
	Fri, 25 Oct 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864317; cv=none; b=aQduZMtY6mEG/nvJqa8d4J1fo5kqIucd9iFNVPAfjaqFEL885nJDayULeUCBqbAVX+W8ak+h9W2eUx8v3apL6QPpM7TAu6U58caBtjw/6U2df4UQU5nd7uzGWuJ304VDD6sGHTAlksOg6LxyB8ST/Lo8Z8502+RKJqB69MC6iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864317; c=relaxed/simple;
	bh=FQSFureBauIfH+2beFHnFnQn+Qg5yHchQex4fb8mwCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/neK03dMLvt0Mcp77fsuF5H4/KmJiblzrJYxeKq1OyftXOMFQwod4yqIfRXlUkVBvUFTzGwVUKBj0J10rEhlqv2CrcKJ6cxsSdwuy6Mt+FW7QQqEKtibzUNogj/NlnzXoHZ5rZHYXqS4N/H6kHE2/3osdZfNsjafFSuRNl+Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07164497;
	Fri, 25 Oct 2024 06:52:24 -0700 (PDT)
Received: from [10.57.55.217] (unknown [10.57.55.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7443F73B;
	Fri, 25 Oct 2024 06:51:52 -0700 (PDT)
Message-ID: <ff51089b-e07d-4aa3-91f3-a6018baf8ec2@arm.com>
Date: Fri, 25 Oct 2024 14:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <1930069.tdWV9SEqCh@rjwysocki.net>
 <2fc850b3-93af-4d8e-8a64-1c95942e911b@arm.com>
 <CAJZ5v0g7zKWT_DpQ5uO+AeDXEKmJrwVBqcN-4PAJNYBORX+rAQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g7zKWT_DpQ5uO+AeDXEKmJrwVBqcN-4PAJNYBORX+rAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/24 10:50, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Tue, Oct 22, 2024 at 11:01 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 10/10/24 23:05, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Add and use a guard for thermal zone locking.
>>>
>>> This allows quite a few error code paths to be simplified among
>>> other things and brings in a noticeable code size reduction for
>>> a good measure.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is a new iteration of
>>>
>>> https://lore.kernel.org/linux-pm/3241904.5fSG56mABF@rjwysocki.net/
>>>
>>> that has been combined with
>>>
>>> https://lore.kernel.org/linux-pm/4613601.LvFx2qVVIh@rjwysocki.net/
>>>
>>> and rebased on top of
>>>
>>> https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
>>>
>>> and
>>>
>>> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
>>>
>>> ---
>>>    drivers/thermal/thermal_core.c    |   61 +++++++---------------------
>>>    drivers/thermal/thermal_core.h    |    4 +
>>>    drivers/thermal/thermal_debugfs.c |   25 +++++++----
>>>    drivers/thermal/thermal_helpers.c |   17 ++-----
>>>    drivers/thermal/thermal_hwmon.c   |    5 --
>>>    drivers/thermal/thermal_netlink.c |   21 ++-------
>>>    drivers/thermal/thermal_sysfs.c   |   81 ++++++++++++++++----------------------
>>>    drivers/thermal/thermal_trip.c    |    8 ---
>>>    8 files changed, 86 insertions(+), 136 deletions(-)
>>>
>>
>>
>> [snip]
>>
>> Surprise, how the code can look smaller using that
>> style with 'guard'.
> 
> Yes, it gets more concise.
> 
> Not only that, though.  It is also less error-prone, because you won't
> forget to unlock the lock in an error path and you won't use "lock"
> instead of "unlock" by mistake etc.
> 
> Moreover, it kind of promotes dividing the code into smaller
> self-contained pieces, which is a plus too IMV.

I cannot agree more!


