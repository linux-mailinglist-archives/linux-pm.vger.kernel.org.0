Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272AC1F0E70
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgFGS6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgFGS5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41208C08C5C3;
        Sun,  7 Jun 2020 11:57:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so17729060lji.11;
        Sun, 07 Jun 2020 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/l7+vPYH5EAd2WIrcrF+WV/TlTdD/VFXDpsYjNZO6cA=;
        b=dVsgERA8EoMvfU/i/6FPKu7i1+I5nNoKaAZEtWAWmOQTfEbO3SsXfIyLO6ZsbnXF4d
         kQqBD9tsHztUpMIttlX8B1qjzGnD8F0wvyG0DXltz1gt02GCZ1Otbke+dcj+89LxiUvz
         nV7JT1V+EPVS2ZZqy6DP1TmKV5MkdtI2X0K/XaQOKiw8/XwxZADP3g+wdFy8qXb0uPCc
         SwgkVqtlwztpiCb7yj1rlquOoYg+FHsfOWarKvcywUtoKaxDSINfU4C4XjwmmQjhzxZe
         A129/zRtYWe+cVGVa1sGOnPS0KlG+aYkbdLRKpz6WRjTl2EQSgUEI0vFbJz6H06bcpFn
         B4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/l7+vPYH5EAd2WIrcrF+WV/TlTdD/VFXDpsYjNZO6cA=;
        b=WdHLG/6UFDMNnliix7O6MD4F9f2ibbDSSzL24CiqUgWeK1AxUGDhOgDatOTKQK1PoT
         qIfgc0Bmu40Fib+ZEC8hhASjOpeF5qujKJtAZPTzbDk4s3wSmA6j5w/e9jJY4S2cdwmy
         F3eQ/Lp+9aMd37w/Aa9Avv+E1FvrAV1Vi7wIEtEnPJOM3yRn1fy5Q98Vg1N5KpQATmJl
         veDRN1eA/AblNncpFNbgXvl8hwA+ZY5pkhYceqUDUgZPcBE47UxT547gQTktRq9nUp0x
         cY2LUr/qJaO9xumSAqGyCRomehyIJakTQWoKHVDYvIw9K6hMIR3YG3gJ4t+Kc81lPnms
         NsAA==
X-Gm-Message-State: AOAM530PseOJNXeBIfofrbpvG2w2NjXk9fSmExTHZAyOlovpN0ya9Tj1
        lboAifQa4ECdci6rZ5PhCSA=
X-Google-Smtp-Source: ABdhPJzD+LEVvvSpdeGXtpL+iBegUzavLwLLbh0JeGHk01OuI3UWdFgXAchY/h+rdfr36Bw76q1vXg==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr4442488ljj.166.1591556272788;
        Sun, 07 Jun 2020 11:57:52 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:52 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 32/39] memory: tegra20-emc: Create tegra20-devfreq device
Date:   Sun,  7 Jun 2020 21:55:23 +0300
Message-Id: <20200607185530.18113-33-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra20-devfreq driver provides memory frequency scaling functionality
and it uses EMC clock for the scaling. Since tegra20-devfreq is a software
driver, the device for the driver needs to be created manually. Let's do
it from EMC driver since it provides the clk rate-change functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 2281bf9b784b..6dfd9807e042 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -882,6 +882,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 				err);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_TEGRA20_DEVFREQ))
+		platform_device_register_simple("tegra20-devfreq", -1, NULL, 0);
+
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
 	 * extra complexity which doesn't really worth the effort in a case of
-- 
2.26.0

