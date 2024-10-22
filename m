Return-Path: <linux-pm+bounces-16271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86B9AB96C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C13B224BD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE01CCEE7;
	Tue, 22 Oct 2024 22:24:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB91A2547;
	Tue, 22 Oct 2024 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635858; cv=none; b=IMkIfmwqI9gaW58w7edGYNNHj4w34ahvwbpV1SzKICJWPIpp9lwKqiKQyYadFFoPDzoftbzTlLeZHKYUeE9pyUKl0zfz2+VBXrn/FW04ocUZ2RHnxEN25EjLiyEE8PPlnS6p5kGzwaTCD1O4v57YaCcUI2SrpmrGM7D+F9pxRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635858; c=relaxed/simple;
	bh=LoklsZ5kNbjG7ecRihxDQqqb27hzsyvkCadGx4Bg554=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uzgg4R/xYYwi/CkR2krlRPJ06dWVoWv+QjGsqzYPKnHitA+PHHQVn8ZT5IXjcmGMAK/o6I9vtDPIAiXkpCTti32LmCcgY4TUaPYy/4df8LTJjiR0I6lKj9jUFZgnud2pf0QHQtAcJLLjqhuPMFsxH7qm/CKspXy8B5RMpXtQgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E79497;
	Tue, 22 Oct 2024 15:24:45 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865D03F528;
	Tue, 22 Oct 2024 15:24:14 -0700 (PDT)
Message-ID: <fd8729ab-85ba-4cbb-80f2-c5e188987d62@arm.com>
Date: Tue, 22 Oct 2024 23:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] thermal: core: Add and use cooling device guard
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <2655659.Lt9SDvczpP@rjwysocki.net>
 <CAJZ5v0h_tsCKpvZuHejCF4qnvJt7+=GqMGc7YgiM=Eu55bKBCg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0h_tsCKpvZuHejCF4qnvJt7+=GqMGc7YgiM=Eu55bKBCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/24 13:26, Rafael J. Wysocki wrote:
> On Fri, Oct 11, 2024 at 12:22 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Add and use a special guard for cooling devices.
>>
>> This allows quite a few error code paths to be simplified among
>> other things and brings in code size reduction for a good measure.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is a new iteration of
>>
>> https://lore.kernel.org/linux-pm/1890654.atdPhlSkOF@rjwysocki.net/
>>
>> v1 -> v2: Rearrange cur_state_store()
>>
>> ---
>>   drivers/thermal/gov_power_allocator.c |   21 +++++++--------
>>   drivers/thermal/gov_step_wise.c       |    6 ++--
>>   drivers/thermal/thermal_core.c        |   17 +++---------
>>   drivers/thermal/thermal_debugfs.c     |   25 +++++++++++-------
>>   drivers/thermal/thermal_helpers.c     |   19 +++-----------
>>   drivers/thermal/thermal_sysfs.c       |   45 ++++++++++++----------------------
>>   include/linux/thermal.h               |    3 ++
>>   7 files changed, 57 insertions(+), 79 deletions(-)
>>

[snip]

>>
>>          stats = cdev->stats;
>> -       if (!stats) {
>> -               len = -ENODATA;
>> -               goto unlock;
>> -       }
>> +       if (!stats)
>> +               return -ENODATA;
>>
>>          len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
>>          len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
> 
> There is one more "goto unlock" statement in this function that needs
> to be replaced with "return".
> 
> I'll send an update of it shortly.
> 

OK, I will review that when it's ready.

