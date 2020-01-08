Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE731338F9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 03:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHCDE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 21:03:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgAHCDE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 21:03:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA696E820EC056E7C97E;
        Wed,  8 Jan 2020 10:03:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 10:02:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nishanth Menon <nm@ti.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] power: avs: qcom-cpr: remove duplicated include from qcom-cpr.c
Date:   Wed, 8 Jan 2020 01:58:49 +0000
Message-ID: <20200108015849.54289-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/power/avs/qcom-cpr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 9247f53550b3..9b1d7d919ee9 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -25,7 +25,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 #include <linux/nvmem-consumer.h>
-#include <linux/bitops.h>
 
 /* Register Offsets for RB-CPR and Bit Definitions */



