Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2C723E1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfGXBmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 21:42:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41844 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfGXBmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 21:42:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id q14so27463295pff.8
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tcec6G8mdYvC44AUiiZquxcEHQD3/poU4Cd0DIagRzY=;
        b=OjqB0ijOd5pzNZ1elvcBfW/VYQq9Xyi191z3lVRIEijGecmCpThtCaH7iAEAOQV6tt
         n1Ma7p9sAXcFTkGiDuRpVzqQGS9v541NtuMY6wTBEFaB3+mr4IX8M4w8OiWHQCvmubm8
         Yju7NLSi4U7n/lTTOksPbc2XETeb5BvCiu5vo6wve7xyJW1gy/VAecz2XFeG0rLFAV/G
         zZ+mJdKhPjpQMlhvl95+iF1kVbre+8PnJY5WGzv4zkJmDfzAx29ovEXNLLGStTbDkEc+
         NJ0im1qi8CZTIkUMjx+pxaVVsobC496FzzkLJtNZgBvfbrzOAV7JFut85IszWRP7WF0K
         9S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tcec6G8mdYvC44AUiiZquxcEHQD3/poU4Cd0DIagRzY=;
        b=jHIR2G20Ac2oKK5uEP1S9dIc/P68tUI7akwSwuMvQWag04tjk2Vc00LGHzQLhI6lCM
         BplqZg5Inzm3/AX4TX1T8kX6AeY7edvE/84NEoVwuZBq8EnJaJ6xscMSW1UoIZ5gZd6W
         hJk3ouvyKqEos53OtwlkHnbsCLm8B/sf8/Ovf04Tnlv5Wv8KmfyxOEHhjwdSy2RhdEhj
         vUiHPjxPyQtvrT/TidWuBMZkGNLmlmdSPP0di8sz8QzKpkAGNjgIHybaULbNZPbbrF/Q
         adis+xazaj1q6Cw0y/TA4HcTAkllyOIB0FYKmRKhp4Y8tLkE8bjIR2eMLuN6DWwnc6UR
         29Aw==
X-Gm-Message-State: APjAAAXxL8M5jnPUu4TMGF6otrvjmeRvy+3g68yJKXIYwH2lFCrOEnRd
        atg+Z1PL96Qh7R3PaEN/xX8vtPhOXY9A/4s=
X-Google-Smtp-Source: APXvYqzFshsuv+IyMmfv+K7ZxtUfZm5PhJHbRo0sv/PZ+9kPjXaRXrDQoTPve3lpQ+P63v+BW0L/MbdyD6oDveA=
X-Received: by 2002:a63:4404:: with SMTP id r4mr77919539pga.245.1563932561833;
 Tue, 23 Jul 2019 18:42:41 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:21 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 5/5] PM / devfreq: Add required OPPs support to passive governor
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
index 58308948b863..14dc5bb58733 100644
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
+		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
+						    devfreq->opp_table, p_opp);
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
2.22.0.709.g102302147b-goog

