Return-Path: <linux-pm+bounces-40027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99FACE8F5A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47CB030115F1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29F3009F6;
	Tue, 30 Dec 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="korD3yhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527362D978B
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081709; cv=none; b=ln9RVuUig9LbMxl3t+ENazymHhhilU5sVvxJ0XnBbZJl1rnjNredLdRWqMs/hmHNzYhoplZgJkhZ3+EYhwuz7DD1k+ofW95971zKmpNSgpGv7u4saEd1Rhb6ERMvTt6GGGnlXkxi2t5lvaSRCQ2OLDqXdVF8ijCAxXJArVyex+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081709; c=relaxed/simple;
	bh=ErV7G2j0q9I5F6FE7Goq7jF87LsuizPameGQ/8LAwhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af4ltYawJqN3f7SFgBR+A95bsPafWqxeCjjtsBcjbY0Ar5c1Q53MuTwyjqnXG2QKJKsCkU32vaLgeWNBLaGoQYxnp+xgKET1qenAKH5eA57R24oiW8viiXqWUxWK5d+lBU0jOvorE0vHEemJdtat9sNgePYuwF5bn5LVhJvYV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=korD3yhM; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sqyt8bf9Ew92JWDnF3KjYgpd3c/yQp3pSxZmYV/7WXk=;
	b=korD3yhMC4Ih4Uu2zukKgHfhtOXoUar2/BPA5C6981yz7AbdKGTG117nWBgYuypr1Ddc2Y6PI
	A/h2qzmLHaDanwuoCfA4EkJ10uN9A/ReieR5ZyzIq2KK9MYlnCL2ixfqcKt8C8e4LdvXJTkLuwc
	wGNZigBN41QXvJVtHDevUxU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dgQSh1kSSz1prKv;
	Tue, 30 Dec 2025 15:58:28 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BFD5F2016A;
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
Subject: [REPOST PATCH v6 1/3] arm64: topology: Skip already covered CPUs when setting freq source
Date: Tue, 30 Dec 2025 16:01:13 +0800
Message-ID: <20251230080115.2120612-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
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
index 5d24dc53799b..cf9bb761af3a 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -272,7 +272,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
 
-	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
+	topology_set_scale_freq_source(&amu_sfd, cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
-- 
2.33.0


