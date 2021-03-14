Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8662933A6E4
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhCNQso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhCNQsY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 12:48:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABECC061574;
        Sun, 14 Mar 2021 09:48:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z25so13415322lja.3;
        Sun, 14 Mar 2021 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uo5cQWIcO3eMQBwWai9I8Oi87phRnH0WT+/lmBuZjU=;
        b=banWFytj4hsP9DOcC5HIgxVH0yRY89MkqHf3xi4f2KA7KTTJCH+2bNJ9CMPy4snXZX
         KRw9spfKmYZeBWRL29nN44VEj8hZwJLwG4yMP+ZjM+/pfokUYPnA/r0vkfXXgtxCUlfg
         XIyCp+1GjQwrulJJ7tWxiVnYkiqG2Um/eW6zz6uFI7raDAUk1zoF2UzhSuvVXf5u8ThT
         Y7W2pHb/tvOsqWGUJ8JU/OJmU2EA/WfEdz39b64TBs/tpd8wc9AfvcATwqiDyKTGbjCS
         ukTzdbECyEyRcO3PYTHRSPDYsiU0W+96j7qd6qBUeUImEpRBHFWMUxSl+EZhvN09NAsM
         Jh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uo5cQWIcO3eMQBwWai9I8Oi87phRnH0WT+/lmBuZjU=;
        b=hmCJo9o17oJN/5j4qmL630jW08MisNCSWPUpV698pS31xWDcekMtdffGWCZ5qqJMoG
         re/zC8Cd+UBntCk72QFMBCxNt/vehCvjta0ubigHfjUVKFAjtI9fBoAPXVF/2nL85dSP
         xc6ZPKiNW4E4jqffHt+Pphn4bPkkbsoLdOkwFKYbyPi3VKYlcIjB9PlhrxnvvBSAkViP
         rznGHJ60i5eW7Ro8BdKC6E5eqsEyM8KiiNm4arGrBtZmMEIbdieXiRS1aB/EkrsLvz1m
         QIALGB6w+TEAfODWLN+jLpSFjGJE7ejV4sEFpROuuIMo95uWZpeiqAoTMfzdc0jXDVIe
         lPFQ==
X-Gm-Message-State: AOAM532pcshYW4+f60n5qlDm1jFeou11kTMo+h2bl4RBryjn8OtuerA4
        psuM/uqzBx6lJPotRIMO3K0=
X-Google-Smtp-Source: ABdhPJwx96gsxPwuyaJJcabZ1kfwjYUuXmsECHj7VC8JOu6t0wyVc68y+290not+8oMG+GbTFthVCQ==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr7903244lji.253.1615740502369;
        Sun, 14 Mar 2021 09:48:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id a3sm2387993lfr.55.2021.03.14.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:48:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] soc/tegra: pmc: Link children power domains to the parent domain
Date:   Sun, 14 Mar 2021 19:48:10 +0300
Message-Id: <20210314164810.26317-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164810.26317-1-digetx@gmail.com>
References: <20210314164810.26317-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Core domain is a parent of PMC power domains, hence PMC domains
should be set up as a sub-domains of the parent (Core) domain if
"power-domains" phandle presents in a device-tree node of PMC domain.

This allows to propagate GENPD performance changes to the parent Core
domain if performance change is applied to a PMC domain.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 84ab27d85d92..ba8407819397 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1283,6 +1283,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 static int tegra_powergate_init(struct tegra_pmc *pmc,
 				struct device_node *parent)
 {
+	struct of_phandle_args child_args, parent_args;
 	struct device_node *np, *child;
 	int err = 0;
 
@@ -1296,6 +1297,21 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
 			of_node_put(child);
 			break;
 		}
+
+		if (of_parse_phandle_with_args(child, "power-domains",
+					       "#power-domain-cells",
+					       0, &parent_args))
+			continue;
+
+		child_args.np = child;
+		child_args.args_count = 0;
+
+		err = of_genpd_add_subdomain(&parent_args, &child_args);
+		of_node_put(parent_args.np);
+		if (err) {
+			of_node_put(child);
+			break;
+		}
 	}
 
 	of_node_put(np);
-- 
2.30.2

