Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300DB1A41A4
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 06:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDJD6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 23:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgDJDsn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 23:48:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D68220BED;
        Fri, 10 Apr 2020 03:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490523;
        bh=Ikc0AYvLKTZZv4VYpqWl7cUBvSOW5ZMNjoOQKDLh2aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB632ctI7ZUomtHbgwgD9PECx6ID7RCoVVr2W/RFmpsadAGIF5JluCIFybyBApPB9
         btPuG1CQrjFxoiyZwrBszm+j/wlJFJvF4GqIRbpiYjy4jW5/O9Qva8ExohzOalNJ7R
         Uq/LUSCfERinkiCwG77lIR6VTYK6tzftbiY5aAA4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 36/56] cpufreq: imx6q: fix error handling
Date:   Thu,  9 Apr 2020 23:47:40 -0400
Message-Id: <20200410034800.8381-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 3646f50a3838c5949a89ecbdb868497cdc05b8fd ]

When speed checking failed, direclty jumping to put_node label
is not correct. Need jump to out_free_opp to avoid resources leak.

Fixes: 2733fb0d0699 ("cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 1fcbbd53a48a2..edef3399c9794 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -381,23 +381,24 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_reg;
 	}
 
+	/* Because we have added the OPPs here, we must free them */
+	free_opp = true;
+
 	if (of_machine_is_compatible("fsl,imx6ul") ||
 	    of_machine_is_compatible("fsl,imx6ull")) {
 		ret = imx6ul_opp_check_speed_grading(cpu_dev);
 		if (ret) {
 			if (ret == -EPROBE_DEFER)
-				goto put_node;
+				goto out_free_opp;
 
 			dev_err(cpu_dev, "failed to read ocotp: %d\n",
 				ret);
-			goto put_node;
+			goto out_free_opp;
 		}
 	} else {
 		imx6q_opp_check_speed_grading(cpu_dev);
 	}
 
-	/* Because we have added the OPPs here, we must free them */
-	free_opp = true;
 	num = dev_pm_opp_get_opp_count(cpu_dev);
 	if (num < 0) {
 		ret = num;
-- 
2.20.1

