Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433D7162DEE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgBRSMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 13:12:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34139 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBRSMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 13:12:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so11066335pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 10:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzP6DDxjNOEcRZc6aP2dcvH1CJqWKtefu5asJA+DstU=;
        b=cZf5qStkhDbF+2285LVwTF25BVh9UjH/fnLeRooy56tUNVAhSwMt3dFT7KK5QHfbKn
         YOa5d7141qV+nMVIFog2MWchsku1UWXSC14D8Z7+Zt9t+EBvT9fytkk/dcq9kegDWOi6
         G5kiHKRudS09kb7+8HVKHOSvnTemXYK4JBUwdnuTBosulCv1XxM9dRcqTKuI4f9BAGnb
         3cn7d5GHivpsGz4GZdP+jtxsV06IKzBiGEmuRob0eDLeeWJkvIpqjEpE+qbhZEpgVxCC
         v6vjaZzp3/XALSSX2zxRJvS/139lii4oiJGEn8XFs9blYtIuhqVShVLBKpcu5/ZvlcH/
         zguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzP6DDxjNOEcRZc6aP2dcvH1CJqWKtefu5asJA+DstU=;
        b=T4b05qrs6mHGW+bg1ZqKCCJmRe0I5QBhhL+UmkqyVHMZWjX0yMOIcIShzWha0v/dCk
         MmwgQun/31a4gd21wdRDudDO+uNTg7NsCxXM9nyb8uiugDjW6nXOStOxc5AcYi+WBGhT
         nkR5b4UCw8w0vTB0C5iZg2krY98VnQo9C8Z+jwjAUIcw0I2bxtISBtxDJB0uORbN6PAm
         BLvZf3x53Hz3z9BWWB6tTA6txZxEtzPFTvreKFC5CPBAHNU/YrjOrkwZmrS3AXDFQrjz
         FYTNcE/fa+737Go6VGxLcoYwK8MfoJD2PrKuvqRucjpIqqfiwIKGQkDOMhW1Lmfair5G
         Kg3A==
X-Gm-Message-State: APjAAAUieuqTbuRP8qIiqTf82zjfhtpNwIVnDqoF4pWaVmwcY7xz7edL
        thBZAP+y3s1OuZXlzKt6kIv7oQ==
X-Google-Smtp-Source: APXvYqzRmHIQixHL/dT3g9+URkrEvbTD1662LCKASj2k0uJ6uY3NugxAdfAfz04HmHTeYWl0Y6pjGA==
X-Received: by 2002:a62:1402:: with SMTP id 2mr22863254pfu.126.1582049568452;
        Tue, 18 Feb 2020 10:12:48 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id j17sm4952292pfa.16.2020.02.18.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 7/8] drivers: thermal: tsens: kernel-doc fixup
Date:   Tue, 18 Feb 2020 23:42:11 +0530
Message-Id: <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document ul_lock, threshold and control structure members and make
the following kernel-doc invocation happy:

$ scripts/kernel-doc -v -none drivers/thermal/qcom/*

drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for qpnp_tm_get_temp_stage
drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tsens_irq_data
drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_to_mC
drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_to_hw
drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set_interrupt
drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_threshold_violated
drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_critical_irq_thread
drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq_thread
drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sensor
drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_features
drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_plat_data
drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_context

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index ad7574fe0811..f49e516b3458 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -526,6 +526,8 @@ struct tsens_plat_data {
 
 /**
  * struct tsens_context - Registers to be saved/restored across a context loss
+ * @threshold: Threshold register value
+ * @control: Control register value
  */
 struct tsens_context {
 	int	threshold;
@@ -540,6 +542,7 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
+ * @ul_lock: lock while processing upper/lower threshold interrupts
  * @crit_lock: lock while processing critical threshold interrupts
  * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
-- 
2.20.1

