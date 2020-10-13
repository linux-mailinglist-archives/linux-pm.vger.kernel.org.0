Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5728CFA7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgJMN7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbgJMN7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 09:59:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88821C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so24206359wrq.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bxQjF8JFA6Asp2x5Qy6bOVvEknWT2jmgAadI+Foe/4=;
        b=UHFX6ogsO9YEIpG7gnor6Jqroymz8ZdFMfwBgY/YnjRGDWk0Pegm37VyPl2TgQF5kH
         vj92LXD9MWFC9LoKlOn7V4+8rkWsBTmKCmznAkmSPV3OUi6bCeSKhnRT9a6QuXnPZeAW
         78F/hDYd4oNUQ7IZYHKvywWP0tx0xrtnRkJp3bChNvTbz2ijfnaNWSmK8Y231P90Ya7h
         Mnh7Y3mkorQ3UZ/KstidY7o0MLC2jaLpT38dGooda1B6XEz00X+NDIJOIH5CpIlJjnku
         3mWCTkdgtru9x58w/kJNfIfozrbntdYPaL/PpP14Rj8ACE676wMRiKQMKdJOHX1sPgwb
         uQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bxQjF8JFA6Asp2x5Qy6bOVvEknWT2jmgAadI+Foe/4=;
        b=npibwHKE2WmFMCW+NMnho5zWPHrrQzxCsUGPPm020LgscYecqhFrVywHP2vcUxMc0F
         9bL3ryH5J3F65ruyasonMAeF5cvgx9zvVN8a8JgG/ad7rtT0nBtSy+5Bjn0Hmwuk42JZ
         LneLHOjvbQ2U+/q3ToHCAUJXsQtZHU9NKUtFSQ4wrFP+6kQPRrxk/gbICNeh455Eh5+N
         sfbuT7sI4pyETucsA6/Xf4/44ebEIlZm93IZ68cQccGjKQvyI0/KMOBd3bOFU+NO1Rsx
         GKlaNMdnn9nH8RTAQ7ACapitK0GBgfE36KkR9UqjU07/ay6LkTKe+2HzMdftFUZfHKCa
         8Eug==
X-Gm-Message-State: AOAM53391+cv9Nc4gh9w/CsEaCi/Tzk25tt9qAvQXvQ0gpYwn4pyFRFq
        bZ66dcxFNrYnY2s7E8pnbGvFUhZRQ5duyQ==
X-Google-Smtp-Source: ABdhPJySAnjh+044UzGZPOEf9/B71RqNokP2SUMBpwVEdgmbgwgSwLsXYJa+QYU6CxndkNvBNPltTQ==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr34581095wrb.378.1602597554919;
        Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a199sm17785wmd.8.2020.10.13.06.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 3/3] interconnect: qcom: sc7180: Init BCMs before creating the nodes
Date:   Tue, 13 Oct 2020 16:59:13 +0300
Message-Id: <20201013135913.29059-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013135913.29059-1-georgi.djakov@linaro.org>
References: <20201013135913.29059-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently if we use sync_state, by default the bandwidth is maxed out,
but in order to set this in hardware, the BCMs (Bus Clock Managers) need
to be initialized first. Move the BCM initialization before creating the
nodes to fix this.

Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index bf11b82ed55c..8d9044ed18ab 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -553,6 +553,9 @@ static int qnoc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -576,9 +579,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
 	platform_set_drvdata(pdev, qp);
 
 	return 0;
