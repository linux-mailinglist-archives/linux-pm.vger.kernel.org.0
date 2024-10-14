Return-Path: <linux-pm+bounces-15620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE399CAC8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDD01C2222B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B621A76B9;
	Mon, 14 Oct 2024 12:54:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7831E4A6
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910447; cv=none; b=MN1ihbcuGqWvCV3E1VjkHax6XW1ylEyUscxOt4AqYXg48pi/QZQ+JBxVyDA5QCbvLEROQ4EGVK3Ov4jIkiL+lV2AW++tmeoUp/GVxYk/+t9pmkLtdr0AweLsGJPQ3Wak9E6ni1sDNA8qJQkuVeunY6IrvHR7QnCK0qx6i69x3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910447; c=relaxed/simple;
	bh=OadrTDNs7kOIYsiwm0UsqyCgGmQ6/CFrjyYaoE41xWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIAjTof+KcF7iAKt6rF8W5k2Igfd/IF098ETJ7q8d3USCW0n04SFs9eSo4NA/XlgFETKLegk9wicfk7p9nAqtTUUSC8F2/a01hJeyQn6MJbvkM0j7+BTimfw18fCcQKd/KltPemTcTTdJbyGCbD2Y7y33+1h8gRCiLA0Zuiz6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8855A1007;
	Mon, 14 Oct 2024 05:54:35 -0700 (PDT)
Received: from [10.1.33.17] (e127648.arm.com [10.1.33.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56103F71E;
	Mon, 14 Oct 2024 05:54:04 -0700 (PDT)
Message-ID: <5055c0ce-00cb-4319-beac-650436d4ad15@arm.com>
Date: Mon, 14 Oct 2024 13:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
To: Vivek yadav <linux.ninja23@gmail.com>, linux-pm@vger.kernel.org,
 linux-newbie@vger.kerne
Cc: daniel.lezcano@linaro.org, lpieralisi@kernel.org, krzk@kernel.org
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAO6a-9-Gd44qiM7obURXwd8hrarZQ_8BpdbQPWQojh+yhO4oRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/24 11:28, Vivek yadav wrote:
> ---------- Forwarded message ---------
> From: Vivek yadav <linux.ninja23@gmail.com>
> Date: Fri, Oct 11, 2024 at 3:14 PM
> Subject: ARM64: CPUIdle driver is not select any Idle state other then WFI
> To: <linux-pm@vger.kernel.org>
> 
> 
> Hi @all,
> 
> I am working on one custom SoC. Where I add one CPUIdle state for
> ``arm,cortex-a55`` processor.
> 
> idle-states {
>       entry-method = "psci";
>        cpu_ret_l: cpu-retention-l {
>          compatible = "arm,idle-state";
>          arm,psci-suspend-param = <0x00010001>;
>          local-timer-stop;
>          entry-latency-us = <55>;
>           exit-latency-us = <140>;
>           min-residency-us = <780>;
>     };
> };
> 
> I am using ``Menu governor`` with the ``psci_idle driver`` in its original form.
> After booting Linux I find out that the CPUIdle core is never going
> inside the ``cpu-retention`` state.
> To check time spent by CPU in any state. I am using the below command.
> 
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``
> 
> OUTPUT:
> 0 ===>CPU0 state0 (WFI)
> 0 ===>CPU0 state1 (cpu-retention)
> 
> increasing some time value ===>CPU1 state0 (WFI)
> 0 ===>CPU1 state1 (cpu-retention)
> 
> increasing some time value
> 0
> 
> increasing some time value
> 0
> 
> What am I doing wrong? Why does ``cpu-retention`` state time not increase?
> Any pointer will be helpful.

What is the value of 
cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage
?
Does state1 usage increase?

What if you disable state0 on all CPUs?
echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state0/disable

