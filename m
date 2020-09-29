Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2746727BF5A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgI2I1n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 04:27:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbgI2I1n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 04:27:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6773D63A7B6C47B20E41;
        Tue, 29 Sep 2020 16:27:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 16:27:05 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] thermal: core: add the misse nlmsg_free() for thermal_genl_sampling_temp()
Date:   Tue, 29 Sep 2020 16:26:52 +0800
Message-ID: <20200929082652.59876-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

thermal_genl_sampling_temp() misses to call nlmsg_free() in an error path.
Jump to out_free to fix it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/thermal/thermal_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index af7b2383e8f6..019f4812def6 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -78,7 +78,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0,
 			  THERMAL_GENL_SAMPLING_TEMP);
 	if (!hdr)
-		return -EMSGSIZE;
+		goto out_free;
 
 	if (nla_put_u32(skb, THERMAL_GENL_ATTR_TZ_ID, id))
 		goto out_cancel;
@@ -93,6 +93,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 	return 0;
 out_cancel:
 	genlmsg_cancel(skb, hdr);
+out_free:
 	nlmsg_free(skb);
 
 	return -EMSGSIZE;
-- 
2.26.0.106.g9fadedd

