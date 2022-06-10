Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D56545ED7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiFJIZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347726AbiFJIZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 04:25:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921D401BE5
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x138so1437381pfc.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUzjpkdJ+Oncv2pX+1niDcaxvElVVVJiI1pxvyK4stI=;
        b=OVEHPpNyDybpByzG4Og2VhdQn9E3yN7w1x1PHJ5Ue3QyiL3Zht3ZifjplCx2lqka+9
         RKe2QfEAwUYpqo+Dvmf68WTvmtcyGFkZYTngl2BGmBFDHd+vY7LkSTWGAKryQ9XCvZ2O
         JHng0+Q1ZqGnStUDaocqHm2KV6DoL1Zkz4XLjVoT5NfBclEY/af0QkuZ/auvuMBFDrL6
         HrxUUJ+xKe1pvo+B4FsPvqYTc1cogDL3Txll0g+pOMSFDDDkYSyfEgT/qalaAWFUVcUK
         +YUyjx+MkDb6RkZmN1AVkLF9tdddWBxkMnVcJV8ZC1KeklgMSnWraKHtW9B7jHShOkfp
         Qngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUzjpkdJ+Oncv2pX+1niDcaxvElVVVJiI1pxvyK4stI=;
        b=5ihz9FPI0xUKFU8kWJioehBBbetRyp58ZhWfPGqqJ0o6/nDzttfltOctpM73VOs4Xa
         iEstunUNr18Udgx2e7RJ1uRPAD90cvgkk8uN+0EhWBiSxnV21YFR1a4psqKPxR69e6wH
         53rE4fwqnFwSJGrVTc3/eFcyAvjw/nm/Dw7wGWqtmrOm4pixTl+rUMBv+Nl95nfJFhc0
         D0iIugssqijth/l3pr6nCk61r5qe2vfREuuK87juvnwz42XYcE/TWxK43si1cviygzlj
         WoMR9Cek+YEJKIiCMOYh3g3hKGGcVG9uyf3hEGxTTk1jghYfJuefZsvAJpxJvuZNY5dx
         EACw==
X-Gm-Message-State: AOAM5326hYGObr0CFpLz6xd6cSIbf5l64ySkE5kOhPQenozoVbHDEtYh
        s6skAPDqbXECRzpGU5OGuESpFQ==
X-Google-Smtp-Source: ABdhPJy9fS1pS+m8xIVzcpT20JbS53iP38zAf+tndvGYCAK/poMTbNC3yPmuG94w0SE9XKervmyW8A==
X-Received: by 2002:a05:6a00:1992:b0:51c:391f:6ff5 with SMTP id d18-20020a056a00199200b0051c391f6ff5mr19345170pfl.16.1654849287665;
        Fri, 10 Jun 2022 01:21:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b0016777b33d41sm10318730plm.294.2022.06.10.01.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] OPP: Provide a simple implementation to configure multiple clocks
Date:   Fri, 10 Jun 2022 13:50:52 +0530
Message-Id: <76c4db9b37866c60306d39ed982cba56af15ff00.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This provides a simple implementation to configure multiple clocks for a
device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 ++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5635f4ad6d59..bb7be115a0c9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -825,6 +825,40 @@ _opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
 	return ret;
 }
 
+/*
+ * Simple implementation for configuring multiple clocks. Configure clocks in
+ * the order in which they are present in the array while scaling up.
+ */
+int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down)
+{
+	int ret, i;
+
+	if (scaling_down) {
+		for (i = opp_table->clk_count - 1; i >= 0; i--) {
+			ret = clk_set_rate(opp_table->clks[i], opp->rates[i]);
+			if (ret) {
+				dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+					ret);
+				return ret;
+			}
+		}
+	} else {
+		for (i = 0; i < opp_table->clk_count; i++) {
+			ret = clk_set_rate(opp_table->clks[i], opp->rates[i]);
+			if (ret) {
+				dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
+					ret);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_config_clks_simple);
+
 static int _opp_config_regulator_single(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 74fbb7515128..8e69b4e971d0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -162,6 +162,9 @@ int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb
 struct opp_table *dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config);
 void dev_pm_opp_clear_config(struct opp_table *opp_table);
+int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down);
 
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
@@ -345,6 +348,13 @@ static inline int devm_pm_opp_set_config(struct device *dev, struct dev_pm_opp_c
 
 static inline void dev_pm_opp_clear_config(struct opp_table *opp_table) {}
 
+static inline int dev_pm_opp_config_clks_simple(struct device *dev,
+		struct opp_table *opp_table, struct dev_pm_opp *opp, void *data,
+		bool scaling_down)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 				struct opp_table *dst_table, struct dev_pm_opp *src_opp)
 {
-- 
2.31.1.272.g89b43f80a514

