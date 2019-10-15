Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322E2D81CD
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbfJOVSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:18:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40163 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389439AbfJOVRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so21753044ljw.7;
        Tue, 15 Oct 2019 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40MTszG3atQ4WGlY18YWAe6XPjiAZd4Si2W063emoiw=;
        b=NzTDsfrhbRs6+yzUzdu4WxiLkjpn7WNQUH63MPH+vW+EDRI9CeT2xj96FY355wnEoa
         yy0bpx8k/LfucqgwN+1zkTZT6vKIfEyneyaeKDKIZQbuOoLxasKyxGH5TVlkC3EcuDmo
         S+wZO7Fi7UfX5Cw25llld/oe/E3tlvVTWcq9Zn+RZP5RzZ8Ohps4NLs7+7X+wXOq/AJt
         FoMaWKsxIA9hzEK9IPATAertWPgJ9v5RKbieHrZ8lF3EQTIv4lw9h57RfA2c8yJZ4CIH
         EUnMkPUyRjbLwURHRjcM1XaOL8MJuSC5Fg/YXKasPmXzjJkKs10B2W2T8sKEEnIofWZ5
         aFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40MTszG3atQ4WGlY18YWAe6XPjiAZd4Si2W063emoiw=;
        b=d2AUO/3ucUe/0+lFFoqh6T8na6b1Nqyv5rQOyj2ICHRopUZaOoSv/MTrO1SETuVWJA
         mUvKwfT2AZgijFI6ZbBPf5NU5wO1JgkxOXoM8IyFjkLo1Do1MPWPyQYEyGNQ3rnRvfVe
         zJ3sKZyGILz/T8pc91o+W+iN33R/Q5YokwpFhvAjZ6obbGf79U7B1M5XpzVyabVyiDE0
         4rwO/Mq62Ni3oaSypWRvJILEFeco60NyxmfRf97VDsbqztOLeF9obWEtEoJ2Ru6yeaWs
         /mWVp6Mu5I3LVzKXl/VsB5d4zMT9ssumwuGgyWBYdUp2GMlY/h6wuWoPh0v+AnT0Qa0e
         a/AA==
X-Gm-Message-State: APjAAAXXYVK/OXo3mZfbhcQWUbFSC6LOt3Ghduo7ITsoZwevVrYl13Or
        P9a0QQtPtz15uVG+VeZaFv8=
X-Google-Smtp-Source: APXvYqx6kL0SJA0AlLHuw7Q3ZI6N7gNYRZfzv5rHjCKIzr98PRvurqY5gtM4+fjB7yUbwve4UCnGgg==
X-Received: by 2002:a2e:9f08:: with SMTP id u8mr1698412ljk.124.1571174227989;
        Tue, 15 Oct 2019 14:17:07 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/17] ARM: tegra: Remove tegra20-cpufreq platform device creation
Date:   Wed, 16 Oct 2019 00:16:09 +0300
Message-Id: <20191015211618.20758-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-cpufreq now instantiates cpufreq-dt and tegra20-cpufreq is not
a platform driver anymore.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e512e606eabd..29972b44eba7 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -91,10 +91,6 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("compal,paz00"))
 		tegra_paz00_wifikill_init();
-
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
-	    of_machine_is_compatible("nvidia,tegra20"))
-		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.23.0

