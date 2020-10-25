Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A272983F8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419330AbgJYWSb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419326AbgJYWS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BFC061755;
        Sun, 25 Oct 2020 15:18:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so9400734lfp.11;
        Sun, 25 Oct 2020 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fg4He703fmuSrlVAk0wJsvaFKAB74pGCCwxOoopIZEI=;
        b=VHEUlUYQ3XWj/2jC60Lr+VJjNgxo+pNKDO0JPR3z+WLZtsgVdYcM5RybqQaEoh988G
         /qTG5bBtU4uflVAnLbI6pcVQIS6t+0SjL0hJklMEz7xvVJyoJ9i4rbGxP9b6qX+NZOgH
         8a4VBert2XPVYEjKOv4z1y5Y54h4BwZ5OTT00RkVRKnkZgYqFocpof5zWvYhs+3ERofF
         jfOs7gvKJXoCCeiyGpvq2SxSo7sydDyevCF0CMo8wLAOa1jl7aJGX8AjqdaL/SA5vzk2
         InDFnV1NHEdEuoH9NnZDIl3UYfS/YSn59Bpzj3KMKBAlYP+7Pqr9Q6yIGC2btjhlRCPe
         JRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fg4He703fmuSrlVAk0wJsvaFKAB74pGCCwxOoopIZEI=;
        b=dN2gzB47usMnbNDREJelhzDe/QmjQFWBM2WFC9LEcKXlJBaSMPuGz6rl2c8eltANWq
         b/50RJx2sQZcpZSw12KgQi3P+zSQwptz6aIH7RR8ay3aR/3gKtfo9Ut3ydRegcWPWU+u
         2bdwBvT3k6B6yibaFiZ+xOtFtHidQlCQMRxmCehDYSsGCEDkB6SQuyxik6O5EcPmmYBU
         QJ2dNJxESZ6T1IuPcfML+7IldrkkskfB+CEI4MwtOLVXWm9X3fwdA/7iRvvx4dgIBbLW
         MI9MAkwB0nqpw3HO6BRsLDo6QJ1popV8i2P7Y3fLtb1tJqXqUyDA3VZwjUBaRT6JFr5Z
         pCcg==
X-Gm-Message-State: AOAM531fq7s7Ojz06fIt5qlfmIq0wPibGW61rTrjJ/i8OBNuiA1udxLc
        MTI4kD5LwXxWpuKE5MoXxsc=
X-Google-Smtp-Source: ABdhPJzYfunjZPDkuX1/Kipa8zC3KL4U82okU9J+6tg24AZPLn3QS6zIBqTDxPsmgKCQLGng8iK+dA==
X-Received: by 2002:a05:6512:2029:: with SMTP id s9mr3782053lfs.273.1603664307205;
        Sun, 25 Oct 2020 15:18:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 34/52] memory: tegra20-emc: Don't parse emc-stats node
Date:   Mon, 26 Oct 2020 01:17:17 +0300
Message-Id: <20201025221735.3062-35-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC device-tree node now contains new emc-stats sub-node which needs to
be skipped when timing nodes are parsed by EMC driver, otherwise driver
will try to parse the emc-stats as a timing node and will error out.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 69ccb3fe5b0b..27242659dfd6 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -349,7 +349,10 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 	int child_count;
 	int err;
 
-	child_count = of_get_child_count(node);
+	child = of_find_node_by_name(node, "emc-stats");
+	of_node_put(child);
+
+	child_count = of_get_child_count(node) - (child ? 1 : 0);
 	if (!child_count) {
 		dev_err(emc->dev, "no memory timings in DT node: %pOF\n", node);
 		return -EINVAL;
@@ -364,6 +367,9 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 	timing = emc->timings;
 
 	for_each_child_of_node(node, child) {
+		if (of_device_is_compatible(child, "nvidia,tegra20-emc-statistics"))
+			continue;
+
 		err = load_one_timing_from_dt(emc, timing++, child);
 		if (err) {
 			of_node_put(child);
@@ -391,7 +397,11 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
-	if (of_get_child_count(dev->of_node) == 0) {
+	/* old device-trees don't have emc-stats node */
+	np = of_find_node_by_name(dev->of_node, "emc-stats");
+	of_node_put(np);
+
+	if (of_get_child_count(dev->of_node) == (np ? 1 : 0)) {
 		dev_info(dev, "device-tree doesn't have memory timings\n");
 		return NULL;
 	}
-- 
2.27.0

