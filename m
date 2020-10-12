Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3F28B9AB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgJLOCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 10:02:40 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44951 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731074AbgJLOCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 10:02:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.11137|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00991924-0.0257103-0.96437;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.IiEJW-V_1602511313;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IiEJW-V_1602511313)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 12 Oct 2020 22:01:57 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     patrice.chotard@st.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH] cpufreq: sti-cpufreq: fix mem leak in sti_cpufreq_set_opp_info()
Date:   Mon, 12 Oct 2020 22:01:41 +0800
Message-Id: <20201012140141.20296-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use dev_pm_opp_put_prop_name() to avoid mem leak, which free opp_table.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/cpufreq/sti-cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index a5ad96d29adc..9668a48dad33 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -222,7 +222,8 @@ static int sti_cpufreq_set_opp_info(void)
 	opp_table = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "Failed to set supported hardware\n");
-		return PTR_ERR(opp_table);
+		ret = PTR_ERR(opp_table);
+		goto err_put_prop_name;
 	}
 
 	dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
@@ -231,6 +232,10 @@ static int sti_cpufreq_set_opp_info(void)
 		version[0], version[1], version[2]);
 
 	return 0;
+
+err_put_prop_name:
+	dev_pm_opp_put_prop_name(opp_table);
+	return ret;
 }
 
 static int sti_cpufreq_fetch_syscon_registers(void)
-- 
2.28.0

