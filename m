Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE39539376A
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhE0Utl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbhE0Uth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C31C061760;
        Thu, 27 May 2021 13:48:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w7so2564724lji.6;
        Thu, 27 May 2021 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh0E0lNRUm1mrVubbzi0uRUQqD90YPh9J/68C68CTo4=;
        b=K+SZRhJvmrFYEcoQ7qH4v/W+bWF3fdWIkY1tjIdM6r8sxF5qMwM50I/pJdQNxPj2Hz
         JPTAT2IvOf88TI7F1uheLfbw2dKNT8QtvDTH5fnm1Y+FJg0X5XRTRb4Rr7fnHdXBeMQW
         vL+m+UQOSxFXDAbmtZFIHQw2/0lhbplUelvIsw2l40cO5sWfeAfjQsmTGHQYNsm/fFvL
         2bJl6BpWYPig+6qenh+ZtgkwweKA+LUcuMyEhXgmJvjYRpm61M3x4+hEsIOdzHzE6E6q
         oc6gS9sPLkd6YcXjNvOAZmuxRJW91hEB5EgGchHsxA8iQPj8dg8FUoqQD44aV3axX34G
         QE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh0E0lNRUm1mrVubbzi0uRUQqD90YPh9J/68C68CTo4=;
        b=ikAB0gDvobl1vQRVXimS4V9MUWsOq/4BKA0R8AdoLVg59cqgMJREIa1D1DwIg6851+
         sU9Rjut0ozDb7d+fgapUKJOX69Zc2aSpSFU2L4nfyUOtZyhrFUt8AlEH9dyxzdwV0xCa
         AlqtuHWHHCiAv4Q0v2uGR1Z73b+DK3Efqvqyk57NQDdNyvcTn0bZIWyVSU9TLomRcSvs
         rLxUt6TjICfVVZgOYxQBTAvUMpeF36CZQ4uv9hzt6MH/ECRCtpofoPikU5nD4KqLvbm+
         d6oXVHMH0gO4Ezbj3XZ/AAlRONKA6mFH3sYCAKjmkNcWMpru39IfxHF1H47w3cJuKPMn
         wkAA==
X-Gm-Message-State: AOAM5314UTWUx82bixzwGsYc9H3qMEbhzXIPY/B8pjVV7v16KKcVWc+9
        q0DXoWCPEYh5qAoF5HL2JWM=
X-Google-Smtp-Source: ABdhPJw8zFp4MTPGT8xbzVVgCj8sNyzKGTPxHysbj/43ISJH0KtpgLb58hcr5socKchaufBL9l1ZqQ==
X-Received: by 2002:a05:651c:106a:: with SMTP id y10mr4122729ljm.470.1622148480721;
        Thu, 27 May 2021 13:48:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:48:00 -0700 (PDT)
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
Subject: [PATCH v3 06/14] clk: tegra: Add stubs needed for compile-testing
Date:   Thu, 27 May 2021 23:47:34 +0300
Message-Id: <20210527204742.10379-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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
index f7ff722a03dd..5667fe7a979c 100644
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
+			struct tegra210_clk_emc_provider *provider);
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

