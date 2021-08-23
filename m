Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B03F4620
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhHWHy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 03:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhHWHy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 03:54:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6BC061756
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:54:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m17so2602027plc.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P2vk1dPujyHe2bA8wdfK7wJXlS4mwNbr7mrDNm9VQV8=;
        b=dUuW965dWK7Gm+redpLnqPY9wdCCtIQCQnz4YRdFgSqtLLS23ZcQ2y6D2FTNqPKcLZ
         IM7RBCjsw8iGv2CdKPthaBP+LMnYNfzP3A3LGuHsvL4sSkljIr/ACBJsqG1s29qkOBaZ
         Oz+dIe8WZ21Eh7qhZNEroFEF6L1+KVl5yGAi69pYka0ReMAc8eF9C2l4oaChltyo0TgA
         1+Ia7bfHVTD7JzNYZRmWT6lYM3ojl2gpYC0/E944nK4aoA39tZf8TMh9zS0siGTCMmI5
         6E+7w0Stjs3gNVpqI0dI3+pyhWazIot3OqksmQz66bZwHPYDe6ww6VA8WyBW2budw0NW
         rPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P2vk1dPujyHe2bA8wdfK7wJXlS4mwNbr7mrDNm9VQV8=;
        b=fFAfzXbe/I14PqBDveb3V9zrBuGbvL05CWKqOVT88OiUQvlTr3a4F5O23hBkPzfQxV
         7abJBr1cZhdM83qadvOk8cE5bWlBkBf139knFa7BoRnrZ1Wt/sjNi8NwCvQbTtUUoGpd
         WZCZezg29ShNTgWh5RjoekOurwh2NNzrzJ+y4PVq87YsXYiX4Y4gAabTL1t0LpC7Ci7U
         0UXKrAHxHcPp9+wLFvYTg4exWOetUJ16L+6RI3U9TJoqc5QMAIue6bS7QV+DuOHKa0vV
         yVfbDu4SJbgjsS6AYsmrUC/Q+Y7CPaTqaDjt9mu8NcB9ZXWNGZhMdpWPilT9T71mnIjg
         82aA==
X-Gm-Message-State: AOAM530bWl86L8J1Lh9UJdjdgz0JF3ckHJLLMRGzsnTnbnLjj7Qn2JFy
        JHOs/Fnt58KbwIQm+CzYriqjpw==
X-Google-Smtp-Source: ABdhPJxOx6Me2c5i80oP8llIoKFi+Y/W6XvJbvtM9bIhbsGNP32rdqwEFSNXPZCfsrVLPcXHqYvZ7A==
X-Received: by 2002:a17:902:7585:b0:135:2585:e261 with SMTP id j5-20020a170902758500b001352585e261mr1309187pll.21.1629705255690;
        Mon, 23 Aug 2021 00:54:15 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p17sm18587793pjg.54.2021.08.23.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:54:15 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY shift and mask
Date:   Mon, 23 Aug 2021 15:54:05 +0800
Message-Id: <20210823075405.382-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NOC_QOS_PRIORITY shift and mask do not match what vendor kernel
defines [1].  Correct them per vendor kernel.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/msm_bus/msm_bus_noc_adhoc.c?h=LA.UM.8.2.r1-04800-sdm660.0#n37

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index ac13046537e8..c89c991a80a0 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -44,9 +44,10 @@
 #define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
 
 #define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
-#define NOC_QOS_PRIORITY_MASK		0xf
+#define NOC_QOS_PRIORITY_P1_MASK	0xc
+#define NOC_QOS_PRIORITY_P0_MASK	0x3
 #define NOC_QOS_PRIORITY_P1_SHIFT	0x2
-#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
+#define NOC_QOS_PRIORITY_P0_SHIFT	0x0
 
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
@@ -624,13 +625,13 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
 	/* Must be updated one at a time, P1 first, P0 last */
 	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
 	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
-				NOC_QOS_PRIORITY_MASK, val);
+				NOC_QOS_PRIORITY_P1_MASK, val);
 	if (rc)
 		return rc;
 
 	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
 	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
-				  NOC_QOS_PRIORITY_MASK, val);
+				  NOC_QOS_PRIORITY_P0_MASK, val);
 }
 
 static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
-- 
2.17.1

