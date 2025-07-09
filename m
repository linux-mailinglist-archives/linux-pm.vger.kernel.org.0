Return-Path: <linux-pm+bounces-30448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00AAFE62A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132807BB470
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEE2980B9;
	Wed,  9 Jul 2025 10:42:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAF28DF23;
	Wed,  9 Jul 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057723; cv=none; b=knRVq7xH5MI6iXApfErWN836NxuUePqTF+aNRzAIziujztZxUXoWA0HlgYUrLwgEOjKkldILrPNED7GrWLhu5IQRyTp39D71NCHzKR9gTqVtcjX+hh9Zmdl3AfTO2pQ5T/oN5jZbXLzjH5w0sDULWwJ+zMpbQNP4uHBADkp6Qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057723; c=relaxed/simple;
	bh=wN9wjk0Pdo/dhut5zvBXxW2nGB/Hp2vsGhoBr49ktIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Idn/sqhkzwVR3AdO5AWcHwf2rDJwPzYhWn4fAiJUzSoTSAIay56y7P4stiGORXxpVCk7AfNiSdIA6QgyUqfqdZ2G/yy79dDT12JT139t6+0hi+ZGDKUXsOaIJSjyyYgDKAgDgpzpkB7oLHOCaTGDcAwz8DkiRX3fVufXNLZ07bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bcZLl08XPz16THx;
	Wed,  9 Jul 2025 18:42:55 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4835D1A0188;
	Wed,  9 Jul 2025 18:41:57 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 18:41:56 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH v2 0/4] cpufreq: Some optimizations for cpufreq.c
Date: Wed, 9 Jul 2025 18:41:41 +0800
Message-ID: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100008.china.huawei.com (7.202.181.93)

This patch series makes some minor optimizations for cpufreq.c to make
codes cleaner.

Changelog:

v2:

 - drop patch 3 and 4 as they have been applied
 - drop patch 6
 - move invariance initialization instead of add a
   static_branch_disable_cpuslocked() in error path
 - add a Fixes tag in patch 2

---
Discussions of previous versions:
v1: https://lore.kernel.org/all/20250623133402.3120230-1-zhenglifeng1@huawei.com/

Lifeng Zheng (4):
  cpufreq: Move cpufreq-based invariance initialization to where all
    other initializations have been successfully done in
    cpufreq_register_driver()
  cpufreq: Init policy->rwsem before it may be possibly used
  cpufreq: Move the check of cpufreq_driver->get into
    cpufreq_verify_current_freq()
  cpufreq: Exit governor when failed to start old governor

 drivers/cpufreq/cpufreq.c | 40 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

-- 
2.33.0


