Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC522D937
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGYSOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgGYSOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B97C08C5C0;
        Sat, 25 Jul 2020 11:14:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so9264125edy.1;
        Sat, 25 Jul 2020 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIBquEHwAX4sD8ioWCYBykLFT3YhKbCVKKRvF9l5a+0=;
        b=dSNeB0RNr2d0huNjg44CIsNaarRJ6XfXL7/OBPpazPg+a8wMz+A1yyim/L2/3rFzhC
         GeqbddjxjtYNCCGYDYVqyMC3gHpATEvdVWTxatad934Y8Wa/rv0q3W0t79/4KEaiwcDK
         ynMJtR44W0Hc9/akYmoGCNChS07q+ExhqrF74N43Y96LwWqdtjsWHbVuiUqmha23kYxM
         mQaALSrpZBcRyybO/Sw35tZcRYI+meQbW9DkoHwKGNqOoxa/Ey+LlJH2Mfenw4+S0GmC
         BqFTS0q3zO91rP9+9niFnae2UtolcS75TB5XLVlokzJc7d+v/TheywLgbsy34QY6h3iR
         BsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIBquEHwAX4sD8ioWCYBykLFT3YhKbCVKKRvF9l5a+0=;
        b=YLigrHlQgsm/8h6NcjdgOG6ysAu+kRmcPyzQ/zGBgr9QVSavOCeodSt2E4F0QSyI9E
         9/aR/W/gWyplAi7CSg/Q+14dXQfBlzVhQKkriiC1/OxNnTn21yZfDgoR/zc03sHT3Xpk
         f16Y0s7SZ4XAo0VSD8XyLgASHS7I8rINGE/4PsqmmDcDqfBTl31wQ/kFfM1DxkiXyOQA
         6ceng4M8Ibrz4+1gYChOOyYsgYjI7atQZu6Aua+PWYb26wRjeLO9gDhulMuHvQfXMUBy
         wj6fSX5+GRhgBgWs+sECBYx7EE/+7uWvSm/WAQa6kkuDM+BQcfserHrIDPdF0I3BYQNQ
         YFkw==
X-Gm-Message-State: AOAM530jAxcXRpplGJwVr9b/kTDNl6u1JWvkQWfFnM01qiPSZLC7iAxA
        kll0wykcqwkB8HPYUtmRxF4=
X-Google-Smtp-Source: ABdhPJwdpSYmMX7UtI2iKfDEzNFHrYmdxQPbg5q1/SOLHrvfwunAcXxsEdnWJTu4q/jEc0YprHimzw==
X-Received: by 2002:a50:931e:: with SMTP id m30mr14806586eda.341.1595700876387;
        Sat, 25 Jul 2020 11:14:36 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 6/7] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Sat, 25 Jul 2020 20:14:02 +0200
Message-Id: <20200725181404.18951-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725181404.18951-1-ansuelsmth@gmail.com>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 78840c1bc5d2..5eb036767e8d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -991,6 +991,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.27.0

