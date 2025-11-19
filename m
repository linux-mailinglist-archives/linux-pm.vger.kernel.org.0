Return-Path: <linux-pm+bounces-38207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72BC6D580
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 09:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1E8CF2D4AA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016DA31ED89;
	Wed, 19 Nov 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gPU3nY6H"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6931A810
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540056; cv=none; b=nKRsb+EVwDSe7kD7HPcKj7jOPhLRewwyfExqjgjW/nLziZnEpXj3XwIC6Nq4ixwRYCu9HqjpWlaPSQb6HFF+27zJLYwBcSq2Y5FMtD+KS7OCsgX7wB1aH9UUxrFWQE4bkUN+VQFsAMMB/eOnN6ISz6SZZcdlT4JTE8AewWFlMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540056; c=relaxed/simple;
	bh=Ujb3MHebReL3gtwH6jEGrS6wHFdMn5IhVx0IPYF6N+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spT2l78miqYEwG4aMHjGfu4F/3WhuLmH8MEl2lzpdu271LCgauowT0jc/SG05pArsVHgku/lp2I98EYyv2ijhQS2SbTVBR5nq0l6Na/wfBBUcU6Q+C3/4bU3Xj9rAkWR8KoLVkhJr4PWtNgUhnXr9bTsspLLXuFjnI+uzyCuG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gPU3nY6H; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gFRntSnV/K0Zf4DIc0jm2RPgoY38SvcsIuMyab0Umgk=;
	b=gPU3nY6H56tggE13zBgfpTPTYO32TCgVYNyBFWuEfbYiJ9QUdXSmBjm756cf/7/2ozA15y/iG
	4UkF5r+Cbd1l0/c3JSMpOIHS/AKsZviskAomNCiX++Kd/bjJ+wiztevYkksRXm6bn5gnzOcl+3t
	hrakd2EVMtWB4Nyk+0lWSc8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dBDjz3sPmz12LcJ;
	Wed, 19 Nov 2025 16:12:39 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E0B8180B56;
	Wed, 19 Nov 2025 16:14:07 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 16:14:06 +0800
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
Subject: [PATCH v6 1/3] arm64: topology: Skip already covered CPUs when setting freq source
Date: Wed, 19 Nov 2025 16:13:54 +0800
Message-ID: <20251119081356.2495290-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)

The scale freq source of the CPUs in 'amu_fie_cpus' mask are already set to
AMU tick before, so in amu_fie_setup(), only the CPUs in the 'cpus' mask
should be set.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 arch/arm64/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae..9317a618bb87 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -373,7 +373,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
 
-	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
+	topology_set_scale_freq_source(&amu_sfd, cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
-- 
2.33.0


