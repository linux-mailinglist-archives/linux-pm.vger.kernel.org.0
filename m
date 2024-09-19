Return-Path: <linux-pm+bounces-14467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A5B97CAB1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660472847A0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19C19F49E;
	Thu, 19 Sep 2024 14:04:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5C19B59D
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754686; cv=none; b=J47427ji84o7xjTJm/iZCNs7dUhvsQFZ6D3EaPI5chHbkQ2L0ZeladICl16Bk4EfMtN6wFexz6pHT4/Kpn9Tg+q+utiS0ETtoI0dfSnx2WqsUQfEOPvlGSf7RPkZh54BjhiG5nKMuTiAzCdYoLCxBXWgZM2/Nx6/LFhe/vf57EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754686; c=relaxed/simple;
	bh=sTgene5gi8O99+OmHyr1eLk/+WtoSC6OcLy9MtHtQDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkjDz8sxCrp/ircRpmfskzXDwROP2MeSUU75WlbhIrsG8H8T7Ax86u8dTmIEvSt7OgZSxUiYQ5JO0JllJdogWhWo0OdT6sIatJPwULhE400TN7c36aqlWEb+XVAzfTfgDUVch109qihdHqyRFA5n/aWQeM6GGCPFq3+BuPHTfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.30.4.253] (unknown [193.158.90.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7FF7F61E5FE05;
	Thu, 19 Sep 2024 16:04:01 +0200 (CEST)
Message-ID: <b3cc0791-6334-4143-90bc-d3ae04aae0de@molgen.mpg.de>
Date: Thu, 19 Sep 2024 16:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
To: Hans de Goede <hdegoede@redhat.com>, Marek Maslanka
 <mmaslanka@google.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
 <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hans,


Am 19.09.24 um 13:57 schrieb Hans de Goede:

> On 19-Sep-24 1:03 PM, Paul Menzel wrote:

>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>
>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>
>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>
>>>>> On the Intel Kaby Lake laptop Dell XPS 13, Linux
>>>>> 6.11.0-04557- g2f27fce67173 (“6.12-rc0”) fails to ACPI S3
>>>>> suspend the system. The screen turns black (as expected) and
>>>>> the power button LED stays on.
>>>>>
>>>>> Doing
>>>>>
>>>>>       echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>>>>
>>>>> and on tty2
>>>>>
>>>>>       sudo systemctl stop gdm3
>>>>>       sudo systemctl start getty@tty1.service
>>>>>
>>>>> and then on tty1
>>>>>
>>>>>       sudo systemctl suspend
>>>>>
>>>>> I see some panic messages and traces containing ktime_get or
>>>>> so, but I failed to save the messages. (Hints very much
>>>>> appreciated.)>>>>>
>>>>> I try to test the printk changes, but otherwise bisecting is
>>>>> not feasible, as it’s my production machine.>>>
>>> It’s not the printk changes. I tested some commits, and assume it’s the timer core changes:
>>>
>>>       $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>>>       daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>       9ea925c806dbb Merge tag 'timers-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>       cb69d86550b3f Merge tag 'irq-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>
>>>
>>> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
>>> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend
>> 
>> It truns out your commit e86c8186d03a (platform/x86:intel/pmc:
>> Enable the ACPI PM Timer to be turned off when suspended) causes
>> the regression. The laptop defaults to s2idle, but due to
>> problems, I force it to `deep`.
>>
>> Revert on master is not easily possible due to other changes it seems.
> 
> First of all thank you for reporting this so early in the cycle and
> for pinning it down to a specific commit. Both are really appreciated.
> 
> I guess that the power-savings from disabling the pm-timer are mostly
> relevant for s0ix suspend. If regular S3 suspend is used the the
> firmware is in control of the suspend and if necessary it should disable
> the timer.
> 
> So I think we can fix this by limiting the new handling to s0ix suspend.
> 
> Can you please give the attached patch a try?

Thank you so much for the instant reaction. Indeed, your patch makes 
ACPI S3 suspend work.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 
9360/0596KF, BIOS 2.21.0 06/02/2022


Kind regards,

Paul

