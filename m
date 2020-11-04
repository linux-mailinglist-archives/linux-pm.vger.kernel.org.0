Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160752A6B12
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgKDQte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgKDQtd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F4C0613D4;
        Wed,  4 Nov 2020 08:49:33 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so5744292lfc.4;
        Wed, 04 Nov 2020 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crJJm+NJzX9nNGfEw3yeviT1h3BYRo8BzSQA7+fLOns=;
        b=GIW9qAMdCMH2xtWA68F2XwDqytaBnWVGD1ga01N0NTSOrl8CxFhZbSLz8FlPcfkY4K
         bxTV5U0FHL8cHzww8fIOe8gSlFw/OLqA3ZpsoY409KGElyH+1hlYCoraDe34iD1UD6R5
         wwS184NUI/ja1ZjaVJ6YMG2H6jFK9vLQbEAJc9gSwL6Scp8P6H94gezgbYiX6Nk8ZD6J
         3UuP+REx+n65fzrGi4UjHJynleoqj1NAnotzHg79F9IUHz+bCPkmM7DBtenNvsEsszkI
         QoMas1l7Z27AQ8YN7AONii81cQbJBeladQanNyUuzDn1hUY9lRjzOSPlxEfAoqwr30qS
         4P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crJJm+NJzX9nNGfEw3yeviT1h3BYRo8BzSQA7+fLOns=;
        b=o++xsp8g+mXxOnZy5+TTQJp51ofVU9mP0X4Vt4UmDBdwTxvGUDzNimGeJwxsZJq9br
         9OGvocz7H2xFSPfHLFUbGKjmItQtNovgVLX856fRXnSvJnB7Ocnl0W51FBvxpPg2UjrX
         +Q1dycZoMEk0RyB3zeNBfkCI7u4RBaUrHHvzY9VYGMO/VvisjLESeVfuADaW1CtqzXH4
         EZsySl/aFaK9bBu0QRZO+PKyPCEL+0WhtYuL6I5zhPf8ktKuvaw2efrkSsk49KiHZaww
         K91PXsOufwae8j3kjwveemi2pVZXJAxGRmzDZOoz4uzDTOD3q0efowYNM7HSFrApkSNv
         qKWg==
X-Gm-Message-State: AOAM531MvILm5H+p53r/MOXVTRx3sMJYIN3SdmypgNqo+3OcRKzU0nvm
        Pyrb6OwGKLyXfJIZdPNm3mk=
X-Google-Smtp-Source: ABdhPJxOl7/JqZ7qhE8E22tCWDcsvDG+RX5n/zXPK169JDaNrnMVeePskTl+GlbctB+qjSNT8+N+vQ==
X-Received: by 2002:ac2:5938:: with SMTP id v24mr9168385lfi.228.1604508571556;
        Wed, 04 Nov 2020 08:49:31 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:31 -0800 (PST)
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
Subject: [PATCH v7 01/47] clk: tegra: Export Tegra20 EMC kernel symbols
Date:   Wed,  4 Nov 2020 19:48:37 +0300
Message-Id: <20201104164923.21238-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to modularize Tegra EMC drivers and some of the EMC-clock
driver symbols need to be exported, let's export them.

Acked-by: Thierry Reding <treding@nvidia.com>
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

