Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E644EA572
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJ3Vff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44079 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfJ3Vff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so2753954lfd.11;
        Wed, 30 Oct 2019 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=pwrdF0uOP1QQJTP5ElenVP3eBeZrYGAFkmkfgZa6GKGZSF1EOUCbCBL2GsFsdPSNT9
         9tiBTAfDyVIQVWCvWjaIZrBH2KHx8UpdcHkRICyw8MJZAnxO9Gm2E6n73K04iETY+sH3
         XEU7ND9gKDQP8SEduhG6f70hSy8hBvtYWHehkqB5mJ482HacGfHHjawt+2qr/W0TlS7i
         XGQf6okN0sfVOvHOLPx8UhCqAXnA7ZLTPlSkaeWOAcDz0wM8v0sj1dKf98TLguXLaFjE
         cx3fTBMCXu/O58lqFPAaOgeJfe2rCbqoyuGqMLBIWfz/+bQ6+z3iWVwJm6btZjdzxBj2
         KwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=PkaIIDvr03pPOrcDyTEtedAH4m3pgv0/bL5ZLX5e7Eka/AfV6X5hbZ3VRFnkpEP5vb
         JfCqxYUI3f9RxAtOyH8DCJYWgtUkbd9+BTE0UiaMtDY10xaSCEW0FX1ZIQ4rDfAQLPuC
         +06exSbl5h/dr5BgWYJMzMnBzzY3tf/+cXym0Kd8QKHaBpCLnMphgpRryuVuiL2Cpybs
         g0q7gMOm9kz+TrRDPUiAft+AgvlvIvsVUMCWLSoxPmlPj8VpsnSoshOqqEAxCHoGqYQy
         i/oXJqcx+zbtWfyxKmQaUvV9Rvps0RhncaF/4ZDmZN3jVw3RDcFad3kml4Ef2vYpIkMf
         10Fw==
X-Gm-Message-State: APjAAAWYFdks8TRfW5R2V0t0gUOWNzqpcgy5wa051O5UfOgzT+BBy3By
        XKe/NLN89aJL9wcHSbnNa2k=
X-Google-Smtp-Source: APXvYqz1VsJQPmSeMl+4IOFC/N8lHzf+F/i7JDn1ZHvn8GdJ0MB4lynO6GmEr7vNdamOgNmb4JKAXA==
X-Received: by 2002:a19:fc1c:: with SMTP id a28mr251195lfi.170.1572471332741;
        Wed, 30 Oct 2019 14:35:32 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Thu, 31 Oct 2019 00:33:58 +0300
Message-Id: <20191030213400.29434-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-cpufreq now instantiates cpufreq-dt and Tegra30 is fully
supported by that driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e512e606eabd..1e3b85923ca3 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -95,6 +95,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.23.0

