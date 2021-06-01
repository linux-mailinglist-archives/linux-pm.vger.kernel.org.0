Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72E396B38
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhFACfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhFACfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32306C0613ED;
        Mon, 31 May 2021 19:33:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so19333270lfc.9;
        Mon, 31 May 2021 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEKPn5zr4I+8/AtOiSwHRKGzHnBRRsPHcHwAKCmzMDQ=;
        b=M7xcUEBjgTYIoHxwMY5XEeYSwsgZ/t54BNS6IrUkxPqnIRY+aVCERkHF2KFbRDKQ91
         DROoeUqb/0Tsr5YMMbVW66qAQeZMAQwJRM6upLTAVFCsSOh8UBrMpvUpYPsw8BvFcjlx
         hOUC2IRPnle2o3oH/HlXVP+biyBVxPs4mYwAXiTTF9ij5pMRIpDMPf9JTYQWsWdd8MYT
         nTrM7iStq0tJMv2WaTtJB15SoKudp9pENaFZ2xEnB/2J2q7zP40ijktd3RhMdC0wat6C
         9fr3IYVKw+ktd2DsMQsa7fVpTnc34di08QL/AAnU3KpqcLUwp5P20OBgpPBWoVGiNAyS
         k7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEKPn5zr4I+8/AtOiSwHRKGzHnBRRsPHcHwAKCmzMDQ=;
        b=Srjzcvz3b+nN+pRWCD9LFBLt6ec+hvmkBZ9DpBiorZcAAuz/844mWvVNCCeuZdnZpR
         wA3ZPBeLUgKGicfX/2KYr1vIojOrD4gCFJ9aPcP0n++UhbUWgziuYk/Ey2YoYkXtBv/T
         YwDssPDeeX8b8HexXeZrumxb7ek4DZWCH2FyHxmbA9tJjDuXP+q9Pj/D4YThyvPfh6N9
         pBQSrVpxGSMvcfu0tOWYDmUBHwzkRYSiGy3obHmcePKns6r+sVgfpCx+OPypqI+wuljh
         Bp1ObvEyOILISAF4ERSMG5Ctt77a3K5lREOmwqEV6o1Oz2WVHxzaE1Sh402tMrbpqugO
         x7Lw==
X-Gm-Message-State: AOAM532Hr5ASO6gV9dQDkaQz9J16olQzIVXyRsxoZOBZIGs5hQg0G8U3
        kOVZnoGu1w4JVIx+DHq6wOsc2widISM=
X-Google-Smtp-Source: ABdhPJwZgh2Z6z6+CxO/d1gYET2V2YbSCubuNWwTGgVA14vv/UP53NaD4WMi0xcIio3AKPNwdfb2Hg==
X-Received: by 2002:a05:6512:118c:: with SMTP id g12mr16600133lfr.316.1622514809555;
        Mon, 31 May 2021 19:33:29 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 06/14] clk: tegra: Add stubs needed for compile-testing
Date:   Tue,  1 Jun 2021 05:31:11 +0300
Message-Id: <20210601023119.22044-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of Tegra memory drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c   |   5 --
 include/linux/clk/tegra.h | 100 ++++++++++++++++++++++++++++++--------
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8e3b78bb2ac2..4a582eae82ef 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -743,11 +743,6 @@ static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
 	return err;
 }
 
-int __weak tegra210_clk_handle_mbist_war(unsigned int id)
-{
-	return 0;
-}
-
 static int tegra_powergate_power_up(struct tegra_powergate *pg,
 				    bool disable_clocks)
 {
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index f7ff722a03dd..d128ad1570aa 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -123,20 +123,6 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
-extern int tegra210_plle_hw_sequence_start(void);
-extern bool tegra210_plle_hw_sequence_is_enabled(void);
-extern void tegra210_xusb_pll_hw_control_enable(void);
-extern void tegra210_xusb_pll_hw_sequence_start(void);
-extern void tegra210_sata_pll_hw_control_enable(void);
-extern void tegra210_sata_pll_hw_sequence_start(void);
-extern void tegra210_set_sata_pll_seq_sw(bool state);
-extern void tegra210_put_utmipll_in_iddq(void);
-extern void tegra210_put_utmipll_out_iddq(void);
-extern int tegra210_clk_handle_mbist_war(unsigned int id);
-extern void tegra210_clk_emc_dll_enable(bool flag);
-extern void tegra210_clk_emc_dll_update_setting(u32 emc_dll_src_value);
-extern void tegra210_clk_emc_update_setting(u32 emc_src_value);
-
 struct clk;
 struct tegra_emc;
 
@@ -144,17 +130,10 @@ typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
 					unsigned long min_rate,
 					unsigned long max_rate,
 					void *arg);
