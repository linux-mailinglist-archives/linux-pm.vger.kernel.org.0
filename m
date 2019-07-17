Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA46C31F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfGQWYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:24:17 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:42128 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfGQWYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:24:04 -0400
Received: by mail-vs1-f74.google.com with SMTP id a11so6122745vso.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hlgN2kJF8O2fjyDEv3zuJRNqQ1+92Wl3CueXhQyVzIU=;
        b=NnRzkWoN5/S27nZtGN8yKD37RUeIb30TAYui+l8MKkJjjOT5PipUtajEOAMDk3YNoc
         8PTBCgW0yWc1MCot3JFGVlX5HzIjsbmZczGK5SNXBXM6xPTUEjTFyzzAUFh66LXRZ2yf
         V49f5emTq5XuK2SSmMsDaN20WSehh/hCsKJ+cnTyJvPTXH6CtdFx0vRDarSfmgThKmdz
         bNj4bz2ocVw0o9Loue41WzGw0CyLlFFVs/s8DwT3wOQgsYug5wJZjnxA0QwV55V6XxDF
         JRjsdyUDNLiB5KUNQtrXX51GVqXwEjhJvFrupEnXsyMIpNF0B3yA23l9dvCmdFsRQZ2u
         Zo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hlgN2kJF8O2fjyDEv3zuJRNqQ1+92Wl3CueXhQyVzIU=;
        b=o0jy5rZfXf+7TgcLmgA9ziNk6rYWvZnhVXEjf9RL6N1eoQWQ8K46W60qZgK0Q4tlLy
         87Nlher9TN2uL9nsiPZjWDdpAb1F6Rl+PPojNsAIY7mh9h4mhoDar6PO+UGYbaI9CxKH
         tU6HUUGmuYb7aKVKqCWprE7vTRhsOIHTyo8gl4IIN0qDZOBv/E7hq6EDOQbDziesLwEq
         q0SI0FbgE9gUtyfFLEOdDQlRsDMPzQRgPofbuT3PVnWH2G14btBtzrwkN3mkEASECRiz
         3Na/bJif7ZNPwsfCSTJr0Gy0hK14lkAj5zAqm8/q7CFej4wmG8qfi7cdP7tvsSKJSUe1
         3OQA==
X-Gm-Message-State: APjAAAVAERxJqXsl5FNBSdIMgwxVJFBSHNtLoNGqBvrUFMEboYBAixPV
        s25ovWb6AYabmH9huri0ypwOZUBwwzQthBo=
X-Google-Smtp-Source: APXvYqxT7Vys34+uPXtEl++ZtCFPgc1bYc+kkS7nUGHqMGkJzXWLXdIw67qCU6GNH5aCIzUf7VLs2KSSKQQV+0o=
X-Received: by 2002:a1f:6e8e:: with SMTP id j136mr17525706vkc.80.1563402243539;
 Wed, 17 Jul 2019 15:24:03 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:39 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 4/5] PM / devfreq: Cache OPP table reference in devfreq
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

The OPP table can be used often in devfreq. Trying to get it each time can
be expensive, so cache it in the devfreq struct.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 include/linux/devfreq.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e4f931..7984b01d585d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -594,6 +594,8 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	if (devfreq->opp_table)
+		dev_pm_opp_put_opp_table(devfreq->opp_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -674,6 +676,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR(devfreq->opp_table))
+		devfreq->opp_table = NULL;
+
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..1c05129f76c0 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -116,6 +116,7 @@ struct devfreq_dev_profile {
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
  * @governor_name:	devfreq governor name for use with this devfreq
+ * @opp_table:	Reference to OPP table of dev.parent, if one exists.
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -153,6 +154,7 @@ struct devfreq {
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
 	char governor_name[DEVFREQ_NAME_LEN];
+	struct opp_table *opp_table;
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.22.0.510.g264f2c817a-goog

