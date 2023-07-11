Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76E74F206
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGKOXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjGKOWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 10:22:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1361FE7
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b717e9d423so34400461fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085335; x=1691677335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/xuXo525qhEtOsBMOOeqNnkhkuvPW6MSZV6cV6RV74=;
        b=ecZdF7I1cB6puCD8OiDeTOgVfmGrb7jQHt8u7hGDt+6wSgOBzFtvtMcJnL0pqmF5tx
         /MaCsgSo4MNhWN56Xtycp4uqigyprB72n9zGQpw9da4j2vVetSkoO9K6PsOYiwGc8fj1
         nhcR0S60n6gx7M2gnA0JnF7WAHWHnBxzjl+4GmCgaDGu5/IDtcK8M93GWALyCaolr8ZE
         cs9VIMS8nwD79e2dgWi9puQcINBwPr58wYZtS5rj+IwTL/7faCUdDBpwmLmKa3x4pDBz
         iGoj68vRCKJKhOjXcoAGS80oJNThRYdV0GcA2CJksmGwAgnY8GYIjaXRPcsA/5KgrH5k
         FuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085335; x=1691677335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/xuXo525qhEtOsBMOOeqNnkhkuvPW6MSZV6cV6RV74=;
        b=Y6Lx6Sqle6/LOpGgcW9Jq8OASZ+hl8iNbyoKHhsICmFJxYhYufy4kPLp1UqD+fQbRe
         SWw1ETjQ8YT+7lTrXoQvVbCU0+18YquAGa7q0deg+nQNqeDvMo53S7ysy8lo4Uk29iOv
         zAADYOGWICRQcquMNt2JXdTYC0xRPduFmsSLnPOFrVuiyroJlXvE5b0CW3ze+Jj8qhYg
         82I5uxE+pwlmMcu1vano+2EJhdKMN2wJICe4701/YTrIgZOcRx6MNLemVpw+SOQjt9IA
         mOI1RA4FY3yAmjnRPELG7NwG3XRKC+78bwMAmqKBvHqocyBeZuJQFtMHfv0kBGSNLHD7
         yr7w==
X-Gm-Message-State: ABy/qLYLejU83RY8wJECTLmdO1ExjpZAs0Vtq3em754YrnVTZPP1PNfA
        tHtFP+j0YOPgg+019v96L+tFzt3ayb5M5Cgk/yU=
X-Google-Smtp-Source: APBJJlHAzO1ekClENkgJuRc1MMovRYV7zFJoIH7lfgd0ZdS0MSPENbgHnh9IJWigjKrmlVKeQm6hMw==
X-Received: by 2002:a05:651c:339:b0:2b6:9e82:446 with SMTP id b25-20020a05651c033900b002b69e820446mr7357921ljp.0.1689085335391;
        Tue, 11 Jul 2023 07:22:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b3-20020a2e8943000000b002b6db0ed72fsm483073ljk.48.2023.07.11.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 14/18] soc: tegra: Move powergate-bpmp driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:22:12 +0200
Message-Id: <20230711142212.751774-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To simplify with maintenance let's move the powergate-bpmp driver to the
new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Note that, we leave the pmc driver in the soc directory for now, as it
looks like it may need some re-structuring before it's ready to be moved.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: <linux-tegra@vger.kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                        | 1 +
 drivers/genpd/tegra/Makefile                  | 2 ++
 drivers/{soc => genpd}/tegra/powergate-bpmp.c | 0
 drivers/soc/tegra/Makefile                    | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc => genpd}/tegra/powergate-bpmp.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 76f2a411e6bc..e6f34d82e6a8 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -10,3 +10,4 @@ obj-y					+= rockchip/
 obj-y					+= samsung/
 obj-y					+= starfive/
 obj-y					+= sunxi/
+obj-y					+= tegra/
diff --git a/drivers/genpd/tegra/Makefile b/drivers/genpd/tegra/Makefile
new file mode 100644
index 000000000000..ec8acfd2c77c
--- /dev/null
+++ b/drivers/genpd/tegra/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP)	+= powergate-bpmp.o
diff --git a/drivers/soc/tegra/powergate-bpmp.c b/drivers/genpd/tegra/powergate-bpmp.c
similarity index 100%
rename from drivers/soc/tegra/powergate-bpmp.c
rename to drivers/genpd/tegra/powergate-bpmp.c
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index d722f512dc9d..01059619e764 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -5,7 +5,6 @@ obj-y += cbb/
 obj-y += common.o
 obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
-obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
 obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
 obj-$(CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER) += regulators-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_186_SOC) += ari-tegra186.o
-- 
2.34.1

