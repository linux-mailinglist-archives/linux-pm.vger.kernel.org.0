Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEF310274
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 02:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBEByE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 20:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBEByA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 20:54:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF9C0617A7
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 17:52:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b21so3432079pgk.7
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dbop8oOXb3CIgxFtxFxfz6HESSuLiJPucRa+5GXJ/bo=;
        b=fQMaSLXGZBrcPVrSQYclJC9FHcowZVqyYZUFs6lyFiNZAI7A4ub83yhp274+9RAeE9
         Ps2u2TNuh/38BXmQAKsKOfP0eJjWsAciFmHtJY+z4xy2fJe+3tcLPuGHGkBUftTjNwyp
         IZ/tng9+CFkS0CzCXTqAddrqT/SsnL2JqjM+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dbop8oOXb3CIgxFtxFxfz6HESSuLiJPucRa+5GXJ/bo=;
        b=tUzwh3iA7SOpHXaPbKNj3A1MWrE8BuQ4JwRVbiWite+b0aUjMEuaVDXeFKUANTqLfC
         Z87VBnmXLUlpndppkn9B0hc/sblPyR9XHYStySry12d+Fnlagu7QgRbhUaF2ADK/+yXT
         SGcEONGnkC8Cj2lv4/rjORLhPRFCBX2/s7+deDEyPTvkD/eEZbyVYvj1ORPgycd/s9xo
         x74Nnqp19xJ+YQI97W9wpUtDQb5ErDvJsil0z6eo5Iw/oeE/Ab0JB/Mhc8DFN47ojgYf
         GV4jbbGr0zsFtvIP4KeJjSVyO3BQINRM5i4FpryQGrlnY4cpOesZ0sILErnST5KiLXpe
         tCrA==
X-Gm-Message-State: AOAM5304jE9SMQJbzizwyUohUh+wYr7H0ccSv6EmFINhw0c683Ebs/yK
        YSYaSSTmH7wZvPA3eqGoSDGw+A==
X-Google-Smtp-Source: ABdhPJx/CcA9hQR9m5B0/zVA9D6H4PJOG1ikKfcj7pc81C6qci/SwTbWYYrQYcuBgw5/v22eJWpGng==
X-Received: by 2002:a65:620f:: with SMTP id d15mr1885160pgv.218.1612489966483;
        Thu, 04 Feb 2021 17:52:46 -0800 (PST)
Received: from localhost (162-207-206-139.lightspeed.sntcca.sbcglobal.net. [162.207.206.139])
        by smtp.gmail.com with ESMTPSA id n4sm6319302pgg.68.2021.02.04.17.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 17:52:45 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Jun Nie <jun.nie@linaro.org>
Cc:     kernel@squareup.com, Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes
Date:   Thu,  4 Feb 2021 17:52:05 -0800
Message-Id: <20210205015205.22947-3-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205015205.22947-1-benl@squareup.com>
References: <20210205015205.22947-1-benl@squareup.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some nodes are incorrectly marked as RPM-controlled (they have RPM
master and slave ids assigned), but are actually controlled by the
application CPU instead. The RPM complains when we send requests for
resources that it can't control. Let's fix this by replacing the IDs,
with the default "-1" in which case no requests are sent.

