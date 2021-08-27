Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE63F9201
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhH0Bir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhH0Biq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DE2C061757;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq28so10938959lfb.7;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqOLBs3Nwyu81nR7iG6dy0Zgt3vhXrekmHkbrh0BHsc=;
        b=AXFhQ7PtFQcCfglLz4K5e3Z12xgItnECaCKjR31sF97ooC4qWRhHhIf1sZEo/k++K0
         +x4lJlpTWGlncypKT9nipNZ90fk3DzbnZ3GTD5HujO/S1wTzbITB5NojUlgyd9YgYUCG
         chrgvRsSuNO/sDrXgTy36poq1FsdjV5GPc+Ov8PnrbBVdPHonFmmui48yq5Xfmp6fLUW
         L9gVMJ7LWZS+ExqyvpAqZgN/jv75Cm9LJGu5dOKdOPIEANdXNkvnIpXRZX66IOt8ep2u
         mG0ry9HFTYH0nYs42JZNepQOJ5OnufLTeKvzrwYABey5+FdtOUgYel/1PoP3fR2CPFGC
         Kt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqOLBs3Nwyu81nR7iG6dy0Zgt3vhXrekmHkbrh0BHsc=;
        b=SgGFNEx1ETNh2SuJhbAdqW18tldmI19BwHxGNL7fUSRRPzV9ACIH/FneAZ++lzSlTV
         t283vBStgoDpZGKi+Dupw7YFWwzy0QtMCrXlXe9iP0H6JensPoKrIGTv67UE62AWWXy3
         +g02clLE+Wnlqov8+4c+Znx9s+lYi6Fl07QBrOHdam5Ic0G4LwtN3LPklqBTv/0v2T6W
         d0opXNL/a8i0uEW8sRVr0ttyr4dw/Q6dyWP3EjH1cv3f/7bwxeVy6A9kA0o+PrNpYh79
         Qk+osm8Po0zFmqRcP98QMOY+vFwCeVe9D4O0aTbgYdJ213MAKnO0YO/Ez3/lXMqEdCTF
         OyVw==
X-Gm-Message-State: AOAM533XYCSF4gcXknpMP9tmwscTayl+BsnAeSkx5CHKmePP7ng+FAkT
        ORvIUbUIPYhNxiOMmTu5Ldc=
X-Google-Smtp-Source: ABdhPJzrovdEiZXHdZ3lJ/SUptA05WOZqAu9/vuHUcdKVVyHj54n8AMOgirYyNgJ5Xr8HItW7a0WXA==
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr4621658lfv.607.1630028276540;
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 3/8] opp: Change type of dev_pm_opp_attach_genpd(names) argument
Date:   Fri, 27 Aug 2021 04:34:10 +0300
Message-Id: <20210827013415.24027-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Elements of the 'names' array are not changed by the code, constify them
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 6 +++---
 include/linux/pm_opp.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e26da1d4d6be..8d947e4f8c68 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2349,12 +2349,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
-		const char **names, struct device ***virt_devs)
+		const char * const *names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
-	const char **name = names;
+	const char * const *name = names;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2458,7 +2458,7 @@ static void devm_pm_opp_detach_genpd(void *data)
  *
  * Return: 0 on success and errorno otherwise.
  */
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
 			     struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 57e75144dd88..b77f2b41c30b 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -156,9 +156,9 @@ int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -377,7 +377,7 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -385,7 +385,7 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
 static inline int devm_pm_opp_attach_genpd(struct device *dev,
-					   const char **names,
+					   const char * const *names,
 					   struct device ***virt_devs)
 {
 	return -EOPNOTSUPP;
-- 
2.32.0

