Return-Path: <linux-pm+bounces-32603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F9CB2BACD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AA51BA3270
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091A30F814;
	Tue, 19 Aug 2025 07:30:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F466254AEB;
	Tue, 19 Aug 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588611; cv=none; b=aIfmDNVaC2aVLm1r52/likAMNwYkzq3PMUtI5bhb77QRdWlGWuuvbDWVQZspO1BhGrgKRToAXyzbAckT3gSd/MAq+2hzrL2sRAwuOHzhMt5Oq9lZEGrM+C+/2vLge6B0pxHdjsnJcbmu7Z7oN2DBsVDCcP5Fww13i7EV1llwYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588611; c=relaxed/simple;
	bh=HTb73vp+W4b4DaRPuSsYKm2LCbmToo9jG749eszIuzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5BkKkT2jmEPSTIIYxJVp/BRZLDynRtUTBSUbuMZ26pWkvLYmaNiXC1LB4sTs6hBU4NB7aDper/CVs5r6G+kom5nFuxEvSpqZhppbZcCwfm5hVKPWF80Q8Q+sorw43A8MGozgvI/taAUOf1BUQR4lKlLu7QAomT3eVOlgQjaZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c5h403KFbz2Dc35;
	Tue, 19 Aug 2025 15:27:12 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id AFD1C180042;
	Tue, 19 Aug 2025 15:29:59 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 15:29:58 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v5 0/3] arm64: topology: Setup AMU FIE for online CPUs only
Date: Tue, 19 Aug 2025 15:29:28 +0800
Message-ID: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
even though they're eligible.

Changelog:

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

Lifeng Zheng (3):
  arm64: topology: Set scale freq source only for the CPUs that have not
    been set before
  cpufreq: Add a new function to get cpufreq policy without checking if
    the CPU is online
  arm64: topology: Setup AMU FIE for online CPUs only

 arch/arm64/kernel/topology.c | 56 ++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c    | 10 +++++--
 include/linux/cpufreq.h      |  5 ++++
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.33.0


