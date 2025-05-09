Return-Path: <linux-pm+bounces-26919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B0AB1149
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F6A1898EE8
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198CF28CF51;
	Fri,  9 May 2025 10:55:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499B21D3EF;
	Fri,  9 May 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788156; cv=none; b=pRAiCE3e1wY/UzHLuimjQe2FXe6W7S3h0o08sddd2HNpGiQLKsQ9xvF0lGle2zOoS9rtQ2xmBzWus0z5KXdCYCRZ4KAW9imtRplTfOF/kyK40SFRNY+lBOlbUmcMTq6q3GooRx+wBKJTtsAjp1v1dLvlLw4UnjybmqXcdLH7j3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788156; c=relaxed/simple;
	bh=nfM47SJeZdWs2tvw/ayH0OAUPrt70KkrIywLMuZiSE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFCagAceiy3nGDjdtcAO9ZJX5/c6Em+AdlbAAV1yHiQI9+ffMKwd/KaARJHHnSx4WWuWrzqfnIlXbe00k9KWOxqij4+vsEsLdWxm/Zt3z98hXh63ZfRpRGBwFpef8X68jrQwWAnUDgK40MRLw+9ljU47AEkmFNTuyKxr1WLDIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 541731595;
	Fri,  9 May 2025 03:55:42 -0700 (PDT)
Received: from [10.57.47.109] (unknown [10.57.47.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981E43F58B;
	Fri,  9 May 2025 03:55:51 -0700 (PDT)
Message-ID: <a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com>
Date: Fri, 9 May 2025 11:55:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, rafael@kernel.org,
 pavel@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, len.brown@intel.com
References: <20250507014728.6094-1-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250507014728.6094-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Changwoo,

On 5/7/25 02:47, Changwoo Min wrote:
> The sched_ext schedulers [1] currently access the energy model through the
> debugfs to make energy-aware scheduling decisions [2]. The userspace part
> of a sched_ext scheduler feeds the necessary (post-processed) energy-model
> information to the BPF part of the scheduler.
> 
> However, there is a limitation in the current debugfs support of the energy
> model. When the energy model is updated (em_dev_update_perf_domain), there
> is no way for the userspace part to know such changes (besides polling the
> debugfs files).
> 
> Therefore, add inotify support (IN_MODIFY) when the energy model is updated.
> With this inotify support, the directory of an updated performance domain
> (e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory (e.g.,
> /sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
> scheduler (or any userspace application) monitors the energy model change
> in userspace using the regular inotify interface.
> 
> Note that accessing the energy model information from userspace has many
> advantages over other alternatives, especially adding new BPF kfuncs. The
> userspace has much more freedom than the BPF code (e.g., using external
> libraries and floating point arithmetics), which may be infeasible (if not
> impossible) in the BPF/kernel code.
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://github.com/sched-ext/scx/pull/1624
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
> 
> ChangeLog v1 -> v2:
>    - Change em_debug_update() to only inotify the directory of an updated
>      performance domain (and its parent directory).
>    - Move the em_debug_update() call outside of the mutex lock.
>    - Update the commit message to clarify its motivation and what will be
>      inotified when updated.
> 
>   kernel/power/energy_model.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

I have discussed that with Rafael and we have similar view.
The EM debugfs is not the right interface for this purpose.

A better design and mechanism for your purpose would be the netlink
notification. It is present in the kernel in thermal framework
and e.g. is used by Intel HFI
- drivers/thermal/intel/intel_hfi.c
- drivers/thermal/thermal_netlink.c
It's able to send to the user space the information from FW about
the CPUs' efficiency changes, which is similar to this EM modification.

Would you be interested in writing similar mechanism in the EM fwk?

Regards,
Lukasz


