Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00D645343
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfFNERm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:17:42 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51119 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFNERm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:42 -0400
Received: by mail-qt1-f201.google.com with SMTP id g30so1044582qtm.17
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nT/RN++hgSEY1oFXDZU2+2vA7A3kNiWfnEI7MgbZhNk=;
        b=n5yi/fsSkLPZsXmOhD6VaVWd4K75Sp6QVYZWyYN4AtitTODNfEvka82I6ouh9pIllG
         dByhWETJ+8aEVnytSO/6g5UZ468kBNbvHIY8phwEkAWG2tZrVyIT0IsUTnuJQzR3aN5e
         XLV3Bp8RtbiNIhG4M2j+89d4S8rQhOaXxXhPxrP4R3GuFvA3KrIT2TCwKcbf5jWgDRdY
         hXKGsyRZDlYUqE42uRR1Cxv/vlIoapqsipres07YeHegPtQ6LxBQwOSWtvBOezOpgD3I
         Qu28AYiZTS3TgBTeUizjfUrhu0yM3b2DuiIp11SST0LVUveEP+ZUo3ggXGNYrpastq/N
         2/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nT/RN++hgSEY1oFXDZU2+2vA7A3kNiWfnEI7MgbZhNk=;
        b=JHeFzjd/sjCZST7lZ3ZVMaPP3XNOIxZyQeyugdzqikBOqhF93lITQ6+Hitov2dl8Gh
         IhUBZEMLsDcBkG4v9lNQXBSKLW9TWA4JipUc2vnq1x9g8KY/Qe4BrdFfA70+KPsr1ZAo
         yGMoDMYYrSvRuW4zHE+DWJOWZ0urEnSW50pXKyJyWmA2SKqI2qknIyV92GR+vBUchOHo
         4Q0DOqggd1EiSX+TrUYV5EH6GNmH42wFoJcH49FTMiX0jXhwCo+1SaL1CWpTvJcV7wx3
         qLgnhrUCKx1FEJ1FJ7REfc/ip24uTywo3ewgspYF9dSjVB1uhmwku7Tr0vNN1EqHuQaE
         l15Q==
X-Gm-Message-State: APjAAAXlTuMoV+71FwZm18NLSXRBp1foz+nnFuxJyKJefwIwg8Jb5Y/i
        CYr0MeYk3zZy4WLDaQ8Dy/aX+RWbcqt61wM=
X-Google-Smtp-Source: APXvYqyNMF63uMGGdRuluuVrT4/Cbxxxf47Mr3fg6agQhouB8jIcIqFEqN0r4I8WQRbVaepWXMQu0HlCnhutkjM=
X-Received: by 2002:ac8:1a9d:: with SMTP id x29mr79446143qtj.128.1560485861512;
 Thu, 13 Jun 2019 21:17:41 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:23 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 01/11] OPP: Allow required-opps even if the device doesn't
 have power-domains
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A Device-A can have a (minimum) performance requirement on another
Device-B to be able to function correctly. This performance requirement
on Device-B can also change based on the current performance level of
Device-A.

The existing required-opps feature fits well to describe this need. So,
instead of limiting required-opps to point to only PM-domain devices,
allow it to point to any device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c |  2 +-
 drivers/opp/of.c   | 14 --------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..74c7bdc6f463 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
 		return 0;
 
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
+	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
 		pstate = opp->required_opps[0]->pstate;
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret) {
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..7c8336e94aff 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	 */
 	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
 					      "#power-domain-cells");
-	if (!count_pd)
-		goto put_np;
-
 	if (count_pd > 1) {
 		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
 					GFP_KERNEL);
@@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 
 		if (IS_ERR(required_opp_tables[i]))
 			goto free_required_tables;
-
-		/*
-		 * We only support genpd's OPPs in the "required-opps" for now,
-		 * as we don't know how much about other cases. Error out if the
-		 * required OPP doesn't belong to a genpd.
-		 */
-		if (!required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
-				required_np);
-			goto free_required_tables;
-		}
 	}
 
 	goto put_np;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

