Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A08100CAE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKRUFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42266 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfKRUFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id z12so14867837lfj.9;
        Mon, 18 Nov 2019 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7i+JiP2AUVVtcNWDD/lNg9r2NMfGMrduOQTKI4kG/wc=;
        b=AEpTKk0TnoUtlKqnK4B7kw3Kf8aqVJy55OQFKG2GJBsMS7xkSTddyVnpI51QsC/5yv
         69MBUaCMoErrhOmhXslNhIXSBtp9lOVptYygy8GMYp19Rw2YpL9jQoR3go6I07TKaql0
         EvgRs5uG09afr9O/3t2L1U7/vDi40sq9kw/XT9xo12lzmgxedKI+fi82QlNVfjTwfSew
         SYfjIcGq8S8RGThHsEqXWaCPsMAKLnzKiFXqRrEnQXmGMHIhp/b0WA4mZGASKPwB9w2I
         fy1AvlTtvGlHZBERoeyGGf2sGvzAVmA1L5vbNzE/3CSVEpsC/qYdwD8p044jItzlFblE
         iYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7i+JiP2AUVVtcNWDD/lNg9r2NMfGMrduOQTKI4kG/wc=;
        b=j7Kn/OjXWw08jGJkFhUumoWadtWnDcLUZg+TcalUpMwcRAZ4+JkrISk9Ca3JJNIeqH
         B/i0tWVjEoHGi83dAikvSuQJ/xsxfc/CkQSvIbbuNMJnClzBukOAEGNUNP/XKpKaw3ht
         FTIXw8w1H0XAdIfloejkNV9a9zTT6/9XdHgz2NH5JHcVeoNaaJ3m4PyU/DFSpZv1e9Gi
         PGw7KzOd3GjkoVdTvyhqUMZKxpma1FLG/hduJ7AhzcWE1smUC8bqkxGfFBXP66q42d1T
         ggibT9Lk235TctRx1oPWFzLsMS0w6mGVSnbRNxnvlg9pvqkUuGwcBAbsBGh6Pm+07dxK
         IQ8g==
X-Gm-Message-State: APjAAAVn2tNy6WS9IT857/vPksvnQ/l0DvetAALoR+BtQl74qyeOZBka
        +1bAv5El6/RK4GuzdcHL5Ns=
X-Google-Smtp-Source: APXvYqwEEpqxrD0qEapvfQlnj+xT3sW4TKX4Zbgpx8nwOF8+kZOlCgDEWudmC8WcMQHM7usssGtgHA==
X-Received: by 2002:ac2:46f3:: with SMTP id q19mr839198lfo.65.1574107549694;
        Mon, 18 Nov 2019 12:05:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 19/29] memory: tegra20-emc: Register as interconnect provider
Date:   Mon, 18 Nov 2019 23:02:37 +0300
Message-Id: <20191118200247.3567-20-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC now provides MC with memory bandwidth using interconnect API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 28bd9fd4c3c9..61ce422e102a 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/mc.h>
 
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
@@ -87,6 +88,8 @@
 #define EMC_DBG_READ_DQM_CTRL			BIT(9)
 #define EMC_DBG_CFG_PRIORITY			BIT(24)
 
+#define EMC_FBIO_CFG5_DRAM_WIDTH_X16		BIT(4)
+
 static const u16 emc_timing_registers[] = {
 	EMC_RC,
 	EMC_RFC,
@@ -486,10 +489,27 @@ static long emc_round_rate(unsigned long rate,
 	return timing->rate;
 }
 
+static unsigned int emc_dram_data_bus_width_bytes(struct tegra_emc *emc)
+{
+	unsigned int bus_width;
+	u32 emc_cfg;
+
+	emc_cfg = readl_relaxed(emc->regs + EMC_FBIO_CFG5);
+	if (emc_cfg & EMC_FBIO_CFG5_DRAM_WIDTH_X16)
+		bus_width = 16;
+	else
+		bus_width = 32;
+
+	dev_info(emc->dev, "DRAM data-bus width: %ubit\n", bus_width);
+
+	return bus_width / 8;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
+	unsigned int bus_width;
 	int irq, err;
 
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
@@ -549,6 +569,12 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto unset_cb;
 	}
 
+	bus_width = emc_dram_data_bus_width_bytes(emc);
+
+	err = tegra_icc_emc_setup_interconnect(&pdev->dev, bus_width);
+	if (err)
+		dev_err(&pdev->dev, "failed to initialize ICC: %d\n", err);
+
 	return 0;
 
 unset_cb:
-- 
2.23.0

