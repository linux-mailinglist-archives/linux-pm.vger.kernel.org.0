Return-Path: <linux-pm+bounces-26838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C286AAEC67
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AD04E6C3A
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B01FBEA8;
	Wed,  7 May 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fakkwfbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0479E1
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647156; cv=none; b=WF8c3LrvjedSYysmCJvF1DW/hTUnShKEU6l/pTTevKUqYRGpTL89P8PABTBBR0dcXBENP1JYJTAWfVcCzgpMjBBpI5mpJEFnmJ6StTCjEeeVNHmtB8sh4odL5IcyfoooY+rLC/GzKNFqPmu9z6pnrTwL6NE6se+HI+/tAoumqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647156; c=relaxed/simple;
	bh=WgSebmhN43frxJW5nnVmkO3qM8pnX9hlJyAGZ4H6jUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdsPDdL7FraNb/Yey1iGQwILc9FZBLGNNki4dbl39XXXkBZReQkkgqlfHpJprunZl2CDRysBxL1AiWtky3SHcECouFdwGppuazIbXCmepaBky9UHa2HnJqzxO8BcsWPoP/EOkkXdwRZCQ/9m5gPdq+QGdgCRohzDYWwrFZs4r8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fakkwfbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA117C4CEE2;
	Wed,  7 May 2025 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647155;
	bh=WgSebmhN43frxJW5nnVmkO3qM8pnX9hlJyAGZ4H6jUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FakkwfbqNa7criGhemy8k/vdD6lIcFMzAMsICjzWwYUU6EgvgheUeQNY0TLnoO0QM
	 gyQu1n8Pjvn0KW6morbQo0P9txgQrZIUNrh9vzdaulF7voDI4kg9g2qqPXXregpcAh
	 rljU1g9GeUz8Ieu/Av+Ds4VCAZmyfmEHLTC4E/bX5rO+iAwHuyuhLFNhkcD7SxyC2m
	 6op/IrrFwzyzNym9yhTF/dtAEq9q/ip2cBvBik96QyLTZO7MDqW1I2RXcBmAka0S6y
	 j3+BrEPyEgfAPJmYH23fLQT+EAP0WyvlA9vZ8hoTKAjZRs5417eVdm3zbd7KBUZnHi
	 ggZl1zv7B0YtA==
Message-ID: <74428a0f-754b-4f85-bca3-48216613c208@kernel.org>
Date: Wed, 7 May 2025 14:45:53 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze
 notifications
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250501211734.2434369-1-superm1@kernel.org>
 <20250501211734.2434369-3-superm1@kernel.org>
 <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
 <98d527c6-a185-40f9-8ce3-46f5d7a67e81@kernel.org>
 <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0i=9fpg2YxJhd+2rAx1gkqaquoExHvgMiFefn6YqVieOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/2025 2:39 PM, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 9:17 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 5/7/2025 2:14 PM, Rafael J. Wysocki wrote:
>>> On Thu, May 1, 2025 at 11:17 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
>>>> callback support") introduced a VRAM eviction earlier in the PM
>>>> sequences when swap was still available for evicting to. This helped
>>>> to fix a number of memory pressure related bugs but also exposed a
>>>> new one.
>>>>
>>>> If a userspace process is actively using the GPU when suspend starts
>>>> then a deadlock could occur.
>>>>
>>>> Instead of going off the prepare notifier, use the PM notifiers that
>>>> occur after processes have been frozen to do evictions.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
>>>> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 7f354cd532dc1..cad311b9fd834 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
>>>>           int r;
>>>>
>>>>           switch (mode) {
>>>> -       case PM_HIBERNATION_PREPARE:
>>>> +       case PM_HIBERNATION_POST_FREEZE:
>>>>                   adev->in_s4 = true;
>>>>                   fallthrough;
>>>> -       case PM_SUSPEND_PREPARE:
>>>> +       case PM_SUSPEND_POST_FREEZE:
>>>>                   r = amdgpu_device_evict_resources(adev);
>>>>                   /*
>>>>                    * This is considered non-fatal at this time because
>>>> --
>>>
>>> Why do you need a notifier for this?
>>>
>>> It looks like this could be done from amdgpu_device_prepare(), but if
>>> there is a reason why it cannot be done from there, it should be
>>> mentioned in the changelog.
>>
>> It's actually done in amdgpu_device_prepare() "as well" already, but the
>> reason that it's being done earlier is because swap still needs to be
>> available, especially with heavy memory fragmentation.
> 
> Swap should be still available when amdgpu_device_prepare() runs.

No; it's not.  The basic call trace (for suspend) looks like this:

enter_state(state) {
     suspend_prepare(state);
     ...
     pm_restrict_gfp_mask();  // disable swap
     suspend_devices_and_enter(state) → dpm_suspend_start() {
         dpm_prepare() {
             amdgpu_pmops_prepare();
         }
         dpm_suspend() {
             amdgpu_pmops_suspend();
         }
     }
}

If the intention was for it to be available, it would be better to move 
the pm_restrict_gfp_mask() call "into" suspend_devices_and_enter() 
between dpm_prepare() and dpm_suspend() calls.

> 
>> I'll add more detail about this to the commit for the next spin if
>> you're relatively happy with the new notifier from the first patch.
> 
> I need to have a look at it, but adding it for just one user seems a
> bit over the top.  I'd prefer to avoid doing this.


