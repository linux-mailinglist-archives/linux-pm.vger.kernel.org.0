Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D82AE5AA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbgKKBRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgKKBPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:31 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BBC0613D3;
        Tue, 10 Nov 2020 17:15:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so762975wrn.0;
        Tue, 10 Nov 2020 17:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=UAREEgI3cbyJi9cBfgE72sf74JOhJ7Wdt8SYY4CxrqamEkdkUDNcJTlqWcP6q5xbjM
         8ymdLZVPvsJlnqsKX+p1yazwPe2yBwr4SAza4iBJbJBOHkVio84XinYiEBN7Vq+XgwdA
         AY1dEDhkfvi2NCl2ImCZEFqttMpQwny1Vg4yBF01SFndKI7F4l+eviHfnXkH9XFvd0Rn
         nGoR59IM0nGthDtQ5FaxsBuBXmU0yfa8/UrTyoxMWqpq34VrSNJ7EqoUWuRbxgyEoW2q
         QYoAniol5IRPFVZb0OZzB3XpShBM5F1MPYllf3aOJ7SLhVJKwO27Hwnhz3uDIih2ZLDK
         s9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=d6DQnOSLBI7mKVc0tiuYNiUEct0Tt7LCvYO9RZvJWwP3j9SCR9pENYuXfVcGMFp13c
         2UAVJMyuZrlPwxAHItxnWVAJRoatYBjS+ITbpg+dPYkgkc/5YnzO2egKBbkkvMW2m0jj
         r24o4cFSQOqjR3xDNPmqbrZFc3Qr2+/chnpMDITzkf6Nrbi2yV/deZLd1PM6jSfFz09m
         D+b+UI79IeBOMIhQA3ZOBObybyM+Jvg1pAk6ifErJ/Yw5eQTgWiGfY9w07G2rFUXypkU
         YWb9Hc+Jl1wOuWBVh8zNmck0zYi9N+2GZCE+WRLwyyBNmw6awCJfDxVPGjV155Q4i/ts
         W1Hw==
X-Gm-Message-State: AOAM533l7O/eXpQ1Ae0vY8JtW4e3zz54IpT2q6GlSTdV8yznk95ldL7x
        ISpfDjQ7i4l+JAEyoCQkdVI=
X-Google-Smtp-Source: ABdhPJwP2Md9t/kDAOA0Ws2ahugPNxFWZWYrlV3nv2wq6b/GxsIiNeVNI1kojRkZ+Ll1oYqVC4ClEg==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr28079897wru.296.1605057329868;
        Tue, 10 Nov 2020 17:15:29 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:29 -0800 (PST)
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
Subject: [PATCH v8 12/26] memory: tegra124-emc: Continue probing if timings are missing in device-tree
Date:   Wed, 11 Nov 2020 04:14:42 +0300
Message-Id: <20201111011456.7875-13-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
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

