Return-Path: <linux-pm+bounces-12596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC2959376
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC8AB22715
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25C1586E7;
	Wed, 21 Aug 2024 03:53:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F4158522
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212413; cv=none; b=DfQoAKAOJJ9FoxhBDRmX5NKK6PQNwtpmCXNJ94dl5mefDYEGl4pM5dluj2NiUiZfffie0CCtlT2QjoarFRxZTIKJ1CsyxqilLvx2Dx2V5E6vH28xArxtOT0Al5KOtd2IVHK42Nw6MAuHVAQLuWJnqyzF2prCf8/CtTNjy2lfS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212413; c=relaxed/simple;
	bh=B2Hbx5lEsn00CiZ8+aUNv54Gaq65rX+rJz3MHLaA53o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPMraKmMbXfZxQNp+qM/kMNg+yG6YC9Ish5nHJjgKxzMd3KliZuDbl2gvlOiSdEvJcM0rUbWQKlOp3eNyXRo5mMHl9lqgj6den8PFCjlT01TcVJTz/L31jzmixElrTxzl8avUttv2FM9NZufk4fSowfdhL5TSPURKfGjyrGniOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpXSj5tW2z1xtxw;
	Wed, 21 Aug 2024 11:51:33 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 38A041A016C;
	Wed, 21 Aug 2024 11:53:28 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 11:53:27 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 2/2] pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.
Date: Wed, 21 Aug 2024 11:40:22 +0800
Message-ID: <20240821034022.27394-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240821034022.27394-1-zhangzekun11@huawei.com>
References: <20240821034022.27394-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use scope based of_node_put() to simplify the code logic, and we don't
need to call of_node_put(). This will simplify the code a lot.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pmdomain/qcom/cpr.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index 1834b3861232..37b318bf505a 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1040,36 +1040,30 @@ static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 					    struct device *cpu_dev)
 {
-	u64 rate = 0;
-	struct device_node *ref_np;
-	struct device_node *desc_np;
-	struct device_node *child_np = NULL;
-	struct device_node *child_req_np = NULL;
+	struct device_node *ref_np __free(device_node) = NULL;
+	struct device_node *desc_np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 
-	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!desc_np)
 		return 0;
 
 	ref_np = dev_pm_opp_get_of_node(ref);
 	if (!ref_np)
-		goto out_ref;
+		return 0;
+
+	for_each_available_child_of_node_scoped(desc_np, child_np) {
+		struct device_node *child_req_np __free(device_node) =
+			of_parse_phandle(child_np, "required-opps", 0);
 
-	for_each_available_child_of_node(desc_np, child_np) {
-		of_node_put(child_req_np);
-		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
 		if (child_req_np == ref_np) {
+			u64 rate;
+
 			of_property_read_u64(child_np, "opp-hz", &rate);
-			break;
+			return (unsigned long) rate;
 		}
 	}
 
-	of_node_put(child_req_np);
-	of_node_put(child_np);
-	of_node_put(ref_np);
-out_ref:
-	of_node_put(desc_np);
-
-	return (unsigned long) rate;
+	return 0;
 }
 
 static int cpr_corner_init(struct cpr_drv *drv)
-- 
2.17.1


