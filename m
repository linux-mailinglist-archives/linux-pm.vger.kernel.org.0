Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2B24B706
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgHTKqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbgHTKom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 06:44:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A63C061357
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so934810pgm.7
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBvIIVWSqLOvxm5DPjzeQaBDOBFgxxRxk7Pa8spcF4Y=;
        b=V874UKRvNzPN6yCv8qVBDzRdBiJEA270fWjz5BPet8N9PL05DbDPPGSBzOT4Y+iY/1
         4d2DG05vPqpn16MzA1A+YMSq8cHlRMPn5JqZL3jVJih72dFB482zLOHksr4wnhik+uif
         WcXaSkGUZ4nY/8eKsNBikSG/6AXbZcr4EdezbYKrUzTJrY0yYz4d+Bb/FG/cV8ePqrwv
         dRyqQDFGT8c4oKA3pst29XRQ3/f3sIHW+cL2p7rERY/1sF3+Z6MTCvUuYSRYUwPPsd4+
         AcusnBcReAvdqC0EVkWzaOONn61yPgQ5MBD3Nskh3CCbTi80YJwSyWZp2Gs9InhPlcP3
         tmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBvIIVWSqLOvxm5DPjzeQaBDOBFgxxRxk7Pa8spcF4Y=;
        b=WFSSJKioYXXdP1zJQRl8mJPs09CGi+S9G+MXLDp9Cf9ABBquWqp+mmkcPsUxAWb8q6
         jlKhny+LVwYoU0VbmNJFQcUjZLWWT+TnhUqeufSRwjnEGWeJa7pb77YYkULfaA+2o1e/
         e1SexvI9RA6amWw1K0FEniFubuTgXkxqtMAZrvG3B1W4ddNi50pBkn6ArYV0jhFN2YN6
         pS7AX0REevdEPYT1x1GQ2v8ERGmmRc6cPOXUYQ56iNwpnve3khOnnJnIdEnYktUinRg7
         Fj8JTO10+cemNIh4oyM3FSr6tY3f1DDfmfd32U5WHWA0VsHWFn7bjWhQJoPIBf5e6Rli
         dXsg==
X-Gm-Message-State: AOAM532/svkfDmTKybvZJWoo7S22eymj1gqTaIKejj/qqV2gufpLY3A1
        PVkDeyUKcDMU/JM8SkVm1HKJ3A==
X-Google-Smtp-Source: ABdhPJymYxVzYFrgD51zd21b7M1MPbmHJ7swyrMN/Tbs1N+OkZBWPAWKnZsexxmQeaYm+lrhpfO1EQ==
X-Received: by 2002:aa7:9f8a:: with SMTP id z10mr1853318pfr.176.1597920270879;
        Thu, 20 Aug 2020 03:44:30 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id d13sm1862811pjz.3.2020.08.20.03.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Thu, 20 Aug 2020 16:13:54 +0530
Message-Id: <91321ced21a5bbb98abc24c99e14b7f94f9045c0.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/spi/spi-geni-qcom.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 80cea5cd3612..5d3904a0aff8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -613,9 +613,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 		return PTR_ERR(mas->se.opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		mas->se.has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 		return ret;
 	}
@@ -669,8 +667,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
 	spi_master_put(spi);
-	if (mas->se.has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return ret;
 }
@@ -685,8 +682,7 @@ static int spi_geni_remove(struct platform_device *pdev)
 
 	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
-	if (mas->se.has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return 0;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

