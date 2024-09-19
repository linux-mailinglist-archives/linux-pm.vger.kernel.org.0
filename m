Return-Path: <linux-pm+bounces-14457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3997C84D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5BE1F24BD6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42919ABB3;
	Thu, 19 Sep 2024 11:04:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E017D344
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726743845; cv=none; b=NhPFJFUBiMyVsZPEhTxUKiEectv/eksPg2xwEDRWCvgzpE1m1+/mCZxN5TtvtvuNIPPPbvxymYBrnsWngIpsi076Js34/u0Trizj7lqlaSPjv6mxcGt/hYD0SxF/q6AM35RtivRqFqpXyQWkAAWw0a4bGIRNO069T39NYHOGFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726743845; c=relaxed/simple;
	bh=72Qxy5S8yu5QxJGrxPsUCoBegyZ550stFJfj7SD/6wQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qn4cCIWac+FPMHFGTR8HG879TV5IkKwfJXrigczYNFGNAAY43wdWTQDc85Lb0Xxeb1eqMm9BI5/KIdEjiajma6rkDNgrc8oeWYIn5FLBiCuuhOaIWgiUwVWt+DwOYYktyRue2oZqoyyWoE3CPvvLwu36CZFd4FF3INpFMiJpSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.30.4.253] (unknown [193.158.90.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1141D61E5FE05;
	Thu, 19 Sep 2024 13:03:22 +0200 (CEST)
Message-ID: <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
Date: Thu, 19 Sep 2024 13:03:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Marek Maslanka <mmaslanka@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Marek,


Am 19.09.24 um 10:17 schrieb Paul Menzel:

> Am 19.09.24 um 07:51 schrieb Paul Menzel:
> 
>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
> 
>>> On the Intel Kaby Lake laptop Dell XPS 13, Linux 6.11.0-04557- 
>>> g2f27fce67173 (“6.12-rc0”) fails to ACPI S3 suspend the system. The 
>>> screen turns black (as expected) and the power button LED stays on.
>>>
>>> Doing
>>>
>>>      echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>>
>>> and on tty2
>>>
>>>      sudo systemctl stop gdm3
>>>      sudo systemctl start getty@tty1.service
>>>
>>> and then on tty1
>>>
>>>      sudo systemctl suspend
>>>
>>> I see some panic messages and traces containing ktime_get or so, but 
>>> I failed to save the messages. (Hints very much appreciated.)
>>>
>>> I try to test the printk changes, but otherwise bisecting is not 
>>> feasible, as it’s my production machine.
> 
> It’s not the printk changes. I tested some commits, and assume it’s the 
> timer core changes:
> 
>      $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>      daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>      9ea925c806dbb Merge tag 'timers-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>      cb69d86550b3f Merge tag 'irq-core-2024-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> 
> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend

It truns out your commit e86c8186d03a (platform/x86:intel/pmc: Enable 
the ACPI PM Timer to be turned off when suspended) causes the 
regression. The laptop defaults to s2idle, but due to problems, I force 
it to `deep`.

Revert on master is not easily possible due to other changes it seems.


Kind regards,

Paul



