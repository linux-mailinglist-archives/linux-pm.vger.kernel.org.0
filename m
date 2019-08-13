Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D386F8B260
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfHMI0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 04:26:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfHMI0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 04:26:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20091608BA; Tue, 13 Aug 2019 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684793;
        bh=HkxmZCpMhY95DY3tCFQakYJtOGjDO+eSi569Q+9yzjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5+E5QexOO9sgCvjSQknNHyBnBDUrLd9TTxSIeozq1rwIxYsFN1dcgJB8hhNtevUz
         GOOQEMRrMuXtc7rSa69eLmaKsYiN+ZHLk//rWKmYtxHfS4EL9QLsSTLQnGWue1//Om
         1XsiNT/A5vxiRC9gvu+Kg4tg6YgeNfBRrb+oRNMg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CC9F60A4E;
        Tue, 13 Aug 2019 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684789;
        bh=HkxmZCpMhY95DY3tCFQakYJtOGjDO+eSi569Q+9yzjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew+f+Eaz52UrKU32eTsvKqQS6IJKbMXp/nn04WTQfIcOhphh7u4+bZuIEX6wqHNlk
         k19XzK2Ir4474MaxoXAqRbu5ETQ/hrKRI5bjkB+cnioVQtiThk/thGjDvDmpm9NOIz
         /T61+KTw8NXdV+cuYS9HVpQ3syWfHFP597qOqYZE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CC9F60A4E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 4/4] drivers: qcom: rpmh-rsc: Add RSC power domain support
Date:   Tue, 13 Aug 2019 13:54:42 +0530
Message-Id: <20190813082442.25796-5-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add RSC power domain support. RSC is top level power domain in
hireachical CPU LPM modes. Once the rsc domain is down flush all
cached sleep and wake votes from controller.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  2 +
 drivers/soc/qcom/rpmh-rsc.c      | 96 ++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 6eec32b97f83..3736c148effc 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -8,6 +8,7 @@
 #define __RPM_INTERNAL_H__
 
 #include <linux/bitmap.h>
+#include <linux/pm_domain.h>
 #include <soc/qcom/tcs.h>
 
 #define TCS_TYPE_NR			4
@@ -102,6 +103,7 @@ struct rsc_drv {
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
 	spinlock_t lock;
 	struct rpmh_ctrlr client;
+	struct generic_pm_domain rsc_pd;
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc11fe5c..bd8e9f1a43b4 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -498,6 +498,32 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	return ret;
 }
 
+/**
+ *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
+ *
+ *  @drv: The controller
+ *
+ *  Returns false if the TCSes are engaged in handling requests,
+ *  True if controller is idle.
+ */
+static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
+{
+	int m;
+	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+	bool ret = true;
+
+	spin_lock(&drv->lock);
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m)) {
+			ret = false;
+			break;
+		}
+	}
+	spin_unlock(&drv->lock);
+
+	return ret;
+}
+
 /**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
@@ -521,6 +547,65 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	return tcs_ctrl_write(drv, msg);
 }
 
+int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
+{
+	struct rsc_drv *drv = container_of(rsc_pd, struct rsc_drv, rsc_pd);
+	int ret = 0;
+
+	/*
+	 * RPMh domain can not be powered off when there is pending ACK for
+	 * ACTIVE_TCS request. Exit when controller is busy.
+	 */
+
+	ret = rpmh_rsc_ctrlr_is_idle(drv);
+	if (!ret)
+		goto exit;
+
+	ret = rpmh_flush(&drv->client);
+	if (ret)
+		goto exit;
+
+exit:
+	return ret;
+}
+
+static int rpmh_probe_power_domain(struct platform_device *pdev,
+				   struct rsc_drv *drv)
+{
+	int ret = -ENOMEM;
+	struct generic_pm_domain *rsc_pd = &drv->rsc_pd;
+	struct device_node *dn = pdev->dev.of_node;
+
+	rsc_pd->name = kasprintf(GFP_KERNEL, "%s", dn->name);
+	if (!rsc_pd->name)
+		goto exit;
+
+	rsc_pd->name = kbasename(rsc_pd->name);
+	rsc_pd->power_off = rpmh_domain_power_off;
+	rsc_pd->flags |= GENPD_FLAG_IRQ_SAFE;
+
+	ret = pm_genpd_init(rsc_pd, NULL, false);
+	if (ret)
+		goto free_name;
+
+	ret = of_genpd_add_provider_simple(dn, rsc_pd);
+	if (ret)
+		goto remove_pd;
+
+	pr_debug("init PM domain %s\n", rsc_pd->name);
+
+	return ret;
+
+remove_pd:
+	pm_genpd_remove(rsc_pd);
+
+free_name:
+	kfree(rsc_pd->name);
+
+exit:
+	return ret;
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -650,6 +735,17 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Power domain is not required for controllers that support 'solver'
+	 * mode where they can be in autonomous mode executing low power mode
+	 * to power down.
+	 */
+	if (of_property_read_bool(dn, "#power-domain-cells")) {
+		ret = rpmh_probe_power_domain(pdev, drv);
+		if (ret)
+			return ret;
+	}
+
 	spin_lock_init(&drv->lock);
 	bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

