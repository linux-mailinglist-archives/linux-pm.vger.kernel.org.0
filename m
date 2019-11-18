Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533E9100992
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRQq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46012 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfKRQq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so19690759ljg.12;
        Mon, 18 Nov 2019 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=jTsDtw9oCgvN1tZfytF8rTf6rjvcB5glix3bogcIm674ZXC7Dga9De30UHCuo4b7a6
         cpLKMMyvoO5LXk0r//hPOMKNgfu+YH/R9bWoFOusvNhE1ssdTkuxxY4MN+p/bawHDzmK
         kqqwB1yUYX16Dtnnm0lI2gDkOY+9qLGqTfeZnPiqergPgVDE0P6jkQQHIAHQ2j+U0vEe
         pJywsrYbPj+sDPW0ZeYHiCIPwRHZBdtHGdPguTPXRIURVaPHCr2+pvrYhAFDm7xyzRws
         iGWREQemd/KPCMbMTVCdN5TVkngzOcnNE2eiC1gvXp+jpWu1NpI9VxLJykfjnuvTiWjY
         zl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=nGlioWOawBSJdDD9D7rMKFdQVKLTZnhdtw3JmICsiuuaJz4rZlBJ9P46Ng1P9Olz6i
         SzNN+HoKWOpN8BrRpGAH8TJaHHJ244pC0nHG9ZEEIM5pIpLN5d9xvGH7iD0CDjyuJz1m
         apol71abqDIIUxqia4jqsvEllU9ISAZrUDje3A8+AMPQVhphNgGTcvEWqufvCxe+kFNb
         I59Jw9YZY2sb7KbZjltigDXZXPP0KWFCOVtbQyVtjyfrnbgfnEJ+IDV8Om0lPA4rsYk5
         aE/U8JOftPlApBKYN3G1grm6rHsMNvDI/1mKAvSikvyS0p/jMznXthFp69caL366jHZl
         0OGA==
X-Gm-Message-State: APjAAAW5jLQZdWYsacbwjKv/9oZzSGhnQUvalQM6xTaMduJVLGpnriyy
        3jrA7EmcIs6A94dSnlw32ws=
X-Google-Smtp-Source: APXvYqx+hi0/v2Zg31tKS5UadyLsnRV7KElGXJc9xwkNnK/wq7pGQnyxMwPOcBqmag3FDGj3kPdKMg==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr241720ljc.139.1574095615381;
        Mon, 18 Nov 2019 08:46:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:54 -0800 (PST)
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
Subject: [PATCH v5 09/11] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Mon, 18 Nov 2019 19:45:10 +0300
Message-Id: <20191118164512.8676-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

