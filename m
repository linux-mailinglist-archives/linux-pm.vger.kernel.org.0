Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D64243357
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHME30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 00:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgHME30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 00:29:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A6FC061383
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so2078651plt.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=R39mZXnsq0qTraesNliee1MsAVA33s9QnxlmS7GVZbI=;
        b=H1n9tH4E5LR0hLMncTHZa2OqXcJNGM/3MvpETAWc3xKJJ9siDUlT2ZUQURgpPlKa+J
         HmNGgAwmwoRAWO6F/0Qlx0qr2uy8Ou0s3fXMQKoOkwTYAHCuC+KQPUQzw6216SHg0e77
         RMghBXdyNvyQ9Rnz+XnB5xM1BBL9L9cYbN+AUFMbmwsLkgjbtB3IPnG6JYQyWTh63eOj
         GDW6niGkwGcCDGMtHG6O98TsJtdMXPvxOFABUPHKrQm8YqX4InK55oS29bDncwbabq43
         10SCYCle0cQ9QfVH4RGsUb6sIJKd7PiVwJhdnY2zhfZxfPlFLhaQRp7Wqc/s9LGz1IbS
         G1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R39mZXnsq0qTraesNliee1MsAVA33s9QnxlmS7GVZbI=;
        b=goFS8HSRddZL/6qqTPzzZ8dJqgeVODtkmX6saB63zNeaI3T/n4HXZc18UqcKs/Mty8
         VZ1kr4Y3JsFawjz6/PMK7c0AxhECcH+MELJz0bcXeXNItRCx1RSuXlB/1+knDgnhPkHr
         Fa/kRrBwib3/Py97KmizHvCGqtSVVnO33Lpz/L6Gc3aG+RUYNY7s5cbhFOgHK1Oi79gx
         0zkT3fyFO21ww2bxqB6Y/sQi0gcBK2m1TwjK2FcAmyLhgpfhOvUoaooWK2nFu+jCc7BC
         Zssga2p7dipga2Sl6aJbHf04PhQpbqUNauvymMUWnBM5bswJxL9eWDf9LY6iyiaPkgu/
         jqtw==
X-Gm-Message-State: AOAM531cxabgQOYR6DPKPplnLsdLDjmipX21FhLbcTBvT7W7qudGv8dl
        DClnntLSffMLyljt1rkqecXYDw==
X-Google-Smtp-Source: ABdhPJyiHs3lx6zA/+e4gEiWWHS7Z1ltMlLkHBMkgHHERccGq0Yjc56OGchqNhaTJkR9ZYmw4IVAUQ==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr2354217pls.117.1597292965549;
        Wed, 12 Aug 2020 21:29:25 -0700 (PDT)
Received: from localhost ([171.79.32.211])
        by smtp.gmail.com with ESMTPSA id e26sm4100031pfj.197.2020.08.12.21.29.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 21:29:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] opp: Split out _opp_set_rate_zero()
Date:   Thu, 13 Aug 2020 09:59:01 +0530
Message-Id: <c30377622c4f4754fb709f6bd2eb3ba61db38f19.1597292833.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Create separate routine _opp_set_rate_zero() to handle !target_freq
case.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f5da257f58a..e198b57efcf8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -860,6 +860,34 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
+static int _opp_set_rate_zero(struct device *dev, struct opp_table *opp_table)
+{
+	int ret;
+
+	if (!opp_table->enabled)
+		return 0;
+
+	/*
+	 * Some drivers need to support cases where some platforms may
+	 * have OPP table for the device, while others don't and
+	 * opp_set_rate() just needs to behave like clk_set_rate().
+	 */
+	if (!_get_opp_count(opp_table))
+		return 0;
+
+	ret = _set_opp_bw(opp_table, NULL, dev, true);
+	if (ret)
+		return ret;
+
+	regulator_disable(opp_table->regulators[0]);
+
+	ret = _set_required_opps(dev, opp_table, NULL);
+	if (!ret)
+		opp_table->enabled = false;
+
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -886,29 +914,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		ret = 0;
-
-		if (!opp_table->enabled)
-			goto put_opp_table;
-
-		/*
-		 * Some drivers need to support cases where some platforms may
-		 * have OPP table for the device, while others don't and
-		 * opp_set_rate() just needs to behave like clk_set_rate().
-		 */
-		if (!_get_opp_count(opp_table))
-			goto put_opp_table;
-
-		ret = _set_opp_bw(opp_table, NULL, dev, true);
-		if (ret)
-			goto put_opp_table;
-
-		regulator_disable(opp_table->regulators[0]);
-
-		ret = _set_required_opps(dev, opp_table, NULL);
-		if (!ret)
-			opp_table->enabled = false;
-
+		ret = _opp_set_rate_zero(dev, opp_table);
 		goto put_opp_table;
 	}
 
-- 
2.14.1

