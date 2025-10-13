Return-Path: <linux-pm+bounces-35991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E6BD5B4B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2085188353C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BFF2D47E0;
	Mon, 13 Oct 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjlM5bfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A52D3A6F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380024; cv=none; b=LYrL6s7GLVkFotDyCaqg/wGPXTdeN8Nm2j0p5vxSdY/ORkJ2Oi+nZq/shS1wPGQndgJWw+4+Hoi6k/v9yUG8wsIqVMPwBNl7Pg4J3uPWzD/73LzJ7gwfe5Q4lqz1615H//TeYxxSg/KuNmRByoIMTDX4/e2fwooez+8Hucfl9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380024; c=relaxed/simple;
	bh=VE/HEIwj1bQ+ebqbNdMwxt3bASigE0XM2z92yrmXfDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKjcZzYg3ZZiFFczo+3vViHc+xKKsxnd9TplZDG/JqhJ2ZKNwa4eEYGjOmUT2GgLivnmUJChy+nqAz9ngyk0Zu8S23wgcL/2G1+zlAmTmpOaLL1Luw/pLQkWvgciOTp/Gas2eTxxz438xN4oMOIjTptY4NwfRHq9M/GdiUVy5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjlM5bfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8A0C4CEF8;
	Mon, 13 Oct 2025 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380024;
	bh=VE/HEIwj1bQ+ebqbNdMwxt3bASigE0XM2z92yrmXfDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KjlM5bfbkT+4+m5BdOU5B0W5Wv4D5UrDDNYxdMQ/MaC3ZoJfWGavHfNJuvgpEPiiZ
	 v3oI+ocDKLhoIlKWsp137pL/07yXexaPsQZG3Nm9i2NH3JgsuvBbyTyKOtzynco1uO
	 jOI7OtlewXS65VF7txuvDT3vvZk1dFjYZkNdB6OgWW0L+pun+P9HRnr6V8iNyIJKXT
	 3Mj/gD+0JqBzHq3XXAjk/QZE+jjna//o4L/VUco4+G2semqAQzRbb9DaH9Ze09aVpY
	 X5FAf2uUwAVchWhZc4RaES27DC2l+9PRvwMP9fyLwQ00SP1h/dh/C+pMigoJ8gAGnn
	 //3Krfwf5bpoA==
Message-ID: <92a24599-efc7-4684-abc0-bcf3fb203744@kernel.org>
Date: Mon, 13 Oct 2025 13:27:02 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] PM: hibernate: Nominally skip thaw sequence for
 all devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20251013174729.1101186-1-superm1@kernel.org>
 <20251013174729.1101186-2-superm1@kernel.org>
 <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 12:58 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 13, 2025 at 7:48 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> After the hibernation snapshot is created all devices will have
>> their thaw() callback called before the next stage.  For the most
>> common scenarios of hibernation this is not necessary because the
>> device will be powered off anyway.
> 
> And how exactly is the image going to be saved?
> 
> It is only in memory when the "thaw" callbacks are invoked.

Ah; right.

I suppose one option would be to thaw "just" the backing device, but 
this could turn into a relatively complex mess because it would have 
relationships (parent/child or device link) to other devices that need 
to thaw too then.

> 
>> If the hibernation snapshot was successfully created skip thawing
>> devices until it's needed for userspace created hibernation image
>> or hybrid sleep. To accomplish this use PMSG_INVALID in
>> hibernation_snapshot() and set the dpm functions to skip running.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/base/power/main.c |  6 ++++++
>>   kernel/power/hibernate.c  | 13 ++++++++++---
>>   kernel/power/user.c       |  3 +++
>>   3 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 8179fd53171dc..58f5270a173e8 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1143,6 +1143,9 @@ void dpm_resume(pm_message_t state)
>>          struct device *dev;
>>          ktime_t starttime = ktime_get();
>>
>> +       if (state.event == PM_EVENT_INVALID)
>> +               return;
>> +
>>          trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>>
>>          pm_transition = state;
>> @@ -1245,6 +1248,9 @@ void dpm_complete(pm_message_t state)
>>   {
>>          struct list_head list;
>>
>> +       if (state.event == PM_EVENT_INVALID)
>> +               return;
>> +
>>          trace_suspend_resume(TPS("dpm_complete"), state.event, true);
>>
>>          INIT_LIST_HEAD(&list);
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index aadf82f57e868..7af2e392c574a 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -480,13 +480,14 @@ int hibernation_snapshot(int platform_mode)
>>          if (error || !in_suspend)
>>                  swsusp_free();
>>
>> -       msg = in_suspend ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE;
>> +       msg = in_suspend ? (error ? PMSG_RECOVER : PMSG_INVALID) : PMSG_RESTORE;
>>          dpm_resume(msg);
>>
>> -       if (error || !in_suspend)
>> +       if (error || !in_suspend) {
>>                  pm_restore_gfp_mask();
>> +               console_resume_all();
>> +       }
>>
>> -       console_resume_all();
>>          dpm_complete(msg);
>>
>>    Close:
>> @@ -707,7 +708,13 @@ static void power_down(void)
>>
>>   #ifdef CONFIG_SUSPEND
>>          if (hibernation_mode == HIBERNATION_SUSPEND) {
>> +               /* recover from hibernation_snapshot() */
>> +               dpm_resume(PMSG_THAW);
>> +               console_resume_all();
>> +               dpm_complete(PMSG_THAW);
>>                  pm_restore_gfp_mask();
>> +
>> +               /* run suspend sequence */
>>                  error = suspend_devices_and_enter(mem_sleep_current);
>>                  if (!error)
>>                          goto exit;
>> diff --git a/kernel/power/user.c b/kernel/power/user.c
>> index 3f9e3efb9f6e7..d70c963b1ba88 100644
>> --- a/kernel/power/user.c
>> +++ b/kernel/power/user.c
>> @@ -310,6 +310,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>>                  pm_restore_gfp_mask();
>>                  error = hibernation_snapshot(data->platform_support);
>>                  if (!error) {
>> +                       dpm_resume(PMSG_THAW);
>> +                       console_resume_all();
>> +                       dpm_complete(PMSG_THAW);
>>                          error = put_user(in_suspend, (int __user *)arg);
>>                          data->ready = !freezer_test_done && !error;
>>                          freezer_test_done = false;
>> --
>> 2.43.0
>>


