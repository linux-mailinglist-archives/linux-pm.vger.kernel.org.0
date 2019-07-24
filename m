Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192D2723E4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfGXBmx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 21:42:53 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39392 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfGXBmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 21:42:40 -0400
Received: by mail-qt1-f202.google.com with SMTP id o16so40013062qtj.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UHmTiaufl6SZU/ga2qxE1n4DzY+HliCfb2daW2FDx5s=;
        b=F/pbGCP0Z49OtouWOpJ4H0DXRkAubfHQGcLlqlsa5NDb1CDAnuVsUAS5VFQQsxYucW
         KyDGrT8U88EZ5h6RYqhpaXu02TZd5awobBVJ03rNjXLWPAFIwY0Jh03vzCSeEo8+Vp0s
         nTFk0UFa25oagNxikNPB7ilbcW8AMRiHf/5HP5Nlmf5hpunxS9FLqNomJ9mCCf1gbFj8
         JFQNkTADaNu1PRNErHMMQc7JOn31bz6jNpJrT+0nM+orWutTK/+vx3qps8/8avzwTxJb
         NGFYHgaL/bfKfOJQGK7+nxvNaQQwWawlLsP1W1Auqee0R/z1ftoTMCPibotRnNtqw1om
         ayfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UHmTiaufl6SZU/ga2qxE1n4DzY+HliCfb2daW2FDx5s=;
        b=JMrZilSSYtyulPUHNPnQmwChbiIRMHnVSwfh4ghjrIeUMRlLdZ3vDShu2nzQxnP1Ug
         VlT36/WSJE++BLTEl2SjoxrKtXzvcAW8T15oqYW++KogmNmF8+qztTryMzQkVTqfCb1d
         TcZIA9UFTTNeiNHpMa0cRw3OpvliPLq0Rl4Efk8wAS1EWmIiLJouK0Gv5uQyMUOIhgC6
         kxG/+tSm124vrwDjAVa+vOuReXQ+WT8Qf26b/u3zwRMQo89i7IqMoq34TlZPyOwey6cI
         MehMlSlcLKlY9ffjKHBeot712d5evyzcBxUxGYczBIfy1NFjKGLQHBogGjQ8rea0U2jh
         W1hg==
X-Gm-Message-State: APjAAAWvNQpUej3rrhSDsIk0/3YVqWd0F48D4pDgPNd4cb2uFaYccdS1
        o0Pmt+PKyd2WWaIMiqHyhllAcujFdK0yZHs=
X-Google-Smtp-Source: APXvYqxss61/VE7v9dgtMgGjjEpT3s/T/+xiumelI1+T+A9k+d2XukhCv5scQKRkHMyYQl8CFsCDwovwd8/r4WQ=
X-Received: by 2002:ac8:3345:: with SMTP id u5mr55871060qta.219.1563932558973;
 Tue, 23 Jul 2019 18:42:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:20 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 4/5] PM / devfreq: Cache OPP table reference in devfreq
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
2.22.0.709.g102302147b-goog

