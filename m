Return-Path: <linux-pm+bounces-16718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659E9B61EB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E881C21D25
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8441E500F;
	Wed, 30 Oct 2024 11:33:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19051E32C5;
	Wed, 30 Oct 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287997; cv=none; b=o9doOB8/vgA2NPHf9fnYooTsNf+qUF/8m+QXrWg6KObud3Qti9U5PdG0jNcoHcwW9D9k/VN9/U5QFbKSizOD40EGAidBW2SXkTwEHqH+KpkyMP++Fp67+KHyua5+cPomGPmGxHOgY/URFGJoPwMy0lE/j4b8LQGqJI22mdrrhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287997; c=relaxed/simple;
	bh=9B/VVbiId1lYYO5sgVk3wUfVIDhtcgA4odTw4h0xYKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO8EGN9aPTB6erjr7GCd1ZnyGSuLHHSVEbqpYb9y+90/ebtUxP5Vp0gFgeIVCyUoaK8R7x4jKxo9df/WA4UZVL6k0qrk7xHBF5ZicCTFnnrheDvyAHH5YoxrAgScAnc4sFP2LFWk3cU9quDTZJBEBl9v4j6pzeE2lqPhsXEctYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C76A8113E;
	Wed, 30 Oct 2024 04:33:43 -0700 (PDT)
Received: from [10.57.58.72] (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AAB93F66E;
	Wed, 30 Oct 2024 04:33:13 -0700 (PDT)
Message-ID: <6847bb0d-805f-4bf6-bb22-635d5f8e9d6b@arm.com>
Date: Wed, 30 Oct 2024 11:34:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state
 limits
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com
References: <20241029094452.495439-1-lukasz.luba@arm.com>
 <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0gzQhw3wkRVFTEx-y4pawknJqC2JPrN6_dqd77vTVuSOw@mail.gmail.com>
 <6cdb2f8b-62e0-455c-a3a5-ed5359a2e941@arm.com>
 <61afac10-b434-4e39-8c49-c220add4bd8e@arm.com>
 <CAJZ5v0jk+0vfn88+gaunezgtb6TLVagqav=9sM-D169Q69MF5w@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jk+0vfn88+gaunezgtb6TLVagqav=9sM-D169Q69MF5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/24 11:23, Rafael J. Wysocki wrote:
> On Wed, Oct 30, 2024 at 11:00 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On 10/30/24 08:48, Lukasz Luba wrote:
>>> Hi Rafael,
>>>
>>> On 10/29/24 18:29, Rafael J. Wysocki wrote:
>>>> On Tue, Oct 29, 2024 at 10:43 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>
>> [snip]
>>
>>>>> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
>>>>
>>>> It would be good to have at least one caller of this function in the
>>>> tree.
>>>
>>> Yes, I know, but we had delays with the SCMI cpufreq to get the
>>> notifications support, which are sent from FW...
>>>
>>> The patch using this API was part of v1 but with assumption that
>>> those SCMI notifications are merged.
>>>
>>> The patch v1 for the SCMI cpufreq driver [1].
>>>
>>> In that v1 cover letter I mentioned that the 2nd patch depends
>>> on notifications [2].
>>>
>>> I will have to work with Cristian on that notification in SCMI
>>> then this API will be used. I can see that it stuck for a while
>>> in v5. Let me sort that out (probably not in this merge window
>>> though).
>>
>> Just to link the effort which has been started into that direction:
>>
>> https://lore.kernel.org/lkml/ab36709d-a181-4621-a8e5-0ef38b80186b@arm.com/
> 
> OK, then this can be queued up as a prerequisite for the upcoming changes.
> 
> I would, however, mention that in the patch changelog and add a Link:
> tag pointing to the above.
> 

Thank you Rafael!

