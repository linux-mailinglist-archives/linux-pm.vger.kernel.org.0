Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2130A2F6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 09:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBAIDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 03:03:16 -0500
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:54190 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232032AbhBAIDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 03:03:16 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 03:03:16 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612165870;
        bh=V9vC6gmX2Ghrx0NvJKmm1W4qtIAW5zo8GQmVYWHEha8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=I6ZKvrA5oWEqCJS4vXKSplQZe59gEPWibD8ZW2sJn4+LKrJL+/eMb55H0JOD5K/Ih
         PdbjGoA3UGb+Nrj9SR1Fjkk3QKpacWfoEiSLnXencGsm7Ea1HZeqrXk0+4Gya/4o9X
         8JooYIrFfDIlEaQfOExtL8wXPRLwI398zumn9org7xF3wVnB8qxMS+ZDW++Wx7hzGH
         d5GEZjAHlaONU29x0FIyPgSzzBxlph9hkZ1uyxxrt7vDCfV2RCXKTaFBcgehSkvyq1
         hDjpx3bBncQL9txbFtPiK1TzhPrccwWT2yr3gFiTTvEEdvTDYIOZct6wZd5b58WYwR
         At8sMLs3GXSEA==
Received: from localhost.localdomain (unknown [119.3.119.19])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 696EA280650;
        Mon,  1 Feb 2021 07:51:05 +0000 (UTC)
From:   Abel Wu <abel.w@icloud.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com, wuyun.wu@huawei.com,
        Abel Wu <abel.w@icloud.com>
Subject: [PATCH] PM: hibernate: add sanity check on power_kobj
Date:   Mon,  1 Feb 2021 02:50:41 -0500
Message-Id: <20210201075041.1201-1-abel.w@icloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_03:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102010038
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The @power_kobj is initialized in pm_init() which is the same
initcall level as pm_disk_init(). Although this dependency is
guaranteed based on the current initcall serial execution model,
it would still be better do a cost-less sanity check to avoid
oops once the dependency is broken.

Signed-off-by: Abel Wu <abel.w@icloud.com>
---
 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index da0b41914177..060089cc261d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1262,6 +1262,9 @@ static const struct attribute_group attr_group = {
 
 static int __init pm_disk_init(void)
 {
+	if (!power_kobj)
+		return -EINVAL;
+
 	return sysfs_create_group(power_kobj, &attr_group);
 }
 
-- 
2.27.0

