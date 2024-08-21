Return-Path: <linux-pm+bounces-12595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF4959375
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5885B226FC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB2132139;
	Wed, 21 Aug 2024 03:53:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041C158203
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212413; cv=none; b=St5TrcK2SAfBMJ5OMr97LUasmOBfw5VtQfScJ8vkVn8ggLI6iIKTMLU/ORMq6cyIhaBmZfn0DI5c3Ai9xRgWURL9FYupunyi1Uvf5xYpRoHz9d18wswDDM1d9dei8f2FHRn4Qu2HT7ULPmQUg7tm25CXfNWRH9hXJPYggEnzx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212413; c=relaxed/simple;
	bh=ZZ1EsSyYhgnLcTr/scEzAK0VMxp+M5HAdXbWqAdHTbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeXgeX8ecfV3k8JdEjIKQKfYkzOjBsmvNPmTKWX9duxM2Wj8F0DIQRAyYnBMRvsznReD8AzLnHCtX6qTCISGZCPPuQFqGSS40YDFGyv3ZA5y4VIfNcGD0zmTK4GFm2aVuKeXV2Lgnwq4L4TfmCjpDRNLRioDlItSV3stkBBoxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WpXV90dZvz13c39;
	Wed, 21 Aug 2024 11:52:49 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id A4C4B180101;
	Wed, 21 Aug 2024 11:53:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 11:53:26 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 1/2] pmdomain: qcom-cpr: Use helper function for_each_available_child_of_node()
Date: Wed, 21 Aug 2024 11:40:21 +0800
Message-ID: <20240821034022.27394-2-zhangzekun11@huawei.com>
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

for_each_available_child_of_node() can help to iterate through the
device_node, and we don't need to use while loop. Besides, the purpose
of the while loop is to find a device_node which fits the condition
"child_req_np == ref_np", we can just read the property of "child_np"
directly in for_each_available_child_of_node(). No functional change
with such conversion.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pmdomain/qcom/cpr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index c64e84a27cc7..1834b3861232 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1054,14 +1054,14 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	if (!ref_np)
 		goto out_ref;
 
-	do {
+	for_each_available_child_of_node(desc_np, child_np) {
 		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
 		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
-
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
+		if (child_req_np == ref_np) {
+			of_property_read_u64(child_np, "opp-hz", &rate);
+			break;
+		}
+	}
 
 	of_node_put(child_req_np);
 	of_node_put(child_np);
-- 
2.17.1


