Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB36A3512AE
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 11:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhDAJrs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 05:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhDAJrQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 05:47:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD2C061788
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 02:47:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so1197789wrn.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBdvQRxeQcCFQu8Y2aYQXu7K8mkdOhCuVP0CWMq+2PY=;
        b=xGieC0rx7WEt2fZZY9crPoQQXeT446be2DItwPNmUVKhVRCKKT0esJ5MIuooOgr7HY
         5yZuXnBE6ENdYH3ePPeY26ERjXqzWspYqLAK1sSe3rW7laQId2dgE0LCzevq32wQ6WO/
         U4EBEFk17RddsenBRPDaEba7v6Zy60O5CeW+qHWFRWc31o/S3jKJ2pHH6XU61G07h0yw
         qcTufd+VyDGCJD3sK9dTtazGPb8JWPI5urCua3uwJVarRc06I8vSCvnAZNulkUTii9AX
         f+dgTfzm1JfZWUupXo6PaN8/95opq5sqdM/1kqvVP1SJ2kbzssLf54nMpvZfQ9V/5Ktb
         FdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBdvQRxeQcCFQu8Y2aYQXu7K8mkdOhCuVP0CWMq+2PY=;
        b=Q9RTpT8xkDIma9WJgbp9BQljLexab0Y2GI7QIhCwqOdZrFqzxweC7RddXjD1fUGc/D
         +eZej+Gb7258o8jPpoy5PbuZvfHDKRkUHBlzjGPPbT2fiyraD4la3lwZHIxBYINbk8x+
         QbU/hPGh4SPA+jFM2zIiOp/dgTw+RYIBnokfshYSBwPXTvvASFuqxFMJa3m8p49EDHgv
         IjxMTLX9IsgEe4gKLRInWA9XfdodkK8vAlUIp/GaW/bPyyUH6BkCYhIPZoKhUr42+k+4
         R0WWGBFz+dpMgAkuJJSj8gnbsXxxJTKJ/rRq76E748rBlpvu6QAlNELDCbIIyY3qLN1Q
         KkLQ==
X-Gm-Message-State: AOAM530THy75gacgHI4UpR+VyCNQOZxJOW5FqCtWBK5TINZ8XoO99vSZ
        iPw3cptUmOrZe1gKbTvCp06Y9Q==
X-Google-Smtp-Source: ABdhPJxvseZmlo5VRBRusKDc09vi3eD7/8hICGIS2Mlu/tsI8I6KMx0/3xDdMDZQKHN68V/GbccX8w==
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr8534120wrg.271.1617270435090;
        Thu, 01 Apr 2021 02:47:15 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j14sm8695352wrw.69.2021.04.01.02.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:47:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: sdm660: Fix kerneldoc warning
Date:   Thu,  1 Apr 2021 12:47:14 +0300
Message-Id: <20210401094714.29075-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following warning:

sdm660.c:191:warning: Function parameter or member 'regmap'
	not described in 'qcom_icc_provider'

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 6953d6d99a11..632dbdd21915 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -179,6 +179,7 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @is_bimc_node: indicates whether to use bimc specific setting
+ * @regmap: regmap for QoS registers read/write access
  * @mmio: NoC base iospace
  */
 struct qcom_icc_provider {
