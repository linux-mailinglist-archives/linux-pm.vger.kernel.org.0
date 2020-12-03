Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66A2CDEEE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgLCT0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgLCT0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:26:20 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D0C061A54;
        Thu,  3 Dec 2020 11:24:58 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so4352325lfl.13;
        Thu, 03 Dec 2020 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=QEWd41CnpBZr+s2jfgx+kjdr+OCukSXqV2r6K1UXFHqwAs5EIFN5R7KspcuRNSy1Pl
         Y6+/hiCvJPOJmAFhOz9DwZYDavZsbvhL656T5Z6obbmbOGaORouwra6oEYcyd0Gq0xhR
         8pdKrbho6alWI7XE3EFZAqMoIWu1OPm/qHbZRoCPKdbr8SOjqM/lL0ghe4fYhXMzFzac
         WbqI2BUkTP3Ms6EqSbIenuBwfYqpyBC2EvbWX+99aWAnOyms6PnO2CiaoPzV+a7FGJgg
         JgXZUpmVY4kncmdqMOTxAEMaU/2bhKnfXrQgEdbs9zQXLl7+TnQQw7J1QfYAlbgz4JRi
         fyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=te5IHCNOoiX+e9BSKJsXCWL5I5KnzNQpiHHbnykTI77daGVpy4FC3nsLPCOxVnSa94
         Hu43lX+g7f6D273yITZbkuD4Ll30DO1LZgWsTuyHsjXRcGWrGKhq2QyZ4s6v+R5T1q6g
         d2QkDgHZbwh1rI+B4UbCErrnWzemLQG7QgfLL91EwIhCi0Mo98muuDm2t0jQqctHv+X6
         /4jfRH+oQVCOl5fRCGzxZ2KkHgIy4MXVLjU4KF2q/UhsWLsQ/AU2UPc0wJbBHKKEvGf6
         sPmmOd/i7hjjYmTnpaO+CwG7oUM84F63p/YuNqtkHQ1/VdNbUmVMX8H4dIhCQQerPCKr
         uMTQ==
X-Gm-Message-State: AOAM530OcOZgHsSHpoeWcV0NudSQWsv9r6GNCey0hRUmhb6r2OH+ns4A
        oS4Y8YYqYV+WNxEGtVX+5sU=
X-Google-Smtp-Source: ABdhPJy+HAc8kMCWNUM3YphR3pr0R4c3XmFLHkdYKSGR+qdqRI98D+7+uOENw7Va9fyDd4M+wT4NWw==
X-Received: by 2002:ac2:53af:: with SMTP id j15mr1956530lfh.256.1607023497187;
        Thu, 03 Dec 2020 11:24:57 -0800 (PST)
Received: from localhost.localdomain (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.gmail.com with ESMTPSA id z7sm861932lfq.50.2020.12.03.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:24:56 -0800 (PST)
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
Subject: [PATCH v11 05/10] memory: tegra124-emc: Continue probing if timings are missing in device-tree
Date:   Thu,  3 Dec 2020 22:24:34 +0300
Message-Id: <20201203192439.16177-6-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203192439.16177-1-digetx@gmail.com>
References: <20201203192439.16177-1-digetx@gmail.com>
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

