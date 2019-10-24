Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D40E3F22
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfJXWSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:18:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32982 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfJXWRr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so7951lfc.0;
        Thu, 24 Oct 2019 15:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=g2NGEIwwhJa0woZBAE/zZA/hMNx0rB9lISsT1UKnCwootQscZHFcysHmZDSyfuKJfY
         6MXZ38johamu+TMeEAeQeWqtv6e39NIwMfDYKKEVrVXcdwcWu02bLoWBM4xnEZ7ld9T2
         mrkCoRTFzGhUvFZ5mLSRXQrKHr/VwaKkVk/smMev34lIUJ16V8zgMLLBbxOfOc0EX4eN
         kZoOi22RA0Mr9Gy74Poau55vMELsduY65MiaIXG55mMQ4ICTBfgnl5bparMQEJ7X7X9k
         jHIrLW9ZSyqbtrQlvWq6F9LV07Yzb334oBD1pnSAS95unRfiQ47F6pvsDmU8Xgosarbf
         +ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=VOUHkhI45tWm6m/yMNYUHYeyA1KgMOgduRwy5AHFNg207Rr9zI01D8ACCTk0OMeLqp
         tyVKUp3v/Xj1XMigvQ9PI7XZyXQ4Tgm+mDT3llD+IVCyp4GhPEdnuj4fsDR68X3EYyLS
         aG550BD1Ht6uK/XEN2LOhq+I9zChFizeI4+NOedV9dC+zchDt1T7l476+/cSzTPoXKjc
         qwGcN1z/L8qujqWfoVYM1zZN1kyBo2EXTN8JHy1auFec4jSi2PRnf6cZEeFHvG0jJufd
         mycdniWYIzPWdxvDML5F1GuNu7kPbl3b+ktPrZqx2bRIRW6xoPlqWgRI7fIOnpzOU/Rn
         XYgA==
X-Gm-Message-State: APjAAAX8OjtwEJOxFcnIJj/rm9YfwtyziEuCS+i7F2qAUgeKQN2kReiI
        UPiVBKrEsUYUaeFrA69r9Gw=
X-Google-Smtp-Source: APXvYqwIx+nS0nesccE/FwPYXtz4JktcKoQOjsy8BlfgJXv+1e3lTqOMJ9+MbCVWBbaYQW9tAtOTHA==
X-Received: by 2002:a19:10:: with SMTP id 16mr309717lfa.100.1571955464672;
        Thu, 24 Oct 2019 15:17:44 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Fri, 25 Oct 2019 01:14:07 +0300
Message-Id: <20191024221416.14197-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
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

