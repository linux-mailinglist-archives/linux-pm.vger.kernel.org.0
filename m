Return-Path: <linux-pm+bounces-14432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C680E97C5B7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C7F1F21A13
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA518C938;
	Thu, 19 Sep 2024 08:17:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072151CABA
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733879; cv=none; b=MG3O3Vwco9FIQiXG3+03l7aOgh0c0DIJGLvwPNW5ONC2f8x6LXgEomZ0Y4zpVlw0MpfcgPzBIjpD+k+Tr4o4reUTXT6TLCj8DUI98A1GcpmPqGo/ukIY/T6F/lA32YHW+0TyvqrChswM5P2W6yEMiMQJdGboH/pF/INRNVql0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733879; c=relaxed/simple;
	bh=DNopGvnld8pSSptoXLpTLBtQfMJgy+FaQwlZUQSCkPY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VPCK2/6rst2H8o1BwOwxULPO6pwZIsp5bvsysyNPpeO7cORNKi/bdNip5c9kcHNhp7ZTlD7y5BuQOw5FBS06tbkwUtv7VUBtGL8sTHOLtBOVLauhoxORaf0nnW2uxJ4YxBhOwmG363OyzGceng0FV5r/2z8Ewa3ljEaJTkb70TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.30.4.124] (unknown [193.158.90.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 90EA361E5FE05;
	Thu, 19 Sep 2024 10:17:25 +0200 (CEST)
Message-ID: <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
Date: Thu, 19 Sep 2024 10:17:24 +0200
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
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Am 19.09.24 um 07:51 schrieb Paul Menzel:

> Am 19.09.24 um 07:51 schrieb Paul Menzel:

>> On the Intel Kaby Lake laptop Dell XPS 13, Linux 6.11.0-04557- 
>> g2f27fce67173 (“6.12-rc0”) fails to ACPI S3 suspend the system. The 
>> screen turns black (as expected) and the power button LED stays on.
>>
>> Doing
>>
>>      echo N | sudo tee /sys/module/printk/parameters/console_suspend
>>
>> and on tty2
>>
>>      sudo systemctl stop gdm3
>>      sudo systemctl start getty@tty1.service
>>
>> and then on tty1
>>
>>      sudo systemctl suspend
>>
>> I see some panic messages and traces containing ktime_get or so, but I 
>> failed to save the messages. (Hints very much appreciated.)
>>
>> I try to test the printk changes, but otherwise bisecting is not 
>> feasible, as it’s my production machine.

It’s not the printk changes. I tested some commits, and assume it’s the 
timer core changes:

     $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
     daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
     9ea925c806dbb Merge tag 'timers-core-2024-09-16' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
     cb69d86550b3f Merge tag 'irq-core-2024-09-16' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip


1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend


Kind regards,

Paul

