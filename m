Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128E0F81B9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKKU5T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39745 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKKU5S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id p18so15320039ljc.6;
        Mon, 11 Nov 2019 12:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=pedissdrIdIHiWyniHn/0DxGNSI6cQGY7pDEkyPn0tavx8vGYNTj8wYrGzAo5MUTSb
         5gA5Y/9jlSlTtaFeb815NuLF7qjSVW9Nc9qYgLHzij2JZYZZ8x4/dwF4EAq60eJsQTw5
         0/j27FQC3GvCKhqVSHUIw1+6wCP0rQW2zzwk5Y+65ee50Ly38lcTS8ta9vHP218bNXJ/
         ZY7zXRoU09xIOcQCuqT6YZvPuVg/ApPwTSh7uefgBkjpRhLCBuCoO36XYdfERRqfF1Z+
         nkopwQNjfVxqIitvgXHHTch6JprSlhSe2aYTlVx70kQMSlJe3q92fUVlImA0z/g9e3yi
         IuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzAZfLCHZriyZeqCihOmNKPh325Oe6nsAgLe2vRiK88=;
        b=Dk85gnxukQD97eczQ+sys4AmlqQ3m4EpF/zXr8vkP2cA9+bxwvCcV5NsPyStyTb1Tf
         6pEpc0A9lY/3Bq2+1FunA1hr495cLKXEj9vqYzfgeDx6by9j3e/nMj4j5ktdGCooqykS
         vv/+yTO7TTBy+0bQl/+PRF+5GQGJ/okQ+5jXBtA6kmOIBGXZhQFDlitaFrMSGig91pJ6
         M63bx4hXzCyHQ2zPU+1ekbnYxAxb+PuUH8Yk7oi0CaIc8lm7VXllP3aIbeWC8MkylxFB
         QugTeSXUmhg4yoEvhK+hsJWXBFkzqLp7UhsIn9o3i7NL4GSBH4GJDnZIeHqWYnPQWXsF
         sbmw==
X-Gm-Message-State: APjAAAXOssanNYlqIW4UvI2SIQgop8u8O7zpGIFvDIDJGQ0PEPDqN+sC
        XmI5xOmkPPLwmj/1ZyB2JNY=
X-Google-Smtp-Source: APXvYqxFZAg/oTA2LfrKmyC76eAuwZ0hYdsNwbu0i+AmCw9fWVFpoIjwG0P/hv6u7OLGR//QxyaUzw==
X-Received: by 2002:a2e:760d:: with SMTP id r13mr16940476ljc.15.1573505835624;
        Mon, 11 Nov 2019 12:57:15 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:15 -0800 (PST)
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
Subject: [PATCH v4 08/10] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Mon, 11 Nov 2019 23:54:17 +0300
Message-Id: <20191111205419.16768-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

