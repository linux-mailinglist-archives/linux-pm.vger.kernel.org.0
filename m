Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0603183061
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCLMha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:30 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54651 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgCLMha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:30 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so2507665pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRyyj8+FD2GmzJZEo23f/1uP4q0C29vXZ903dztLNAg=;
        b=Veu21IQS88+BrjA0kJx+gT5G/wiO5/54HJr9fYr5H9cOOGTFdokez/otlTr8hAa2Gc
         CLf3Wue/zOVwAjg9ZkbXxoPstMX11lR1FTGtOKGPCnBIDS95DUePCtLUNVfN821se4kK
         Og2+5s0ur+TdnSyBM+OarSAfuOPeqABlGIXTUimbzwPYAyHhuYWBoKvMKPMBjjPWgrrb
         STikHjMhj69BZuGGvnqq9ci+G6Ukg8AN8t0rav3lXW7uYWphG5JEgaRa0pIL8V3azPCz
         a2J7/SB5yDKebUN4iXOmNB/Zx1nk1tp1+HrfE/KcDlpqC18QovL0SCR4jp5B5evN21sw
         70VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRyyj8+FD2GmzJZEo23f/1uP4q0C29vXZ903dztLNAg=;
        b=mWdBfp6JtCFy1/uMEt9/A2vbGGJDx/HeoqZkJcRm4v370Q+aRtqVXkGfy4V1TcaqcQ
         LvUpZeozAMOlboYIFUDjaIYCuWt0zr+vW7vJ+PAgjM8Xp4JXpOj7zuLLf0CVee1r4O0v
         UcFzk01rr1Uu76AUhILAlDdT0rzF8I7TzJwo+TtKP3G6WIBeDKwdaXtDvUX9HbciqnJe
         CLhgH1JWRfrSR7dz2auAwv758Sv+D+ZRyFI3ZIs4NKjXLvJCmxCOcVWE9qnf6K/AfwQ4
         K7i6/lhCfUCgqtBbDdrgr482C2YiCRzFk8RFdo+0AucHHW5qFaqbqqwIE7h+5lDns1jA
         ue4Q==
X-Gm-Message-State: ANhLgQ1zqeI2GCJNVt9/TH9QUiC4kGDMIIz3hn7lCGo8dArz9qKI6UBr
        rOGnY40iVPMVx3OEpZiw0S7q4w==
X-Google-Smtp-Source: ADFU+vvxhD3+xCtoGtZH4A9IT0BbfLipgX7yDbpC4nFQlnRtOGQ+zhHfKoRjIPI8fJaPyy2NRvnJDA==
X-Received: by 2002:a17:90a:7f06:: with SMTP id k6mr3952684pjl.78.1584016649232;
        Thu, 12 Mar 2020 05:37:29 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id y7sm14816748pfq.159.2020.03.12.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:28 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 4/8] drivers: thermal: tsens: Release device in success path
Date:   Thu, 12 Mar 2020 18:07:01 +0530
Message-Id: <d3996667e9f976bb30e97e301585cb1023be422e.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584015867.git.amit.kucheria@linaro.org>
References: <cover.1584015867.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device. So we hold the reference and keep the device pinned forever.

Allow control to fall through so we can use same code for success and
error paths to put_device.

As a part of this fixup, change devm_ioremap_resource to act on the same
device pointer as that used to allocate regmap memory. That ensures that
we are free to release op->dev after examining its resources.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index f044788681c48..fd3b56d523411 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -603,7 +603,7 @@ int __init init_common(struct tsens_priv *priv)
 		/* DT with separate SROT and TM address space */
 		priv->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(&op->dev, res);
+		srot_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(srot_base)) {
 			ret = PTR_ERR(srot_base);
 			goto err_put_device;
@@ -621,7 +621,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base = devm_ioremap_resource(&op->dev, res);
+	tm_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(tm_base)) {
 		ret = PTR_ERR(tm_base);
 		goto err_put_device;
@@ -688,8 +688,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.20.1

