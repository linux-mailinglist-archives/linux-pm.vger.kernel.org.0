Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F51865EA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgCPHts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 03:49:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729946AbgCPHts (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 03:49:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F51AAE99B3444D1ABF2;
        Mon, 16 Mar 2020 15:49:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 15:49:42 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Add maintainers for kunpeng thermal
Date:   Mon, 16 Mar 2020 15:49:09 +0800
Message-ID: <1584344949-42011-3-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584344949-42011-1-git-send-email-shenyang39@huawei.com>
References: <1584344949-42011-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Yang Shen and Zhou Wang as maintainers for kunpeng thermal

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18c..b7d4af4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7602,6 +7602,13 @@ F:	drivers/crypto/hisilicon/sgl.c
 F:	drivers/crypto/hisilicon/zip/
 F:	Documentation/ABI/testing/debugfs-hisi-zip
 
+HISILICON KUNPENG TSENSOR DRIVER
+M:	Yang Shen <shenyang39@huawei.com>
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/kunpeng_thermal.c
+
 HMM - Heterogeneous Memory Management
 M:	Jérôme Glisse <jglisse@redhat.com>
 L:	linux-mm@kvack.org
-- 
2.7.4

