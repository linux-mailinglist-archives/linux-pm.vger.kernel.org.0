Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4443E38BA1E
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhETXKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhETXKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFAEC06138A;
        Thu, 20 May 2021 16:08:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so26915272lft.1;
        Thu, 20 May 2021 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyIAF+FPDoF3L0c8SxBikD76UBKYvvu1WBUmyZdYlws=;
        b=dT782xigAvMZGuiMZUJtdzP8P1Ndn8d18C4nErOh7hlRxvjaJf68jCerk2cwRY2KNm
         BJuWyxoBHfEPECmT1fp90ZoPlyBpdihDwYGV1b7vUKiVFIK+clvD4thmaxLJaefzHsNi
         /ZgAJbhmRndPpbwUj9DDBaTLWdwdMCq0er8pw/pi7oMUQlm22ss/NG4PS2ZOCr2hfkTI
         VVAu1f267teP2Zr7GpmwEFEOmvBg3rQFhoeF9EMth0SppVP0BEinuXi240lJUVeo78GR
         seOSzsW9gC5YfcOFKaFLRC6oeTXTU1AkUwhWUBRM8BE1R2T4Sq+mpc9p9Zb+bNP4hdG0
         aBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyIAF+FPDoF3L0c8SxBikD76UBKYvvu1WBUmyZdYlws=;
        b=REFb5PuB9sJJgSNopNYXE9BgBKabUbsg9x1/E74H0e8XaSVBrVAYCnDwr0Ifh0/m3z
         ewurCA+hO8MbUdUsvpSAS+abdhvFAXxh902hqcwjPU6OwUIa03CGRRubt9LscNS4FIAP
         CYXuasJJ33tDTXcbgSsnBHYVwNmJuZ0xYZRvyWGwzjfp4VkHmz1Ko8pyGb2FR/eMCcfE
         FSTy/ZoRMEX7Wkh2lAVGpRe0Imcuz1awazHfeQrpzIuVFPRlyU3sEJ/6B4CPWc6UpPU3
         4kK6jL6F897fydSGTn89L72UhGqWwhdGQpJPGHvWTHRC89GXrJ5yjNsHYpB5B9k7uvsJ
         KP/A==
X-Gm-Message-State: AOAM53185EQliGKtpLUoVhksx/OeDZVpzqsw0vLMctGGiVVZ4kB7Y04R
        pQ1cV4BSMqLfY4GiJM6Ag2k=
X-Google-Smtp-Source: ABdhPJy6gBEFQ+VAaEcZ0Wm4eVWqnt5KdO8Hlz/U9iAczXGHQicCANZaveV3uNCn8FnHiIvcLcfP0g==
X-Received: by 2002:a05:6512:40a:: with SMTP id u10mr4623215lfk.341.1621552124459;
        Thu, 20 May 2021 16:08:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:44 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 06/13] clk: tegra: Add stubs needed for compile-testing
Date:   Fri, 21 May 2021 02:07:44 +0300
Message-Id: <20210520230751.26848-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs needed for compile-testing of Tegra memory drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index f7ff722a03dd..d540b2879c26 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -144,17 +144,37 @@ typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
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
+#endif
 
 struct tegra210_clk_emc_config {
 	unsigned long rate;
-- 
2.30.2

