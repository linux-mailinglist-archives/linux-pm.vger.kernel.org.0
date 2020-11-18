Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452562B7C1E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKRLKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 06:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKRLKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 06:10:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74EC061A48
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 03:10:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so1767878wrg.7
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TM4xeCFqhqNPAzGhqi5+938j8jku7K9Wdryn7CNC1ME=;
        b=TGKY7RuGO77gVB241XAL+NVsGYh6cpT3uiYRDighw58NflqbuQwh4EgaEI1KNxQw4u
         AVZDvR2dW4sSylM2M3u6W8H6J9UUYMSOLQDgh6KDFVC6WMK3Ca2u10xzRHcX5uJcuLoK
         3UW/d1KZDCiXpUiBeIBvYHc2ytxZz36QrLFVTj8scTWc6QTc1mHzudSjX5eZBUFh0WRd
         sh43ebAsXf4lHZKAvX5hUPqPxkOzQHRdtJZ9oZl0Ih/RgtR7Q7ItPfnt2NevujJLlheD
         HaqWSPHZZ05bI/Ikq49gWx7R9daA/ZPBc4FxhZM1a3m6DfSFcRhCCjvYx4dvHRHSdAfm
         grEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TM4xeCFqhqNPAzGhqi5+938j8jku7K9Wdryn7CNC1ME=;
        b=bVsIBBRfY+B8+A3FYFjaDQQr85CPi/cLDe1gjAo4EHoD6mJrlu5XtICqORzJ4+nlmd
         6QVmLdkvvmbt+eFJYjqEPLBMv0fmbHove8MNLwG6lPD/PralgAM1PQKwE7z4UO93R2W9
         NGIIK3ZZvePre4aBvhclNs3JuiLWBr/QDveEE4J8srimrzAMJyVokURypNlJnnmDAnqR
         3FlxBrUl0y02eoE7orgjmxDuKZ52xQldF8sC9d99W17GvakbEwiTNp/RRJx9lJg3Jqhz
         rQTxO2s1d2qiAYJDuX+7NsvjpjjjIo41dPBp9KBnSxQSdFbtuVRIAyxhJl+c31qGuNOm
         K3WQ==
X-Gm-Message-State: AOAM532LG5lzUuq/KpLl9m9LSbjUDPkp4SMkkGXKEHm07NYMw1bYward
        6+DJ5P53+S/yjiCgkos+D/S+LQ==
X-Google-Smtp-Source: ABdhPJxKcSpP5PNEgdsLExRl9hVOtWk9A08Woie5Y8ZNqZYsH2v8ah7p0jFQnFfCdZxkJt8he/I4dA==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr4149899wrq.424.1605697845849;
        Wed, 18 Nov 2020 03:10:45 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y203sm3649174wmg.9.2020.11.18.03.10.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 03:10:45 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     mdtipton@codeaurora.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2] interconnect: qcom: qcs404: Remove GPU and display RPM IDs
Date:   Wed, 18 Nov 2020 13:10:44 +0200
Message-Id: <20201118111044.26056-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following errors are noticed during boot on a QCS404 board:
[    2.926647] qcom_icc_rpm_smd_send mas 6 error -6
[    2.934573] qcom_icc_rpm_smd_send mas 8 error -6

These errors show when we try to configure the GPU and display nodes.
Since these particular nodes aren't supported on RPM and are purely
local, we should just change their mas_rpm_id to -1 to avoid any
requests being sent for these master IDs.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
* Keep the nodes and just set the IDs to -1, as suggested by Mike.

v1: http://lore.kernel.org/r/20201111100734.307-1-georgi.djakov@linaro.org

 drivers/interconnect/qcom/qcs404.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index d4769a5ea182..9820709b43db 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -157,8 +157,8 @@ struct qcom_icc_desc {
 	}
 
 DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, 6, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
-DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, 8, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
+DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
+DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_snoc_bimc_1, QCS404_SNOC_BIMC_1_MAS, 8, 76, -1, QCS404_SLAVE_EBI_CH0);
 DEFINE_QNODE(mas_tcu_0, QCS404_MASTER_TCU_0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_spdm, QCS404_MASTER_SPDM, 4, -1, -1, QCS404_PNOC_INT_3);