See commit c497f9322af9 ("interconnect: qcom: msm8916: Remove rpm-ids
from non-RPM nodes") where this was done for msm8916.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/interconnect/qcom/msm8939.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index dfbec30ed149..20f31a1b4192 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -131,7 +131,7 @@ DEFINE_QNODE(mas_pcnoc_sdcc_1, MSM8939_MASTER_SDCC_1, 8, -1, -1, MSM8939_PNOC_IN
 DEFINE_QNODE(mas_pcnoc_sdcc_2, MSM8939_MASTER_SDCC_2, 8, -1, -1, MSM8939_PNOC_INT_1);
 DEFINE_QNODE(mas_qdss_bam, MSM8939_MASTER_QDSS_BAM, 8, -1, -1, MSM8939_SNOC_QDSS_INT);
 DEFINE_QNODE(mas_qdss_etr, MSM8939_MASTER_QDSS_ETR, 8, -1, -1, MSM8939_SNOC_QDSS_INT);
-DEFINE_QNODE(mas_snoc_cfg, MSM8939_MASTER_SNOC_CFG, 4, 20, -1, MSM8939_SLAVE_SRVC_SNOC);
+DEFINE_QNODE(mas_snoc_cfg, MSM8939_MASTER_SNOC_CFG, 4, -1, -1, MSM8939_SLAVE_SRVC_SNOC);
 DEFINE_QNODE(mas_spdm, MSM8939_MASTER_SPDM, 4, -1, -1, MSM8939_PNOC_MAS_0);
 DEFINE_QNODE(mas_tcu0, MSM8939_MASTER_TCU0, 16, -1, -1, MSM8939_SLAVE_EBI_CH0, MSM8939_BIMC_SNOC_MAS, MSM8939_SLAVE_AMPSS_L2);
 DEFINE_QNODE(mas_usb_hs1, MSM8939_MASTER_USB_HS1, 4, -1, -1, MSM8939_PNOC_MAS_1);
@@ -156,14 +156,14 @@ DEFINE_QNODE(pcnoc_snoc_mas, MSM8939_PNOC_SNOC_MAS, 8, 29, -1, MSM8939_PNOC_SNOC
 DEFINE_QNODE(pcnoc_snoc_slv, MSM8939_PNOC_SNOC_SLV, 8, -1, 45, MSM8939_SNOC_INT_0, MSM8939_SNOC_INT_BIMC, MSM8939_SNOC_INT_1);
 DEFINE_QNODE(qdss_int, MSM8939_SNOC_QDSS_INT, 8, -1, -1, MSM8939_SNOC_INT_0, MSM8939_SNOC_INT_BIMC);
 DEFINE_QNODE(slv_apps_l2, MSM8939_SLAVE_AMPSS_L2, 16, -1, -1, 0);
-DEFINE_QNODE(slv_apss, MSM8939_SLAVE_APSS, 4, -1, 20, 0);
+DEFINE_QNODE(slv_apss, MSM8939_SLAVE_APSS, 4, -1, -1, 0);
 DEFINE_QNODE(slv_audio, MSM8939_SLAVE_LPASS, 4, -1, -1, 0);
 DEFINE_QNODE(slv_bimc_cfg, MSM8939_SLAVE_BIMC_CFG, 4, -1, -1, 0);
 DEFINE_QNODE(slv_blsp_1, MSM8939_SLAVE_BLSP_1, 4, -1, -1, 0);
 DEFINE_QNODE(slv_boot_rom, MSM8939_SLAVE_BOOT_ROM, 4, -1, -1, 0);
 DEFINE_QNODE(slv_camera_cfg, MSM8939_SLAVE_CAMERA_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(slv_cats_0, MSM8939_SLAVE_CATS_128, 16, -1, 106, 0);
-DEFINE_QNODE(slv_cats_1, MSM8939_SLAVE_OCMEM_64, 8, -1, 107, 0);
+DEFINE_QNODE(slv_cats_0, MSM8939_SLAVE_CATS_128, 16, -1, -1, 0);
+DEFINE_QNODE(slv_cats_1, MSM8939_SLAVE_OCMEM_64, 8, -1, -1, 0);
 DEFINE_QNODE(slv_clk_ctl, MSM8939_SLAVE_CLK_CTL, 4, -1, -1, 0);
 DEFINE_QNODE(slv_crypto_0_cfg, MSM8939_SLAVE_CRYPTO_0_CFG, 4, -1, -1, 0);
 DEFINE_QNODE(slv_dehr_cfg, MSM8939_SLAVE_DEHR_CFG, 4, -1, -1, 0);
@@ -187,20 +187,20 @@ DEFINE_QNODE(slv_sdcc_2, MSM8939_SLAVE_SDCC_2, 4, -1, -1, 0);
 DEFINE_QNODE(slv_security, MSM8939_SLAVE_SECURITY, 4, -1, -1, 0);
 DEFINE_QNODE(slv_snoc_cfg, MSM8939_SLAVE_SNOC_CFG, 4, -1, -1, 0);
 DEFINE_QNODE(slv_spdm, MSM8939_SLAVE_SPDM, 4, -1, -1, 0);
-DEFINE_QNODE(slv_srvc_snoc, MSM8939_SLAVE_SRVC_SNOC, 8, -1, 29, 0);
+DEFINE_QNODE(slv_srvc_snoc, MSM8939_SLAVE_SRVC_SNOC, 8, -1, -1, 0);
 DEFINE_QNODE(slv_tcsr, MSM8939_SLAVE_TCSR, 4, -1, -1, 0);
 DEFINE_QNODE(slv_tlmm, MSM8939_SLAVE_TLMM, 4, -1, -1, 0);
 DEFINE_QNODE(slv_usb_hs1, MSM8939_SLAVE_USB_HS1, 4, -1, -1, 0);
 DEFINE_QNODE(slv_usb_hs2, MSM8939_SLAVE_USB_HS2, 4, -1, -1, 0);
 DEFINE_QNODE(slv_venus_cfg, MSM8939_SLAVE_VENUS_CFG, 4, -1, -1, 0);
-DEFINE_QNODE(snoc_bimc_0_mas, MSM8939_SNOC_BIMC_0_MAS, 16, 3, -1, MSM8939_SNOC_BIMC_0_SLV);
-DEFINE_QNODE(snoc_bimc_0_slv, MSM8939_SNOC_BIMC_0_SLV, 16, -1, 24, MSM8939_SLAVE_EBI_CH0);
+DEFINE_QNODE(snoc_bimc_0_mas, MSM8939_SNOC_BIMC_0_MAS, 16, -1, -1, MSM8939_SNOC_BIMC_0_SLV);
+DEFINE_QNODE(snoc_bimc_0_slv, MSM8939_SNOC_BIMC_0_SLV, 16, -1, -1, MSM8939_SLAVE_EBI_CH0);
 DEFINE_QNODE(snoc_bimc_1_mas, MSM8939_SNOC_BIMC_1_MAS, 16, 76, -1, MSM8939_SNOC_BIMC_1_SLV);
 DEFINE_QNODE(snoc_bimc_1_slv, MSM8939_SNOC_BIMC_1_SLV, 16, -1, 104, MSM8939_SLAVE_EBI_CH0);
 DEFINE_QNODE(snoc_bimc_2_mas, MSM8939_SNOC_BIMC_2_MAS, 16, -1, -1, MSM8939_SNOC_BIMC_2_SLV);
 DEFINE_QNODE(snoc_bimc_2_slv, MSM8939_SNOC_BIMC_2_SLV, 16, -1, -1, MSM8939_SLAVE_EBI_CH0);
 DEFINE_QNODE(snoc_int_0, MSM8939_SNOC_INT_0, 8, 99, 130, MSM8939_SLAVE_QDSS_STM, MSM8939_SLAVE_IMEM, MSM8939_SNOC_PNOC_MAS);
-DEFINE_QNODE(snoc_int_1, MSM8939_SNOC_INT_1, 8, 100, 131, MSM8939_SLAVE_APSS, MSM8939_SLAVE_CATS_128, MSM8939_SLAVE_OCMEM_64);
+DEFINE_QNODE(snoc_int_1, MSM8939_SNOC_INT_1, 8, -1, -1, MSM8939_SLAVE_APSS, MSM8939_SLAVE_CATS_128, MSM8939_SLAVE_OCMEM_64);
 DEFINE_QNODE(snoc_int_bimc, MSM8939_SNOC_INT_BIMC, 8, 101, 132, MSM8939_SNOC_BIMC_1_MAS);
 DEFINE_QNODE(snoc_pcnoc_mas, MSM8939_SNOC_PNOC_MAS, 8, -1, -1, MSM8939_SNOC_PNOC_SLV);
 DEFINE_QNODE(snoc_pcnoc_slv, MSM8939_SNOC_PNOC_SLV, 8, -1, -1, MSM8939_PNOC_INT_0);
-- 
2.17.1

