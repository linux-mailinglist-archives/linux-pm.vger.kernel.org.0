Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27C522AAC9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGWIhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGWIhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 04:37:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4DC0619E2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so4319212wrl.4
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FsnuFGDVv4psbzCMdUgLWW9kRE3eTQu9xp4X3h9oaFY=;
        b=Fk35wGEnjwq6EBu8VQPDLzPRCiOJHdN3EeqYfHB68aXvg5EbEis3sIMi4yxjthJxEp
         EWf0NBo+Znqi0dwwpTvH6eA85ghs+StgkSwlu6Qp1aoaJOTJnr3Qmhr121yK4Z17j6iI
         +GlCK64b78nUZ2aSUl+AFHRMIs/Tfsz+wQBYAfBGUyJiXVpE0i7m9mTh2u0OXY70c2mj
         FVYcyMHOTL4vFMqwWLLVA/RflRDJgZGBXp3dlkdtnOPLwBhfXooCk3E9cngI0OHPhJGT
         qg+7u0ui7gcdWGMWaSpzzpayf4N0Dq3q7OZRBzgX49Qy1PqfFvPYDH1Ojmwwfw8YS+DK
         lfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FsnuFGDVv4psbzCMdUgLWW9kRE3eTQu9xp4X3h9oaFY=;
        b=pMSHrpiPGITH2PvduErm/6f8cGShd+0u6kB0geUmvMuGamvRTTyWqr/7jUPSP4fCgr
         EdZlyhpdoS7RaXrddxEuVJcbNpjLa24SB4Apd6sFTsPlZBBhAB8fDW7YXNX435Jsp1kP
         nk86TBKkpvqqCW9bnbrs8LHX4dG8n//ugO/aiiWpN5vJaMgcFKQ4T7kMScMk17lf/XxH
         42eF/w451ssQdxWBuS9OSI3Y3En/mIV4jp4WsH4aTz/4Mcwm4Qoeh3rxBooWVnyWtdIE
         D/igmlIVo4cRIowYdmvDhK/Q4D9u7kHzNqCvB640QBxXc7Y5UQF/ziKvcr0kGRZ34zZj
         H3KQ==
X-Gm-Message-State: AOAM533fJgJMYPuIjTTuqO5U3gd6lCNXVZPLC24AsThVckmy662SM60h
        5NVCOtVdPp5HEgN++GUsE1QB4gRNGFE=
X-Google-Smtp-Source: ABdhPJzKn3ACYZScxU5ip96Xth5sdO8Dw4NeLV6xvdeJfoqBzUvJABpgi4BG0pgJ11sdybPSWBzC+w==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr2920636wrq.238.1595493458933;
        Thu, 23 Jul 2020 01:37:38 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h11sm3105039wrb.68.2020.07.23.01.37.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 01:37:38 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 2/2] interconnect: msm8916: Fix buswidth of pcnoc_s nodes
Date:   Thu, 23 Jul 2020 11:37:35 +0300
Message-Id: <20200723083735.5616-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723083735.5616-1-georgi.djakov@linaro.org>
References: <20200723083735.5616-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The buswidth of the pcnoc_s_* nodes is actually not 8, but
4 bytes. Let's fix it.

Reported-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Mike Tipton <mdtipton@codeaurora.org>
Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Link: https://lore.kernel.org/r/20200709130004.12462-1-georgi.djakov@linaro.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index e94f3c5228b7..42c6c5581662 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -197,13 +197,13 @@ DEFINE_QNODE(pcnoc_int_0, MSM8916_PNOC_INT_0, 8, -1, -1, MSM8916_PNOC_SNOC_MAS,
 DEFINE_QNODE(pcnoc_int_1, MSM8916_PNOC_INT_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
 DEFINE_QNODE(pcnoc_m_0, MSM8916_PNOC_MAS_0, 8, -1, -1, MSM8916_PNOC_INT_0);
 DEFINE_QNODE(pcnoc_m_1, MSM8916_PNOC_MAS_1, 8, -1, -1, MSM8916_PNOC_SNOC_MAS);
-DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 8, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
-DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 8, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
-DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 8, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
-DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 8, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
-DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 8, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
-DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 8, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
-DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 8, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
+DEFINE_QNODE(pcnoc_s_0, MSM8916_PNOC_SLV_0, 4, -1, -1, MSM8916_SLAVE_CLK_CTL, MSM8916_SLAVE_TLMM, MSM8916_SLAVE_TCSR, MSM8916_SLAVE_SECURITY, MSM8916_SLAVE_MSS);
+DEFINE_QNODE(pcnoc_s_1, MSM8916_PNOC_SLV_1, 4, -1, -1, MSM8916_SLAVE_IMEM_CFG, MSM8916_SLAVE_CRYPTO_0_CFG, MSM8916_SLAVE_MSG_RAM, MSM8916_SLAVE_PDM, MSM8916_SLAVE_PRNG);
+DEFINE_QNODE(pcnoc_s_2, MSM8916_PNOC_SLV_2, 4, -1, -1, MSM8916_SLAVE_SPDM, MSM8916_SLAVE_BOOT_ROM, MSM8916_SLAVE_BIMC_CFG, MSM8916_SLAVE_PNOC_CFG, MSM8916_SLAVE_PMIC_ARB);
+DEFINE_QNODE(pcnoc_s_3, MSM8916_PNOC_SLV_3, 4, -1, -1, MSM8916_SLAVE_MPM, MSM8916_SLAVE_SNOC_CFG, MSM8916_SLAVE_RBCPR_CFG, MSM8916_SLAVE_QDSS_CFG, MSM8916_SLAVE_DEHR_CFG);
+DEFINE_QNODE(pcnoc_s_4, MSM8916_PNOC_SLV_4, 4, -1, -1, MSM8916_SLAVE_VENUS_CFG, MSM8916_SLAVE_CAMERA_CFG, MSM8916_SLAVE_DISPLAY_CFG);
+DEFINE_QNODE(pcnoc_s_8, MSM8916_PNOC_SLV_8, 4, -1, -1, MSM8916_SLAVE_USB_HS, MSM8916_SLAVE_SDCC_1, MSM8916_SLAVE_BLSP_1);
+DEFINE_QNODE(pcnoc_s_9, MSM8916_PNOC_SLV_9, 4, -1, -1, MSM8916_SLAVE_SDCC_2, MSM8916_SLAVE_LPASS, MSM8916_SLAVE_GRAPHICS_3D_CFG);
 DEFINE_QNODE(pcnoc_snoc_mas, MSM8916_PNOC_SNOC_MAS, 8, 29, -1, MSM8916_PNOC_SNOC_SLV);
 DEFINE_QNODE(pcnoc_snoc_slv, MSM8916_PNOC_SNOC_SLV, 8, -1, 45, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC, MSM8916_SNOC_INT_1);
 DEFINE_QNODE(qdss_int, MSM8916_SNOC_QDSS_INT, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_BIMC);
