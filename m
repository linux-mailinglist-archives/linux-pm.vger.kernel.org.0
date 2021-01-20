Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C72FC72D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 02:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbhATBvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 20:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbhATBvi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 20:51:38 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C26C0613C1;
        Tue, 19 Jan 2021 17:50:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p13so24252474ljg.2;
        Tue, 19 Jan 2021 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+el3VIqkWAp25RXB+JlKxWDLf4kOHIGgrJ38WDh5Pk=;
        b=pLgHq7yrL+0pGIV9dPMxFcgDX2EklYdhCYTNM+yMvqAaVxCE2Aq6gYUrtPUtngwzBG
         Ty2zr/SfpHWGv7E//bQIRXMONLcWukGxfIdIaQxOyd8fL2yYb9hcF6BcnYrc0KCEqlBg
         tulBkuqcGPbgQlTxqLOy56AKMpLWGfif9PF5RX8F7LBASugSSqvPLqYp4E8g2wG0SteL
         cj4J9JwIubSkavGCUoBVxLuCnO7A8xUUod5Wy2H7hBtLMWfrPAPmYo+HOrnqvlCCFrSF
         w4SOp5VjDVgr71echP+1dg9g8hkdM65DL4Oef9jwXETRHGqU5PIzuKkvzsvm6gyuH2it
         aK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+el3VIqkWAp25RXB+JlKxWDLf4kOHIGgrJ38WDh5Pk=;
        b=L+Kx4Z26Uu1thDu+Y52iiwjhNL9gr2Fea/FqMNeYrFKQU57k8d4peHKRoK1xj3k3Sn
         qLzKJO1iw+hQ1fHYPOvTYMUQ+Ek1tjXs5puLXMClBIxGq/UnN1iVFvPhssvOWd5eRrlq
         7ldRDmIv35KI6u6uGsXCDbpxeAeTxsY/XFaOseZNd/yTwpCxCSkA6nD27K+MIZClWxYn
         7dejV90YxUrP+40gmqUopT1SW5oL87RcX5XMSlP5KZtzCzzqPaoOplj1V04ACBwxpVCn
         OH1m0JT2GSdC5sChgljFhvOl+T442Yt1zKH1/tdQQKb7LiCdUnOsBIRnCqvTX71lPNlM
         vHXw==
X-Gm-Message-State: AOAM533i9Zqx0Dv6rZho/TnG+oBDIeqXtnCGRlm4jYTQclPxt0UEcthH
        xRLjnrNN1cCpMcsTZYvJJe6O521RdaE=
X-Google-Smtp-Source: ABdhPJxmbbwMRyb8F+D6bg+A9gWr/i0fgshQtT0jfMJOnDfELKumrgu1Z1LjSZcShiuYL/twLEopHQ==
X-Received: by 2002:a2e:a58f:: with SMTP id m15mr3191366ljp.214.1611107454918;
        Tue, 19 Jan 2021 17:50:54 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id o14sm56163lfi.92.2021.01.19.17.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:50:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 1/3] PM: domains: Make set_performance_state() callback optional
Date:   Wed, 20 Jan 2021 04:50:08 +0300
Message-Id: <20210120015010.14191-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120015010.14191-1-digetx@gmail.com>
References: <20210120015010.14191-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make set_performance_state() callback optional in order to remove the
need from power domain drivers to implement a dummy callback. If callback
isn't implemented by a GENPD driver, then the performance state is passed
to the parent domain.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
[tested on NVIDIA Tegra20/30/124 SoCs]
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a14eedacb92..0bd0cdc30393 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 	return state;
 }
 
+static int _genpd_xlate_performance_state(struct generic_pm_domain *src_genpd,
+					  struct generic_pm_domain *dst_genpd,
+					  unsigned int pstate)
+{
+	if (!dst_genpd->set_performance_state)
+		return pstate;
+
+	return dev_pm_opp_xlate_performance_state(src_genpd->opp_table,
+						  dst_genpd->opp_table,
+						  pstate);
+}
+
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					unsigned int state, int depth)
 {
@@ -311,13 +323,8 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	list_for_each_entry(link, &genpd->child_links, child_node) {
 		parent = link->parent;
 
-		if (!parent->set_performance_state)
-			continue;
-
 		/* Find parent's performance state */
-		ret = dev_pm_opp_xlate_performance_state(genpd->opp_table,
-							 parent->opp_table,
-							 state);
+		ret = _genpd_xlate_performance_state(genpd, parent, state);
 		if (unlikely(ret < 0))
 			goto err;
 
@@ -339,9 +346,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 			goto err;
 	}
 
-	ret = genpd->set_performance_state(genpd, state);
-	if (ret)
-		goto err;
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (ret)
+			goto err;
+	}
 
 	genpd->performance_state = state;
 	return 0;
@@ -352,9 +361,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 					     child_node) {
 		parent = link->parent;
 
-		if (!parent->set_performance_state)
-			continue;
-
 		genpd_lock_nested(parent, depth + 1);
 
 		parent_state = link->prev_performance_state;
@@ -399,9 +405,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	if (!genpd)
 		return -ENODEV;
 
-	if (unlikely(!genpd->set_performance_state))
-		return -EINVAL;
-
 	if (WARN_ON(!dev->power.subsys_data ||
 		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
-- 
2.29.2

