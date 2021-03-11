Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE333813F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCKXPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 18:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCKXPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 18:15:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A986C061574;
        Thu, 11 Mar 2021 15:15:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3757200wmq.1;
        Thu, 11 Mar 2021 15:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71fxTItf1AgeFQSKsbzR7kraZTpHLUDyfFhnrJaGwrw=;
        b=uu6E6nC4/zN4upjsUSqJiiaqAa7h7mCnViSwz/8iM729ShQLcS8Vx2o/6NVAqAQuZ0
         d+b/6iSxl7VikLNWT06+IS59xNF3uTyOfFL4NC+a7BkmaW07ei4eGnDc9GBn99vzsUyU
         /iiVKRk6m9XDeqJxQZpeo1UTU2pePj4HDoEX0YCpDnjg5eF8lTlLg+dUzEyv9l5tQic4
         wbTuxK/ztAH29YEQGBs6FcPZKJqsgFTJXtEsobac+3e+CaYupjY7fnUOgOCghjmuupqI
         y+DP3bulX704gnYL8OmLSZ1HsIyjGVlN2RH+oFa7huc5d3edy/u9PyJq7BB9FN9P7CZh
         613A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71fxTItf1AgeFQSKsbzR7kraZTpHLUDyfFhnrJaGwrw=;
        b=dfPtJYzyOhnC0kMgr4E0j3wBuAswZ29F4Hf2zVIfby4Yhv04T+v5M1uWMXhGN27fCR
         YUD5MqfcbnXML6HVG+INpCaLVmGStwvbJ5yzaPx7tD3Dj4bbchJBojfExfPOCbzk0GZL
         Iupyc1KWxphAH5Z8hIblxXre25u5kjnddIUSH5TogHU9Dbt5xdCKOo4S5AC5aOuIRpZF
         g+Y3Kky7ClynR9ArgF8ZzWba8hx/OWoKRfJMXJFp5z82S6JuGWA6+pDe+JlpmYwE/1Jb
         L1AkNjOu3fQE7PfZB29GMQzsDYyfimprPyFuxu/J5MKXmN6tEoW0H5evNeGhUdfOirVz
         wxiA==
X-Gm-Message-State: AOAM532Y0N8TStAebraqJ2p61UqUw/flsaCLj5k3+ReJRNzqpfrp9C1R
        L3feiz7Lprz3vi6KYaUo3CY=
X-Google-Smtp-Source: ABdhPJwE95EGQstZlkbfzbOnaIDxZzbh7wAuT5AJWDSf9qYPFZA4csf0zLMGekB4DJSl4V+V1/6WMw==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr10255440wmi.178.1615504530799;
        Thu, 11 Mar 2021 15:15:30 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id j203sm263918wmj.40.2021.03.11.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:15:30 -0800 (PST)
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
Subject: [PATCH v3 6/6] soc/tegra: pmc: Link children power domains to the parent domain
Date:   Fri, 12 Mar 2021 02:12:08 +0300
Message-Id: <20210311231208.18180-7-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311231208.18180-1-digetx@gmail.com>
References: <20210311231208.18180-1-digetx@gmail.com>
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
2.29.2

