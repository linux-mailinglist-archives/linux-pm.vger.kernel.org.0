Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6748024426F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHNAHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHNAHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9306C061757;
        Thu, 13 Aug 2020 17:07:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so8109669ljj.4;
        Thu, 13 Aug 2020 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8WUsWu+WDkJcn4CeG8tWfLig6GMVsRbCZOtSjwc5GA=;
        b=ReKpF9Nh4A3O2mffo48Cg8bRKlALwqgZzoJI2At2j2+5lQLElla390fe/XZrKLdYU+
         wQj8DlEEdYBcZzQn+T49smT/PhDHeTgjpMpS1MaERuF1gYFhd0lLcNskFacKhV4VVwFp
         a75irKF9g1zK8taydsdmGxosWKWUqdCvVYYYG4nWFH+fbXUqcMtfVeH/vYCk6bL0BL1b
         Nf7Ovi6hPoON3hmGi9Itsz3H31az/AuGqSgIJ8xcf68k3CTOOr/e/g24RN8Fsl9dG7qK
         5v0MCRKjYTFgNM2Ty5rQGxkxKfYoQgXycbZAA/JwKQeRIep2Lgs2krSJJbZVcKX6sbuz
         NIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8WUsWu+WDkJcn4CeG8tWfLig6GMVsRbCZOtSjwc5GA=;
        b=kHxrYjq3KYjoBSEjAqNST4MAj2QmUqT4bhKimwEO9ja045JCytd+0YoNyJ3WKhx/El
         9ICtutgbZKPRzs/XMCE0bLe0dMoCkmo/LkTxKT2K6LgjoAbusnjr+J73Wi5NFMN1H92a
         4s7FmAKTq2ZZTOnWT5J65CGYHIvotWDJvAUc/JkXuL9ismD+0kxy5tXN9spocCfZVABA
         xqdS3JtfbQrxBZdzuNRnTTdSW25gYpvWOpsH8wsh71OErO6taTBgMt+oXbr/3glJAW8c
         PbPoPN33JRbflqK5ty6YbK2VBh6c/d5uZWYppaiSkxYtqPvdg8GBpKbuu/0hubeTL6QI
         T3yw==
X-Gm-Message-State: AOAM532jKCczRW0QgcODMuXWoe4lUWfvjXbR9P7hm43lt5k4+PRSMj1L
        eXCK9FxmgEuN3JRbF7ygnvo=
X-Google-Smtp-Source: ABdhPJyGDXB6vp3xne6wt6r4gyLq9ymwRWqza2AIFAfNX3uUqYlDJIshUgPgyxS5zOcVTprilhAViw==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr115493ljg.406.1597363624295;
        Thu, 13 Aug 2020 17:07:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:03 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 03/36] clk: tegra: Export Tegra20 EMC kernel symbols
Date:   Fri, 14 Aug 2020 03:05:48 +0300
Message-Id: <20200814000621.8415-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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

