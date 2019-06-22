Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D74F2C9
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 02:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFVAe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 20:34:58 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:32790 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFVAe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 20:34:57 -0400
Received: by mail-vs1-f74.google.com with SMTP id x140so2878400vsc.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=diT5j67eq/c/BsDoIxqIkGMzy6KvSDn7bQJLbufPm+c=;
        b=gwulcSEH8dOdXkARw/cWbDR+p8ks9AaHOrso90YTxOcu3ZhBY6OTJ2q8Qgjkx6F2pU
         aKXt7HBMIMq2v9JgCWAMJfcSzqcYaMSimcOOybm2+PzXjoTN3S6V8vweB1K+VrNVuQnq
         HOT5/C0X51K+41Mfm+DJ+AA0N0fg1MKDuTPsJ+akOv+eaRlKlmo2XDUOKZAhOndwo//U
         HHBviqAW/VRLrmHPTR2qPjmB2NiFKIG+sAuk2m5uSwxuGg9+q2wUDicraebKvydsSyGj
         HV4szT6Eo/vIQIjrZugzSdJPIh/BZLCM9j6MFYqdHiGNjRHKJHdlvkNIMH4JsoUoL17f
         SkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=diT5j67eq/c/BsDoIxqIkGMzy6KvSDn7bQJLbufPm+c=;
        b=ZO/alkMJGlraZJxweGniwsPkGmvgXqmq1Rj9AmtUyPRoGPK5leC3JpE3bKwV5hci6x
         Mfk9ezRSHUmCSl6o3TaYUq1v0ONskvl5HZTihc+j1ld1T+rqhTZThw8IX9mnanOviHvU
         M46H4lcZXm+PemgXCDLb+0cOyjfRqk2ZR/no/KHHbwa+I7JhpB/DxfUsd6guPZoUpeva
         cjymk3Hn64IIJF6Zx8XmnEFQe1W8l/zev8SovUEcdlS012Bwf99HD1LMlqsSEljH1Aws
         bGccdCOaKHaP+Se1rq4czDUXqSEQrsbJPrUF4bBfioop8gOp1zZgcPX9nC1BNmIVsEK0
         nqBw==
X-Gm-Message-State: APjAAAVvdOpOpK7lMpVWOxNshhnK7al4k1fR18lcy8ZsdspJQRAusOzG
        vmDeHUp8v9wE27XlQqTwMWjLtEqnQGF1Scc=
X-Google-Smtp-Source: APXvYqwyrBBBbzxUpFGw4I6kygyR7FpMpsJ6pewvPbKv6gEArXJ7XqY7SOep1hfkAGVXj+jU0V7vS+0IQWgjhJo=
X-Received: by 2002:a1f:b20d:: with SMTP id b13mr10556131vkf.75.1561163696586;
 Fri, 21 Jun 2019 17:34:56 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:46 -0700
In-Reply-To: <20190622003449.33707-1-saravanak@google.com>
Message-Id: <20190622003449.33707-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 1/3] OPP: Allow required-opps even if the device doesn't
 have power-domains
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.22.0.410.gd8fdbe21b5-goog

