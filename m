Return-Path: <linux-pm+bounces-28485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFEAD553E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B041BC1C85
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97E2777F9;
	Wed, 11 Jun 2025 12:17:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1901274FDE;
	Wed, 11 Jun 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644238; cv=none; b=t6hVLufbYcMev9xIaIfo/PbUQF19sMh4I6+95wkU/eUOtMd3DkgkPG6gzTgqnE5clF0Yrc4oNnC9vurEAj8Ih9sYVmk/OzvUDnRIR4Y4EoCQrF3IeKi753MOYC3GiuFgSY04eI6uJJ6ozXzCw15FUs0kkyXRZKm4xSz09iUG9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644238; c=relaxed/simple;
	bh=HF5uVuhB0h+FzyGFATdcJwR9EcckejdGzlGRXznbmOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtUbQNxwBAusO28YlVB6CaTrUlPzzoRfJUxD52Q3DuwBpvm/QriiEz1rbfZUBvSt+6YRO0j8YsLIUThV95xOy4RnPsfHUKhPn6Y2W7pmyzmIYN4Iw7wBMaFiKvtMYL54LvxlxWcZCEo5zIXENMWAdkXef9Pky4TuZYhBT17OKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E0FC15A1;
	Wed, 11 Jun 2025 05:16:56 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CBAB3F673;
	Wed, 11 Jun 2025 05:17:13 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:17:11 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable
 notification only if supported by platform
Message-ID: <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>

On Wed, Jun 11, 2025 at 03:52:42PM +0800, Peng Fan (OSS) wrote:
> PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
> commands. If use these commands on platforms that not support the two,
> there is error log:
>   SCMI Notifications - Failed to ENABLE events for key:13000008 !
>   scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
> 

I wonder if it makes sense to quiesce the warnings from the core if the
platform doesn't support notifications. I prefer to not add if notification
supported in all the protocols.

If the interface can return -EOPNOTSUPP(equivalent to SCMI_ERR_SUPPORT),
the caller must handle it appropriately(i.e. continue if it can handle
absence of notification or propagate error).

Cristian, Thoughts/opinions ?

> If platforms not support perf notification, saving some cpu cycles
> by introducing notify_supported ops.
> 

Sure, makes sense to improve where ever possible.

> While at here, patch 1 is a typo fix when doing the patchset.
>

This one looks OK.

-- 
Regards,
Sudeep

