Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9352BFD84
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKWAbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgKWAbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:22 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE2EC061A4B;
        Sun, 22 Nov 2020 16:31:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so21398427lfe.12;
        Sun, 22 Nov 2020 16:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=Lde7ZDqYx8dJkOCebv5BhXG3l/59/kykD0OHSLRbiHLoPp9Zr+KqwSdCUovpwbuIuV
         40Ug0wZPdzOm8sh2YNsTpr5iL/RKpwFVLyxj4Sys6+Eap181JcU3vjo723T3i3KGazdR
         XS74fVh70SrgGeRQvRbJSkiSKDmwmrh9OQN/DQ+0oPMuJEUdOdVp+puLukxtEHalqguO
         Sk4KL6W+bYqot121mvuO/oNuDSDJTR9SZElXwIpyqXLL7ErUgSPK4FbO2gJm44d/e5N+
         Ecx1mtB6GcfdH7aGbhQhdU1/kcFThaPWohUx9Kf9wDSI2Ee8FnMnXHvbEBSIdzYciw3r
         2HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=fSARN7rv3WPc86uoLkODe6eAaXUtozm6N0Br8mIAwRHTvDGynDLlFB38le25TB9n6l
         bI0Cp3uH5dixI27ZGbMLBGY/YvI9SIjMO61+80D77lolr75lcMaGi5nYg1ZxgNdl6WTn
         xdM7VZUV382kB+wffRBHygvux/6H4mIejSREKU/7khNprRARrqFzr/gYnSYPwfEbM/kk
         nSAdFlxTyt/U2juY+iaZ8kUroVF0cCqYvZ4e5OEJFVJavvB8XILUyQg51Ngq7oyyf2ei
         LTG+B/7vEEO6MXZxoKUbIj0pDblpxAWm2BMnuJ1UHWs7P2KOzBxVn3w8Pi21AsKvT7A6
         FMYA==
X-Gm-Message-State: AOAM533z3aPekVMu93p+TnysZUeMZj6ZI2nnIEG7u5z4MtbOIBmBI/y9
        bkSiLJIf1QN3FpuEtHzDLm8=
X-Google-Smtp-Source: ABdhPJz1K729hX4qJiI+60UtmuZxTEjD8U6Rdp0X8aJQjoLdzHwtLAL92XIpv4YmX0zgw9gEY+MSPg==
X-Received: by 2002:ac2:5591:: with SMTP id v17mr11553276lfg.562.1606091479185;
        Sun, 22 Nov 2020 16:31:19 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:18 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v10 05/19] memory: tegra124-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 23 Nov 2020 03:27:09 +0300
Message-Id: <20201123002723.28463-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index edfbf6d6d357..8fb8c1af25c9 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1201,23 +1201,15 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	ram_code = tegra_read_ram_code();
 
 	np = tegra_emc_find_node_by_ram_code(pdev->dev.of_node, ram_code);
-	if (!np) {
-		dev_err(&pdev->dev,
-			"no memory timings for RAM code %u found in DT\n",
-			ram_code);
-		return -ENOENT;
-	}
-
-	err = tegra_emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
-
-	if (emc->num_timings == 0) {
-		dev_err(&pdev->dev,
-			"no memory timings for RAM code %u registered\n",
-			ram_code);
-		return -ENOENT;
+	if (np) {
+		err = tegra_emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	} else {
+		dev_info(&pdev->dev,
+			 "no memory timings for RAM code %u found in DT\n",
+			 ram_code);
 	}
 
 	err = emc_init(emc);
-- 
2.29.2

