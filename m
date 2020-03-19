Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413A918BFF7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCSTEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36054 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCSTEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so2572595lfd.3;
        Thu, 19 Mar 2020 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrx6enxmE5rGr1bvvcfpjzqZxRZxQ6z8sM9vbLY+H/I=;
        b=feeFqaI46hVNYGlFk9z5z8b8cY+jQXz/JovqRmRA5Y/CQe1uu3pwO+f5l3joj3c4zE
         2TglVxKJ20Wj0TGqnXUSNqH9lTlXHneovS2C7AJBT5uEkxnFDfv7Eq1h7RzoQF2QxapU
         Bylr0doMH17gs67TxYqxTe6fpyvA0a3W6ZDT3VGA7L8JwcxZ1LgAgG37cFurV7C782gS
         Dszu/KoD7oSpvAsrBbp5JhAfVm6FGUqWCZrI+vGjxKFnNTRyAx8l314BM1S47o9fOMEZ
         zL+lPmzDwBb1Cw0p/GBvk6rvQNEBzTUFS33lXROlnOqNmcSv/RcpO8KfgU+2CXRr22ay
         FiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrx6enxmE5rGr1bvvcfpjzqZxRZxQ6z8sM9vbLY+H/I=;
        b=QHTJnkr3tYC+6GCJUOpEaaJpUi5lTWxc+3BpYpKx6RxjkDTFjqYEkG8CepWQQHLX9z
         BfeNcFM6R30vg9ThP3lamuU0rom1mKrD1Lxc3ZJSj3zqo1aywkU6MoiRuyf+F9W+lluy
         ZJC3AJC94tXYXN/ChkuHxoFsCL+YfKRFMHGlV5TtJFhBJ9xLkgWvsjW0vDr7j0hZpG8B
         oXtlJSvBMe3cyRu6KXm8TijsU0J33BqP4sVHum9DPxNGXG4vOBFBqdmzYYbw20zuPgaE
         bLVxPmxB0eyls++UBj5XQmNx84Hp89mOKRSsqJhGhusTHzV0snDoGfRPeDYNmyUsZyOe
         wXAA==
X-Gm-Message-State: ANhLgQ0V3zZoket7Yx6IjYoVbbZS77esbmNzxQtyoXScuPThO7mRkXY+
        XBqDOkwcsS4yGsDUYPH1pcA=
X-Google-Smtp-Source: ADFU+vtxnrQyRT7PRmc8o2TVUmUf9rkCCQABxJ6M4QeuS21nsc7NRq2i/38MAs9/zAkrZgDeGzCXjA==
X-Received: by 2002:a19:4350:: with SMTP id m16mr2981697lfj.67.1584644661668;
        Thu, 19 Mar 2020 12:04:21 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:21 -0700 (PDT)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Thu, 19 Mar 2020 22:02:27 +0300
Message-Id: <20200319190229.32200-11-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-cpufreq now instantiates cpufreq-dt and Tegra30 is fully
supported by that driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f1ce2857a251..3882a6c66969 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -96,6 +96,10 @@ static void __init tegra_dt_init_late(void)
 
 	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
 		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.25.1

