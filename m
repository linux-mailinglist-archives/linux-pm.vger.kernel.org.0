Return-Path: <linux-pm+bounces-15643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A899E2F8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9E61F22C59
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838CF1DEFE9;
	Tue, 15 Oct 2024 09:42:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD591CACF9
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985373; cv=none; b=csBesF6x1rFRpyTT0jjE1Qee8iojQyYfZR3FwXBiYLAcnuSDHjkMSMDrbcSubGd7WZSKxAbbjbEepaiw3cphQblTtZD5kdXT2SlUfvghXW7trH5qq+El0VYYQPSMRPIfb9BkcaBzm/2OqOVWm2/qlI9Nv8eQs/AHlKI7h123QtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985373; c=relaxed/simple;
	bh=VvxwXrou6TWK6TPhUVi5koHIa69Be0CW1I7dMRc575U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP+ahNqANLv7gAiu/LnE09n8l3oOgpsCqcjouyPajlcnOURRnlOJLZhUUAsvkEaUYZyCe5Gc1JxNRX3EqjzbtiaY7LKpSVNkasT11wIyOCPY066sgtxAmkORnHLpz6rA/2JEnkkUqWsoq/C83Wrnq6GzgHC4aQeM0A+i45uOdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DA341007;
	Tue, 15 Oct 2024 02:43:20 -0700 (PDT)
Received: from [10.1.33.17] (e127648.arm.com [10.1.33.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372893F51B;
	Tue, 15 Oct 2024 02:42:49 -0700 (PDT)
Message-ID: <8421fc1b-3d92-4f54-944f-6a612e5741dc@arm.com>
Date: Tue, 15 Oct 2024 10:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Vivek yadav <linux.ninja23@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-newbie@vger.kerne" <linux-newbie@vger.kerne>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
 <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com>
 <CAO6a-99xVXE-XgnRWMCK5OPC3aYCvhJoGqEbxJOGGy8-yK7W8g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAO6a-99xVXE-XgnRWMCK5OPC3aYCvhJoGqEbxJOGGy8-yK7W8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 16:49, Vivek yadav wrote:
> * # Be careful, this email looks suspicious; * User Impersonation: The display name on this email is very similar to an internal user but was sent from an email address not normally used by the person. *
> Hi Christian,
> 
>> What is the value of
>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage?
> 
> 0 ===>CPU0 state0 (WFI)
> 0 ===>CPU0 state1 (cpu-retention)
> 408 ==> these values are increasing
> 0
> 38
> 0
> 14
> 0
> 
>> What if you disable state0 on all CPUs?
>> echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state0/disable
> 
> After executing above command.  CPU Idle state WFI time stopped. But
> no change in ``state1`` time.
> 
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``
> 
> OUTPUT:
> 0 ===>CPU0 state0 (WFI)
> 0 ===>CPU0 state1 (cpu-retention)
> 
> increasing some time value(23968) ===>CPU1 state0 (WFI)
> 0 ===>CPU1 state1 (cpu-retention)
> 
> increasing some time value(17512) ==> now it also not increasing
> 0
> 
> increasing some time value(6661)
> 0
> 
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage``
> 
> 0 ===>CPU0 state0 (WFI)
> 0 ===>CPU0 state1 (cpu-retention)
> 
> 408 ==> now these values also stop increasing
> 0
> 
> 42
> 0
> 
> 14
> 0

My guess would be that state1 can't be entered, i.e.
entered_state = target_state->enter(dev, drv, index);
returns < 0, in that case the sysfs 'rejected' field
will be incremented instead of usage and time.

Is that the case for you?
In that case your psci description is probably wrong
and doesn't match your system.

Regards,
Christian



