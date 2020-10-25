Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5246B29844C
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419650AbgJYWUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419367AbgJYWSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C46C061755;
        Sun, 25 Oct 2020 15:18:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so7706438ljg.10;
        Sun, 25 Oct 2020 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L79iwZ0bcQ/bYNErMnkgdiSpet8EKxInzRHfHgz6Aeo=;
        b=vC9RCqqWoD5ylqvyoLyxFpJB5u2HDtHdyu+50U7XHzOuSK9/gZXYFL7FYDuL3WnDaH
         WbJxl76boqcFWLlCC1PjES5SGW+5fc1xNIK94gpfvi/rXyGTRhl0/7JYfTiDRe+7nt8E
         emUPbPNdX71A/J8LcRbIH/5c9WQxGlS7yEN0p/q/bJ5or978wHMTHaX8b6msuGA0zijw
         YCViEYBPuCks8n6SmqUGX+cmARPRHVevxDQJUbkkWzCzcfdb1wks2DBj2Z0hKLZJAhgX
         XyDyzNTi1FKWQMesk33U5DcqraGGaIbJR+WsTf9Y623ZOqten1Q4OcnHwnamB/poKsWs
         hVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L79iwZ0bcQ/bYNErMnkgdiSpet8EKxInzRHfHgz6Aeo=;
        b=K6Ki+lHqAmuTcF0UcQyOnZfD/lEI5sS4epjZsdw1VWZ3imW9UJao/B2fkLALiIyUB5
         CI/uaINpvg6kIR5CB3dSiTzqSepimMfGfDnxyZPAIn80Y3ARhXQMzets9nWLiXY0Em8Y
         2VTok+Zerfyf2WOcKqW2eP7wyflURTwHkKGOUY73KCaLN5tS+RvYe4wo2kkNyjrWZk7T
         mbUKL2uQ8XdjypgjcbtZcm2+eIKHZfTZMMqL0Y5DwWAPxoEkFh2DM8vAQvgf4mV6JVRz
         y6BIGgPP/CmXeCF2Vt/VoBJO9x9Vh+m1Eu+b50zMO9Ok4V6JJH17cm6UPNkJlBbcpk83
         QJSg==
X-Gm-Message-State: AOAM530qbeM+gvURhoMLMXmJoT0faYVk44zRrArANezSNOhwIW4U1Oxw
        bvlBdLvaZ001YwNqQH23byI=
X-Google-Smtp-Source: ABdhPJwu8jgCsNIcFJ3FXu51zCJDEosGMUATemWh5TEorgxVddy3uWItefq/iD1WNFrVWVQctfRMfg==
X-Received: by 2002:a2e:910a:: with SMTP id m10mr4817770ljg.385.1603664323005;
        Sun, 25 Oct 2020 15:18:43 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:42 -0700 (PDT)
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
Subject: [PATCH v6 48/52] PM / devfreq: tegra20: Relax Kconfig dependency
Date:   Mon, 26 Oct 2020 01:17:31 +0300
Message-Id: <20201025221735.3062-49-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra EMC driver now could be compiled as a loadable kernel module.
Currently devfreq driver depends on the EMC/MC drivers in Kconfig, and
thus, devfreq is forced to be a kernel module if EMC is compiled as a
module. This build dependency could be relaxed since devfreq driver
checks MC/EMC presence on probe, allowing kernel configuration where
devfreq is a built-in driver and EMC driver is a loadable module.
This change puts Tegra20 devfreq Kconfig entry on a par with the Tegra30
devfreq entry.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 37dc40d1fcfb..0ee36ae2fa79 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -123,7 +123,7 @@ config ARM_TEGRA_DEVFREQ
 
 config ARM_TEGRA20_DEVFREQ
 	tristate "NVIDIA Tegra20 DEVFREQ Driver"
-	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
-- 
2.27.0

