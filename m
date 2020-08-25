Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D203251DBE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHYRCV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHYRCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 13:02:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BFC0613ED
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so3204622wme.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QV/ePTGwly0PbuCxUdBYC9fwASHXwx8pOAXdY4hkxSk=;
        b=w6fLWxnzdnmnnXwVZMk3NMnzMDQI/s5/Sd0s5QnL7uZt4yk9BbTM0UauO2iHQMPchX
         j1YQGKFqB72CTy7+YBK1ukBydPhtP2nsnOAR61T8QnnqTC2PFdJQKXmLRU+LkNx09bgM
         fwxpVU5bekWJsrlGboysgLFzprUsXKUw8aibKC/p2qghW8jgZvjdXojcD78t1FbKyn2B
         7rDSkydZejaaedVnlDmp4sSrZL15YRLFdRu6KuEs2w4kXU4THMAkZIxtiX2P3mA1f1GL
         /Ka64J+Ytz1TY5wY9IXLKCm0b92iKlQCZtyMCQnH1rl77Ce7foZ12BaRClKuQq+5zPhg
         29yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QV/ePTGwly0PbuCxUdBYC9fwASHXwx8pOAXdY4hkxSk=;
        b=Nle8+nKfS1HUnuSm2qBAhiOsQdpZbnu4X1UWEdcbJYbgLqI3l1IUmF+qW/Xftgiaov
         B5xAYk+Zt3Pvif5DRsZvQKMOci1YCfWkP0wk2v+hFvtQilL1NQdwu/oCMruV5vfk6M5h
         HxoGvSATAyPR0xyRV88jVu9t8+SKt7MabtEpAAo80pGu2ovQeMsyLvYzaKZeWb8p4Y2F
         TgDo9EzTgXcCpaLIh93rp2c6jYf/rAo4tLKUVqrUXgADMepZXtKDyvqtsnMErWT+/iBz
         XqCHs4visn221ueNAzZOuNlQu8zX9i/NtFkN3fY9jBAKLJWZaRXaRWIwElWZgj0NxzJE
         13/w==
X-Gm-Message-State: AOAM533o6UkqJ4VGynxMcd7ob1Dsd6Spft2WfsSAGQdbYhHXLniZRNiS
        m+N33GM2YwWJS0/xKiTLiitVtLd0qkZocA==
X-Google-Smtp-Source: ABdhPJz6SGQKUWpezGmwk3pInh4KEjtCXIoaZSTSgkQZZ9UzMSysDbUPGFWDWLXvfkWmLwVT/oXtDA==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr2926290wmh.39.1598374917760;
        Tue, 25 Aug 2020 10:01:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] interconnect: qcom: Use icc_sync_state
Date:   Tue, 25 Aug 2020 20:01:52 +0300
Message-Id: <20200825170152.6434-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lowering the bandwidth on the bus might have negative consequences if
it's done before all consumers had a chance to cast their vote. Now by
default the framework sets the bandwidth to maximum during boot. We need
to use the icc_sync_state callback to notify the framework when all
consumers are probed and there is no need to keep the bandwidth set to
maximum anymore.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 1 +
 drivers/interconnect/qcom/sc7180.c | 1 +
 drivers/interconnect/qcom/sdm845.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 96fb9ff5ff2e..ae955f164442 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -268,6 +268,7 @@ static struct platform_driver osm_l3_driver = {
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(osm_l3_driver);
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index dcf493d07928..4c5d38649220 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -633,6 +633,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sc7180",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..6aa39aad2555 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -559,6 +559,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
