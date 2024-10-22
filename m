Return-Path: <linux-pm+bounces-16209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5ED9A9FCB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342B71F23A10
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD419925A;
	Tue, 22 Oct 2024 10:19:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45A12D1EA;
	Tue, 22 Oct 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592398; cv=none; b=ZnQ/WfcaDRz1As/clv0WVpE0DW3UvZ3eJhdBNad0zW89QRQrUj3nfOfrnK1XMKdE2yPDz/O3E9+8Y0wrDbc6Tv6AKU3j+XUR15iX6GCSSnDxWM8q3JlsxgewlZgPJyojj8suB0W2ovHKUJHYesVWYbzxDlSJhO/KLADrM+F2Kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592398; c=relaxed/simple;
	bh=5DHY+qnatij+MGCadRUcaUBKEvw0C69Oa6l9LhfDZpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VktDw7/N3depV+l5Q9j1t1P/jI41962+QjORmeuQ4q5bTFdtSn/+bXSwI956dKOK9MHlxZlyn+0jMknHuD0p2w6SANX8FPJoKOgzotvF08UypwVDXatwx/rAf58jJ7m8riySo4Gc2g+EoP/EIb57mNlJuZcycjvLYI74jlhNSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4269C497;
	Tue, 22 Oct 2024 03:20:25 -0700 (PDT)
Received: from [10.57.65.67] (unknown [10.57.65.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619703F71E;
	Tue, 22 Oct 2024 03:19:54 -0700 (PDT)
Message-ID: <8f7fdfe6-f29c-46e0-ae85-c2f794ee268d@arm.com>
Date: Tue, 22 Oct 2024 11:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through
 guards
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
 <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
 <81c752c1-6f51-4aae-ac25-98214c9b9da0@arm.com>
 <CAJZ5v0iy3Z_WV1k7KBwuy1RrdgXpqK2fu2J2wG6PWpLxz293zA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iy3Z_WV1k7KBwuy1RrdgXpqK2fu2J2wG6PWpLxz293zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/22/24 10:57, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Tue, Oct 22, 2024 at 12:02 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 10/21/24 12:08, Rafael J. Wysocki wrote:
>>> On Fri, Oct 11, 2024 at 8:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Fri, Oct 11, 2024 at 12:22 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>
>>>>> Hi Everyone,
>>>>>
>>>>> This is a continuation of
>>>>>
>>>>> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
>>>>>
>>>>> and (quite obviously) it is based on that series.
>>>>>
>>>>> The majority of the patches in it are new iterations of patches included in
>>>>>
>>>>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
>>>>>
>>>>> and there is one new patch ([02/11]).
>>>>>
>>>>> All of these patches are related to locking, but some of them are preparatory.
>>>>>
>>>>> The series as a whole introduces guards for thermal zones and cooling devices
>>>>> and uses them to re-implement locking in the thermal core.  It also uses mutex
>>>>> guards for thermal_list_lock and thermal_governor_lock locking.
>>>>>
>>>>> As usual, the details are described by the individual patch changelogs.
>>>>
>>>> This material is now present in the thermal-core-experimental branch
>>>> in linux-pm.git.
>>>
>>> I gather that it is not controversial as it was covered in the PM+TC
>>> session at the LPC and it has been around for quite a while, so I've
>>> just queued it up for 6.13.
>>
>> If it's not too late, I will do the review tomorrow.
> 
> No, it isn't, please do!

OK, I will do that today.

