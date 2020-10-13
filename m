Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4449828CFA8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgJMN7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbgJMN7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 09:59:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45740C0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so56234wmq.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bDJucZgJh5FF2qZq2dSXU5O6ciFzNhYy3NAEbiOW5U=;
        b=FYwrlQmKtFjItcjW6NkFA6usPpaoxqkvxN79cTvEqLVez2ARTv8noXL+aHKz9UF49Z
         yVXpMQ89CRyszsM4HeQ8CSiosmbuBKpjt0ILH+VmI+6+Umkf7ONAeQy+u3Xssg3oV9MM
         GmmHDplpH3S3q3zVshgXn5CD5HFk2UBehaCr8EeMGdI4NlsHu6/AE2j08dIwmK9WgY7v
         /7u/DY3dMA71zueWe76a1so59dbBTs3ApoT9oIYbcXPxWFzSwCygQcgV7D/V3RlOTI90
         VPKw5NxJKEi5cqGslb9JoN6KvpqOWf2TRBZ7x6fed4Ukp+2xey6DZU+MkZVUU5eKBxtM
         GmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bDJucZgJh5FF2qZq2dSXU5O6ciFzNhYy3NAEbiOW5U=;
        b=ZK9OE9z/0ItOhNnGmENTwYPmBwo/lrCT4ntpwXrjMJUGl3lmXqReYMCopdpSWsXVR7
         j2MpDFFmME2u6nSdDDWEfgZVgOsNXFK+eH0ujGE1KH/NXbb0zLoxcumtTX6vDfW7108K
         pxQJKM8Gw5df/6gEcuI+vzVNj9jfDmTC21GnkfKwc4f8xj+TsQtrwxhkFfnmtb3xxAfm
         iYzPVWwKbRCeooXNlNXNEmBm+nTPSV0a25E5yWlnB80+Mj2U5UQ4LvaS/ejsSexKkBjQ
         f0rMc7Ndkm1WsacdOilv48TQGNVsc0Mok871fh7DaHPmiQ9EvgVZiTety9kTAD+ad2wr
         lKlA==
X-Gm-Message-State: AOAM533uqeNclSdBx2Pmnn6Zdbk9N5z9fk6KwJr+jUMjHCitGBdElah8
        O3DJC6qSrRzr7p2Rh3MQrntuZnj/qp58eg==
X-Google-Smtp-Source: ABdhPJyTqWE1iekyZsDPD0wv7UkeTZYONKeacFueCiZ9ySbqbFfs8FIbdlS+AoqntIL9/dCNMWdhWg==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr78968wmk.88.1602597553753;
        Tue, 13 Oct 2020 06:59:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a199sm17785wmd.8.2020.10.13.06.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:59:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 2/3] interconnect: qcom: sdm845: Init BCMs before creating the nodes
Date:   Tue, 13 Oct 2020 16:59:12 +0300
Message-Id: <20201013135913.29059-2-georgi.djakov@linaro.org>
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
 drivers/interconnect/qcom/sdm845.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index d79e3163e2c3..47556dc12ec0 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -489,6 +489,9 @@ static int qnoc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -512,9 +515,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
 	platform_set_drvdata(pdev, qp);
 
 	return 0;
