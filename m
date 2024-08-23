Return-Path: <linux-pm+bounces-12791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED195C641
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB841F25FE2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FA13B2A8;
	Fri, 23 Aug 2024 07:08:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99513AA27;
	Fri, 23 Aug 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396904; cv=none; b=Bwwf3ueqNDBE4oqawAWl0/BWtwaQd0M/nQ2YTTJda0A0xi6HZcKD21dORel38KuNev8F3d5/isTxx0BUrqM1HZpFasUhdzR41FKZAisboQA2GF4o6l5EOEE+kuHm0mydfAgAG/coT/yw4Hs00P+Q0NvvTPxMSAgExX5avw6Wack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396904; c=relaxed/simple;
	bh=S1pkoqACmb92FIjEhnT7vdarH8chgfpWPt0IadZnPMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUPeUBfsNqvZp14NwqRAn7htRePAkdDzKU2yl8nIDiazo/qMAcvSGRxmi3gWM4haDJDenvroFCIlyaSDbomWpW4DF4QdBJZ/BUttAh0DOyFIgfmtgGn4DiBW8gpmQFa8aCL+1Qj3l4Y3puP5mCcL5ILFHsj4IBZJ2Xy3V+VTKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wqrkk4ZrRz1j71H;
	Fri, 23 Aug 2024 15:08:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 240741402C7;
	Fri, 23 Aug 2024 15:08:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 15:08:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] thermal/of: Fix duplicate of_node_put()
Date: Fri, 23 Aug 2024 15:15:55 +0800
Message-ID: <20240823071555.3331632-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

In for_each_child_of_node(), if continue, of_node_put(prev) will be
called by __of_get_next_child(), so remove the duplicate
of_node_put(child).

Fixes: 0f0a1b4ba3e4 ("thermal/of: Use the .should_bind() thermal zone callback")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/thermal/thermal_of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index dc43f50db890..85e7e3c43c7e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -319,10 +319,8 @@ static bool thermal_of_should_bind(struct thermal_zone_device *tz,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv) {
-			of_node_put(child);
+		if (tr_np != trip->priv)
 			continue;
-		}
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device", "#cooling-cells");
-- 
2.34.1


