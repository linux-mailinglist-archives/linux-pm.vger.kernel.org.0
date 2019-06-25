Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3174559FC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFYVd4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 17:33:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37913 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFYVdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 17:33:55 -0400
Received: by mail-pg1-f202.google.com with SMTP id 3so161780pgc.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pSd2SEQBNKQJHNErQavWSNgkmJEBQdH7SImGVZiADmI=;
        b=Nac5aiSPpKXkEoBjULWPNAHKlYVVswo8Sv+aG4Nke8sMPOVW/szdI6v3v2LjD3wyEj
         dSxGFXMq4R6/VUvASlerc0YHjxEciGlmfpvUQaqcj9qMSwHIIRpqZIrWJldrniWDW9Hg
         CyVQmYNhxjtZcDOdChKUCwLkP9gicQce4SEip766nU7aK7h7m17qe6A1M/GXpqAaVYZu
         xCtO7hBsnvfCOL+wvWBKWthJhv9Yi76HPcJxAiR7XIIb7WmR4GVwX5BVQP558AWcJlB6
         LcSUR0W4OQfEKF47DlvQQlgePqeSjxEA9B7/QWoIUYLIMXjc+UQDI6N9vFjDEnXMypku
         M9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pSd2SEQBNKQJHNErQavWSNgkmJEBQdH7SImGVZiADmI=;
        b=CCmdofbxgOsdWeU36hzn+d+TFSVxeaI/NlRb6rpkojeZ9755qv8j644vBSQ0QhKifk
         V5Lt6p+p3qnHUIeixHzD46BJNPTkvxKXxhFvtizF9zJCATJUntVm4oVUxIeD3ZzHwJq2
         OgxGoVuVT0tEn312aoTjTBj9JkuAjrTZES0lHRDgkTOuEUxfQWd6zuqfWK4QJ1oxNKko
         iGEXNGGN+Kh+zl6uGWZb5S1/SbHYDcXEZhftYfgmFqaPXo8khCGXCtug8af6VNesJTQe
         T5D7TTgWzn6aRj6pD0sUyDvV7esmDiInnPgQv8+Crg7YWzfgv1zmaeAHXMd6qajzxF+k
         d+2w==
X-Gm-Message-State: APjAAAUZTVY0SwCPJiU/kig0nmMnC4p38OMugEOV1SubnoqC+pi9wfDS
        ZOrJsn1psi6zDM1iNwVY76PJH6f7vPzuHEM=
X-Google-Smtp-Source: APXvYqxiaI1A+FOWzhGL3gXUXbGdGJVhVOkRbDCDZJ1LQ4tDeB1cBg4isNNSqYgykqDQ7wiPiLWYdl6pW7jSYMI=
X-Received: by 2002:a63:34c3:: with SMTP id b186mr507704pga.294.1561498434498;
 Tue, 25 Jun 2019 14:33:54 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:37 -0700
In-Reply-To: <20190625213337.157525-1-saravanak@google.com>
Message-Id: <20190625213337.157525-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 4/4] PM / devfreq: Add required OPPs support to passive governor
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

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..f6de03de7a64 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -22,7 +22,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -59,13 +59,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
+	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	if (IS_ERR(p_opp)) {
+		ret = PTR_ERR(p_opp);
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	if (devfreq->opp_table && parent_devfreq->opp_table)
+		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
+					   devfreq->opp_table, p_opp);
+	if (opp) {
+		*freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -92,6 +99,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

