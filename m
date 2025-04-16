Return-Path: <linux-pm+bounces-25546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1387A8B816
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FB0189CEA4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB52309AA;
	Wed, 16 Apr 2025 12:01:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8720E6E4;
	Wed, 16 Apr 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804914; cv=none; b=toZXGyobQSSJU5ESK9kp242HsTkPUp+kKDEnAhzHphIiRZdLsFciYefLbUAbc6sagBGqOUakJKHoeAduazny5kohLfDflUifYAOJHZiKEu3x47SH0clvkFbb2jK/6OcK8vV5pXY7wMx73Syuw7akVyzw2CgoYY/oJpIipkAEu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804914; c=relaxed/simple;
	bh=61G4ZtYEDF4bwHv3JKZIAd75tAB7F5sVcNbZwmSNjpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpCSCqiJj9EclAuNoEmd/5RduBqb1BJE1huRP0SiSYpePEBiDyc5yw78aTRjJiWWKZmyDU6yMmQ9fNYQnn5JwRCW8hMJf8qBhWor+xHf1KPWM1sjt20QecroYFbeapiS7v+SMk55XB2CgE/JrDsdF6b1n2abHx22ikQ6DFJjMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4DC1595;
	Wed, 16 Apr 2025 05:01:48 -0700 (PDT)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225443F694;
	Wed, 16 Apr 2025 05:01:47 -0700 (PDT)
Message-ID: <b0c863d8-b1bd-4b69-b5ec-18544608448c@arm.com>
Date: Wed, 16 Apr 2025 13:01:46 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] cpufreq/sched: Explicitly synchronize
 limits_changed flag handling
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <3376719.44csPzL39Z@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3376719.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 10:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The handling of the limits_changed flag in struct sugov_policy needs to
> be explicitly synchronized to ensure that cpufreq policy limits updates
> will not be missed in some cases.
> 
> Without that synchronization it is theoretically possible that
> the limits_changed update in sugov_should_update_freq() will be
> reordered with respect to the reads of the policy limits in
> cpufreq_driver_resolve_freq() and in that case, if the limits_changed
> update in sugov_limits() clobbers the one in sugov_should_update_freq(),
> the new policy limits may not take effect for a long time.
> 
> Likewise, the limits_changed update in sugov_limits() may theoretically
> get reordered with respect to the updates of the policy limits in
> cpufreq_set_policy() and if sugov_should_update_freq() runs between
> them, the policy limits change may be missed.
> 
> To ensure that the above situations will not take place, add memory
> barriers preventing the reordering in question from taking place and
> add READ_ONCE() and WRITE_ONCE() annotations around all of the
> limits_changed flag updates to prevent the compiler from messing up
> with that code.
> 
> Fixes: 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")
> Cc: 5.3+ <stable@vger.nernel.org> # 5.3+

typo in the address here.
I don't fully understand why we wouldn't want this in 6.15-rc already,
even if the actual impact may be limited?

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

>[snip]

