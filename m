Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A24564A8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhKRVFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 16:05:53 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:36936 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhKRVFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 16:05:53 -0500
Received: from localhost.localdomain (ip-213-127-109-54.ip.prioritytelecom.net [213.127.109.54])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5667BCADFE;
        Thu, 18 Nov 2021 21:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1637269371; bh=VkZLd4MrD1jYefgkbKqN/uBus6sSvz99v85KNgNeEo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WhArt4LnAT0NYc1Te9WK/DU1BrV1BFN3qq03WK/VfTMLGArhJN+vVjRJrrcSm5g8S
         XDSdd4xtzhCgaAvgZa6a1y7KTLc/oWPclRtm3YL7GG5caGPJcPGRO063cgNV6Ph83R
         XGxS8TN+TW+lfISRVtsS6vuyADHQ1FfXfSZgQI5E=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] power: supply: qcom_smbb: support pm8226
Date:   Thu, 18 Nov 2021 22:02:05 +0100
Message-Id: <20211118210210.160895-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211118210210.160895-1-luca@z3ntu.xyz>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PM8226 (used in MSM8226) has v1 smbb hardware and works fine with the
current driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/power/supply/qcom_smbb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index 84cc9fba029d..bd50124eef9f 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -863,8 +863,8 @@ static int smbb_charger_probe(struct platform_device *pdev)
 	}
 
 	chg->revision += 1;
-	if (chg->revision != 2 && chg->revision != 3) {
-		dev_err(&pdev->dev, "v1 hardware not supported\n");
+	if (chg->revision != 1 && chg->revision != 2 && chg->revision != 3) {
+		dev_err(&pdev->dev, "v%d hardware not supported\n", chg->revision);
 		return -ENODEV;
 	}
 	dev_info(&pdev->dev, "Initializing SMBB rev %u", chg->revision);
@@ -1012,6 +1012,7 @@ static int smbb_charger_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id smbb_charger_id_table[] = {
+	{ .compatible = "qcom,pm8226-charger" },
 	{ .compatible = "qcom,pm8941-charger" },
 	{ }
 };
-- 
2.34.0

