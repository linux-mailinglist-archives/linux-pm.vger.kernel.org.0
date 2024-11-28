Return-Path: <linux-pm+bounces-18208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768AC9DB6B0
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A2161607
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3B5199FBF;
	Thu, 28 Nov 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWPWB0Pi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D619ABCE;
	Thu, 28 Nov 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794314; cv=none; b=B015Me7tSlRvrwGysMOrRdQRMkxJU/87MjptcocoDFoqCn81+VWSTyeBECLcX6WjqlW2l3xYzlos8BqxqsxgFRbS9a+1d2pdQgqtS7yXANAf7596WYL+v3Q6HHWUFplDqU25Ud1N/zHli2e6iP3Au0sAHPVMyyB7XoC12ltDe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794314; c=relaxed/simple;
	bh=iX5o/BZVDyrvl+aCVdHs4HzTN4nl9aeKKOXztJ3BvMM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AAFl/diuI1uPDJnKpJ5q6A5+hv27P7OW9vf2S58ysGKUkhfkPwdgJ04XCXhXTKopdGv5aA4ur5ojSbAfMH4y/PAix9k7J/uYrSV88fL03mNJCNZ27AqsL3nUNU7yhiHxjmCNTkngJ3Xt8/08K8e9aUAEORwUfFRRBKuxnoaBkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWPWB0Pi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732794313; x=1764330313;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iX5o/BZVDyrvl+aCVdHs4HzTN4nl9aeKKOXztJ3BvMM=;
  b=RWPWB0PinoE7Z/xQOsur9nWQ6W5KCSlX2pRLh9zu7lsTKMsWqD6XcTmk
   ftrnA8OfyCTfxPOvpcqMt1JpmygpmauEBVxKRC14d0u3Uzpq+ikJT+vJP
   pk8EOaBKJ8f9Z+bXbHY2CBYjXYDw7fQ9SsUPiAEmo8CWmCVhal/x95CK2
   77iVFE2bPCXcd/m5clY+YeBflKs+j68+L7/FnozQS2v25HCN+uFuJgMZ5
   v+WJMLwap2A/0ITqPH1xZLbZKpNv1o66niiJO8TkZtmmy6MHf1/laiJep
   /CaSjJDYAk/lVMy77MpQrzbkejbo1yfWXMsPPt3Mi/Bld2Bd993d+2Cbd
   g==;
X-CSE-ConnectionGUID: bvTkvlzeTyyZNoX0J475Ug==
X-CSE-MsgGUID: apIDYNtvQ5iCn2YCbc9EMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32970383"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32970383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 03:45:12 -0800
X-CSE-ConnectionGUID: mFpD3BQvTAGQETYMm9BxZg==
X-CSE-MsgGUID: S0aAHS/kQa+3W3QPltqk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92148153"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 03:45:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 Nov 2024 13:45:07 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    dri-devel@lists.freedesktop.org, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Kyle Gospodnetich <me@kylegospodneti.ch>
Subject: Re: [RFC 13/13] PM: standby: Add sysfs attribute for modern standby
 transitions
In-Reply-To: <20241121172239.119590-14-lkml@antheas.dev>
Message-ID: <ae43443d-74a8-799d-26aa-608af973a9e8@linux.intel.com>
References: <20241121172239.119590-1-lkml@antheas.dev> <20241121172239.119590-14-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Nov 2024, Antheas Kapenekakis wrote:

