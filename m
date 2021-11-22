Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D280458AC7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhKVIyn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 03:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbhKVIym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 03:54:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D2C061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r130so15464520pfc.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 00:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrS5M6DytZl+EPmdclSiBMyMOC/Af23DduwHTH7/9D0=;
        b=hV8vJ5Hhqe9f7G0mHN4gVdSc0X+ojLVAqcD0F4B7pY40g4acbTPLZgBKRjUdzSXpDd
         f2c+MOaqaBadtc1VZSqaBemAtOZUSZIPf6kKQ8nNWTXdbj0zY5opkd2szs/EbvJTrI9A
         lDGz4524IKwFllJWYzAjVH5d+ymmYbEcQqplndN0qlbNrUrQfjXi1Qrkh/sFFl6HZZO/
         MVULtLcsTpEIXRqC5YnNP0wN+Mqu0mxY1idiKVjz81qTIMIh+Vfy1DcCpwjKawhuOu0U
         h8+WIrfvGIUtN/b6P8ZzBz6pwG+XoMUDLQWs72Alw8yHYhdOmeiSGCaHctyoCnhFTvAP
         Zsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrS5M6DytZl+EPmdclSiBMyMOC/Af23DduwHTH7/9D0=;
        b=Jpe3nuNuPrTciguj/xVvDgstE1v9LJpgJx+plZbrs87E0koLi+stwSGu5xLjOO9U3k
         Ch0s4XOsRU7he/x6jUzuWB0PoJf9h1KKOq1s/U9j8m00GX4DZ+QpuYzkJCV/y7SVYND2
         Du+XwyMd2wu4lDnxmGL9I5nmYC3V0BmWUBdPvZXpCijGQOVcfFvP7r6raZ3IoqCauh+q
         LNrlEKOu0dqz4wcugcdQ2XUMqbixNXrKCoLMCIg+RuoIgF2t0avHB4RQA+3I86ubF7vM
         E0TdkvUtErFc6TZOX6yftdEfzjM92rLTDHtIdEi7clYfti9qEamkR+HgzZ58K5n1hVVU
         h1Vg==
X-Gm-Message-State: AOAM533l4l0NCg29D2Gzg1m9Wll1QF39zY+gK20s5jJH/37IBRoeUjWG
        DVuxZfyGltvd3gTCsIFYTl1x1Q==
X-Google-Smtp-Source: ABdhPJyFOp3ta3lraSt0RfwgCwE1hkuUHMyTkhgAKHevDQ6z0cjghv2dIdmYyGdkYezWZojI9Y4+Hw==
X-Received: by 2002:a63:1451:: with SMTP id 17mr32113745pgu.175.1637571096264;
        Mon, 22 Nov 2021 00:51:36 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f8sm8445582pfv.135.2021.11.22.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:51:36 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/6] interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
Date:   Mon, 22 Nov 2021 16:51:18 +0800
Message-Id: <20211122085123.21049-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122085123.21049-1-shawn.guo@linaro.org>
References: <20211122085123.21049-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use NOC_QOS_MODE_INVALID for invalid qos_mode check to improve the
readability.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ef7999a08c8b..35888721a690 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -76,7 +76,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	/* QoS Priority: The QoS Health parameters are getting considered
@@ -137,7 +137,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 		return 0;
 	}
 
-	if (qn->qos.qos_mode != -1)
+	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
 		mode = qn->qos.qos_mode;
 
 	if (mode == NOC_QOS_MODE_FIXED) {
-- 
2.17.1

