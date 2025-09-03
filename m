Return-Path: <linux-pm+bounces-33747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36AB427F2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B318917D1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56112302756;
	Wed,  3 Sep 2025 17:26:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098E3043DB
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920404; cv=none; b=Kiv2Z52Zl5GWHUASngpq9hjcr4hoBL8Df6+lKInIceY0FOgXlWKOFm3qvqcTEK+P4of54mJBbulgqBr+e/bJifb7x9NF4rtqt98vWLHj54fjU2/n8oNnRJaP86qs10KsqkG7HuXP6r3pajycY+dYd+lN1Nuv+akWMQE8GJy9jgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920404; c=relaxed/simple;
	bh=bzXpP2tDlbXT+AlP6juQW9DF4uBa3cF9wN5WvUO1tVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jY8nBDxkD7PEfwG/d7NKUXX2iIp2MogrTAG5w5B97CbBv90iVKKE3pmt/VEvHdkvAVBR/6+xQSfJhcdkcQ2hkKDgJmNNlr4njm9wm1kznWpGiGYonWhY0qe1CAt8IQhXtVwGQv/mQiVLKPKVC76Q3+uqL+a1sHPUzD/T5w4QKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F94B1655;
	Wed,  3 Sep 2025 10:26:33 -0700 (PDT)
Received: from [10.1.28.62] (e127648.arm.com [10.1.28.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D893F694;
	Wed,  3 Sep 2025 10:26:40 -0700 (PDT)
Message-ID: <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
Date: Wed, 3 Sep 2025 18:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: Kenneth Crudup <kenny@panix.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
 <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/25 18:19, Kenneth Crudup wrote:
> 
> (Sorry for the delay, it's been a US holiday weekend here)
> 
>> I wonder though, given that this works fine on my x86 nosmt hybrid (presumably something like yours?) is this actually an issue for you?
> 
> TBH, the real reason I'd looked into it was 'cause I was getting "energy_model: Accessing cpu1 policy failed" every few seconds spammed into my dmesg and I thought it may have been an error.
> 
> That being said, do you expect your patch to be upstreamed? Raphael seems to think it's OK.

Yeah looks like we're dropping that debug message.
See
https://lore.kernel.org/lkml/20250831214357.2020076-1-christian.loehle@arm.com/

> 
> I still have /proc/sys/kernel/sched_energy_aware == 1, and then there's:

That means all is well and EAS is enabled!

> 
> sudo ls -las /sys/kernel/debug/energy_model/
> total 0
> 0 drwxr-xr-x 16 root root 0 Sep  2 14:20 .
> 0 drwx------ 53 root root 0 Sep  2 14:20 ..
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu0
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu10
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu12
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu13
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu14
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu15
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu16
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu17
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu18
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu19
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu2
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu4
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu6
> 0 drwxr-xr-x  6 root root 0 Sep  2 14:20 cpu8
> 
>> (and neutering a bunch of userspace stuff that insists on switching schedutil to something inferior)
> 
> Huh. What were these processes, so I can be on the lookout? I just switched to using the energy model so still weighing it all out to see if I'm sticking to it (I'm not sure if I'm seeing the battery-life benefits).

Pretty much anything listed here:
https://wiki.archlinux.org/title/CPU_frequency_scaling
They have different profiles set for these "powersave/balanced/performance" UI knobs
you often get and some of them switch the governor based on that, but as long as
you get
/sys/devices/system/cpu/cpufreq/policy*/scaling_governor
schedutil
or
/proc/sys/kernel/sched_energy_aware
1
You're fine (EAS requires schedutil anyway, so the latter is stronger).

> [snip]

