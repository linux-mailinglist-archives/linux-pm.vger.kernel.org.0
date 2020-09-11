Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ECA265CDF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKJuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKJuG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 05:50:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BFC061573
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 02:50:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so6243063pgo.13
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHCqsvIu83bEFNo3aLaW7H1ltiqU0PztIdRU2no/+cM=;
        b=jw0gTeZW0bWZxDIXwLvslEr5ZIIGkuQxyY55djRUdIv0TVBVhA9eg8l0oiY0IFZ4qU
         rqQpUp+K8YRyJ15dM0t0nYuu5Uo7pwwy7hYhCWRiwh4ccwtXk/ZmFVPn3ctKWVQQ3uFV
         HoOhtbhScxSjxCz3FQQz2oKfKiopcy3CUfEh11Gq/6m4zUmtiykpqhLc4VpYDqQhB5/K
         DU1m2eAikF7/Y0VQAzsGAZcisMa2cwhdh6KCVJzVxJKHi+3B0DyQEXQwHBMWsXYNegZ5
         ehFYOpYHAyLswbNng7PAkR0k0wWapxP4Y+LPWgkS81SkRF9FsUBU9spWkpGgVHLblgFy
         +d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHCqsvIu83bEFNo3aLaW7H1ltiqU0PztIdRU2no/+cM=;
        b=CPP0MZT0ntNCBlHz5iwLcE2rnB+ZzH/dMNzugyCOcoeb3Xv+m1c4RmKf1VTrxvUuIg
         wGx+nf6G9hjrDPHSRO7IlqTifou/FchpQYKW8h9rcB0Pgs2YD7K3V2emq0yXWtHLPTnG
         M/zolm+9B60bOMvgFTOwXyjp1xJD3ddxy0OwY8t1fxcP8zj26fLqt631Ggh5obTTK4TY
         ud6abEtuSp6h5DQ4iQUuU8/UhQ6yQ9mrEBye2kTytqF6XXNfyp7iKWMwn4qA2GpctaSZ
         a3K/15BTo0EiFnZKiOwAJpaawHrInvjAEhpGn/XzhGqgoCeFkS7Qias6VPlAU7lBMwla
         PJoQ==
X-Gm-Message-State: AOAM530VvFHFvDCLnaU57qg+sbAHDH65TXc9g0mN+jjWqonew6lEcE6m
        lVjBL1EuN0r2RT7K/eDQJ82mqQ==
X-Google-Smtp-Source: ABdhPJzYJ/xW4JtUp2MxDCxTT79XTEM3qazhysGxIWXTlnn624vpjeODDqtu+dUu6PQGfItgaUbTDg==
X-Received: by 2002:a62:108:: with SMTP id 8mr1491790pfb.36.1599817805535;
        Fri, 11 Sep 2020 02:50:05 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e14sm1364788pgu.47.2020.09.11.02.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 02:50:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Allow opp-level to be set to 0
Date:   Fri, 11 Sep 2020 15:19:53 +0530
Message-Id: <40b676a1e261d1cfd12788d88e0d2026dbbe226b.1599817789.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DT bindings don't put such a constraint, nor should the kernel. It
is perfectly fine for opp-level to be set to 0, if we need to put the
performance state votes for a domain for a particular OPP.

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  3 ---
 drivers/opp/of.c   | 20 +++++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 214c1619b445..2483e765318a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2117,9 +2117,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	int dest_pstate = -EINVAL;
 	int i;
 
-	if (!pstate)
-		return 0;
-
 	/*
 	 * Normally the src_table will have the "required_opps" property set to
 	 * point to one of the OPPs in the dst_table, but in some cases the
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e72753be7dc7..87f839a1899a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -842,7 +842,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *np;
-	int ret, count = 0, pstate_count = 0;
+	int ret, count = 0;
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
@@ -876,20 +876,14 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		goto remove_static_opp;
 	}
 
-	list_for_each_entry(opp, &opp_table->opp_list, node)
-		pstate_count += !!opp->pstate;
-
-	/* Either all or none of the nodes shall have performance state set */
-	if (pstate_count && pstate_count != count) {
-		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
-			count, pstate_count);
-		ret = -ENOENT;
-		goto remove_static_opp;
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		/* Any non-zero performance state would enable the feature */
+		if (opp->pstate) {
+			opp_table->genpd_performance_state = true;
+			break;
+		}
 	}
 
-	if (pstate_count)
-		opp_table->genpd_performance_state = true;
-
 	return 0;
 
 remove_static_opp:
-- 
2.25.0.rc1.19.g042ed3e048af

