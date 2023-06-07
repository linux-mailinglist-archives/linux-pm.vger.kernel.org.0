Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44816726000
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbjFGMsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbjFGMrc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:47:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6C173B
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:47:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso2093952e87.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142036; x=1688734036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGjeBJdPgpOaGz5axPE4yJTdC/ZTW7+SftWuRdijnGw=;
        b=VhYSwRGwS2Sjs65Fop8qjr5mb66J9YNLa2a4RVeqznMNY8oO0QyaMsQCuzvqLszHNH
         +m+3Z2jKOhP8JcJry3+rXyqTJwH9JWmQ5P+HiZPCTfHMTkmGy+dnKDCQHQgLsemnl5B3
         R1ZOy7rmwRXi+6NSUARdAclEsYiigmQA5dXPRTqwC9WawsqQxWNrzIEvt5e9mAp5FnGY
         Giliu/jZ0fun/02VZ81sjzagUR7E8YFJ2uuTBXJXS/dlWSd/GmKEQV520EUk5BDxtiC8
         0exykeNw/LlLVWVwXf2patkeFJ8kk3m4CrnIZLeyNNbeQTcgIOu7AMhrUJ1zKH5zWWA+
         il2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142036; x=1688734036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGjeBJdPgpOaGz5axPE4yJTdC/ZTW7+SftWuRdijnGw=;
        b=U0ufSWH+hAVM3Ru+nPihiRltB06HKU2qgUnn6C2tomyCtejrRT25YF8dFtt4us9k8k
         yFbmF7fYzLo63tCYg1fBGUL532/Dya8XW1QG32FGdNv871F8sVdD/Md4v73f2U5xe7FJ
         EpnAjkeIrwhvB6N0DnvDtkq7gda08MiKLv9gUb96Dbp06Dj61tIZRR1L+7jFxcl81pQ9
         K1o0Tq+VA1GsaD7cDiUKbIFX8z3fM8dTgRaBvBiygVH2aHzHpzwnPiMl5qyDRTim1GCt
         QteT9eKJJIc6xiqyHhdWoiES0x1xc5x6DorbdvvITUlKYSrNXhoFLJYcbwbD6LeSICwp
         q7iQ==
X-Gm-Message-State: AC+VfDx/ziMRd3n2ao84RxDmk+LfBSA7EWma2HCSBhElhwx/Ef1EVIzt
        x/KXyS8LHpxW3PByqrvpD3xbbw==
X-Google-Smtp-Source: ACHHUZ5gTklOwjvOofwGZaihoVmls0o7/kAM9MgICb3wsd0mnMkP7hrhOgNnZgkaFaScq2dXEcyutw==
X-Received: by 2002:ac2:5ded:0:b0:4f6:3000:4d4d with SMTP id z13-20020ac25ded000000b004f630004d4dmr2388353lfq.38.1686142036186;
        Wed, 07 Jun 2023 05:47:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] firmware: arm_scmi: Add generic OPP support to the SCMI performance domain
Date:   Wed,  7 Jun 2023 14:46:28 +0200
Message-Id: <20230607124628.157465-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow a consumer driver to use the generic OPP library to scale the
performance for its device, let's dynamically add the OPP table when the
device gets attached to the SCMI performance domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/scmi_perf_domain.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_perf_domain.c b/drivers/firmware/arm_scmi/scmi_perf_domain.c
index 9be90a7d94de..e9767ca1d34f 100644
--- a/drivers/firmware/arm_scmi/scmi_perf_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_perf_domain.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
 
@@ -39,6 +40,37 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 	return ret;
 }
 
+static int
+scmi_pd_attach_dev(struct generic_pm_domain *genpd, struct device *dev)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+	int ret;
+
+	/*
+	 * Allow the device to be attached, but don't add the OPP table unless
+	 * the performance level can be changed.
+	 */
+	if (!pd->can_level_set)
+		return 0;
+
+	ret = pd->perf_ops->device_opps_add(pd->ph, dev, pd->domain_id, true);
+	if (ret)
+		dev_warn(dev, "failed to add OPPs for the device\n");
+
+	return ret;
+}
+
+static void
+scmi_pd_detach_dev(struct generic_pm_domain *genpd, struct device *dev)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+
+	if (!pd->can_level_set)
+		return;
+
+	dev_pm_opp_remove_all_dynamic(dev);
+}
+
 static int scmi_perf_domain_probe(struct scmi_device *sdev)
 {
 	struct device *dev = &sdev->dev;
@@ -92,6 +124,8 @@ static int scmi_perf_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.name = perf_ops->name_get(ph, i);
 		scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
 		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
+		scmi_pd->genpd.attach_dev = scmi_pd_attach_dev;
+		scmi_pd->genpd.detach_dev = scmi_pd_detach_dev;
 
 		ret = perf_ops->level_get(ph, i, &perf_level, false);
 		if (ret) {
-- 
2.34.1

