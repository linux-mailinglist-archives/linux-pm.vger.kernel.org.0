Return-Path: <linux-pm+bounces-38868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4EC9160C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6C4E1726
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FD3002B0;
	Fri, 28 Nov 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lDPpvwcg"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAB2FBE13;
	Fri, 28 Nov 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321250; cv=none; b=oAoEkuw6Sx8pXPzgzWTg6OjJMXargbPVILciskqFhyBzc/0BSYhULehxEyc3It5TSV4EOyK6UsLDynn9jS4Rp+IpZLwEozUtsi+x0/E1t+/Z3ZKIPweX6MSDShFGClskpfXCTt8B9doLid4UfqJgcj22srMheEML7t3FFOmEToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321250; c=relaxed/simple;
	bh=7GuXicHoxsxW3VAQDZpurSlJBI5/TCJsjXPF5e/M9do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/w90IG5XPBv63Hv83EnKQSgn3QN0d6XYv0aUVzF5MLhy4x32C/jebtlcnuSS0fu+qwDEATNmAhsp9pAekouqJj9fHGmVRZp3tkKwB8Urlaquhlo+KSe0l03t4+076Us0YR/zFLdSbQJNYTkGQSyARS2hORABSJZCPer7CR9nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lDPpvwcg; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DCrT5CqgpxdU83vj3Pfcc21G2fpDOWSmPS/kVvC3t9Q=;
	b=lDPpvwcgi5RhN6ChN/28WuVuRhF/xp8hBfM9jc1MPPf5cYAldPkREmFdOwi3g7tGoV3u+iQLi
	DY5rvB5TUAoCmBg1DH5bptNf4PdUmW1LnRBn5GGfqz9Wm+2q257thGO/QG7t9Ni2yqL1xWhllrq
	V5++YgIufEIAeNqY9PPd68w=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dHncb3Hy8zmV6h;
	Fri, 28 Nov 2025 17:12:15 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BA488140279;
	Fri, 28 Nov 2025 17:14:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 17:14:04 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 2/2] cpufreq: cpufreq_boost_trigger_state() optimization
Date: Fri, 28 Nov 2025 17:13:52 +0800
Message-ID: <20251128091352.1969333-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
References: <20251128091352.1969333-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Simplify the error handling branch code in cpufreq_boost_trigger_state().

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a4399e5490da..a725747572c9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2824,18 +2824,13 @@ static int cpufreq_boost_trigger_state(int state)
 
 		ret = policy_set_boost(policy, state);
 		if (ret)
-			goto err_reset_state;
+			break;
 	}
 
-	if (ret)
-		goto err_reset_state;
-
 	cpus_read_unlock();
 
-	return 0;
-
-err_reset_state:
-	cpus_read_unlock();
+	if (!ret)
+		return 0;
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = !state;
-- 
2.33.0


