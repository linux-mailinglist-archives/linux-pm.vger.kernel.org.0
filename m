Return-Path: <linux-pm+bounces-36261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511BBE3D53
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CB719C54B7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA733CE9D;
	Thu, 16 Oct 2025 13:59:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86103161AB;
	Thu, 16 Oct 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623162; cv=none; b=GLwTW3wT43krRuI3uhTtLNhuIqzjJScM9De7sWmlTISSDKXqA/xrfeU2WIQ5xDZXPHeQb09KkgYXtsm9UbSRWWx1khdFZyiYCdaYD7X9dvbQwpUA9Z0nMlJdltSiObA+ylJZo59FyiYshjPryrzp+rsFirrUSsxwvH5OHMKBB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623162; c=relaxed/simple;
	bh=B0s6KIoFjESrB3oYbxj9czs1Z1wJZW3UuchZlTq9j+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBwpqQdB/S0fKsUwYLPNhEsgBlOdDCAAAPFkRzr/g/PQWPd8fvD+C4GwHh678YafYtkR7OdFMpa3EHAfhBba4ZJDhepGGyRHgW7UdbkdcDn2XljBENkqFhmjtefGjkNc50hhm/53jT6lLF8lBneLT4KDnJbXqA4ieP289iKDdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D666D1688;
	Thu, 16 Oct 2025 06:59:11 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC33B3F738;
	Thu, 16 Oct 2025 06:59:18 -0700 (PDT)
Message-ID: <1592aa65-9dfb-47d6-9bcf-17afd3184a0a@arm.com>
Date: Thu, 16 Oct 2025 15:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model
 rules
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, lukasz.luba@arm.com,
 srinivas.pandruvada@linux.intel.com
References: <3394529.aeNJFYEL58@rafael.j.wysocki>
 <20251016074849.1046580-1-tianyaxiong@kylinos.cn>
 <f48b80d5-0098-424d-9a7c-ae07017ab2bb@arm.com>
 <CAJZ5v0gyGsTdJ+up-peX5_ggF-YKPep1j0uG6zRGn9UKiHA-KQ@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <CAJZ5v0gyGsTdJ+up-peX5_ggF-YKPep1j0uG6zRGn9UKiHA-KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.10.25 11:52, Rafael J. Wysocki wrote:
> On Thu, Oct 16, 2025 at 11:00 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 10/16/25 08:48, Yaxiong Tian wrote:
>>> 在 2025/10/15 21:48, Rafael J. Wysocki 写道:> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

>>> Hi Rafael J. Wysocki:
>>>
>>> Is the increment of this cost for different types of CPUs by one instead
>>> of two?
>>>
>>> cost by increment of 2:
>>>           0~40%  40%~60%  60%~80% 80%~100
>>> LPE-core    2       3        4      5
>>> E-core      4       5        6      7
>>> P-core      6       7        8      9
>>>
>>> So, tasks only start being allocated to more powerful CPUs when
>>> utilization exceeds 80%, but by that point the system is already in an
>>>  overloaded state.
>>>
>>> cost by increment of 1:
>>>           0~40%  40%~60%  60%~80% 80%~100
>>> LPE-core    2       3        4      5
>>> E-core      3       4        5      6
>>> P-core      4       5        6      7
>>>
>>> This situation aligns with the description in your patch.
>>>
>>> The idea of this patch looks good to me.
>>
>> Agreed if you want the threshold to be 60% for both it should be +1 for l3
>> and +2 for P-core.
>> Good catch!
> 
> OK, I'll send an update of this patch then, but I won't resend the
> first two patches in the series.  I don't think that they are
> objectionable.

FWIW: LGTM: tested on i7-13700K (nosmt):

$ cat /sys/devices/system/cpu/cpu{0,8,16}/cpu_capacity
1009
1024
623

root@gulliver:~# cat /sys/kernel/debug/energy_model/cpu0/ps:*/cost
6
7
8
9
root@gulliver:~# cat /sys/kernel/debug/energy_model/cpu8/ps:*/cost
6
7
8
9
root@gulliver:~# cat /sys/kernel/debug/energy_model/cpu16/ps:*/cost
4
5
6
7

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>





