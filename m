Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0457A301472
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 11:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbhAWKGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 05:06:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAWKGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 05:06:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DNBYy4XgczMNbZ;
        Sat, 23 Jan 2021 18:04:38 +0800 (CST)
Received: from huawei.com (10.175.127.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 18:05:58 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>,
        <caihongda@huawei.com>, <yeyunfeng@huawei.com>
Subject: [PATCH 2/2] powercap/intel_rapl: Use topology interface in rapl_init_domains()
Date:   Sat, 23 Jan 2021 05:06:08 -0500
Message-ID: <20210123100608.2349629-2-yeyunfeng@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210123100608.2349629-1-yeyunfeng@huawei.com>
References: <20210123100608.2349629-1-yeyunfeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.234]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not a good way to access the phys_proc_id of cpuinfo directly.
So using topology_physical_package_id(cpu) instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5f3d39b8212a..8888adcb3927 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -547,7 +547,7 @@ static void rapl_init_domains(struct rapl_package *rp)
 
 		if (i == RAPL_DOMAIN_PLATFORM && rp->id > 0) {
 			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "psys-%d",
-				cpu_data(rp->lead_cpu).phys_proc_id);
+				topology_physical_package_id(rp->lead_cpu));
 		} else
 			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "%s",
 				rapl_domain_names[i]);
-- 
2.27.0

