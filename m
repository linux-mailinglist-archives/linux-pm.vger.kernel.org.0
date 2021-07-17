Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254F03CC2F7
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhGQMOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhGQMOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B03C061764;
        Sat, 17 Jul 2021 05:11:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u13so20575113lfs.11;
        Sat, 17 Jul 2021 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oahTHnDPuRKVMxkoilhRCRaRgS46Q75QLsZx7nz1p8=;
        b=i56GSVrF89RYmGEsJilxe/dVYSAaz4A0JcfJRwto7Oe1SpzQg1BH/IAChgLxIXF9Pp
         xEbI8V+n4ucm4LEM27l2DeW1SGb7XNudkeVryR12xuUwBqSUwBoQWzp9HqAbQk7Y0aSI
         0AKfebmc8tHWgUCsc2Q4JyzUe9CgJSPHeFaBZWBvKp7ZGgk8qKCWN97w2KJHR0NgzJcI
         /cMzNaYbrQoU5jfOnZ5rNYt8vIPbFQS7idQr+Jb73/8XKP4+B27bVG1RGkALNfWx/wdv
         kalINKmVyzpQJEFI4ozdQ01nMl/GR7Me9agkLKwpHMIBzL5FenvZapOVrE0DGYnB+uRA
         6BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oahTHnDPuRKVMxkoilhRCRaRgS46Q75QLsZx7nz1p8=;
        b=FsBKcEdjxTO7MmzUXnDMP1VH+QAFzRC8n2D6nRBMoSWtexSySmjgaZWmC20qsFKHct
         JzfcWHLMW9LsDjYkQjMbjpKS2nWhf8iDpAwLP+GaDadURR+lnHXu4d0r7griIfWGAUuO
         QgfDJWE9Rl7usJYv+Tqo+pq5oeRWJay2RN1dt2jQ/ZURJ8WaY62H81Uea4YqSxYeIpp0
         aSCKHz0yGtI0WfSb/6uSqkAh9HX4gqdir7cR3JDutaiWths4+kr49NqhkqJrqT8ZAsaS
         XbWA5MvEMNz9BB7htfot5owALHlya4bePcGoGZMIBsglaeuTPWJw4kr5Dd4S08NNNJG1
         DZEA==
X-Gm-Message-State: AOAM530FwUczG03hNFpLwNr9mKW9XWx+5fuV+27gyLyCajS7QbvQT/ax
        trNPVii5IEDR1F1bFVjp64g=
X-Google-Smtp-Source: ABdhPJwAK5xNNtrxXRoJqZOS4MtCh0tY+oH2ubNZb7Qr/bM7mjbU7v3nQRhixgC5o1cmI7cUK8Kbag==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr10987922lfu.531.1626523887960;
        Sat, 17 Jul 2021 05:11:27 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Sat, 17 Jul 2021 15:11:03 +0300
Message-Id: <20210717121112.3248-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All Tegra SoCs prior to Tegra186 have USB power controls within the Power
Management controller. These controls need to be configured by USB driver.
Expose the regmap to these SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 3d31abb0ed71..5085106c4f53 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3202,7 +3202,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3263,7 +3263,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3320,7 +3320,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra124_powergates[] = {
-- 
2.32.0

