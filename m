Return-Path: <linux-pm+bounces-40029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 515AFCE8F60
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EF8301F26F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C563724169D;
	Tue, 30 Dec 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CrIFgpa+"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28281BF33
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081714; cv=none; b=Y6zxBcCe6+vdlDQTSKX9sfOGmbSgIcrIzQ9Rjc2WNusFfXfADT7aBgI4VqwY3TXBP7eNbIqBLF6wpU6SuQWQqLenpuMOGEl61CFpk79lKEWKxiDTjhDTihUOKoyWTB0B03Bzfh3adi013MxTNol2fpHgc2iDIZiOLnZiGQiTq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081714; c=relaxed/simple;
	bh=MHySaoGg7g32JMvEluFm8zPCg+697Vd8/K27ZZpEXp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CiICtzFQg59euBnOpF4pquDpslgBU3Jtjohq6DMM/Qi+JEadczWiuMbaYV6O85SnWf5J/tBhHjaP0TAoV+j4GgF9zH5jjmpW/Lv3973URAyRx9HJcIGvZ7IasVk7wW1CSK85mVNL26ZoyR5c+Q6qNgdrPynUzE3UV+YeKbgsbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CrIFgpa+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l8AOMXLBKTR+COJZGGsbi068vIs7ru6iSzu/sWMLBAM=;
	b=CrIFgpa+jZ0jIeP69CPkifAfsmzI+9wp6Jki8ODy827ojLDvhnC82FmYGkLydb2oM6Oumhx94
	jQflhr/gAWUPgL5arVy+I0F4xp41jlM+OuxKFdCcLGuyHND1L0tpr00uDY7P8TIHZpcUs3yagD9
	GeTjOPsOKq3EBxq2bNGQYkc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dgQTT5rbjz1T4FZ;
	Tue, 30 Dec 2025 15:59:09 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 267F040363;
	Tue, 30 Dec 2025 16:01:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 16:01:39 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <beata.michalska@arm.com>,
	<ionela.voinescu@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [REPOST PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
Date: Tue, 30 Dec 2025 16:01:12 +0800
Message-ID: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
even though they're eligible.

Changelog:

v6:

 - discard the modifications in cpufreq.c, and instead, make
   supports_scale_freq_counters() checks that at least one CPU in the
   policy supports AMU FIE, instead of all
 - based on Beata's feedback, optimize cpuhp_topology_online() to make it
   more readable
 - use pr_warn instead of WARN_ON to show warning message when the
   freq_counters_valid() check fails in cpuhp_topology_online()
 - modify commit message as Beata and Rafael suggested

v5:

 - add a default implementation for cpufreq_cpu_policy() when
   CONFIG_CPU_FREQ is not defined

v4:

 - change the function's name in patch 2 from
   'cpufreq_cpu_get_raw_no_check' to 'cpufreq_cpu_policy'
 - use only one line in the function body of cpufreq_cpu_policy()
 - use cpus mask instead of related_cpus when calling arch_set_freq_scale()
   in cpufreq.c
 - add a warning when the freq_counters_valid() check fails in
   cpuhp_topology_online()

v3:

 - add a patch to optimize amu_fie_setup()
 - add a patch to add a function to get cpufreq policy without checking if
   the CPU is online
 - discard the reuse of amu_fie_setup() in cpuhp_topology_online() and keep
   all the new logic in cpuhp_topology_online()
 - test only the CPU which is going online in cpuhp_topology_online()
 - when the freq_counters_valid() check fails, not only clear the scale
   freq source but also clear all the related CPUs from amu_fie_cpus mask
 - add some comments

v2:

 - keep init_amu_fie_notifier for setting up AMU FIE when the cpufreq
   policy is being created
 - set up AMU FIE only for online CPUs instead of related_cpus in
   init_amu_fie_callback()
 - check and set all the online CPUs in the same policy when hotplug one
 - clear scale freq source for all the online CPUs in the same policy to
   avoid using different source of the freq scale

---
Discussions of previous version:
v1: https://lore.kernel.org/all/20250607094533.416368-1-zhenglifeng1@huawei.com/
v2: https://lore.kernel.org/all/20250725102813.1404322-1-zhenglifeng1@huawei.com/
v3: https://lore.kernel.org/all/20250805093330.3715444-1-zhenglifeng1@huawei.com/
v4: https://lore.kernel.org/all/20250814072853.3426386-1-zhenglifeng1@huawei.com/
v5: https://lore.kernel.org/all/20250819072931.1647431-1-zhenglifeng1@huawei.com/

Lifeng Zheng (3):
  arm64: topology: Skip already covered CPUs when setting freq source
  cpufreq: Add new helper function returning cpufreq policy
  arm64: topology: Handle AMU FIE setup on CPU hotplug

 arch/arm64/kernel/topology.c | 67 ++++++++++++++++++++++++++++++++++--
 drivers/base/arch_topology.c |  9 ++++-
 drivers/cpufreq/cpufreq.c    |  6 ++++
 include/linux/cpufreq.h      |  5 +++
 4 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.33.0


