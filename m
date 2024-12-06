Return-Path: <linux-pm+bounces-18696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBB9E6FA9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9122228503C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3D207DFB;
	Fri,  6 Dec 2024 13:56:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7D8207DF8;
	Fri,  6 Dec 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493395; cv=none; b=sXUNj2Ip281bNjGV/VNbyZnnYVf5MiV/qD6QChN0ILukssEpAItwMnp95xhDt31mLtU/k4q4+9LQGVbxMxC80PmfFVLIn38nP2pMzuz4tZaZh2YA3sR+UQRyTTQ+3HHg1dIWjkfDGDMdJqZfD+FUv+icwNYhNQQhsiBZUCXPLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493395; c=relaxed/simple;
	bh=bKU/vQCebGDq0D/DCCPWxrVzDVQg49dbgATsgAGCB+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WjAwSPhS63pWVyi2uRP3ux+MkZBBfucv5UF/RC87LtsnhOJyKAG+IfzLudk3iLKP9XwB2isB1v1saybxKcZKdui6PZDC7TuaGZIl+jI9mCMeZ7vMCUw//pzXc4ZlwLxXOyOdyWDtejEAW5cH7HoAYHLYCE7RB4p+hq0ZSe7cRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F9CFEC;
	Fri,  6 Dec 2024 05:56:59 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2469B3F71E;
	Fri,  6 Dec 2024 05:56:28 -0800 (PST)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com,
	zhanjie9@hisilicon.com,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Phil Auld <pauld@redhat.com>,
	x86@kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v8 0/4] Add support for AArch64 AMUv1-based average freq
Date: Fri,  6 Dec 2024 13:55:56 +0000
Message-Id: <20241206135600.4083965-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds support for obtaining an average CPU frequency based on
a hardware provided feedback. The average frequency is being exposed via
dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
The architecture specific bits are being provided for AArch64, caching on
existing implementation for FIE and AMUv1 support: the frequency scale
factor, updated on each sched tick, serving as a base for retrieving
the frequency for a given CPU, representing an average frequency
reported between the ticks.

The changes have been rather lightly (due to some limitations) tested on
an FVP model.

Note that [PATCH 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
can be merged independently.
Additionally, this series depends on [6]

Relevant discussions:
[1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
[2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
[3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
[4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c
[5] https://lore.kernel.org/all/20240603081331.3829278-1-beata.michalska@arm.com/
[6] https://lore.kernel.org/all/20240827154818.1195849-1-ionela.voinescu@arm.com/

v8:
- Drop introducing new function and reuse arch_freq_get_on_cpu, guarding its use
  in scaling_cur_freq sysfs handler with dedicated config for x86

v7:
- Dropping 'arch_topology: init capacity_freq_ref to 0' patch from the series
  as this one has been sent separately as an independent change
  [https://lore.kernel.org/all/20240827154818.1195849-1-ionela.voinescu@arm.com/]
- Including in the series change that introduces new sysfs entry [PATCH 1/4]
- Consequently modifying previously arch_freq_get_on_cpu to match reqs for new
  sysfs attribute
- Dropping an idea of considering a CPU that has been idle for a while as a
  valid source of information for obtaining an AMU-counter based frequency
- Some minor cosmetic changes

v6:
 - delay allocating cpumask for AMU FIE support instead of invalidating the mask
   upon failure to register cpufreq policy notifications
 - drop the change to cpufreq core (for cpuinfo_cur_freq) as this one will be
   sent as a separate change

v5:
 - Fix invalid access to cpumask
 - Reworked finding reference cpu when getting the freq

v4:
- dropping seqcount
- fixing identifying active cpu within given policy
- skipping full dynticks cpus when retrieving the freq
- bringing back plugging in arch_freq_get_on_cpu into cpuinfo_cur_freq

v3:
- dropping changes to cpufreq_verify_current_freq
- pulling in changes from Ionela initializing capacity_freq_ref to 0
  (thanks for that!)  and applying suggestions made by her during last review:
	- switching to arch_scale_freq_capacity and arch_scale_freq_ref when
	  reversing freq scale factor computation
	- swapping shift with multiplication
- adding time limit for considering last scale update as valid
- updating frequency scale factor upon entering idle

v2:
- Splitting the patches
- Adding comment for full dyntick mode
- Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
  with potential freq changes

CC: Jonathan Corbet <corbet@lwn.net>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Phil Auld <pauld@redhat.com>
CC: x86@kernel.org
CC: linux-doc@vger.kernel.org

Beata Michalska (4):
  cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry
  arm64: amu: Delay allocating cpumask for AMU FIE support
  arm64: Provide an AMU-based version of arch_freq_get_on_cpu
  arm64: Update AMU-based freq scale factor on entering idle

 Documentation/admin-guide/pm/cpufreq.rst |  16 ++-
 arch/arm64/kernel/topology.c             | 144 +++++++++++++++++++----
 arch/x86/kernel/cpu/aperfmperf.c         |   2 +-
 arch/x86/kernel/cpu/proc.c               |   7 +-
 drivers/cpufreq/Kconfig.x86              |  12 ++
 drivers/cpufreq/cpufreq.c                |  36 +++++-
 include/linux/cpufreq.h                  |   2 +-
 7 files changed, 188 insertions(+), 31 deletions(-)

-- 
2.25.1


