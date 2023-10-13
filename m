Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63B7C80A6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJMIs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 04:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjJMIs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 04:48:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B62C0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c60cec8041so13460365ad.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186936; x=1697791736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz759/oMLk+eLy7Ws95dezNQB9MhOE7jwblbgespyKU=;
        b=Pa8z4K60xTrZrs0pbRSt+uXHAxirfvwJnFfS+fvBmaHIF+7vPYoSzmAsKZ006jtFSw
         kFYeO0strsUSwb6eFCORNqGQCyW7RbB1SojSxbL6YLJ2bItef++hyco5BkVeQ5TnrqGd
         9XrSBDyuBaTuXvpjh/AW/6ncIgJ0/lbH+DWONglt0zFyULaGKaTxZHAYBlUQOy6Csea5
         hLq1ygBxsRJGBdo9r5J2PIllI1NcvqffY/nSmOr53zhrbpQuEqh/fF2qeXnfthBR7M54
         UuQS+tWCYorJ+yp47hLG3DayVBq1wu1wWJFAcOJUzsxNX05T/M5TbjOdpxJATbKMC1s+
         gQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186936; x=1697791736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz759/oMLk+eLy7Ws95dezNQB9MhOE7jwblbgespyKU=;
        b=GA/6KezRjwC+/iZjvUSvHURjXpQdPAzJiGMj1VQzHgwgJdXzQkPMoV2kJXYejFV0Iw
         xiz5A9ZVo5h50Imr1HB+CiNxneF/Anh0g2V78XqD+Ih7IX/pan3gb31D8p+3nOYN5W8n
         qU1YyfZF2WlypR5Ep1Axiwlb5Kl/25tt/2aZrDLRl+brQ/qsF1M1i+/1g/xZPQYhuHrk
         3L0sqatyR3bNjQfYHh8FVbFWLPDwrASyQmcaBKPmRtCcjyGcrEaqKOfO1Lb1NHa3VCOy
         aaAeIdxRBnAzW6tyulvgjnjwazHPwT1Nrrn8hkEC60srOffU28dUg/ja8NRhd0CdKH9k
         khMA==
X-Gm-Message-State: AOJu0YwMR/2e8vNwbQUN/Mt7n/NLwI5spdTLme3uLDvRwbKxk6gCXgrj
        xzTTo86AoPH1W9WWbr9Gv5mQTQ==
X-Google-Smtp-Source: AGHT+IEn4AbZLaJVaNmG1K6b3v0D9p4hLbiVeobmaJDFxcPbSUYBhHy5/sMFGyYpwHNr+iy8cE+XHQ==
X-Received: by 2002:a17:902:b604:b0:1c9:ba6f:af04 with SMTP id b4-20020a170902b60400b001c9ba6faf04mr8135602pls.35.1697186935994;
        Fri, 13 Oct 2023 01:48:55 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b86492d724sm3321494plj.223.2023.10.13.01.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:55 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] OPP: Add _link_required_opps() to avoid code duplication
Date:   Fri, 13 Oct 2023 14:18:38 +0530
Message-Id: <0890df8ddfafba0d9d214e73e4bb0e243a2db9fa.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Factor out _link_required_opps() to remove duplicate code. No functional
change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 62 ++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 85e2af3d6a49..81fa27599d58 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -296,24 +296,41 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	of_node_put(opp->np);
 }
 
+static int _link_required_opps(struct dev_pm_opp *opp,
+			       struct opp_table *required_table, int index)
+{
+	struct device_node *np;
+
+	np = of_parse_required_opp(opp->np, index);
+	if (unlikely(!np))
+		return -ENODEV;
+
+	opp->required_opps[index] = _find_opp_of_np(required_table, np);
+	of_node_put(np);
+
+	if (!opp->required_opps[index]) {
+		pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
+		       __func__, opp->np, index);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /* Populate all required OPPs which are part of "required-opps" list */
 static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 				       struct dev_pm_opp *opp)
 {
-	struct dev_pm_opp **required_opps;
 	struct opp_table *required_table;
-	struct device_node *np;
 	int i, ret, count = opp_table->required_opp_count;
 
 	if (!count)
 		return 0;
 
-	required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
-	if (!required_opps)
+	opp->required_opps = kcalloc(count, sizeof(*opp->required_opps), GFP_KERNEL);
+	if (!opp->required_opps)
 		return -ENOMEM;
 
-	opp->required_opps = required_opps;
-
 	for (i = 0; i < count; i++) {
 		required_table = opp_table->required_opp_tables[i];
 
@@ -321,21 +338,9 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 		if (IS_ERR_OR_NULL(required_table))
 			continue;
 
-		np = of_parse_required_opp(opp->np, i);
-		if (unlikely(!np)) {
-			ret = -ENODEV;
-			goto free_required_opps;
-		}
-
-		required_opps[i] = _find_opp_of_np(required_table, np);
-		of_node_put(np);
-
-		if (!required_opps[i]) {
-			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
-			       __func__, opp->np, i);
-			ret = -ENODEV;
+		ret = _link_required_opps(opp, required_table, i);
+		if (ret)
 			goto free_required_opps;
-		}
 	}
 
 	return 0;
@@ -350,22 +355,13 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 static int lazy_link_required_opps(struct opp_table *opp_table,
 				   struct opp_table *new_table, int index)
 {
-	struct device_node *required_np;
 	struct dev_pm_opp *opp;
+	int ret;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		required_np = of_parse_required_opp(opp->np, index);
-		if (unlikely(!required_np))
-			return -ENODEV;
-
-		opp->required_opps[index] = _find_opp_of_np(new_table, required_np);
-		of_node_put(required_np);
-
-		if (!opp->required_opps[index]) {
-			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
-			       __func__, opp->np, index);
-			return -ENODEV;
-		}
+		ret = _link_required_opps(opp, new_table, index);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

