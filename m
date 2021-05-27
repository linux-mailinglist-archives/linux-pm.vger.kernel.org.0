Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACC39382F
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhE0Vpi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhE0Vpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D94C061574;
        Thu, 27 May 2021 14:43:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f12so2744820ljp.2;
        Thu, 27 May 2021 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh0E0lNRUm1mrVubbzi0uRUQqD90YPh9J/68C68CTo4=;
        b=tASIXFyXaDCeMIO4ddGAWBmvP+rds3oBoNUROaxcPy5Fxq4yXmHHE1yB2xECmAEoum
         9zQLWIxwTZVaHoddNL89BzoEzij+lFdH7N6M0td4GP9zSk/fk8ke0aD5cM0bNG0CBJJH
         YJTkzJFVlWwIfxzP67YeKMo+6lrNQrQ6jVdx5D3rk+E41Cr4CbaJly916NoNv53NdztT
         kbj61xqYdxcQFZcfEYykjL63XMUEK2zOKnUnnl1uQVo3oQAkX47Gcm0LQFHWMSngnL2u
         pjtXIQWeFVztinrPNEeaem5YMSHz8btjG2spC/nCZAkQPLwlUXPDpu9UbGOCLKlmV2bc
         pQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh0E0lNRUm1mrVubbzi0uRUQqD90YPh9J/68C68CTo4=;
        b=l73FRe3gjtLayIFQbsL+Za8XnCu70pKVK+mBu6WScT8N5ChBT3s4xA6Brm/uv++asn
         LkggrDRNY1ksqzGbrMoAKppQPRfsSUPuYHrIrYYX/33xTI7SIH/VvQIHoTMbnWye4hL9
         VrX/ZuWqvZfHLR874ooZiH2LCi1ms+Rcs7dDcRqCj5zPWFsFxngCHfvtDMOiJeicTpcR
         hfXXowZbeW/Zk1/m70flLaKrXq2d60gdwpwpBgvvqTYJNoEkdCyOQb+QZzvhgG9bZbLI
         zQKZyXSWkfB8W3ftWUoZGDONu11WyhMcQE1cNdClAR7ae72iu2R9JHidSHV0sqNx58kM
         lpSQ==
X-Gm-Message-State: AOAM533yUewehz+5Y5P+gw6Vm+resi3BKF2jRtSWUFgnbFVCoDxx52fT
        YCThweklomxQgN81W/Jl8KM=
X-Google-Smtp-Source: ABdhPJwM2v2Mzl5LZqO4KIJ438Dt2O4ZQcOKGkfmLB6drauwY2cCHmnc/2OgosEOpw0cvwtkwvC2ZQ==
X-Received: by 2002:a2e:b161:: with SMTP id a1mr4131874ljm.426.1622151836687;
        Thu, 27 May 2021 14:43:56 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:56 -0700 (PDT)
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
Subject: [PATCH v4 06/14] clk: tegra: Add stubs needed for compile-testing
Date:   Fri, 28 May 2021 00:43:09 +0300
Message-Id: <20210527214317.31014-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
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

