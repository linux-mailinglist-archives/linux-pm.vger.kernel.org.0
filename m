Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C368644D234
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 08:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhKKHKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 02:10:40 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27196 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKKHKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 02:10:39 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HqXnH3mlfz8vLs;
        Thu, 11 Nov 2021 15:06:11 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 15:07:48 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Thu, 11
 Nov 2021 15:07:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <srinivas.pandruvada@linux.intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] thermal: int340x: processor_thermal: Fix build error
Date:   Thu, 11 Nov 2021 15:07:16 +0800
Message-ID: <20211111070716.20260-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In function ‘send_mbox_cmd’:
drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:16:
 error: implicit declaration of function ‘readq’; did you mean ‘readl’? [-Werror=implicit-function-declaration]
    *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
                ^~~~~
                readl

Add missing include to fix this.

Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index a86521973dad..01008ae00e7f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "processor_thermal_device.h"
 
 #define MBOX_CMD_WORKLOAD_TYPE_READ	0x0E
-- 
2.17.1

