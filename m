Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF72C81F8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 11:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgK3KSr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 05:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgK3KSr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 05:18:47 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5373C0613D3
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 02:18:06 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so15377044wrt.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xH7vKwH75HQqDx86IPkYSGMZHwM3mrlZlWhRbG+87CQ=;
        b=N3svmperiaqvbJV6FavHC8Mhwdny4JUatn5EMlCXuafLWAwx+evti/oLhbQm4Yi8pR
         p8gkhAukBsT5IMdq15tLEcAG49wfdXszuQDPAJzSPR1sj9aEL01uoG8Sju/iJfEuGaMz
         5U0oSHtLLmm1Ec54Gd/PflqR28XwtlUvw+Bg+w+8MSVtEa0X5kJ+Tmi1auYo7bKeLGDr
         vXjYlFcTV5hzKB8yZlNT9ykvxffQ6uNoeRXb/Z4SLQr0FV8IH6uNVyRLh0mPzM/tFtGR
         j1K/T7FSUsxTVEgIcMayCPeRknu2cNtE/oR2w98lfguav/s57qXUWJACkuF9eMroDoJ1
         cKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xH7vKwH75HQqDx86IPkYSGMZHwM3mrlZlWhRbG+87CQ=;
        b=VOT/5cvglCSJX1T5cVcHOjQpxfPOaghxgr+DNMjvxaGefmUktM7JgWpGZd6zvS+mes
         U9zqGbXuHD6x545VR+L95IXVK+MbEo4sk5AZQi4RG162I6ye3JNqbEFlfX437YzTJJRo
         Rj9Dm8A613Ky17O9yS5dmugjiDXC2SfR6v3p7v6WkI06cZVVj1pCaeIoLc9eGIZNbKYq
         ojX5E5Hvxm3Lwu4y+RqdNy7lx4rY4RSdcrlKaHcF+pDpNoWvCs7sFSBbVXs4PekknTJZ
         cNxQPHsfSRHviyCWxkkGuuXLshEeUNNuycqQdSnUDuvTZkd33e+6zVIh9U7RZWtcKsJM
         O56A==
X-Gm-Message-State: AOAM531mbiro4D1wx5r2EKsNLx1Dwe49SCTvyU6ma4krsa/06DiNGfXu
        ysQ5+8jufqS3t5WMcFSUaeOByw==
X-Google-Smtp-Source: ABdhPJxUNYEOhK0O6gGMmBtoyWg32TgxkmM6YEBt/x1eXrX47R9T0/Ya6bhpTmRYzOBDkzeQQ4xdEg==
X-Received: by 2002:adf:f0c3:: with SMTP id x3mr19495602wro.327.1606731485408;
        Mon, 30 Nov 2020 02:18:05 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c187sm26314234wmd.23.2020.11.30.02.18.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 02:18:04 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     kholk11@gmail.com
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/2] interconnect: qcom: sdm660: Fix the kerneldoc for qcom_icc_provider
Date:   Mon, 30 Nov 2020 12:18:07 +0200
Message-Id: <20201130101808.26472-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following warning by documenting the regmap field:

sdm660.c:191: warning: Function parameter or member 'regmap' not
	described in 'qcom_icc_provider'

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 6953d6d99a11..dbcfc8f15738 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -179,6 +179,7 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @is_bimc_node: indicates whether to use bimc specific setting
+ * @regmap: regmap for accessing the QoS registers
  * @mmio: NoC base iospace
  */
 struct qcom_icc_provider {
