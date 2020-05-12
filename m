Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAB1CF4FD
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgELMyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729982AbgELMyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:54:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2642C061A0F
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so15231849wra.7
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrDz0VtEFIllRgR/SygMJHwSLsI5h5gjPBKpNjucqnU=;
        b=hRQiCfERNwcKeaXH+vBgWstpdhfVeFUqZ1HMM5gInNFUPCUmTIxlN+nW06ZqEyr1MT
         WJt82jfFMhSh3/RaGC13yJslFwkNU9IP5rTAXxevITstBNNe0Q0GqLiQ8X/4kMoTb5St
         9DB5LdqtelZUdP4aOiA8r4r6CKfpEsAkHPc+1ZB0OvODMQGzdCislqEz/wGa5WTmLoY2
         d/LAisGXl4ceWObzMaSX+TnByQmuW6rujCdNxrDyZktJU5cYwJDxyLT3uqKLbzHAA/zv
         4Q+Skz9YusrYZTS4w02hgcM5lS0pRpHRcUHCIILUcGrWW36OTz9Rc638ZOyVZKUaow2B
         luIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrDz0VtEFIllRgR/SygMJHwSLsI5h5gjPBKpNjucqnU=;
        b=J6lgp1hw77RLYT/jcdXXWoaCuU4GVLUWe8ORN5O6mE0iNoITYbC2vQ9TidUiLWtgJv
         h7BQlnwRx8vcDHg0LSMrgJK1bgAgoA00TWy9PIl49rYVia29wV5TxMUqF4WOTli0OCIt
         4gbVW89xRQDMgpQDJ2UMQYThCN+hZ9PYbRe/zxa3bUi1PIXmmVU7rggexl1COvAKSHny
         JjMELNjyJxu6T8xh3+AeyHljZceNYEyme0flmBj49uPsQmDP9ezflaxhNo9MAdloZBEH
         7knt9OoQNBIHeINxhrPmMrKYAYyBcVjP1v2KnBr4yYw7eym46aQGxIEBP6b9x5rL/3KD
         iFPA==
X-Gm-Message-State: AGi0PuYT5EnQoh34i3hihrfwBZprQPk+6C2Ne+FxwkWlHT+RWFL2y+bm
        pLjjN7DmDZ5A9dogh2E2LAeTmA==
X-Google-Smtp-Source: APiQypKf6IbOeOx+5EfHUUqCWzbaipquaePVOHE175HL0LBNU9ynasyUz/CcO62uWiKdOHOo00HWLA==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr26414026wrt.77.1589288047573;
        Tue, 12 May 2020 05:54:07 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:06 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 07/10] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Tue, 12 May 2020 15:53:24 +0300
Message-Id: <20200512125327.1868-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* Picked reviewed-by tag.
* Added a separate patch to check the number of paths in DT and validate
  each one of them.

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
