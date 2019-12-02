Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12F610ED08
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLBQVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 11:21:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38421 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfLBQVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 11:21:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6419607wrh.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMBJAp4LSOF18EKZsarCjIvV97iU3KlOms/xsyIv3iQ=;
        b=bIM2E4qQ6P+LyYmjxXTsCE4nf2gqeqyCpaqijLgjBd5rSLfDIbh7mwl3XW1bBKIca+
         5R4fnwcgNEiKGlQH7I2Gf+t3VDeCoW/eVANZOH5MtgbkCaU8YMQPy8TXK/gsviJ3PPpA
         K64lZKCfBUpvGCWnpeq0d3CnYV1mDd7D8qD37vhIwuY5LgxWRTtR60smA6p5EFYhRrZb
         9mUmPaUs37tYNSOMScuGD7eojrFiwusAvQDYFvbkuS72kXfk5qgVd7kdH/3RVzsoU17L
         Q19VvRjKxnuiwFpBuiIwN8moJtDbTil9Z7YpRp71rpqTGuVLWgxdxQLnM5burmTv7dYy
         20Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMBJAp4LSOF18EKZsarCjIvV97iU3KlOms/xsyIv3iQ=;
        b=mMSWDe7OddWyRau9bZUOr2eU1SadLItQQ8u8AVUo27DKV9DZL3KCf/eZZ+g3QGs2QY
         GNkjQgzfWnz5YntTGoo/5n/PGoCi8T00dvZ9pAFIIN70u3oGHiowV4bgAbYUnap8HA8I
         D03z+snokvsNeQTWHzIQ0tNDy7PdPevP57Ynv7JL286uGY5NhZd8A2lcJzeR/m+LRWqj
         GvuY2C0Sv3iMssaOmIxnM8zcL/fl476k9JHdvco2jbK+Jgled0wbkqdKkaTp1niGdo4o
         amUA7HP8hxizF2Yko2vso+GAkT2f4vgakTeGVjw3pfuSjH72MghL+PpHbdToTYwpCTNB
         FiUg==
X-Gm-Message-State: APjAAAWsRy+rTI/OOyZVaUIYNToIiqLZqLBCGAdrANQ+Fipm2aXawZRN
        ok2RmRIKRbr3b5M+yPhW9hBd/9BV+VU=
X-Google-Smtp-Source: APXvYqx39MnObvyWdT1npt9UtcGiQgJph3139C2GJsoL7voal1lBRwS03vjO0tJ6oRSzK8TYFGeAHg==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr54752462wrq.134.1575303699158;
        Mon, 02 Dec 2019 08:21:39 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:38 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 3/5] interconnect: qcom: msm8974: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:31 +0200
Message-Id: <20191202162133.7089-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202162133.7089-1-georgi.djakov@linaro.org>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index f29974ea9671..ca25f31e5f0b 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -643,7 +643,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -723,7 +723,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -739,9 +739,9 @@ static int msm8974_icc_remove(struct platform_device *pdev)
 {
 	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
