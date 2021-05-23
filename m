Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984A738DDD4
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhEWXP3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhEWXPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1CC06138D;
        Sun, 23 May 2021 16:13:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q7so36646539lfr.6;
        Sun, 23 May 2021 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6nNCg6w44EnqtNmMEubKCZTEUERIWb1cQ6vIVM7Yhc=;
        b=SKiI0dYAy0AxhK7iFOdyVMFfkamwRM9/NajcvORTKgZ1EHUKwawTN28SmjFVC2toNm
         3VB9tfnY1I5xjw1EE472Er7KVbk6W85NKXyXUk+7E7OZ6V4zvUE377z+uz86CPtDEI1F
         OP9TACSb/xWcIE86oyo0qWgs6b5fGfxrYZFsWWc/lZqKpJmfqrUCh5e1DeEzEDMyaP23
         6vxTOdiThVgbKViYE154QI1Vdjg+2gTX6sZ+G2WvXsu3iFGsrxrVSpcwcv6V4S53hd/s
         8qF+hqNO+zwQ93Dx1oZL5eD3tRrPmbHPsMinvfpEBhIhYdq91X8QplFl3IVdclKRICwI
         2lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6nNCg6w44EnqtNmMEubKCZTEUERIWb1cQ6vIVM7Yhc=;
        b=sAcr3I84NiOMAA78sCl3r17h4OpCf4j4sgcENrjKs+SP9/SbIkx0dY3/OIZ8KJZn5h
         QKfAe2Evb5BOyMTzfzq+JhsG3Rn/P4N02ISCdO/WEALLyJJ1BkzapDtES6jajyLAThZB
         VRtl4uN0iI2CfPYZXerkyu/9pLnBL4tnKp8UsIPri8gaQxoCiWEWo0X6jGAxzsm/lQaR
         +1A2OuVlXadIAffbf31pLr/Dx4DvtODz2SBF77MvcRzMAYIVFjpM2oCcW1yg65CTg+hA
         kqiK5rnqk6P3pfK9ub0xVKXwwKfvHYG/ZyXj5cy7UwzlzCZmCoes7iFrq6wFln/AcWtP
         5ADg==
X-Gm-Message-State: AOAM532dvKA5CQahpU6zQ2oL/UYfoZxtFofsSVzZdjmbwQZ0Ze7znNXC
        Yws0BUljKUD3mv1pwb2BbIA=
X-Google-Smtp-Source: ABdhPJzMrcceHn4DqExdNKXA6k4t8b6TnPLkJTv5eqq3KugebcpUjrZrjxR0un56rWGzbgOvMu0/oQ==
X-Received: by 2002:ac2:5a0e:: with SMTP id q14mr8736824lfn.506.1621811633120;
        Sun, 23 May 2021 16:13:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:52 -0700 (PDT)
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
Subject: [PATCH v2 07/14] clk: tegra: Add stubs needed for compile-testing
Date:   Mon, 24 May 2021 02:13:28 +0300
Message-Id: <20210523231335.8238-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of Tegra memory drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 82 ++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index f7ff722a03dd..3dab36dcb534 100644
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
 
@@ -144,18 +130,78 @@ typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
 					unsigned long min_rate,
 					unsigned long max_rate,
 					void *arg);
+typedef int (tegra124_emc_prepare_timing_change_cb)(struct tegra_emc *emc,
+						    unsigned long rate);
+typedef void (tegra124_emc_complete_timing_change_cb)(struct tegra_emc *emc,
+						      unsigned long rate);
 
+#ifdef CONFIG_ARCH_TEGRA
 void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
 					void *cb_arg);
 int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
 
-typedef int (tegra124_emc_prepare_timing_change_cb)(struct tegra_emc *emc,
-						    unsigned long rate);
-typedef void (tegra124_emc_complete_timing_change_cb)(struct tegra_emc *emc,
-						      unsigned long rate);
 void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_cb *prep_cb,
 				    tegra124_emc_complete_timing_change_cb *complete_cb);
 
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
+#endif
+
 struct tegra210_clk_emc_config {
 	unsigned long rate;
 	bool same_freq;
-- 
2.30.2

