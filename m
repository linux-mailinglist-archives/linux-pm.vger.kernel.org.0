Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA45393996
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhE0X4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhE0X4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91EC061574;
        Thu, 27 May 2021 16:54:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q7so2638784lfr.6;
        Thu, 27 May 2021 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnerspnEzqAlo5tFahbuBNU//nCYjRUznFzUAfdsm2c=;
        b=W9VQ2wIL8udELW+mjeEANbSp0NbMpqTcWd3zzQge3KVAPke1ePmuxSsBo+tjVfj6F7
         Vcek1WDmZce7Nn1lbwxgU91PhSsILH3prUTmhkwBWYX7gOrFKmD8wJiq/1L2vBRde6ml
         YQrqRXoXw3ZB9uEISq28rVX3h9gmK10aw+fmd0pNEJguvf5t+miLyG1WXXqBEDUyrKgR
         EaWFhNaSeZCjq8HNvCsjjf8dT2pvLPiMzbhwPomdUjeBtQl4jV5wlxNa5ZzB8UFuETpf
         CgQc6zuygUW/CFMVTuoj7VZr3ZJqzn/DTvyVl3ON8GcUOdDK+QeCqd9P4gCEM5AMMW00
         rKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnerspnEzqAlo5tFahbuBNU//nCYjRUznFzUAfdsm2c=;
        b=duCBvKpZO858+0sZ7Dc9kSbJS84f3ohFLwutzjAjfH8INmZ0moY3E3xiAG1lhnNjBz
         jbUBCEg2s9psYoXynukdlH1YdryuzEjg41WLJbLsPjbBj0qrz/k8whOBUAeD+s8L3Rxw
         CuFNtm+jsY6GSrseFH9fSbu0UvDRIVr/H22txZv7LdKW27lUj6jcitB+/gzthjAcVJls
         LanoRnrdhMXaJ78pIqWA285nKcA0FZIjsjwaZ1wbTPfTo2DFpIVL6C/Gu1KZlC3i+e2I
         fqTyR1QIpXCiAKJA7VTUAzdY2N2Go8A9Uk/l4YSmw081Y4DOH473ejoxVOOiYqdPiVUg
         CZsw==
X-Gm-Message-State: AOAM5323vfeRYHl6pCbfjW7SmsFTeJgfY9AnEx7Em0EDbvQ6qbbKgcnb
        5+lT8mNO6mlHyWssLMxrQf4=
X-Google-Smtp-Source: ABdhPJx64pQjQFmCdpu3GQu/S6DWgFWLmvpLv1srmJm9lgnb8y6KEbK2MZdnrpljTJwOS7G1Hb6mBw==
X-Received: by 2002:ac2:520a:: with SMTP id a10mr3975038lfl.180.1622159663729;
        Thu, 27 May 2021 16:54:23 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:23 -0700 (PDT)
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
Subject: [PATCH v5 06/14] clk: tegra: Add stubs needed for compile-testing
Date:   Fri, 28 May 2021 02:54:05 +0300
Message-Id: <20210527235413.23120-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of Tegra memory drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 96 ++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index f7ff722a03dd..9400f0554c60 100644
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
@@ -176,8 +155,83 @@ struct tegra210_clk_emc_provider {
 			const struct tegra210_clk_emc_config *config);
 };
 
+#ifdef CONFIG_ARCH_TEGRA
+void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
+					void *cb_arg);
+int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
+
+void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
+				    tegra124_emc_complete_timing_change_cb *complete_cb);
+
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
+
+static inline void
+tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
+			       tegra124_emc_complete_timing_change_cb *complete_cb)
+{
+}
+
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