-
-void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
-					void *cb_arg);
-int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
-
 typedef int (tegra124_emc_prepare_timing_change_cb)(struct tegra_emc *emc,
 						    unsigned long rate);
 typedef void (tegra124_emc_complete_timing_change_cb)(struct tegra_emc *emc,
 						      unsigned long rate);
-void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
-				    tegra124_emc_complete_timing_change_cb *complete_cb);
 
 struct tegra210_clk_emc_config {
 	unsigned long rate;
@@ -176,8 +155,87 @@ struct tegra210_clk_emc_provider {
 			const struct tegra210_clk_emc_config *config);
 };
 
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC) || defined(CONFIG_ARCH_TEGRA_3x_SOC)
+void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
+					void *cb_arg);
+int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
+#else
+static inline void
+tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
+				   void *cb_arg)
+{
+}
+
+static inline int
+tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_TEGRA124_CLK_EMC
+void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
+				    tegra124_emc_complete_timing_change_cb *complete_cb);
+#else
+static inline void
+tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
+			       tegra124_emc_complete_timing_change_cb *complete_cb)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+int tegra210_plle_hw_sequence_start(void);
+bool tegra210_plle_hw_sequence_is_enabled(void);
+void tegra210_xusb_pll_hw_control_enable(void);
+void tegra210_xusb_pll_hw_sequence_start(void);
+void tegra210_sata_pll_hw_control_enable(void);
+void tegra210_sata_pll_hw_sequence_start(void);
+void tegra210_set_sata_pll_seq_sw(bool state);
+void tegra210_put_utmipll_in_iddq(void);
+void tegra210_put_utmipll_out_iddq(void);
+int tegra210_clk_handle_mbist_war(unsigned int id);
+void tegra210_clk_emc_dll_enable(bool flag);
+void tegra210_clk_emc_dll_update_setting(u32 emc_dll_src_value);
+void tegra210_clk_emc_update_setting(u32 emc_src_value);
+
 int tegra210_clk_emc_attach(struct clk *clk,
 			    struct tegra210_clk_emc_provider *provider);
 void tegra210_clk_emc_detach(struct clk *clk);
+#else
+static inline int tegra210_plle_hw_sequence_start(void)
+{
+	return 0;
+}
+
+static inline bool tegra210_plle_hw_sequence_is_enabled(void)
+{
+	return false;
+}
+
+static inline int tegra210_clk_handle_mbist_war(unsigned int id)
+{
+	return 0;
+}
+
+static inline int
+tegra210_clk_emc_attach(struct clk *clk,
+			struct tegra210_clk_emc_provider *provider)
+{
+	return 0;
+}
+
+static inline void tegra210_xusb_pll_hw_control_enable(void) {}
+static inline void tegra210_xusb_pll_hw_sequence_start(void) {}
+static inline void tegra210_sata_pll_hw_control_enable(void) {}
+static inline void tegra210_sata_pll_hw_sequence_start(void) {}
+static inline void tegra210_set_sata_pll_seq_sw(bool state) {}
+static inline void tegra210_put_utmipll_in_iddq(void) {}
+static inline void tegra210_put_utmipll_out_iddq(void) {}
+static inline void tegra210_clk_emc_dll_enable(bool flag) {}
+static inline void tegra210_clk_emc_dll_update_setting(u32 emc_dll_src_value) {}
+static inline void tegra210_clk_emc_update_setting(u32 emc_src_value) {}
+static inline void tegra210_clk_emc_detach(struct clk *clk) {}
+#endif
 
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
2.30.2

