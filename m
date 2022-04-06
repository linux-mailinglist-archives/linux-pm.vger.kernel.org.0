Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5854F5B7C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiDFKGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348531AbiDFKF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 06:05:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E242CA49
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 18:49:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m16so702637plx.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FW336dtHK89fvl3u7JvXc/X8Vjn0tSLcri6guFx7q0=;
        b=Sm9XupWe/onCfaGAwkmriGjGwohqfs7tWqDVDN3hrzuBMaoUOGdAEyO1VLSUAtATA8
         Ft0TJTt8T8ciBNG6tsVOxsv8tvLCqPvaXb7mzPcJpEZFilTlFRXoZAoBamloOY0jZhkv
         9D62OHjZGQyqzrj1XG9hW8jNlQ6K+qMVy3crY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FW336dtHK89fvl3u7JvXc/X8Vjn0tSLcri6guFx7q0=;
        b=VivfOXCoHtN/CQkuUs9tXWtcpaygCoPOXCDo2CCms48PBhgLr4Zo97jDLQCdeisWbf
         k6461Pg1uTxJ30G9SA/VjZNSWmcqNsZandEWgp5s8nk9X3JF68fA/9JBOpvxlcF0DSjz
         gCkki4j2raj3GTTz/2/BqjcGPfP8pANHHYnQbj/W8KAXAjYnHuqLNtgbtUfCPmakwir3
         Rsn8jA6CKgaws7lOSceglE9d38lLnFsvEL+Q/ddFBPk7z/sFhnSUIJaIbT+WRvRJV3ZR
         YdjuAaSRPgxFhiUKSpa3+4xF6c7EDDagQt99zubCbfXmRV2Tm4pE4zYHWsPvOrFuo6Ea
         oQUg==
X-Gm-Message-State: AOAM530Lx3ThBjuDTLF1V71MNsj87naXA35BGzF2lLsnYjnuUr6DG780
        YiWKymjmEBC1vHt2eTqpsinePQ==
X-Google-Smtp-Source: ABdhPJxPnqmvxiqZo+frZDwXl2WoTFYWCfoh8Unlghz4i8m3sD7L7wbxSmmeVCG/tSr91GVENxFv1Q==
X-Received: by 2002:a17:902:db03:b0:155:cb6a:7c8e with SMTP id m3-20020a170902db0300b00155cb6a7c8emr6492519plx.125.1649209765864;
        Tue, 05 Apr 2022 18:49:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6903:769c:e1f5:9c25])
        by smtp.gmail.com with UTF8SMTPSA id bg13-20020a17090b0d8d00b001caa8f51098sm3475575pjb.9.2022.04.05.18.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 18:49:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
Date:   Tue,  5 Apr 2022 18:48:42 -0700
Message-Id: <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406014842.2771799-1-briannorris@chromium.org>
References: <20220406014842.2771799-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

See the previous patch ("soc: rockchip: power-domain: Manage resource
conflicts with firmware") for a thorough explanation of the conflicts.
While ARM Trusted Firmware may be modifying memory controller and
power-domain states, we need to block the kernel's power-domain driver.

If the power-domain driver is disabled, there is no resource conflict
and this becomes a no-op.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e494d1497d60..daff40702615 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -21,6 +21,7 @@
 #include <linux/rwsem.h>
 #include <linux/suspend.h>
 
+#include <soc/rockchip/pm_domains.h>
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
@@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	mutex_lock(&dmcfreq->lock);
 
+	/*
+	 * Ensure power-domain transitions don't interfere with ARM Trusted
+	 * Firmware power-domain idling.
+	 */
+	err = rockchip_pmu_block();
+	if (err) {
+		dev_err(dev, "Failed to block PMU: %d\n", err);
+		goto out_unlock;
+	}
+
 	/*
 	 * Some idle parameters may be based on the DDR controller clock, which
 	 * is half of the DDR frequency.
@@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	dmcfreq->volt = target_volt;
 
 out:
+	rockchip_pmu_unblock();
+out_unlock:
 	mutex_unlock(&dmcfreq->lock);
 	return err;
 }
-- 
2.35.1.1094.g7c7d902a7c-goog

