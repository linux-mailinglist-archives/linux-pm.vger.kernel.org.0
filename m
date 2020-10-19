Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B8B292873
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJSNoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 09:44:14 -0400
Received: from mail-m965.mail.126.com ([123.126.96.5]:46204 "EHLO
        mail-m965.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgJSNoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 09:44:14 -0400
X-Greylist: delayed 1865 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 09:44:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=42AtCb9UOnyd5mcCNf
        ppcJFAudZINo4FElIi2RdA0ZI=; b=BP0rttWXib8Z8x4EP+/zuSeQJ6SILwBFHV
        YNw4qUC4EwoocwikQoCcczrOfmYMr2PFA5BOoC326obDrN7498V1pfhvvTq8kRb4
        es3zFwwgn2EanD8gA38N35Wt834MuC819bM7EM7zKJCAoaMfMlOa6fbFUoUlPaYS
        p3x9hw93k=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp10 (Coremail) with SMTP id NuRpCgDHzCDTkI1fU_zDeg--.29S2;
        Mon, 19 Oct 2020 21:12:53 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] cpufreq: ti-cpufreq: fix memory leak in ti_cpufreq_probe()
Date:   Mon, 19 Oct 2020 21:12:31 +0800
Message-Id: <1603113151-5219-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: NuRpCgDHzCDTkI1fU_zDeg--.29S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Xw4ftr1kXFy3ZF47urg_yoWDuFc_uw
        15uryxWr48Za1vgrs8CwnaqryDX3W3tr1v9w1IkasxArW8AryrWr95Xr1UZryDWw48Kry7
        XF1Yvr1a9w4UAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU07DGUUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhXC11pEBkphnwAAs+
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to commit<05829d9431df>("cpufreq: ti-cpufreq: kfree opp_data when failure"), opp_data needs to be freed when failure, including fail_put_node.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/cpufreq/ti-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ab0de27..f23be8f 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -342,7 +342,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		return -ENODEV;
+		ret = ENODEV;
+		goto free_opp_data;
 	}
 
 	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
@@ -404,7 +405,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 fail_put_node:
 	of_node_put(opp_data->opp_node);
-
+free_opp_data:
+	kfree(opp_data)
 	return ret;
 }
 
-- 
1.9.1

