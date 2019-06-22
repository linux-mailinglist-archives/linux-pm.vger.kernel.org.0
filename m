Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A694F2CD
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFVAfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 20:35:04 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51342 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFVAfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 20:35:03 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so5336425pfv.18
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uZe8xdTxrcmzsMfd5NRi2oKQSnCX2+7hWLlLXSrqI2Y=;
        b=aq4uyuIUPRA/yb4indcQDCGdufn8KJt3WSE7aAZKuzS6jR6P5TG1ngAmI0rfU9wgdw
         CeOtQFCQ/VO0vrbf8UlFR4d/nZxuz2lfrRBhbULK9L+e9fghj3I11XUMJpRSCwdOSNfy
         v802ZgQzhLZWAzudLn2nQ+BmnIO58KCrTQd2mlt7v+AFLTfUTgYZfe4liUgGc11+1dFG
         WLTsiu77o5u26ue0V4JI3mWsfwjbi71ZaRD5BTWmVqyPJQGcV4XVZRH+4JmVjVqAv4kD
         x71+82LVQ9YRwjUt46owDnvB04IHtZ/4CL9CpvwrnXkQHDkNqSgcqQs676M7TDUHkiXW
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uZe8xdTxrcmzsMfd5NRi2oKQSnCX2+7hWLlLXSrqI2Y=;
        b=YTDVV7mkCjF7mwx9Tlq0yMN87mnXJ936a0yQJffQhdcjIMnw4dB53ogea5ZU65c8zv
         dzSv3pt8chQSIkTT09tljhfFcv/ky2V2py7bS+vFUWq/24rqbGesSYPbCJ+mFmN8R5j2
         g7KSz+7Gtxw8JQpkIkdHAMf1beZqCLxv43eW6UycEX63jRwrnYyEqhuNbUt/K2w+LxFZ
         IWsCxbgZN/X/g6mhTE4RsBHhzD28YSlHEMiLRiAQF+HMv1xfTbaEXMlAEGB38U95+hjz
         79YQfBVkqjyKmTWdhj6x1EQ63GXU5JGk36vUsfTGFfmJJwvpeWjl4ISVOmf4sEB/lP6d
         cbNQ==
X-Gm-Message-State: APjAAAX4JUyLIgj9+aLhK2K+1rmA79REl/SZZvAGRHaaM8DU5IHK9B5U
        Z2w3voc6RCU/9aLDgPaWsqHbk56yqrtMRmA=
X-Google-Smtp-Source: APXvYqxr2NvKIMGYahmV1qrUTQt9g0D8oa2ojuqqy0qIsl/GrmHv3JOO2xz9uNJA0HtzJ6ACxmZX3GCwLqjgm8Q=
X-Received: by 2002:a63:de50:: with SMTP id y16mr4707161pgi.431.1561163702716;
 Fri, 21 Jun 2019 17:35:02 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:48 -0700
In-Reply-To: <20190622003449.33707-1-saravanak@google.com>
Message-Id: <20190622003449.33707-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 3/3] PM / devfreq: Add required OPPs support to passive governor
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
 drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..bd4a98bb15b1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
+	struct opp_table *opp_table = NULL, *c_opp_table = NULL;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *c_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	opp_table = dev_pm_opp_get_opp_table(parent_devfreq->dev.parent);
+	if (IS_ERR_OR_NULL(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto out;
+	}
+
+	c_opp_table = dev_pm_opp_get_opp_table(devfreq->dev.parent);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		c_opp = dev_pm_opp_xlate_opp(opp_table, c_opp_table, opp);
+	if (c_opp) {
+		*freq = dev_pm_opp_get_freq(c_opp);
+		dev_pm_opp_put(c_opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -92,6 +106,13 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp_table))
+		dev_pm_opp_put_opp_table(opp_table);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		dev_pm_opp_put_opp_table(c_opp_table);
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(opp);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

