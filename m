Return-Path: <linux-pm+bounces-30582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1DBB002B0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406833A590F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A025FA3B;
	Thu, 10 Jul 2025 12:58:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2A1E8333;
	Thu, 10 Jul 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152281; cv=none; b=dSCz13zxv2ahe9Bp+1mmJ6ifJl/XehvNeGkHZ44EGXqesIKBaa2lWlE91ST1c/1H8UKkwyuGNwmvaZVoYF7qoZYOWBXrDfdaGSPxjpcX4AAUihWMb9X34kxkBLqQDxWxFEfmGXEZW8WrNe3LLWJ6M9/5CLhjfzcml+RU4gor+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152281; c=relaxed/simple;
	bh=zwBtqkT25ZAX+sp1nl3oFbbZxZoeWwTF/wCZRk2t2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmGbt6Hgm4LYZ+PsygB5oAn9GTmDmqX2T3he7oUDdUDUtOi5IUdFoUZfQ+CkzHlb8aC+x281lFBvUzS+q0Yp7llbHSybwjjb57wdUf7+7mxw4tRUR4Tp4hScWQsXVodllyR4QtL+PYTacpe5F08znD9w1aFz3tSf3bZFStffVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9891EA6;
	Thu, 10 Jul 2025 05:57:46 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09F73F66E;
	Thu, 10 Jul 2025 05:57:55 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:57:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, ulf.hansson@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
Message-ID: <aG-40INpi05v3-fQ@bogus>
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
 <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com>

On Thu, Jul 10, 2025 at 02:43:10PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 9, 2025 at 5:47 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> > not supported because the underlying generic power domain functions
> > used in the cpu hotplug callbacks are incompatible from a lock point
> > of view. This situation prevents the suspend to idle to reach the
> > deepest idle state for the "cluster" as identified in the
> > undermentioned commit.
> >
> > Use the compatible ones when PREEMPT_RT is enabled and remove the
> > boolean disabling the hotplug callbacks with this option.
> >
> > With this change the platform can reach the deepest idle state
> > allowing at suspend time to consume less power.
> >
> > Tested-on Lenovo T14s with the following script:
> >
> > echo 0 > /sys/devices/system/cpu/cpu3/online
> > BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
> > rtcwake -s 1 -m mem;
> > AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
> > if [ $BEFORE -lt $AFTER ]; then
> >     echo "Test successful"
> > else
> >     echo "Test failed"
> > fi
> > echo 1 > /sys/devices/system/cpu/cpu3/online
> >
> > Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
> > Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> As per MAINTAINERS, this is for Ulf/Sudeep.
> 

LGTM, so

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I still prefer to hear from Ulf who has more knowledge and hands-on experience
with s2idle + PREEMPT_RT in case I am missing something.

-- 
Regards,
Sudeep

