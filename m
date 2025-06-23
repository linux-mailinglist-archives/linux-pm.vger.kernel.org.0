Return-Path: <linux-pm+bounces-29409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D3AE5374
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E34A0CC7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B84221FCC;
	Mon, 23 Jun 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5+BKy75"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0A19049B;
	Mon, 23 Jun 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715584; cv=none; b=lWGt7aqBFIJKu1w6iI2VfgqzJFs3SpTc/9V7rWFxbBD0t5ZYTosY+wXtUOgRBmidpFNYHLavBOKWcxM1yTE3sTYZVU0Q1ExrIYM1yVSNKsbH0UKbDIX2R4rfEDzeGOza6Bb+ST+19k85hYJ3oVIGGfosWsKH+yUrLu0XkH3CnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715584; c=relaxed/simple;
	bh=uFG22XUMGmm2tI8HI2nhJKEDzXIL0MCktOxHLoz1+pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFWup5ZEVy1b6yUFFF8CU9kHcru2nO/mRdFIZ5Azaqgo0Aq7hCwj4YsHCFYlKXPzXiL2kInos89CL2loniSJ9GlN3Yb3nt8KyvOW6ujfPwDHFJYdLvVJB9Mc5HGsJqS3V7yllv+VtO+X7Yf4vhQxvRvhWLAQxS+tY0YedX2WFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5+BKy75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F5BC4CEED;
	Mon, 23 Jun 2025 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750715584;
	bh=uFG22XUMGmm2tI8HI2nhJKEDzXIL0MCktOxHLoz1+pY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a5+BKy7510oy4AwlJoShKm7rDVYmQIcZ5J15w2wMvxJgqn/K8DiPikpONkPaGusFI
	 dF7uhgspxgWxm92Z/i38D0hHq3w7tWqtUvzmmKBTfUsA75EuKbduzFx7Etan1vIyKt
	 TyOe0r65LUq/Wdz5lOwUL+mW2rx9QHE6mXMXF4yo6D+SFh+Ny8RNDqjezeU49/lvt9
	 qpd1Eim0gogghqKN8mJKJy3gg5qvZ/zc6FsNQ/oxl0Bgfpb5nhS/jPH6Yg0WakLgX3
	 26Y/e2XwJ7Y/zySFrByJufGkWPwvdHEm+WybHo5LxnP5AmuuP3wGjQVmu/NjogvXOd
	 sQrhvhiUDr8lg==
Message-ID: <df4c0c3e-19b5-4521-9b9b-d445d65ee2c7@kernel.org>
Date: Mon, 23 Jun 2025 16:53:02 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/13] Add support for AMD hardware feedback interface
To: Mario Limonciello <superm1@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/2025 3:05 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification of tasks.
> 
> Threads are classified during runtime into enumerated classes.
> Currently, the driver supports 3 classes (0 through 2). These classes
> represent thread performance/power characteristics that may benefit from
> special scheduling behaviors. The real-time thread classification is
> consumed by the operating system and is intended to be used to inform the scheduler
> of where the thread should be placed for optimal performance or energy efficiency.
> 
> The thread classification can be used to helps to select CPU from a ranking table
> that describes an efficiency and performance ranking for each classification from
> two dimensions. This is not currently done in this series, but is intended for future
> follow ups after the plumbing is laid down.
> 
> The ranking data provided by the ranking table are numbers ranging from 0 to 255,
> where a higher performance value indicates higher performance capability and a higher
> efficiency value indicates greater efficiency. All the CPU cores are ranked into
> different class IDs. Within each class ranking, the cores may have different ranking
> values. Therefore, picking from each classification ID will later allow the scheduler
> to select the best core while threads are classified into the specified workload class.
> 
> This series was originally submitted by Perry Yuan [1] but he is now doing a different
> role and he asked me to take over.
> 
> Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/
> 
> v10->v11:
>   * rebase on v6.16-rc1
>   * Adjust for Randy's and Ingo's feedback
> 
> Mario Limonciello (5):
>    MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
>    cpufreq/amd-pstate: Disable preferred cores on designs with workload
>      classification
>    platform/x86/amd: hfi: Set ITMT priority from ranking data
>    platform/x86/amd: hfi: Add debugfs support
>    x86/itmt: Add debugfs file to show core priorities
> 
> Perry Yuan (8):
>    Documentation: x86: Add AMD Hardware Feedback Interface documentation
>    x86/msr-index: define AMD heterogeneous CPU related MSR
>    platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
>    platform/x86: hfi: parse CPU core ranking data from shared memory
>    platform/x86: hfi: init per-cpu scores for each class
>    platform/x86: hfi: add online and offline callback support
>    platform/x86: hfi: add power management callback
>    x86/process: Clear hardware feedback history for AMD processors
> 
>   Documentation/arch/x86/amd-hfi.rst    | 133 +++++++
>   Documentation/arch/x86/index.rst      |   1 +
>   MAINTAINERS                           |   9 +
>   arch/x86/include/asm/msr-index.h      |   5 +
>   arch/x86/kernel/itmt.c                |  23 ++
>   arch/x86/kernel/process_64.c          |   4 +
>   drivers/cpufreq/amd-pstate.c          |   6 +
>   drivers/platform/x86/amd/Kconfig      |   1 +
>   drivers/platform/x86/amd/Makefile     |   1 +
>   drivers/platform/x86/amd/hfi/Kconfig  |  18 +
>   drivers/platform/x86/amd/hfi/Makefile |   7 +
>   drivers/platform/x86/amd/hfi/hfi.c    | 551 ++++++++++++++++++++++++++
>   12 files changed, 759 insertions(+)
>   create mode 100644 Documentation/arch/x86/amd-hfi.rst
>   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 

Ping on this series, thanks.


