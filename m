Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5737A025C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjINLTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjINLT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:19:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920501FDE
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501be2d45e0so1434180e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690363; x=1695295163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVq5zLi24ZjH2OBzcFU65XomWHmUtYcghlhLwRhU2bo=;
        b=vhOgmzhifgFSWfL9HAibpY55pIQoA2n7U3cebe7lpR5TwuatE18gZqulXK0/qQcH05
         aqciOiGhJRrPUt4iNvLNwZSo2/NVF3xJWI37xigaJFSRdDCkJx7TjScGoJRyuAf7rhMn
         J8m9QigCdjAwTxl2cBh2dvzhGpxoY3KGHEAiz/c0PEnDLn9iUqiuYBog+AzbnHFp1gPd
         7DNPPBoYlmt6R7pMtyCefKnie0QMvaw9TTwGny3cMNQWCnZtiZXYPosKhA7oQgGOlTw+
         VIYOx2cLG/UpJxlKySbMuET18ABnxudJyx9NFwiyji7xzOkS2l1vxbSKhYccokdc0yj4
         kyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690363; x=1695295163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVq5zLi24ZjH2OBzcFU65XomWHmUtYcghlhLwRhU2bo=;
        b=ZfDDQSqt65XKjH6UJBTc6bMq0ACCcFQ5hah8x36x+Iyd5JJX5OvotWVusYDEYSlX5I
         bVQmug0Dch1FX4fq69+b2uLT10Y6i0mcdtkuXcmE+1hZ+VNTZQXKPTOg1LvRCCtF4PPd
         Imc1Lsn0lR+8Y8nXqAJXIqpg/1uerjtEJSsyFLxkWMJEF6ocW1O2E9PmYes7eKtFOVk6
         H9ZcXE+O9xt1CqJcAOw5WJePtyrYIIeIaXUkcE7mE0ckd/o05ukNbzeAFWvUi0M+roDs
         X6AyOItJV7MThKkxQwRig83RGHZb/Jw+kKG/Nk4QumTlH3WBNe8EQq/1IgHbeGHo75hh
         lmwg==
X-Gm-Message-State: AOJu0Yyha799jQPuA7P2LT5GH/1BwiWqBBvXXdNXQNObWAuOBT9Nh/Kb
        yWR2Gu5wr3d/UsOl9E+jMWjLcw==
X-Google-Smtp-Source: AGHT+IEKoLQ14tXcZedXg+7ur2HyspF1KFVJqKExrXMlRMnh2zk12sEOw6eQcPmi901vqUO7zuS5Qw==
X-Received: by 2002:ac2:4c54:0:b0:500:7e70:ddf5 with SMTP id o20-20020ac24c54000000b005007e70ddf5mr5312397lfk.43.1694690362925;
        Thu, 14 Sep 2023 04:19:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p14-20020ac246ce000000b004fdc0e37ecfsm232938lfo.227.2023.09.14.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:19:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 15/17] pmdomain: tegra: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:19:19 +0200
Message-Id: <20230914111919.586784-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: <linux-tegra@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       | 1 +
 drivers/pmdomain/tegra/Kconfig | 6 ++++++
 drivers/soc/tegra/Kconfig      | 5 -----
 3 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pmdomain/tegra/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 39f358f27f2e..08a7d43cb884 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -14,5 +14,6 @@ source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
+source "drivers/pmdomain/tegra/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/tegra/Kconfig b/drivers/pmdomain/tegra/Kconfig
new file mode 100644
index 000000000000..13ade6d84696
--- /dev/null
+++ b/drivers/pmdomain/tegra/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SOC_TEGRA_POWERGATE_BPMP
+	def_bool y
+	depends on PM_GENERIC_DOMAINS
+	depends on TEGRA_BPMP
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 6f3098822969..f16beeabaa92 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -152,11 +152,6 @@ config SOC_TEGRA_PMC
 	select PM_GENERIC_DOMAINS
 	select REGMAP
 
-config SOC_TEGRA_POWERGATE_BPMP
-	def_bool y
-	depends on PM_GENERIC_DOMAINS
-	depends on TEGRA_BPMP
-
 config SOC_TEGRA20_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra20 SoCs"
 	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
-- 
2.34.1

