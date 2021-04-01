Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1A3512A1
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDAJpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 05:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhDAJoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 05:44:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78378C06178A
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 02:44:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so3584243wma.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtEhDbltiZ/OfVBpz9Jx7SA1IxogX1Jkk6XPFN266w4=;
        b=VuepqFNDknWsdsL8lo/vf2lSR512hGTBYSdoU5t0A6DSJvyG4Pw9msoJZXW/2LyoEL
         NAElHsNx+E9N5RoRn9IRDxcsrKMsPkNV0KhxPf4/TnOs0sxZJtr6IF5p97Kn9XlaND6o
         XVm7znnNS3WaRY51FkU6YcNU18O9UjcOLwBzYmVQPDeug6bZp8sjEWRC1h9WnJ7AFJu8
         ZxThnyLYAa9R6OoGlWwoThnrpOhBJtz5CeW+K28Wzr1jHzBxLFef0bq4/SH0RN2GgB1i
         BucXYCruIkt5PHe3U0rZnyCvi7AXWcrz3U5LuQ2GplCYhTZHY3cRVn4IAADiLXrQHPdg
         L45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtEhDbltiZ/OfVBpz9Jx7SA1IxogX1Jkk6XPFN266w4=;
        b=kChDCFJt2al84H6bde1yQN3tuntkZakGvVGuiKJchz5xiwQcxvdG927fUg+m+Pm7zI
         CoDj8DHmdJAUdbmtkzwSWXLcIA7uy0g3Q4yxWo1CjAFNmctHe+Sw6wHTQibjaBqTV0dL
         spNCR/xULVBxItfkfD8Be1gto1IzCYIPwC+aBgtz+MgymhvDCPnbLAC6Vz7Lv033VxTU
         7wpUMTHYblvMJI0A/WRhqJpjk8qZ07q3siHJy2GfBu6pi1Oom3nq9ec8qSRtYpmSrJa/
         isBG1bUjGxBlQUNxadWNz0Eqvtadz4px/7Ng/943eWK5YBOqDK0nptc9aEJmoqG2Xynf
         AXhQ==
X-Gm-Message-State: AOAM533km3NyIpwk7uDyiroWsaCf1Te9wv7Ws9WKVPZyMJ/TsBCWR2Jy
        XirZmv2ZVAXSj3rBwFpQQZXYdA==
X-Google-Smtp-Source: ABdhPJwgCKB8DBoGW8iKnUqTZqgN7lbQehMMzlrJKID29AbwEiVBBJiDJ9zDGQbAacz404TXesZ3tQ==
X-Received: by 2002:a1c:b002:: with SMTP id z2mr7191659wme.121.1617270276227;
        Thu, 01 Apr 2021 02:44:36 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u4sm8921234wrm.24.2021.04.01.02.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:44:35 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     djakov@kernel.org, vkoul@kernel.org, elder@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: sm8350: Add missing link between nodes
Date:   Thu,  1 Apr 2021 12:44:35 +0300
Message-Id: <20210401094435.28937-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a link between the GEM NoC and C NoC nodes, which is currently
missing from the topology. Let's add it to allow consumers request paths
that use this link.

Reported-by: Alex Elder <elder@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 01202989a5b2..579b6ce8e046 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -139,7 +139,7 @@ DEFINE_QNODE(qhs_llcc, SM8350_SLAVE_LLCC_CFG, 1, 4);
 DEFINE_QNODE(qns_gemnoc, SM8350_SLAVE_GEM_NOC_CFG, 1, 4);
 DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8350_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
 DEFINE_QNODE(qhs_modem_ms_mpu_cfg, SM8350_SLAVE_MCDMA_MS_MPU_CFG, 1, 4);
-DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16);
+DEFINE_QNODE(qns_gem_noc_cnoc, SM8350_SLAVE_GEM_NOC_CNOC, 1, 16, SM8350_MASTER_GEM_NOC_CNOC);
 DEFINE_QNODE(qns_llcc, SM8350_SLAVE_LLCC, 4, 16, SM8350_MASTER_LLCC);
 DEFINE_QNODE(qns_pcie, SM8350_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8);
 DEFINE_QNODE(srvc_even_gemnoc, SM8350_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
