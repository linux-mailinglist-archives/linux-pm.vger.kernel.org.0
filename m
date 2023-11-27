Return-Path: <linux-pm+bounces-278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CFB7FA445
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1072E1C20A2E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFAE3175C;
	Mon, 27 Nov 2023 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v677vaar"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE9AA
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:19:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c878e228b4so53696451fa.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098383; x=1701703183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ41arVcAuG43JZqYRRYkpgAWKlZs6YO605nhsMazRg=;
        b=v677vaar2lyjPuA8ZSFU5/CskWsfVobXQA6tXFK9nk3Xes/HIpCGD7Xrjk2Kmtk1JL
         N+E5Sp+FhDdEP5QkUyDizRuYql4kexFpZC3pHKod0+Q+DKYbkrmjXbWJ+Hi2+DdYzbFu
         s7iJmDbVW7XxfeC0bKQ4NRAD94S5tsHSFBek8qv5FRHH64XtNXvgxSWCJ9VjUvNR/JWG
         06GlBblij2zAhT4Poq1RENOCuXdfUvQq6C7H4t1rcdkQd7Qo+kDmEWjKoXPuMevwMKZd
         SKsTo+bQte8Q062iNb9hyhkaZCGoiZdq+Q2Yg9BpcCMuP5zzCgB4RlKaZeG9QoFVyXVE
         sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098383; x=1701703183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ41arVcAuG43JZqYRRYkpgAWKlZs6YO605nhsMazRg=;
        b=G1z67Xhn9aT897LD1C/VV9+YdwYMJI4Y/Amckd7S/iq0pXoCbG/TraoAQC0WBJepPC
         skZCTq8fOXjfZkGmUdJaZHt4dMnUwU1Menqd6B9UjQn5xDJP2kziONzrGLIRwXIkDlDL
         dVz/f9Cs47pXKj/nIu0g2cJj3qt6aa6uGPj9zlfM+OlZ8Y7TUILwmSKSRKMfC8d+KDyz
         7eRoP3Rh5/bfOuy3mXf3sEPF1G09sSvUjOcFqE7mn3QgRX5ypEul/wI5MhG5gwwWn8cp
         +O5Pmw5AwKvFJqx4NIXsSLtx7GA7cf/+e0psSvaiO7sJNinkOSxpW0yk0JkscCqcFXfY
         trIg==
X-Gm-Message-State: AOJu0Yz3K/+JFrgbGXiu3GRgxJTu8l3caZs9r5HeW5Q9G5Gfp1Soka0t
	h6WuIB6PNpSzIyAutj2jel+/xA==
X-Google-Smtp-Source: AGHT+IGzphxorONaJExp0yvzdHT7XzIgSeo6DYR811cKr73UStSCVUYTy9QQ+4aEmW2vjMUL46D7SA==
X-Received: by 2002:a2e:8196:0:b0:2bc:c004:cc22 with SMTP id e22-20020a2e8196000000b002bcc004cc22mr8315420ljg.33.1701098383440;
        Mon, 27 Nov 2023 07:19:43 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e8011000000b002b6c61bac2esm1371363ljg.92.2023.11.27.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:19:42 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
Date: Mon, 27 Nov 2023 16:19:31 +0100
Message-Id: <20231127151931.47055-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any users of the
pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
corresponding ->opp_to_performance_state() callback, which also no longer
has any users.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 --------------------------------
 include/linux/pm_domain.h   | 12 ------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1777e39eaa..cf65b5a9783c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3042,38 +3042,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
-/**
- * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
- *
- * @genpd_dev: Genpd's device for which the performance-state needs to be found.
- * @opp: struct dev_pm_opp of the OPP for which we need to find performance
- *	state.
- *
- * Returns performance state encoded in the OPP of the genpd. This calls
- * platform specific genpd->opp_to_performance_state() callback to translate
- * power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp)
-{
-	struct generic_pm_domain *genpd = NULL;
-	int state;
-
-	genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
-
-	if (unlikely(!genpd->opp_to_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-	state = genpd->opp_to_performance_state(genpd, opp);
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 34663d0d5c55..b97c5e9820f9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,7 +118,6 @@ struct genpd_power_state {
 };
 
 struct genpd_lock_ops;
-struct dev_pm_opp;
 struct opp_table;
 
 struct generic_pm_domain {
@@ -146,8 +145,6 @@ struct generic_pm_domain {
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
-						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
@@ -348,8 +345,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -395,13 +390,6 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
-static inline unsigned int
-pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-				  struct dev_pm_opp *opp)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
-- 
2.34.1


