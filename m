Return-Path: <linux-pm+bounces-35407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209BBA0F8D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A827AC275
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FC3128D3;
	Thu, 25 Sep 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekrw+Epf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791131E0DEA
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823428; cv=none; b=LfMBAjGeK8pedCpN6RQXeXnXwpYGVazWalHOx6xnq0GJHaS4+YL/DN15lQyiZ/zFHuYXL6YK+F8eU+muMPNfP1TixxV/p6BydBi4buNE1uk5mR5TRTxdgMEnpafbiknc/vatIaqjiCosRosWb2DMotA8jhsl9kzFcUA4WR3dTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823428; c=relaxed/simple;
	bh=wYt3Bbzl19VP2E4AL4yangnXFPuJ7GSgCaR18q2I6lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgHim3XlWmoY8yuw2C8ugVeF6hvR4E4rzVhVXIw2aaCyoklBFk5i7VW52aoVE2jgU9Mz8bGdVOdI6tAGMHnd03GJrQ7qnXQg89behuhCytHZy+d9ceOCsbVkTDOFK8lflky24XCa5LCPDOa6CR6sBzMHrIu6fVdZ93R+62zewWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekrw+Epf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56439C4CEF0;
	Thu, 25 Sep 2025 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758823428;
	bh=wYt3Bbzl19VP2E4AL4yangnXFPuJ7GSgCaR18q2I6lU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ekrw+Epf/MmspBPrdaB4zUYELe735w+QTA5HtzrYPulLS7Jh/JiTZuMfH3+GwObgr
	 tcikgrO0fxAlft6S/WvNZWl6+4lV4N396TIKWwKviad7z+OLVWy4KWHEQRWPXZ9Srd
	 p8PPElNOuxARmDgKo2JDjl8O63cE1I/iGhc5HSY4fRoIGnyfIzJ1L4VkASbOFFhBEM
	 InDzeaqRzHiyBRiJNNysUqp8QxtKB5eU6oVXjpPLw6FEkf/DgXhZFJGC4688sydn2P
	 5BCMJtzi3IuKE1srs3b3ahv4bR84BcRko4/0IIOzi5FfSebGmNtqAesWIAo0L+uF+J
	 Lymk/3AxC4zLQ==
Message-ID: <1b204004-03c1-48b5-abc3-eef5084ba680@kernel.org>
Date: Thu, 25 Sep 2025 13:03:46 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>,
 Kenneth Crudup <kenny@panix.com>
References: <20250925155918.2725474-1-superm1@kernel.org>
 <20250925155918.2725474-2-superm1@kernel.org>
 <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
 <CAJZ5v0i4xMy=y-gXgSnewAYu3uBCWYhhXBP1-MSTBfgCLq80VA@mail.gmail.com>
 <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0irbKvO-tFaQWa8E0dLikN6d=y6yOxJfzQvpDVPe-TaTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/2025 12:55 PM, Rafael J. Wysocki wrote:
> On Thu, Sep 25, 2025 at 7:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Sep 25, 2025 at 7:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Thu, Sep 25, 2025 at 5:59 PM Mario Limonciello (AMD)
>>> <superm1@kernel.org> wrote:
>>>>
>>>> Hybrid sleep will hibernate the system followed by running through
>>>> the suspend routine.  Since both the hibernate and the suspend routine
>>>> will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
>>>> before starting the suspend sequence.
>>>>
>>>> Add an explicit call to pm_restore_gfp_mask() to power_down() before
>>>> the suspend sequence starts. Don't call pm_restore_gfp_mask() when
>>>> exiting suspend sequence it is already called:
>>>>
>>>> ```
>>>> power_down()
>>>> ->suspend_devices_and_enter()
>>>> -->dpm_resume_end()
>>>> ```
>>>>
>>>> Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
>>>> Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
>>>> Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequence")
>>>> Tested-by: Kenneth Crudup <kenny@panix.com>
>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>> v2:
>>>>   * Move under CONFIG_SUSPEND scope (LKP robot)
>>>>   * Add tags
>>>> ---
>>>>   kernel/power/hibernate.c | 11 ++++++++++-
>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>>>> index 2f66ab4538231..52c1818749724 100644
>>>> --- a/kernel/power/hibernate.c
>>>> +++ b/kernel/power/hibernate.c
>>>> @@ -695,6 +695,7 @@ static void power_down(void)
>>>>
>>>>   #ifdef CONFIG_SUSPEND
>>>>          if (hibernation_mode == HIBERNATION_SUSPEND) {
>>>> +               pm_restore_gfp_mask();
>>>>                  error = suspend_devices_and_enter(mem_sleep_current);
>>>>                  if (error) {
>>>>                          hibernation_mode = hibernation_ops ?
>>>> @@ -862,7 +863,15 @@ int hibernate(void)
>>>>                                  power_down();
>>>>                  }
>>>>                  in_suspend = 0;
>>>> -               pm_restore_gfp_mask();
>>>> +               switch (hibernation_mode) {
>>>> +#ifdef CONFIG_SUSPEND
>>>> +               case HIBERNATION_SUSPEND:
>>>> +                       break;
>>>> +#endif
>>>> +               default:
>>>> +                       pm_restore_gfp_mask();
>>>> +                       break;
>>>> +               }
>>>
>>> You're breaking HIBERNATION_TEST_RESUME here AFAICS
>>
>> Well, not really because of the hibernation_mode check.
>>
>>> and power_down() doesn't return.
>>
>> But this still is true.
> 
> Well, except when it does HIBERNATION_SUSPEND.
> 
> But can you just make power_down() call pm_restrict_gfp_mask() before
> returning and leave the code in hibernate() as is?

Ah good suggestion.  I believe so.  I'll test it and get out updated 
patches if that works.


