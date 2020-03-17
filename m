Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D019188C53
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQRlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 13:41:36 -0400
Received: from v6.sk ([167.172.42.174]:51262 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgCQRlg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Mar 2020 13:41:36 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 621DF60EC2;
        Tue, 17 Mar 2020 17:41:34 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        kongxinwei <kong.kongxinwei@hisilicon.com>,
        Wangtao <kevin.wangtao@hisilicon.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] thermal: hisilicon: Don't enable by default
Date:   Tue, 17 Mar 2020 18:41:30 +0100
Message-Id: <20200317174130.23523-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Users are generally unlikely to have a HiSilicon thermal sensor.
Like most other thermal drivers, don't build it by default/

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/thermal/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 02c3aa322a4a6..2062f8ec272b6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -233,7 +233,6 @@ config HISI_THERMAL
 	depends on ARCH_HISI || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
-	default y
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
2.25.1

