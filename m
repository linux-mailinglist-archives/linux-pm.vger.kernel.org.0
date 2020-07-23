Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A422B00A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgGWNKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 09:09:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B02C0619E6
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so14193wrs.8
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWTfVRkR79Imko0PPqnIzVcER9nAarkHmVQCWvBzyCc=;
        b=tvaotbhgbQViqsspi5Ia9TKg2g2+k8ZHJrq+MuqBEc7x4WaXGNGGEy7nerdKRpdySD
         AUFA0aEvde2ok3vmf3f7d032hQhoI/FwgRbVHeBsMzKfqIKacX8ch/8XktFVE7ixAXtp
         xLPPa/8uJemD/71lkS+de69byXAyLhqC1PhLMys6VruIqacBVqXH1r76V/IELKpOtb5f
         MbmEuoZdf2Cxe3mEMy4KFrMZ/td+/Pf/fhpk43Hc+Pe3hg36IZUe7lFHn+SwTrv6OCDC
         JLe0q+Pv2lnwhN3rYTWg6KicxVM0cM0TcLWDijyfCSFstREF/FY4UvOhbaLNUcz+I8fS
         sMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWTfVRkR79Imko0PPqnIzVcER9nAarkHmVQCWvBzyCc=;
        b=sZMSfM5WtP5RmqZKAWxdYZzMVrW7JYltIJ6F3DtjybjXZuVdmkcrQE9LLILtrQiQFV
         6dBRHDWcK36FY0XV9G2No5FbF3yc4NF1jH7nAaXy5G0d/+xHlkjxWyRyVvLc023oyOY8
         kZWVFs0i+MroNxEjyuimhScB/kG6flR45hcDaXDS9HIMgWEZ7Ob9Cfr67C3Xesx8guIr
         K6iVHTYOD4SUMsQPas3vizqUs6mCO2aPYdQXdiM4HhLHvHqAOQXKoYKdxcSQOReFMG+2
         2Qrc7z/rmA0Y9dBPci1G1JCPedQfmcoapqHXF8qsd2W1mDXjTmsvwehTNdeh+ZmAW5Lc
         2IDg==
X-Gm-Message-State: AOAM533ESRysf8Ny+KLy0KJoEznq7ESF780QwospoFeRfYHmCsAElWlg
        gDpWRb9lZRXRTVgCblD7ICJIJYW6Gfk=
X-Google-Smtp-Source: ABdhPJypdAbK/l+XgBOALRGgJMjOLyLZ37pF8MBqln+MJ+cdCucrwML/MuWtdw1EdWissbAnd5A8rQ==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr3970548wrr.299.1595509784758;
        Thu, 23 Jul 2020 06:09:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] interconnect: qcom: Implement xlate_extended() to parse tags
Date:   Thu, 23 Jul 2020 16:09:38 +0300
Message-Id: <20200723130942.28491-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement a function to parse the arguments of the "interconnects" DT
property and populate the interconnect path tags if this information
is available.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3ac5182c9ab2..44144fabec32 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -6,6 +6,8 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
@@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+{
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	if (!spec)
+		return ERR_PTR(-EINVAL);
+
+	node = of_icc_xlate_onecell(spec, data);
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+	if (!ndata)
+		return ERR_PTR(-ENOMEM);
+
+	ndata->node = node;
+
+	if (spec->args_count == 2)
+		ndata->tag = spec->args[1];
+
+	return ndata;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
+
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 903d25e61984..1dac39bc255d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -143,6 +143,7 @@ struct qcom_icc_desc {
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 
