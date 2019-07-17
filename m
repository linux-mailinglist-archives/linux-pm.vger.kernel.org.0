Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711236C31B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfGQWXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:23:55 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49310 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfGQWXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:23:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id l14so21387425qke.16
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g20bmVhjq9PwMxcUgTHaVxhylFvIUYxFTb/7hfeQpvk=;
        b=D9RoywcPL8rsZqz0bMu7/+OwR+2YE29yOrq24BR0n6XZX58xaU1+khGkXQfJ7oOrIo
         JC6j6V1utL/bt3TA4HQOwyw39KP7TWDKDm5wD2IE9eEaXDow6O5bqk5GDgZvql6OOEP0
         le0dUMPCh9Smyn8D8kWQ/Dot1jyfKG5pb27a66PvBMZpA1QHJjgTC+MIiSiqy3+afTXa
         yNFl54jamNGQ9OdLQn/d0K3fIDW5onBbqY5cFOW0g2A1Ag7QJLZcnh8hvcuM0LhnW5cb
         vJOIFuenmpajn3YaEaxIqKP6JNQJfOI7/bEUrvmu8fAuhDt3pwKA6y7BBCw4CEwe07dk
         XxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g20bmVhjq9PwMxcUgTHaVxhylFvIUYxFTb/7hfeQpvk=;
        b=aJmMGY1r37T+Iudkx12ucnmuQx5wVfCyEvfiuTuSoNkU5vtqA6GrL3JRgPlIhW0NbM
         q7FL3ebVmXLFPgcmwp/wo6Ikw4o2sSeAisfkZ9MvKGBvfA9Xya794ks8rJxz/zebDcDc
         5ZtWrcGfQZPorx8QMjw6LUhe6pLPfuUKDoUFHxlPXBhFD8k8YQUabvkOozuACukwz6oG
         fRFhwl++zpu6QrjCYg/SPA47iqUiFb1ulclK4cITG3pR7OshPnVLnFnqINsA7R7sbEcH
         Gk1zHaH77V+eEsYdYigHIuihUxGG8ER1ciN2km6hXAENVt/xHRIjWpGvEzsMbfl9GlOC
         qH8A==
X-Gm-Message-State: APjAAAULw2h5jOboRl2ednqPgoCLBgSUwDQJzvonjmRVZloCmDhgsWFS
        S0ZazLDtXgemY8lIli1kXPZamnmycl99ixM=
X-Google-Smtp-Source: APXvYqwz8KDML9VvH5pH0LJQsWloxsFAnC07TtA1W+tW5SM8ax4Yi/o76+L7uXmhgURWW0WrEThWjBifw5lWqiM=
X-Received: by 2002:ae9:de87:: with SMTP id s129mr26896239qkf.485.1563402233331;
 Wed, 17 Jul 2019 15:23:53 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:36 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 1/5] OPP: Allow required-opps even if the device doesn't
 have power-domains
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
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
 drivers/opp/of.c   | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c094d5d20fd7..438fcd134d93 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -707,7 +707,7 @@ static int _set_required_opps(struct device *dev,
 		return 0;
 
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
+	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
 		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret) {
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b313aca9894f..ff88eaf66b56 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -197,17 +197,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 
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
2.22.0.510.g264f2c817a-goog

