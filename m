Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05882A6A5B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgKDQuJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbgKDQuI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:08 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A91C0613D3;
        Wed,  4 Nov 2020 08:50:07 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id i6so28061172lfd.1;
        Wed, 04 Nov 2020 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpnLgrE/KIZ6J0eMhnY4ffyEk5qfjR4pbUa1URS1+kQ=;
        b=eT9AdSwY6QmiNL/vh22cX2gun3H6hYmlPxQL21b8k+N8lGwXf8hg+x01H6hGJJeSD2
         9EUrNpzI68qPfbP7bk+MnfoB63VGTSIdAMnZzp3WubJ1CTvOv/OfOLyBokFQIwsehqB8
         ULSI7PNCmlN7nmqhypp5A72fF2k2sTJhCXh99djwo5UGum+j4isMp46NypiO+NSbi9/t
         8QlRzYPcWiw2iHnSmCYHCWPfulcYnIvR/UMJLgI9MiJg8p1U7OzO8qzrvOkDXel1O+JO
         wgnvfAyIz//nPWaC2agyavBrK6rLDeIESmugfMPjEAp8BuUyXRArlh/HsYZQBZPiHhtl
         cPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpnLgrE/KIZ6J0eMhnY4ffyEk5qfjR4pbUa1URS1+kQ=;
        b=hAV5efvX8IqNQ/lGqKR5mv6UujUxdHnJ6zPxgRAefV2Ppp+tpjx2qTosHC2r6Eacxg
         w3D+qCi3TDsF5mQQnHu6g4bEVuXREeFaw8PlHT//XrqdGg9n0lung5U2xywtliwDPL2W
         Y4i3Yg7FBTqlGANsjZeAqoyGYj8FBgM4C+DO6F6qD54g9cpcEt0Fbjq42E30w0sWV14A
         Uh9C3g8hdqKoBG/mQTtl+OMoJsPkw/kDZGpbvLQl5dh4gg+OFvojk9B/qfQ6QYSq9v/D
         mdtMwlTzd9yVWs396eLtswaI4vlNQNZ4+3xJBw/O+c8FxEHn0y7fJTVb628P8Uqnq8pb
         0lkw==
X-Gm-Message-State: AOAM532xrWFeE4d1crn1LnL6XAaXgrVVbzbSaVsFijwLli+W2xAfiQ4j
        +byWPxo0oBf5z9UvWGGW/OU=
X-Google-Smtp-Source: ABdhPJwi0Z2sWnIE3B1pjc2HPoqa6Q3lOJz48bunHlnvZxcpP08LOm7VVfPYpiy7FyQK5rHj4Z6xiQ==
X-Received: by 2002:ac2:5b50:: with SMTP id i16mr1164553lfp.586.1604508606218;
        Wed, 04 Nov 2020 08:50:06 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 30/47] memory: tegra: Remove superfluous error messages around platform_get_irq()
Date:   Wed,  4 Nov 2020 19:49:06 +0300
Message-Id: <20201104164923.21238-31-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The platform_get_irq() prints error message telling that interrupt is
missing, hence there is no need to duplicated that message in the drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c          | 4 +---
 drivers/memory/tegra/tegra20-emc.c | 1 -
 drivers/memory/tegra/tegra30-emc.c | 5 ++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a72cdcafc933..998f9148ecb8 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -707,10 +707,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
+	if (mc->irq < 0)
 		return mc->irq;
-	}
 
 	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 5ba4e495bfc3..c9fe58a724ee 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -665,7 +665,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
 		dev_err(&pdev->dev, "please update your device tree\n");
 		return irq;
 	}
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index c58cf31cb27b..1be28e28ec34 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1299,10 +1299,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "interrupt not specified: %d\n", err);
+	if (err < 0)
 		return err;
-	}
+
 	emc->irq = err;
 
 	err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
-- 
2.27.0

