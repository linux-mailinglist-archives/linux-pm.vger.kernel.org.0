Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33461CF4ED
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgELMyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730016AbgELMyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:54:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F73C05BD11
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so21578453wmj.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvKbAOWfl/knTZNX27VnXfewubIaPbz+/XetIklYZ7g=;
        b=CtAO3vqc/5ciyMQoZsCfVYtGsZMc+eGRSXx8OOoeAcTbEVI4XVBa71bqTsRSIHZ0gK
         cIoZxWJLoMHxPgfW90arxdJ8OlAjwSTl9umY/OPCe30eJ/bW7vTcQkNceICuv313oULW
         TOGrpVNZ9fr3FpbebaRAGuhnQhXb7jCQv3QOwonNO2kt4Ps1rNkm//Xwdg34qLqRAsiw
         ZF0XfOyfRoK6lhpW+QCop6SAla1XYxNLOWCXFpFzGfqvQkIGLdm42P0TaQuoqZBRveos
         tJhRidy4xOS3ok+vXCq8VghzXgIU1qoCXK7qMumPAlU/3O+ElEbAbTKGV5pfpG4mgQ0B
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvKbAOWfl/knTZNX27VnXfewubIaPbz+/XetIklYZ7g=;
        b=RiqO7yOJkCYhi3s64vuFi4LqQD4QNdeSoijZBU+Xr2htjFZ9BH18POz19Z+snl4mUk
         cnJMh+uegeUt91d0m3eiG+eaxM5jWl/kKKOBP78ViR4bH47xGZqaq8ElrHSw4HZqTlbn
         W+wmWRg5ipkJCum6EfUCNHXCQk+ECAq9dZbUBqwxe7Bi6Y+KJZqTZeLtYUN9VOSsZZIy
         qzMFcMHldGBVOukl4SWpfCvRZrX/15sBg4e7bGwRDXi5UjZ5xiv5NVCMzioMKljDoDRd
         wbnqp5Ax8qVuM/uTEYmIh0+B+DLHf+cw9YtO7cjs8vSVe2wqmz2Y6iS0QK7PJMeYmQHR
         QDdA==
X-Gm-Message-State: AOAM533qPP18/+SwucRZghVebDYpoDMCCRNiidVr/dW1XMdMXU+SANBf
        dwz7anJBuUIp1Yx1s4HK1LmTBQ==
X-Google-Smtp-Source: ABdhPJwY/a0cn3q6lCGX60mZA2InAaE/IzVG1DBnCICgZqVoe54tj6ukY4c547zEb5HQfe3aDNwFYA==
X-Received: by 2002:a1c:444:: with SMTP id 65mr351423wme.21.1589288054568;
        Tue, 12 May 2020 05:54:14 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 10/10] OPP: Add support for setting interconnect-tags
Date:   Tue, 12 May 2020 15:53:27 +0300
Message-Id: <20200512125327.1868-11-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Add support for setting tags on icc paths associated with
the opp_table.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* New patch, picked from here:
  https://lore.kernel.org/r/20200504202243.5476-11-sibis@codeaurora.org

 drivers/opp/of.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 3a64f2aa0f86..fd148d54022f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -336,6 +336,7 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np;
 	int ret, i, count, num_paths;
+	u32 tag;
 
 	np = of_node_get(dev->of_node);
 	if (!np)
@@ -344,20 +345,25 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 	count = of_count_phandle_with_args(np, "interconnects",
 					   "#interconnect-cells");
 	of_node_put(np);
-	if (count < 0)
-		return 0;
+	if (count < 0) {
+		ret = 0;
+		goto put_np;
+	}
 
 	/* two phandles when #interconnect-cells = <1> */
 	if (count % 2) {
 		dev_err(dev, "%s: Invalid interconnects values\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_np;
 	}
 
 	num_paths = count / 2;
 	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
 				   GFP_KERNEL);
-	if (!opp_table->paths)
-		return -ENOMEM;
+	if (!opp_table->paths) {
+		ret = -ENOMEM;
+		goto put_np;
+	}
 
 	for (i = 0; i < num_paths; i++) {
 		opp_table->paths[i] = of_icc_get_by_index(dev, i);
@@ -369,8 +375,14 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 			}
 			goto err;
 		}
+
+		/* Set tag if present */
+		if (!of_property_read_u32_index(np, "interconnect-tags",
+						i, &tag))
+			icc_set_tag(opp_table->paths[i], tag);
 	}
 	opp_table->path_count = num_paths;
+	of_node_put(np);
 
 	return 0;
 
@@ -380,6 +392,8 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 
 	kfree(opp_table->paths);
 	opp_table->paths = NULL;
+put_np:
+	of_node_put(np);
 
 	return ret;
 }
