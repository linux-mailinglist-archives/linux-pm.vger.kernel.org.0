Return-Path: <linux-pm+bounces-31956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CAB1B13E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F77188EBCF
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F682277030;
	Tue,  5 Aug 2025 09:34:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9527586B;
	Tue,  5 Aug 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386441; cv=none; b=taWSD1CiOxQoWUXV5EoYaOY1pFUG+qW2BxnE2t1QOKfZ9wEko0bEPg2LCLIiFQ0+IHrenLO7hXmP+8AkWaKvqrwpLYzC2UION4C8dfuucniNB2UzZfDP3G2zeiK6zEUf+8IKPxJEDucWXOkfqzCZ27LWiA4aDf49T8xTjSoIux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386441; c=relaxed/simple;
	bh=dhX2I5xzRH8UbYiE7+kw8t+gSVpZuL+k7UvqVfKeXGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qAmnV3P7kG8S9CFITJ1g4bm4cpwYPPkNSipAHuSCeQltZ2I2MHzil4oP61k/THxpEUakxjt6EYySiApn3tpggLS0C1NSHoLCHDU5U4uQI1WwuhpWP5+CtEFu3LhxOcyO9vbOcD+h2JxCdE5ZLxpHmMc3eynBdbjxV6zBzwO5bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bx7Qy3Vm8z14M9N;
	Tue,  5 Aug 2025 17:28:58 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 452E4140155;
	Tue,  5 Aug 2025 17:33:54 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 17:33:53 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 0/3] arm64: topology: Setup AMU FIE for online CPUs only
Date: Tue, 5 Aug 2025 17:33:27 +0800
Message-ID: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
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

Lifeng Zheng (3):
  arm64: topology: Set scale freq source only for the CPUs that have not
    been set before
  cpufreq: Add a new function to get cpufreq policy without checking if
    the CPU is online
  arm64: topology: Setup AMU FIE for online CPUs only

 arch/arm64/kernel/topology.c | 56 ++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c    | 11 +++++++
 include/linux/cpufreq.h      |  1 +
 3 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.33.0


