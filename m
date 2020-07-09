Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB4219ECF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgGILHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgGILHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 07:07:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C1C08C5CE
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 04:07:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so1350972wmh.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdwvmHFIIgaNnK77Gxh46Dh+4af85NxewdzZf8almyY=;
        b=F3BGIIIxCLIBykFtP/eblriQzi1cjmRAs1xHNnvelohkNmxSQjuae+kOtSwEJE17hJ
         mRgWwk9Xpqw1iQEgw16Kj49km1fIluo72cMIe7ktEfxD7FiS3lthmE9xWf8OT5UrO+8A
         HXPBdgCopczix3rGZU9Ck+wiFcSmW9XRpF2erZh9jcjcwNDH3HrYlGC93LP0MVi0gOjS
         JIoInn6K6liNXjY7Euw2fyt1co+efyLYSyIwxnqiq+Aj6sqBOm1yKBtPLm+8C25Q+rIU
         5IXO3eVcsk07Icu+FspMyvR28i4wP9cchjooabnObW2tgTtLAsG/oUZUmNMsOQBwULRB
         XVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdwvmHFIIgaNnK77Gxh46Dh+4af85NxewdzZf8almyY=;
        b=ZFe/tjfnzbLzeybf/3K2v7GTKZThuG/UYJW7Hdxx3hjXwitFC7KlwBtXJ7kNjmkXiO
         BrMykP4564q/Eoi+NUH6W3n7ECIEnp9DheX9WqLLWdcfuQBFjz03/uGbqm0y2OYMSIlD
         JRfdhmqPZbggRthTfFNxsBw7vNeprBHC9OfRQ4uiuLd4Tfg5IZa2j7/4hQ/mmbcc3Ov2
         6cd4d/BNySEqflefROn6HkPqBbtT4cuNaA3R3xBR7+7X9Tbq0R2v45iLHy/sEdJrQd1O
         d3g0uSzaErvZ6tT+GGo+Dt3VPHnwP1R9LfeKyYL2pNv6t7eWKLvhGYXsv/+BgjhiN9Al
         7sAA==
X-Gm-Message-State: AOAM531fvCDyH5iglrh64iACHgCtAGd2j1iXNOw+/BrMEbfEzQMejFEv
        q4AVVGeUOHIyBO86FILoc2LytZUjws0=
X-Google-Smtp-Source: ABdhPJyzyO6OJ0n74t6D1mB7vLxMXi4nDrnvEj3LRHpoi/iVMt8GDCSwSYvn6vh+UXBJPO3jj2VhAw==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr13164196wme.135.1594292835740;
        Thu, 09 Jul 2020 04:07:15 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:15 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] interconnect: qcom: osm-l3: Use icc_sync_state
Date:   Thu,  9 Jul 2020 14:07:05 +0300
Message-Id: <20200709110705.30359-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709110705.30359-1-georgi.djakov@linaro.org>
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lowering the bandwidth on the bus might have negative consequences if
it's done before all consumers had a chance to cast their vote. Let's
return the maximum amount of bandwidth as initial value. This bandwidth
level would be maintained until all consumers have probed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 96fb9ff5ff2e..532d541b71be 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -137,6 +137,13 @@ static int qcom_osm_l3_remove(struct platform_device *pdev)
 	return icc_provider_del(&qp->provider);
 }
 
+static int qcom_osm_l3_get_bw(struct icc_node *node, u32 *bw)
+{
+	*bw = INT_MAX;
+
+	return 0;
+}
+
 static int qcom_osm_l3_probe(struct platform_device *pdev)
 {
 	u32 info, src, lval, i, prev_freq = 0, freq;
@@ -215,6 +222,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	provider->dev = &pdev->dev;
 	provider->set = qcom_icc_set;
 	provider->aggregate = icc_std_aggregate;
+	provider->get_bw = qcom_osm_l3_get_bw;
 	provider->xlate = of_icc_xlate_onecell;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
@@ -268,6 +276,7 @@ static struct platform_driver osm_l3_driver = {
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(osm_l3_driver);
