Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872001B7ACB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXPyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgDXPyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 11:54:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F53C09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so11459293wrq.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANWXN+2Z3DDrWrVHhsInrxi4EvXPY/8IIalTrvooHG8=;
        b=ierhYQVQtu+peHFc42kGYjWb//BJX4HxUct5NT4NbIFrjxEH8CyvRdBn6tFBhqOmmb
         UZ9Z4We6ymLhwC+k6u7kLuDxlPVFOOQGvlAk+jPhjmdbCbjYVkCTzKw5zVCT4WE1l3l+
         swhcNCjbycHGW70kjoSWISiktdL9x1hDHAk6tBNdNnJsxMGQ4uEldlTRgEQh5IyTb5+U
         SM8pwVGCpglmLCRaWndJSlE80A10xg6vjnApxIpGL5/9aPpXdgx8QawNiSoyVf1jfWjp
         lXs+QzmVRTk35lbTdx27DwApHTGihQQBam8yyp/jRZk32rizTuYPTdWUu6rc46nUFTTk
         o51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANWXN+2Z3DDrWrVHhsInrxi4EvXPY/8IIalTrvooHG8=;
        b=nKn8mWVYzdwsmmGvcE1OEUaANDOUBYU4Ggi3777FUDL1rjj3CmuwJXKoloFemLHpfo
         O7ZlI6To1y7bVAbi47paAtHZjUsBUOm42bLE2T3HlHx5jRPdtIHJB8ch3N4wScAGBuIh
         V7TjhLtCdqKSJ0DNCe2Eid+w0pIAic2UjMmAcyMoSjDkq2xtabnxDWDGuXgoRooqZS1/
         JhzSeZC9vmQjX4INNDIxauZN4OYNDZiiMsl8Vvk+OR/KaflLcaLXKOgpL/OSYZewIPKr
         7adEbZzfTsL5OC0VgJbrsv99PdHVcTumhLCKDncy6x6vWzWRmF7ZQsK1UA7xfOqkl+qq
         Iriw==
X-Gm-Message-State: AGi0PuYubYpSJ6aIltrxsVtNfA2UYLrJi3lnHHYA9gPXaX49Wjx1OHJS
        8QwKgWzLDUto7vVrwS2JnJByCQ==
X-Google-Smtp-Source: APiQypKrt1I/vfpXrZmkPsz9dzLuK18NN6O8r2S9WWku5sLnMIaDkgNIXVxKYk9wDEbtIfT8TGH1QA==
X-Received: by 2002:adf:c109:: with SMTP id r9mr11837240wre.265.1587743656909;
        Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 7/7] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Fri, 24 Apr 2020 18:54:04 +0300
Message-Id: <20200424155404.10746-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200424155404.10746-1-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v7:
* Drop using dev_pm_opp_set_paths(), as it has been removed.
* Add Kconfig dependency on INTERCONNECT, as it can be module.


v2: https://lore.kernel.org/r/20190423132823.7915-6-georgi.djakov@linaro.org

 drivers/cpufreq/Kconfig      |  1 +
 drivers/cpufreq/cpufreq-dt.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c3e6bd59e920..db2ad54ee67f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,7 @@ config CPUFREQ_DT
 
 config CPUFREQ_DT_PLATDEV
 	bool
+	depends on INTERCONNECT || !INTERCONNECT
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
 	  management.  This creates a 'cpufreq-dt' platform device, on the
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 26fe8dfb9ce6..4ecef3257532 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,6 +13,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -95,6 +96,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -121,6 +123,19 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
+	cpu_path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(cpu_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
+
+		return ret;
+	}
+
+	icc_put(cpu_path);
+
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
