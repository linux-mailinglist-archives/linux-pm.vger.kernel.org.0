Return-Path: <linux-pm+bounces-32371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E8B25D76
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA03516AAB2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A47F26E142;
	Thu, 14 Aug 2025 07:29:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7A26E143;
	Thu, 14 Aug 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156572; cv=none; b=MyMQ78BjqS83B0u3svBYTfaLja3XC/LozU1GP9vGz1VN4AAFLvwocO4FToGQo9OC/mg1jksltqkOwNFj0Tj/BPQsfWd62gMEYwEmwRXLhOWu2DDEVcWObJ3duY0pTlSQ9QWigok+xjCZ35MfZmNmV8q1oKzpvdjIJNF1gcAf9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156572; c=relaxed/simple;
	bh=cDJpHfbHbSQ2Jdhwk27mPhCNYqfrAZiBK+diOGcMZmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETQdbIVAQfnj8w+BOrGTV1+bwQZ8r5pP+UmbKflcEF0yXTqww8CZesEe55T3mlE4939ezAMLGezXPTo1twpl7OYR7X8Xnjf5FZrGCU33fb0jGuqBaJFmfk4uXMeC3Z530dJ8R+1vUdUfB83PiCQRE7tt6H1E3v80LR51xhOfPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c2cHh0HhJz2TT6m;
	Thu, 14 Aug 2025 15:26:40 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AEA81A016C;
	Thu, 14 Aug 2025 15:29:21 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 15:29:20 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 0/3] arm64: topology: Setup AMU FIE for online CPUs only
Date: Thu, 14 Aug 2025 15:28:50 +0800
Message-ID: <20250814072853.3426386-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
even though they're eligible.

Changelog:

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

Lifeng Zheng (3):
  arm64: topology: Set scale freq source only for the CPUs that have not
    been set before
  cpufreq: Add a new function to get cpufreq policy without checking if
    the CPU is online
  arm64: topology: Setup AMU FIE for online CPUs only

 arch/arm64/kernel/topology.c | 56 ++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c    | 10 +++++--
 include/linux/cpufreq.h      |  1 +
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.33.0


