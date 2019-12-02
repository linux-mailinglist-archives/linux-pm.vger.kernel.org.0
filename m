Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E670F10ED0B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLBQV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 11:21:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfLBQVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 11:21:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so45034385wru.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcVG/qj8yyYNSIPEYKFW4bW3tWMavwQ5W53FJik00WM=;
        b=AP6DiGL/aQDTxsAfZ1x0QW+Tv8Bg7T5RqQnXQmNd2D7OmhJ/YbRW1pmAjuDOkM2Y2F
         0xGdykT8B6nyEKr9akZYeTPLwCSAridNAkPznb19AHx3u9eVgUQpuDRnw5U2avBiQfG/
         PnsAwETCY+nidrFK0fkulfX1bd87h+6Gsw8LOAoJjGAarWiauj0mDJq/n7ub4OV/lUPh
         /Ud4d9x5Siix/pN7AZQHNsAWTmwUmH0JHHp3tnAEOtg4ZeeLd+OpAB3eKgZLLRWtGIh9
         KiCfqvewrsnuUXm/K+lkeJe6tEL/9+PU77gfs6Nxmtsi0y97vQHDhZPYnH4kMNgKSYiL
         48KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcVG/qj8yyYNSIPEYKFW4bW3tWMavwQ5W53FJik00WM=;
        b=gZge271VRqdVzlA/M4grQn4iS0JXbCcNxzCXlgAyyC8cZZybjOEbzKihzhYuIJjJac
         DGtfEoZlt0mwPyjD/sd7AkLr5zZVNcTQxWpJvS5Vfl75eKo0lf9EhpY7pL/E1LfV4AB+
         p8otHg/n6Cmwrn3geLTwKSnOor236SjR5zlW8GW4BALW8ik6Je9LxV6mHCD2KI/Dfl/t
         POYqdYuqHAj8RFtAXLw12Ph6PcdLBlsaTmMHPBl76iVRukWdBWCONpYOO1SBkXfpRQMH
         5Pm9SdWf5bZczW/NTmr7HvhMVH3KhswQWgKMcWIqPybiWoekQpgE8yX2wjr6bsefMYhf
         ECjA==
X-Gm-Message-State: APjAAAWNQnThD5uv0rWFOI6eiqoDpcyoO/QvmKcLdXtdCyBcQ+ReZnWn
        UoHwNLXis/X9Na1mvjl24ru3AG23+ek=
X-Google-Smtp-Source: APXvYqzf7GMDnP1dmGoh6t8wKOB1vcicGtxIHotMg3u8fNgCyOCxS5AqgiMbo72c0hzwkLeTx1NJ+w==
X-Received: by 2002:adf:a746:: with SMTP id e6mr15118778wrd.329.1575303697776;
        Mon, 02 Dec 2019 08:21:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:37 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 2/5] interconnect: qcom: qcs404: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:30 +0200
Message-Id: <20191202162133.7089-2-georgi.djakov@linaro.org>
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

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 5e5843e6bd06..9064f6bdaa69 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -405,7 +405,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -485,7 +485,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -499,9 +499,9 @@ static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