> Add a sysfs attribute to allow informing the kernel about the current
> standby state, those being: "active", "screen_off", "sleep", and
> "resume" (to prepare turning the display on). The final modern
> standby state DRIPS is omitted, as that is entered during the kernel
> suspend process and userspace will never see it.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-power | 34 ++++++++++++
>  kernel/power/main.c                   | 75 +++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index a3942b1036e2..eff13980cc7c 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -39,6 +39,40 @@ Description:
>  		See Documentation/admin-guide/pm/sleep-states.rst for more
>  		information.
>  
> +What:		/sys/power/standby
> +Date:		November 2024
> +Contact:	Antheas Kapenekakis <lkml@antheas.dev>
> +Description:
> +		The /sys/power/standby file controls the standby state of the
> +		system. Modern S0ix capable systems can enter a set of low power
> +		states while the kernel is still active. Transitioning into those
> +		states may 1) deactivate tertiary hardware, and 2) change the
> +		presentation of the device (e.g., pulse the suspend light, turn
> +		off the keyboard backlight).
> +
> +		Available states are "active" (fully active), "screen-off" (fully
> +		active but all displays of the system are off; virtual and real),
> +		"sleep" (major userspace components have been frozen; light
> +		background tasks may still run; this state may affect the power
> +		envelope of the device). The final state is DRIPS or LSP0, where
> +		the kernel suspends, and is entered by writing "mem" to
> +		/sys/power/state. There is a secondary sleep state called "resume"
> +		that can only be entered from "sleep" and is used in certain
> +		devices to boost the Power Limit (PLx) while remaining in sleep
> +		to hasten preparing for transitioning to "active".
> +
> +		Writing one of the above strings to this file causes the system
> +		to transition into the corresponding state, by firing the
> +		corresponding firmware notifications during the transition.
> +
> +		DRIPS or LSP0 (i.e., mem "s2idle") can only be entered from the
> +		"sleep" state. If the kernel is asked to transition to DRIPS from
> +		a different state, it will transition to "sleep" and then suspend.
> +		On wakeup, the kernel will transition back to the previous state.
> +
> +		See Documentation/admin-guide/pm/standby-states.rst for more
> +		information.
> +
>  What:		/sys/power/disk
>  Date:		September 2006
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4817..4377fdaf4a8d 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -748,6 +748,80 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  power_attr(state);
>  
> +#ifdef CONFIG_SUSPEND
> +/*
> + * standby - control system s2idle standby state.
> + *
> + * show() returns available standby states, which may be "active", "screen_off",
> + * "sleep" and "resume" (still in sleep but preparing to turn on display).
> + * See Documentation/admin-guide/pm/standby-states.rst for a description of
> + * what they mean.
> + *
> + * store() accepts one of those strings, translates it into the proper
> + * enumerated value, and initiates a transition to that standby state.
> + *
> + * When the system suspends, it will first enter the state "sleep", suspend,
> + * and then restore the last state before entering "sleep". I.e., if userspace
> + * is not S0ix-aware, the transitions expected by Modern Standby devices will
> + * always be performed.
> + */
> +static ssize_t standby_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			  char *buf)
> +{
> +	char *s = buf;

Instead of char *, add size_t len for the offset.

Order these to reverse xmas tree.

> +	standby_state_t i;
> +	standby_state_t curr = pm_standby_state();
> +
> +	if (curr < 0)
> +		return -EBUSY;
> +
> +	for (i = PM_STANDBY_MIN; i < PM_STANDBY_MAX; i++)
> +		if (standby_states[i])
> +			s += sprintf(s, curr == i ? "[%s] " : "%s ", standby_states[i]);

Do not use sprintf() for anything new.

For sysfs, sysfs_emit_at() (or sysfs_emit()) is the correct function.

You could consider using reverse logic + continue to bring down the 
indentation level.

> +
> +	if (s != buf)
> +		/* convert the last space to a newline */
> +		*(s - 1) = '\n';
> +	return (s - buf);
> +}
> +
> +static standby_state_t decode_standby_state(const char *buf, size_t n)
> +{
> +	standby_state_t state;
> +	char *p;
> +	int len;

size_t

> +	p = memchr(buf, '\n', n);
> +	len = p ? p - buf : n;
> +
> +	for (state = PM_STANDBY_MIN; state < PM_STANDBY_MAX; state++) {
> +		const char *label = standby_states[state];
> +
> +		if (label && len == strlen(label) && !strncmp(buf, label, len))

Isn't len == strlen(label) && !strncmp(buf, label, len) same as using just
using !strcmp() ?

> +			return state;
> +	}
> +
> +	return PM_STANDBY_MAX;
> +}
> +
> +static ssize_t standby_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			   const char *buf, size_t n)
> +{
> +	int error;
> +	standby_state_t state;
> +
> +	state = decode_standby_state(buf, n);
> +
> +	if (state >= PM_STANDBY_MAX)
> +		return -EINVAL;
> +
> +	error = pm_standby_transition(state);
> +	return error ? error : n;

return error ?: n

> +}
> +
> +power_attr(standby);
> +#endif
> +
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * The 'wakeup_count' attribute, along with the functions defined in
> @@ -974,6 +1048,7 @@ static struct attribute * g[] = {
>  #ifdef CONFIG_SUSPEND
>  	&mem_sleep_attr.attr,
>  	&sync_on_suspend_attr.attr,
> +	&standby_attr.attr,
>  #endif
>  #ifdef CONFIG_PM_AUTOSLEEP
>  	&autosleep_attr.attr,
> 

-- 
 i.


