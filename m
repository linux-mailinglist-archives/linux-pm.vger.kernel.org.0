Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6D2FF46D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbhAUTSr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbhAUTSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:18:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA59C06174A;
        Thu, 21 Jan 2021 11:17:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so1842929plb.4;
        Thu, 21 Jan 2021 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRiSzjbPGSuciDDwZK/ZEDlRzVvbEgMvnG2EnKEi2b8=;
        b=DkGaRMymQU2Ti7nuGFAec88q4U8hFbvYLkGUOTfTAlcFxyZUCbmVhI4mSTcdoaPVdZ
         ICZyZDieLP/RL9AtWHTrqkd4mPbl+4kdg1vq3OS7cUFg6HCdFnGclcX74Z383TZqCz+W
         PV7qgySksE2aM21H6c/KVJRNe5kycUIW6UkofQahASMjwvKucvbgvjpnGF1YJn5h4SHz
         NrRz2hpz7MINVO4xPpbXdugdIazeFgtm2h/V1pivr6CzL9uRIx3InRtM4rZyKb1Q95YZ
         fC5FJSiLtY0UPFvWfrFEHDqyEZ8sxySanNli61fAEL2lmn/AVK3F/DGuS9Dlfz572XuE
         kJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRiSzjbPGSuciDDwZK/ZEDlRzVvbEgMvnG2EnKEi2b8=;
        b=G1PKX5th2rm2CURi8zCmBrCKKFR0ZEwL10M0UtcnsxyDg0YBi5ej80tz1+m5ad6i04
         cNeax8dQggxzy+SXJcVuTssGBylzx3Yv5xWyO5PZn+kCliYboUEOT3GdIUJl5J/2Bndq
         hIO5PmwFJ99dVv0NQnxFKmswKt4deCxG8Uanq2ygbJYELRXYn8orwJYIsm+NniPBOFlL
         HxGOFcVHfmLiz6/SDT6kj47yGlQLnlmFsSsIQv2xjPFOF9lM0snDvduPU7MGYsSIsNqo
         JXWtWXpeLuK0/vDeltAO7ZKDcNdElb8LTXbuVkNY6Gr5AcuVFG2I/i/fv2/h6OdkRAM5
         zybQ==
X-Gm-Message-State: AOAM532VOqC7gYyw95k+G2lo4Na9szXIIecfDVUMDz1LKKpWRw0qbTTt
        B9hoV5T5OmX7NegkJEZnN98=
X-Google-Smtp-Source: ABdhPJwOllrF6r9nS/4JZsBr6uzAUBd/bZaDSP5ab3c243GAsdrBIkEGUkvzhlR3EtezfDyyOtMuFQ==
X-Received: by 2002:a17:90a:e549:: with SMTP id ei9mr947844pjb.43.1611256639326;
        Thu, 21 Jan 2021 11:17:19 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:17:18 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/8] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Thu, 21 Jan 2021 20:15:59 +0100
Message-Id: <20210121191601.14403-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121191601.14403-1-ansuelsmth@gmail.com>
References: <20210121191601.14403-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index dd9b41157894..586b90962605 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1010,6 +1010,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.29.2

