Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76159C18B8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfI2SAW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36380 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbfI2SAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so5337212lff.3;
        Sun, 29 Sep 2019 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUprcdsgQIcCjuXx7+bJHEM4hFxUfD9RPhaB/mNFrSI=;
        b=U/N9s7GGO+CUwsUEn6edvJBI9YsAHht+y06AVHFaf3/WndLmxtjG+CRm6Y++EK8TXE
         SJVbQmIyPjnmPayODAii8e7DkZE3Kju5cgZjws4G0Bb83moSMOZqFakxjXkHdWcvgSfS
         aCTdaglXOazdSqBoi+V67+MJJPrQCEbJl6oq6zKCyFkpCfaovq4QwqQPQ/0OedwmrGXl
         DkP2snylLwgU+onbpI9Yc/7Piy0Bw+vrdMwi2baFVV3Sgmg+oXQvubYPobXz6jX+IWVA
         9O1BG+XmhNNYiv03oqq2UN+MhQmpcoCYoFwPuyKcYxkwVzzNV1izC5VIKB77iBO37Eiu
         GwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUprcdsgQIcCjuXx7+bJHEM4hFxUfD9RPhaB/mNFrSI=;
        b=hopNTyliYmqbRrpt1xzH88WlEO8JS+MeAK/m3jkVSkD2US4s661ZZnT6rgFIdHXLxj
         mVJvbrtcmkjvO8jRriiuBczOdR1WpHLcXQEOrAlDCRz6tEZzwFTZTraAsoDFX4t+meA6
         Y6cWaAYHAZWIwtmGqsZUySIV6ROaMyNQc2D8AxKfqirB9lbVanHB0Cjh6/Dqbe87cCC2
         Vd/5FU9osAQKvH5HDYmJrXAJVF+q0h80KOMWjhs977igzI3R7nP4xPqaoyrMKxrlNr1W
         QQX4RqFkduyQO7FC5WgtEaG4L5LOtT87mF1IkxQ9QWafFadjmue64rkEfhly/r/XUFw/
         HMRw==
X-Gm-Message-State: APjAAAVR3i37hIJyK96C80mwSqcnjkfdujUjnaBghZp4TDXTnYVm//3C
        DFh4JgnUk2pZPLxw4gknicY=
X-Google-Smtp-Source: APXvYqwg6ETLEflxh8XdeUiL4/CI3v/ukiUSHL3pcduh2+viBq5yErQpxtXpfV5sENpmMsB0CaZSrQ==
X-Received: by 2002:a19:7d55:: with SMTP id y82mr8963163lfc.106.1569780019170;
        Sun, 29 Sep 2019 11:00:19 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/14] ARM: tegra: Create simple platform device for cpuidle driver
Date:   Sun, 29 Sep 2019 20:59:50 +0300
Message-Id: <20190929175952.22690-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPUIDLE driver now is a proper platform driver, hence it needs
a platform device in order to be functional. Register the platform device,
like we do that for the CPUFreq driver. Note that on some Tegra114(124)
devices PSCI may be used for the CPU hotplugging and CPUIDLE driver
doesn't support that case, thus CPUIDLE device won't be registered if
PCSI presents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index d9237769a37c..f1ce2857a251 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
+#include <asm/psci.h>
 #include <asm/setup.h>
 
 #include "board.h"
@@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.23.0

