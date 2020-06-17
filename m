Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF01FC2AC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 02:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQA3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 20:29:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgFQA3V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jun 2020 20:29:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 506918483B30297482EE
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 08:29:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 08:29:16 +0800
From:   Jack Qiu <jack.qiu@huawei.com>
To:     <linux-pm@vger.kernel.org>
Subject: [PATCH -next] opp: export dev_pm_opp_adjust_voltage
Date:   Wed, 17 Jun 2020 09:20:24 +0800
Message-ID: <20200617012024.41704-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_adjust_voltage() is used in qcom-cpufreq-hw module, so export
it to GPL modules. otherwise compile error occurred:
$ make allmodconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
$ make -j64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

ERROR: modpost: "dev_pm_opp_adjust_voltage"
[drivers/cpufreq/qcom-cpufreq-hw.ko] undefined

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 drivers/opp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6937bf45f497..c9336aac74e9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2302,6 +2302,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 	dev_pm_opp_put_opp_table(opp_table);
 	return r;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);

 /**
  * dev_pm_opp_enable() - Enable a specific OPP
--
2.17.1

