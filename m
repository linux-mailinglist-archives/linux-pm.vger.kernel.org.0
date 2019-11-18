Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D972100CAA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKRUG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKRUF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so20431154ljc.9;
        Mon, 18 Nov 2019 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2fZoY0R7IbQjoE/jwqG69vNLdHsoiOa5JN/luWf3e0=;
        b=TTGoXoCUGYgNLTlP5iXVrRXJPwkha1zSQ5AjyRhu1bMfayjzqzarGQeoe7vELP8Nxj
         3vI5/0aOZXaZCRmJyKUU6mmLqM86R4X7aOL5sT1vVAbpgAfvV6uUS10yDdqq0+a0/RG2
         qb5m+2UGJGO6yVqYwWnjw7ZY98IKLQe7jnYgq6XFnTo03LBK/xV1xxyzbh+Nz4Ph2Tcp
         tDe/CWeFPSp0CCAGOLrMX6EoX0VegVJzBS2ZaOWKq0Jhpbqv6NExUuLztuGgi8c/+YxI
         oq0GT1+fhZC5YJ1ky6L1cBdsQRMy7lu3KZh5OE44z8QokmQbIvRQOftu6NWOReH3/V7r
         YWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2fZoY0R7IbQjoE/jwqG69vNLdHsoiOa5JN/luWf3e0=;
        b=OoVUAexYKlsi8ErAwt1PU0DVVqR4xc9oDiqLtDX/RhqVGmBwXRIhnFYLmd/tndRgvC
         zmrlX1hqzZqtzpmk4FC/xDdtr4c8e28fODDkydnTn5vPJY6DQZS4Pu4xi8584vpNmIJK
         D0Gg55h3kprWiAtukRhzArItfoRfr6e1a7bHd2h9PYqceV+/2ZsUPf3RxHGmvHzRI7lp
         HqIlIvaTN/5n3RNZcDW+wW1c0KxdXVIJJ6W4tDFJwTkPeH+SZm3cRy2GBIgRavt2VwIy
         KuVP4xHrlw8I3SWeQ+mwLgFr2aC6vEhQ3pkNqCkcJo0uCpwjmoyHUSmCKM2akaFGPllC
         AQ3g==
X-Gm-Message-State: APjAAAX14Tvp2TEX7/+grgNv+Zd7v81Ls4qAqSwq8HQ/BnwbtDf0Bb5d
        5tD79YYqbBEULaXBXHWm4yo=
X-Google-Smtp-Source: APXvYqz8ghWzEWo16209Cas+BFJnfWldFab38K4eefHAlKvmnAkeVTZ//bkXMQihDlZJIBr4ukwNjg==
X-Received: by 2002:a2e:9b06:: with SMTP id u6mr963460lji.34.1574107553665;
        Mon, 18 Nov 2019 12:05:53 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:53 -0800 (PST)
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
Subject: [PATCH v1 23/29] memory: tegra124-emc: Register as interconnect provider
Date:   Mon, 18 Nov 2019 23:02:41 +0300
Message-Id: <20191118200247.3567-24-digetx@gmail.com>
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
 drivers/memory/tegra/tegra124-emc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 2c73260654ba..c9478dcbeece 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -25,6 +25,7 @@
 #define EMC_FBIO_CFG5				0x104
 #define	EMC_FBIO_CFG5_DRAM_TYPE_MASK		0x3
 #define	EMC_FBIO_CFG5_DRAM_TYPE_SHIFT		0
+#define EMC_FBIO_CFG5_DRAM_WIDTH_X64		BIT(4)
 
 #define EMC_INTSTATUS				0x0
 #define EMC_INTSTATUS_CLKCHANGE_COMPLETE	BIT(4)
@@ -1080,11 +1081,28 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
 		dev_err(dev, "failed to create debugfs entry\n");
 }
 
+static unsigned int emc_dram_data_bus_width_bytes(struct tegra_emc *emc)
+{
+	unsigned int bus_width;
+	u32 emc_cfg;
+
+	emc_cfg = readl_relaxed(emc->regs + EMC_FBIO_CFG5);
+	if (emc_cfg & EMC_FBIO_CFG5_DRAM_WIDTH_X64)
+		bus_width = 64;
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
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
+	unsigned int bus_width;
 	u32 ram_code;
 	int err;
 
@@ -1146,6 +1164,12 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		emc_debugfs_init(&pdev->dev, emc);
 
+	bus_width = emc_dram_data_bus_width_bytes(emc);
+
+	err = tegra_icc_emc_setup_interconnect(&pdev->dev, bus_width);
+	if (err)
+		dev_err(&pdev->dev, "failed to initialize ICC: %d\n", err);
+
 	return 0;
 };
 
-- 
2.23.0

