Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1E301473
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhAWKGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 05:06:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11578 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAWKGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 05:06:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DNBYy48pszMNFw;
        Sat, 23 Jan 2021 18:04:38 +0800 (CST)
Received: from huawei.com (10.175.127.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 18:05:57 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>,
        <caihongda@huawei.com>, <yeyunfeng@huawei.com>
Subject: [PATCH 1/2] powercap/intel_rapl: Use topology interface in rapl_add_package()
Date:   Sat, 23 Jan 2021 05:06:07 -0500
Message-ID: <20210123100608.2349629-1-yeyunfeng@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.234]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not a good way to access phys_proc_id and cpu_die_id directly.
So using topology_physical_package_id(cpu) and topology_die_id(cpu)
instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/powercap/intel_rapl_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c9e57237d778..5f3d39b8212a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1309,7 +1309,6 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
 	if (!rapl_defaults)
@@ -1326,10 +1325,11 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 
 	if (topology_max_die_per_package() > 1)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
-			 "package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
+			 "package-%d-die-%d",
+			 topology_physical_package_id(cpu), topology_die_id(cpu));
 	else
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
-			 c->phys_proc_id);
+			 topology_physical_package_id(cpu));
 
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) || rapl_defaults->check_unit(rp, cpu)) {
-- 
2.27.0

