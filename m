Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEB7AF3A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfG3RKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42339 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbfG3RKS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16704690wrr.9;
        Tue, 30 Jul 2019 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YB/K51J2yBjrGqQBOAGlFNTt2rdW770Na58VRvSkzkE=;
        b=uJe3a6TOWAkM0mBZl1xcGfff3uOQlBMGjTwvrJW7ConUXBv8e7wLGzXhofdwzjNFY9
         2HlDM46hjPxrc53kIIOgBuH+rCdbssmvt9zLn7g1gKix1tS1LJl4bPfPC+V6NiI+A2hZ
         6O0oJX5RJ2V9bMAvPDErMcmBHO5YaIJ1fiDxpwtElaBtLEveFNJc5blNA0L3QEMolX7q
         hVmh39pREkZYztrVqnB8OgixwzPLzRpTBC2L0HqKwdTqBo3txkwaM5QlSNOHo/lmrqYr
         zmBwD6Oae7caejyIxycYDFQUIcUGJmHOAu4hOjyGkmPDheWKRtSf3ggM8r1ZzGWPdTdX
         uLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YB/K51J2yBjrGqQBOAGlFNTt2rdW770Na58VRvSkzkE=;
        b=QnTNaEpQ+ue9Re3AM9BDAGo/eVBp1b4pqC9MGrbzvD57r/BCmTrgKUkRJBWWlFMqHS
         w/f/ails8Fa0nzAMG+mkEXoYSF7nn10wXjW9wD44PeXY3QRowxq2gzPMei560HjJw666
         SoKdW1dSeyWh9P+IUT4nMiVJeGfxV+8XsCyPonSWcmCkBcuKr5rfSA9agwi/iRPXedKE
         nYXUphDobAnecdk2HUC+CnfwGWprMJMXMJfapHzH9x1B4kD5NSQ6sPEdTU084YHR/VgQ
         4Hoves7nLRS25njhmgHsIrju+M/1+UpZNcFokvKw3QglvZ9w2Z5Byk8AlhMy770Veg7X
         NAHg==
X-Gm-Message-State: APjAAAUEfMlJjYmCktK0bikZ3CvB877EKeIx9SBqtw4d9UvZeyg1hZA0
        Xw7sRyA26BNyo+5GyMxubAo=
X-Google-Smtp-Source: APXvYqwWUAkefGUrF7CbjIjQzU6py/KkUB1MLPIDQTIp7IrpU1U4AQIrh4JiKWRfXqEHCPhNed0DSQ==
X-Received: by 2002:a5d:69c4:: with SMTP id s4mr98720282wrw.163.1564506616472;
        Tue, 30 Jul 2019 10:10:16 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/13] clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
Date:   Tue, 30 Jul 2019 20:09:50 +0300
Message-Id: <20190730170955.11987-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPUIDLE driver uses the Tegra's CLK API and that driver won't
strictly depend on CONFIG_PM_SLEEP, hence add the required stubs in
order to allow compiling of the new driver with the CONFIG_PM_SLEEP=n.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index b8aef62cc3f5..cf0f2cb5e109 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
 
 	tegra_cpu_car_ops->resume();
 }
+#else
+static inline bool tegra_cpu_rail_off_ready(void)
+{
+	return false;
+}
+
+static inline void tegra_cpu_clock_suspend(void)
+{
+}
+
+static inline void tegra_cpu_clock_resume(void)
+{
+}
 #endif
 
 extern void tegra210_xusb_pll_hw_control_enable(void);
-- 
2.22.0

