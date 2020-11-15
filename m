Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A12B3982
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgKOVdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgKOVdW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B6C0617A6;
        Sun, 15 Nov 2020 13:33:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so22379425lfj.6;
        Sun, 15 Nov 2020 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=lXS3HiSsnEqc6AR8AaWtwNjKCLrhEhS+nSrbmu8b7vopM4l8ZVWioON+5jYSsLoaM8
         a1arLGaw+zTR6pSwBXSN3/eKjQbPc0jBcRKgjaIj1TqdrIMlN6RqDUemAQOAVEhLe/yT
         I9DNoqlMV/phAzqeaJE8P0vySPpPbajdujVkKTxz950TzWhOOq21KGhOLvVJAyNMZz0Z
         Gf9RswheRxrrMFsh4NihXTH4sOW1FyCfVSh9NcFMbFq7byuQ2TbX6N5XRNkiNdQhEIv1
         tIIs1p+nU4euvgjHf40aAHQhDX/1ypg6yBlcERsssVDi0TuoYwPtEXXq/TY84IfUJaD9
         tp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEcxOMp1NLOMF0Qi1vlqDEHmnss3NDqpNYlgo52Rbfc=;
        b=W2mF4Spu2Z/gBo/OxKbmsY2ak42Ef3emDrYPqCuA7oknpg3QP4/S3MB19k7dQBvLva
         xXPbxdc0sawWGhhqVbSsC9irtolXQYaZURmYD4QbH95DYL+2rFvr/JxOO3iH+xle69K5
         HM+ymLORIfG4w2EubB0mn4KhcZra64ZIuT4eGjw7aPtQmGtRzOoYe7T8VkHt4z22jchP
         sl30WQKQIt3PBAsSHsvfq3qn2Vz4B5Pv5cdILuzraImcI36Hgz6w0wzEtxYiBTmJdnMC
         NtmtqvUJ33uB/ZdIj2/ZFCc+WJ5IrUTuyAQIc54dseLEVPCtuXzj0k8dMF0lof0/9PEz
         XkNQ==
X-Gm-Message-State: AOAM530WuFrpQWDaTfy1S0F/R64YnDwWrRbol94V2qS6hdgqf6QEcAzw
        xd5KaEG3KEKRcUy6t3Nw/ro=
X-Google-Smtp-Source: ABdhPJxQn0b1TgtIIsx4pYPR1+xf/Od/q1CGBVV94Ksm1gZDO5gg75PeUHiFEI7NDYOLoBlz0r+ohg==
X-Received: by 2002:ac2:4543:: with SMTP id j3mr4040093lfm.511.1605475999179;
        Sun, 15 Nov 2020 13:33:19 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:18 -0800 (PST)
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
Subject: [PATCH v9 03/17] memory: tegra124-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 16 Nov 2020 00:29:08 +0300
Message-Id: <20201115212922.4390-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
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

