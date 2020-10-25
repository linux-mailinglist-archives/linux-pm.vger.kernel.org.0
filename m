Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC922983DE
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419198AbgJYWRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419143AbgJYWRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80075C061755;
        Sun, 25 Oct 2020 15:17:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so7711615ljg.4;
        Sun, 25 Oct 2020 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8WUsWu+WDkJcn4CeG8tWfLig6GMVsRbCZOtSjwc5GA=;
        b=uOiJ83Ab/HUSvRlO5J2M7nAN56/Fkm/YLCjuQB4FNn+rI+eMKxxQgtnWzeuzRAq5tA
         rCTGY4mOJNfJXFlA+6mOUNR8kMdxGsMO5HywGojjtkkVjnsJyLBd/2n/nu/IG3iEqJd8
         VISEJp5k89hHlTwknTwfEIyAMDJdI6J0vKMj0rjdpnaAkYVIyzsWmbsPQuKoniJ4ZHY/
         ybS1wcn+Ij2OFA5opFnvWFb5Gitg7bjREx50SnbwWo4/mfn6M7byfKlAec3fw7bRftO8
         3X6HdhQQDxu/NM4r8lzUNr86Q/usHhVhhQ8sUaN9eKUDuiyTW3KQaBER6yrr8zGdyqvG
         S6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8WUsWu+WDkJcn4CeG8tWfLig6GMVsRbCZOtSjwc5GA=;
        b=M7rH4R9oQ+pyROuohmjrKzTYVPIcgB4JwxspUVQSISAadJShV+5m1sny01YaGmZ2cO
         ZqtITob/LcQHcRGAvn3KLgBLcQU63zJDqGu8hsnRTyHc6nHjuqgaUnxbZg0pYOlbMO9U
         2W5IwX6XTQkG5VgzPnDPWukBhQDRWbPpA5T3Wt8CRoAlmyBty7dRp2XehlMwhb555dHe
         bzAz9uR9AF+TM+zHqqiChPyE+bhUFgyjCfL/j1t1bISuIaXfeor49yH38MSl2JNu/T0y
         W78najQy7r/DNrtHsPjYjXGYQ0YNeujPBpSyWFK9nx2zMfOrfPc2zsiDOOH5HQVElzLh
         jKdw==
X-Gm-Message-State: AOAM530Lav3HHZ6kFJhXbLfoKl2EY8lQMsiHK70wUTZLym5K8+lfI2eP
        xpxRXOns93rqOAnSSFBdjTU=
X-Google-Smtp-Source: ABdhPJwHKIyuwDeTFmyp2q3zTLbU7HZciLx18JOBVb3ayyd5qKamxiFgAe+YEQNLOvbrCHzupiN4jA==
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr4495342lja.39.1603664270018;
        Sun, 25 Oct 2020 15:17:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:49 -0700 (PDT)
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
Subject: [PATCH v6 01/52] clk: tegra: Export Tegra20 EMC kernel symbols
Date:   Mon, 26 Oct 2020 01:16:44 +0300
Message-Id: <20201025221735.3062-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to modularize Tegra EMC drivers and some of the EMC clk driver
symbols need to be exported, let's export them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
index 03bf0009a33c..dd74b8543bf1 100644
--- a/drivers/clk/tegra/clk-tegra20-emc.c
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -235,6 +236,7 @@ void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
 		emc->cb_arg = cb_arg;
 	}
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_set_emc_round_callback);
 
 bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
 {
@@ -291,3 +293,4 @@ int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_prepare_emc_mc_same_freq);
-- 
2.27.0

