Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1D6C31A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfGQWYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:24:10 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:38629 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbfGQWYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:24:07 -0400
Received: by mail-vk1-f201.google.com with SMTP id u202so11850574vku.5
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DiFJ3QV0jm1YQeH6o85iwOHAT3O/cgKmhpXPhBt1zRY=;
        b=gUnX3uWKzKk0PdpWQOACtbCTUosGhC+9X0hmQ8V9U0YJgXRqIB7VQ82FCFG0UaJZgc
         ANHsa7Am/jr3H95GksDN+aZmOygrs8L74TDbC8/XgptqkBFsTMsk6GligRGiGe/KnInP
         EDr4mxKVQAhQcthiTTFSxY0rADMAj9jGZYOVzO2PbcLzkZNoEvYe9g0z5YqmuKJ89dF3
         B4ByPzdiT6Yhd+AWM6x8lr87ib5BFJAatlvOE+TvhbUy1qN12S/0oJE91nD/HkU6v/JH
         KT24Fj55t1N5sXs0DGIBl8CjLkb4WmGcxMtiCWEMcGYeR+kD2kDk3oqQVNP3YLiLa6aq
         sBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DiFJ3QV0jm1YQeH6o85iwOHAT3O/cgKmhpXPhBt1zRY=;
        b=iDPtLX8mJ5On4l19NlPDG4ancg9M4JXIpSgoi87iaAMmLhbSXestVu1+e33XkL8FQJ
         5QEHLX5d8O8q706Jvst3079Wl4GiO4OTRjjwdCI7YsN0i83NmqXYiA90Cb8gscSRwwq7
         8IlaHvnIiXMMktxcGBntKRiUytiHHpU0lyniSq3QIZL1LMCySq0WDmJpHYnccFOWx+VD
         yQC+jRE0kN8ZoO0c4CCtZBX/xP5bOnn6Y4IjgVNWByavqMBuULfEI7euX/lEoo8gljqb
         8082BZjwH3ti6MQSHipTPo4yLnv6krELo6Ap/35CYMjDSV/l2MwErIbwH1WFyiRK83rc
         jJnw==
X-Gm-Message-State: APjAAAWW01DwMJ5vi3lmm1L+ek4XBsvyJ91oG29io00eOBVIMmP7rnmO
        NGo2UmS3f1LuKBHij4kv6yCV22kk8hWKh9Q=
X-Google-Smtp-Source: APXvYqy3zbgHJTqW4oLLmWuWgsYaMIERwR4ozjSI+WlW5wAorsi4CAIdlvBrgoJK7UM67//EQe4dWRuDxbj9++c=
X-Received: by 2002:ab0:7457:: with SMTP id p23mr4958003uaq.138.1563402246655;
 Wed, 17 Jul 2019 15:24:06 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:40 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to passive governor
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

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b863..24ce94c80f06 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
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
@@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.22.0.510.g264f2c817a-goog

