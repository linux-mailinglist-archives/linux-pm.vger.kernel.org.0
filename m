Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822C5E3F33
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJXWRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32974 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfJXWRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so7772lfc.0;
        Thu, 24 Oct 2019 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnvZcm6xKDLd2C8gFoE+9zB1+dwZoNg7mIGeQbYm6u0=;
        b=WBt16machypnf8vXgx6SaWWCqVK2vN8ZeF1F/XX1prEthRsZhCDDCd815rz1Szg6Lb
         +u+07FOpbusTfQGiooeBXmWKb7hMEEKgggu+xAsPe0nUanydzAcLj3yIcmhYzq/roNHl
         qAIrLnRR8cRp8H21b07PHyTZDC3SvRilKGUO2AA57sBcnEbnEFiPMSZVhwDcVF0v1oZ9
         RrSXBT1h7eT9YDWDiL/WD4MZkBKnG7SeU2KLNqEhWfd28vsTXtssVs/vhKvFSNg4jNTX
         yVxlW9HTgwYav95IEnsD5Barty995epv3ECecExnvem4G33MundmonNs/7M00Mtk8qRi
         srig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnvZcm6xKDLd2C8gFoE+9zB1+dwZoNg7mIGeQbYm6u0=;
        b=ZF/RGrk9/77gAtycmD7aexZNXMMMU8uj5wTMSbrwHUGyX85IDTWZ46a1gEMqKb5019
         eNK7+DPmuKWvwEIR4WgXcExTF/7VZrzpZEDxtcQ6RK4We68a91Kd8/C3pqgfBB5vyYwd
         tfekfFtdb61OeDAN5ziW7u9WknkV10PKQN+tRhDGGiknYCTbJ/1zvPQ+okqiS26S2R9R
         n8Mjgw5KJadUuBXj5ze2/qvKhaDKAjuFzMHH+kInYBwQk03YB0lbdwavSkae2hzxjWWk
         pnRcr5UcNoMg1cuTFtEfpZGDLuAtrUcdaB1iVTHpfIRt2ccR5YQ3EJechfDJgxsJyAUu
         6ocg==
X-Gm-Message-State: APjAAAXHCOkblDg33dTXg1hD7S3kAFeq1gijf8vGFOpGYWPLCb/e0Uum
        8G9Rny9AHw6YDHYQNQm/Oxc=
X-Google-Smtp-Source: APXvYqwJFtwQMWi+G5LTgk/NjJLB6DxGx2LqodWQ0Bu4voTBHOYCc4OjX/PXeEUXuMsEBoEmiu3t8g==
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr314093lfd.49.1571955459436;
        Thu, 24 Oct 2019 15:17:39 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] clk: tegra20: Support custom CCLK implementation
Date:   Fri, 25 Oct 2019 01:14:03 +0300
Message-Id: <20191024221416.14197-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to switch to the generic cpufreq-dt driver on Tegra20 and
thus CCLK intermediate re-parenting will be performed by the clock driver.
There is now special CCLK implementation that supports all CCLK quirks,
this patch makes Tegra20 SoCs to use that implementation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cceefbd67a3b..bb3d84182b78 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -391,6 +391,8 @@ static struct tegra_clk_pll_params pll_x_params = {
 	.lock_delay = 300,
 	.freq_table = pll_x_freq_table,
 	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.pre_rate_change = tegra_cclk_pre_pllx_rate_change,
+	.post_rate_change = tegra_cclk_post_pllx_rate_change,
 };
 
 static struct tegra_clk_pll_params pll_e_params = {
@@ -704,9 +706,9 @@ static void tegra20_super_clk_init(void)
 	struct clk *clk;
 
 	/* CCLK */
-	clk = tegra_clk_register_super_mux("cclk", cclk_parents,
+	clk = tegra_clk_register_super_cclk("cclk", cclk_parents,
 			      ARRAY_SIZE(cclk_parents), CLK_SET_RATE_PARENT,
-			      clk_base + CCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
+			      clk_base + CCLK_BURST_POLICY, 0, NULL);
 	clks[TEGRA20_CLK_CCLK] = clk;
 
 	/* SCLK */
-- 
2.23.0

