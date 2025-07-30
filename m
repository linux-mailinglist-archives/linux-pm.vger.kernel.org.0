Return-Path: <linux-pm+bounces-31568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E364B157C8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E902118A512A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFE16DEB1;
	Wed, 30 Jul 2025 03:23:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0674645;
	Wed, 30 Jul 2025 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753845799; cv=none; b=b9U3qDNLHzeszPk9PTZK3bWPd+INEulx9/niUApsgBcHRwWx7nQJRYSVEFOlOf2vzl5p5vEno9fSbHbCTCOylAQOh8BoU2h9R39T6+FtqjwH831hy+bkF0winmc1/2zqIqsLwGanVMv3oNRJLLvuBbrRFmQNje1DKDDw2LJ8xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753845799; c=relaxed/simple;
	bh=wB5KpBFdHV/Ud7wxhEufI6lp1TbN5x3s9uFhSwiTCZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urK49bg70/Dj+BFsgwwjSkARfo+QviE6N5XCchH3bWyBuEe0m6FLpBHLifx8w/fWOekltwDZHpjDjoR2eCKLXE2xCf+KW+jl695i7sNXOqtoOGkLRhJzeQh480ACvR+yYiKSiRO1CAcc/LqyTemzyIyKQB6CcDm1EEpc8yQ/awA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bsHcv1fmcz27jBC;
	Wed, 30 Jul 2025 11:24:15 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id B99B9140123;
	Wed, 30 Jul 2025 11:23:13 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 11:23:13 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>
Subject: [PATCH 0/2] cpufreq: CPPC: Changing error message in CPPC FIE
Date: Wed, 30 Jul 2025 11:23:10 +0800
Message-ID: <20250730032312.167062-1-yubowen8@huawei.com>
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
 kwepemk500012.china.huawei.com (7.202.194.97)

Currently, when booting a subset of cpus in policy->related_cpus, and
entering the CPPC FIE initialization process during CPU initialization,
there are repeated warnings: "read perf counters failed".

This occurs because reading performance feedback counters from offline
or low-power idle CPUs may return 0, which is interpreted as an error
and results in returning -EFAULT each time this happens.

Remove warning when reading from offline cpus, and changes the print
level to debug in case the cpu is in low-power idle state.


Jie Zhan (2):
  cpufreq: CPPC: Don't warn on failing to read perf counters on offline
    cpus
  cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()

 drivers/cpufreq/cppc_cpufreq.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.33.0


