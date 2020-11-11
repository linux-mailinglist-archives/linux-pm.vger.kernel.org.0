Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE12AEE7B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgKKKHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 05:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgKKKHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 05:07:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD4C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 02:07:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so1946514wrl.7
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhNVmiGRjKtWj6Yv/r78yPNvE9PCgYoouxIq1h1Gu1E=;
        b=eGNQ2RRHPn8cIvHZO7W4KaoAKsbVJhZjhfzPqRGC2E+OfIx30kHsq0DJcAkvBU9OMs
         AmOLn20fUak02DJ3SAY714hKnBLIoBHRFGbLOf3BmGV1eJV0a1QB2NmhkIb1WdOU6tet
         d1ctqz5Ryqt+fcIqWorFXkXKLV6wHQHT3Q/ZvExgP/W4txFJv8YEJ2eIzl8F1MQykxfQ
         a0QYbpgU/9iZcJEkasGFv4rkKUjiGQd0OS98RRWTJwzFRPWpkIJNzGp+MmKSrU6pZqlH
         9SGuT984v4MKMEaxSA7YXRZY1GAGLKGr+3vVSLLcQzVuzoMGFlrNHfHUKyjqRatLws2K
         vCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lhNVmiGRjKtWj6Yv/r78yPNvE9PCgYoouxIq1h1Gu1E=;
        b=rFMZptdhpK9c5YVhvW/Z+XoB0ZDx6g4uQ5cim3uPCVKVGCxV7+F99sh2DrvEHXqCo+
         tRzyUrAqbGC8wDWggfjI2bXbXS0AxWrS9Ea1c+eOG06y00YgvBLDke/R5UGN1tKe+GIK
         sEzRLoIkJVM/2sqynaBsFQweTI5hGAaRqcH76nKGwbmo64uyalKb++q1AM0P39Z5aOXp
         qur2PQIGNkpyYC8hd+ohBb536JBPj+FVJbaLaaqP6ORemI4jua+C5nwZzopmvq9VkBYh
         eJBKQNDomeWozVLrQgFvBWvdjCgXmOpOB9ilya3AORUdotdImBKEt5NVxLMyM+3t2G2V
         2Aug==
X-Gm-Message-State: AOAM5324RrptsSBFT5QSi33C0SZ+h+5su/Y5AcPE754LdqKo3kYKtAtE
        DwRB8b7V6beTQqWkGvJdcT4C29RtKjXc8A==
X-Google-Smtp-Source: ABdhPJxnas6xPj4y1eZeu09nWk8hlj/K7wPTeewT4L7XHj0sLnBiCg8sq6iv413heH318CAuBmN7sg==
X-Received: by 2002:a5d:62ca:: with SMTP id o10mr7083941wrv.422.1605089251104;
        Wed, 11 Nov 2020 02:07:31 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id s188sm1941424wmf.45.2020.11.11.02.07.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 02:07:30 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: qcs404: Remove gpu and display nodes
Date:   Wed, 11 Nov 2020 12:07:34 +0200
Message-Id: <20201111100734.307-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following errors are noticed during boot on a QCS404 board:
[    2.926647] qcom_icc_rpm_smd_send mas 6 error -6
[    2.934573] qcom_icc_rpm_smd_send mas 8 error -6

These errors show when we try to configure the GPU and display nodes,
which are defined in the topology, but these hardware blocks actually
do not exist on QCS404. According to the datasheet, GPU and display
are only present on QCS405 and QCS407.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 9f992422e92f..2ed544e23ff3 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -20,8 +20,6 @@
 
 enum {
 	QCS404_MASTER_AMPSS_M0 = 1,
-	QCS404_MASTER_GRAPHICS_3D,
-	QCS404_MASTER_MDP_PORT0,
 	QCS404_SNOC_BIMC_1_MAS,
 	QCS404_MASTER_TCU_0,
 	QCS404_MASTER_SPDM,
@@ -156,8 +154,6 @@ struct qcom_icc_desc {
 	}
 
 DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, 6, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, 8, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_snoc_bimc_1, QCS404_SNOC_BIMC_1_MAS, 8, 76, -1, QCS404_SLAVE_EBI_CH0);
 DEFINE_QNODE(mas_tcu_0, QCS404_MASTER_TCU_0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_spdm, QCS404_MASTER_SPDM, 4, -1, -1, QCS404_PNOC_INT_3);
@@ -231,8 +227,6 @@ DEFINE_QNODE(slv_lpass, QCS404_SLAVE_LPASS, 4, -1, -1, 0);
 
 static struct qcom_icc_node *qcs404_bimc_nodes[] = {
 	[MASTER_AMPSS_M0] = &mas_apps_proc,
-	[MASTER_OXILI] = &mas_oxili,
-	[MASTER_MDP_PORT0] = &mas_mdp,
 	[MASTER_SNOC_BIMC_1] = &mas_snoc_bimc_1,
 	[MASTER_TCU_0] = &mas_tcu_0,
 	[SLAVE_EBI_CH0] = &slv_ebi,
@@ -460,6 +454,9 @@ static int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
+		if (!qnodes[i])
+			continue;
+
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
