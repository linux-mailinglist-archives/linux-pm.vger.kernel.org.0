Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3B295049
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444302AbgJUP7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444293AbgJUP7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 11:59:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EAC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 08:59:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i1so3776531wro.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctjUV/qDzuMk+99Zc1qceboDHYtb3OZdKyaQ+fU3OVg=;
        b=V2K64qCtTgV8FUgCG4h32MU/PMEDUom+DqEluPXdvc+C5bRsP2g/ezqF1IsksWDmIS
         aHK7H4cJcC6MNJLz7dmjZbhqDhedvLHwXAWKy4l1BPrUQVcoLEx4f6lEacNcdJfYQUVi
         grwut/0Vhll0dnz3WNXmQFHHYClIsrPZycBp5koAx/0OGFecQX6L6jCH4DeV/9H1j8vc
         sm2/pvBwWK9eqqa4Jy0baKN1Wd1a5+sSkNHiJzmrQF3lSVuPBJOM5j/svWSbi4yLy/3F
         FUZgwWcFWw4lUdrqHlv0oBpkkzDqsKJMS1fzFeq7woPTXapF7p6dVc4FQH9Uh6i28ylV
         0CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctjUV/qDzuMk+99Zc1qceboDHYtb3OZdKyaQ+fU3OVg=;
        b=Ta/4+2IhFgEtUSGRJWil7vp78Kf+4sa9ossPvSB2YV72RD0akfPXVjGaLZ/ZJlWuut
         8Wt9yhDP07j1hUWlpNIm24dKjBsXquIhRDYx1IM/XMZLQO377YTq55+cSRY+zAnKLSco
         Ix4BQSdxlVAiQ3/jGlPKohsLOwT+4sa5fJUwEEvbcINRadBYpRPOixUGf9D7i1jtn+Pr
         7l2LUHAGc+CjFz9tGYzz4sDrYpakgcQyi7FcYi0IQSd3spl+olU3HWiE0dhysTdmG3op
         P6pdas9ad8yp2AQDbyMDTThUuk8Q5x87+AeUZa33MdvDOdyd1bbthn+1MH/pEyXvYMH/
         Lepw==
X-Gm-Message-State: AOAM530k8qytFXeZEqUN20AkBI6OC6Sd5D4AFOrhWK7BgZ+sxC5P4gU5
        xRMyoLImeJN6frT4JNnlxplGWC9gXTxx+A==
X-Google-Smtp-Source: ABdhPJzNeqpfZ9Z5/doYrUWxZ6Y/WBmCmbimWFc1mEb+N2LkVgz3WH5jS5Bk///p9yyi/huPjiIlPg==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr5545597wrt.221.1603295980283;
        Wed, 21 Oct 2020 08:59:40 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j13sm4617571wru.86.2020.10.21.08.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 08:59:39 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     akashast@codeaurora.org, mdtipton@codeaurora.org,
        saravanak@google.com, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: Ensure that the floor bandwidth value is enforced
Date:   Wed, 21 Oct 2020 18:59:38 +0300
Message-Id: <20201021155938.9223-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Take into account the initial bandwidth from the framework and update
the internal sum and max values before committing if needed. This will
ensure that the floor bandwidth values are enforced until the providers
get into sync state.

Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index cf10a4b9611b..bf01d09dba6c 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
 	struct icc_node *node;
 
 	if (!src)
@@ -87,6 +88,12 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		node = src;
 
 	qp = to_qcom_provider(node->provider);
+	qn = node->data;
+
+	qn->sum_avg[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->sum_avg[QCOM_ICC_BUCKET_AMC],
+						 node->avg_bw);
+	qn->max_peak[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->max_peak[QCOM_ICC_BUCKET_AMC],
+						  node->peak_bw);
 
 	qcom_icc_bcm_voter_commit(qp->voter);
 
