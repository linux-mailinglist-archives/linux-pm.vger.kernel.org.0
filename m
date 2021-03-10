Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098D3337C5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCJIsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 03:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhCJIrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 03:47:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB97C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 00:47:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u18so8116488plc.12
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGrZBeaXF+HMjO/q86rB/lGHV4vmErBKjQ6gCEkLtJg=;
        b=LiqddgMQU/ytIi87DsBUbe2czSBzJqyVO8mWfBcvKZcpV3AYXJYNzwIT2dgEpdUKb+
         lTzfaPzKBKdiaPDCbnAtR+qhnpncnI3YH0lt/2tNzbd1ISnAZG/hvZLuS4TwpFkIWU88
         UODjQpl2mVWPz7hTOBSl++o/TTlcnHzSJ3twXfm56y1ZeHU2xVw8iGrae2/S70qGVRKK
         a6VIIg3XvVSHZQx38lqofxQiP6JBFLJ2HpvE1fGc6JGWgMNQ/DLW4WWhL5lQIoAIgLHG
         od9Q6+EKg2Hx08Vgpo8ZlRxx2f1F7QLflQeAmAC6zSBUn2GG2ioJtsMZO6hwQxMEPy32
         WZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGrZBeaXF+HMjO/q86rB/lGHV4vmErBKjQ6gCEkLtJg=;
        b=l3CmH/Ft60vLhHT2t6TtkPL5aClLKPzyawnB5aO4wTz1KgU4E/gbxFFUYKueSp7C5Y
         LzxUoIsA9w4rQuxKa+cmKCNbyVqTyhkiPEE0x5tNqY1Uj0DbVdnZBWrlVlddvJ7PsOuv
         +e4VYEZEIsO9yyfyFVwn6mwQ8VKCMbS9vCWIOmzZSMP1y1RPKiw+maKmixDLWB5wXObA
         QI7KLImOZ0P4PknAq2GxlpNMZR6z5VZ6YkAir0PqeanBlN1k7wfWAxfucgM3QMuG0mac
         HCAqWe7MTOPjpvxb86i/GMmtqJ08TDObBab02tBq99HbtgR2l9nsnurJdSAgn3Fx/vyP
         3c1g==
X-Gm-Message-State: AOAM532Cp91dUqvn7hLpVeKW1c/H18mTSc6GnhsfvoYUa8/XzYi75Cfg
        2fMAZ1smZXZyfCMg0qoZJUw4xa89aASsCQ==
X-Google-Smtp-Source: ABdhPJzJ/qdbZbQl+zKjvTIt4cG5snuGZzohy8/hMovj5qb9lLyI8rS+OxudEmZk5cxPuRJQyFBd6g==
X-Received: by 2002:a17:90a:2a41:: with SMTP id d1mr2455382pjg.164.1615366061310;
        Wed, 10 Mar 2021 00:47:41 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id j35sm15947670pgj.45.2021.03.10.00.47.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Mar 2021 00:47:40 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:17:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210310084738.pe7ppyeq6hn7wbvv@vireshk-i7>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
 <20210308181446.GA26783@e120325.cambridge.arm.com>
 <20210309043121.546mlvl4jmshogor@vireshk-i7>
 <20210309121455.GA13095@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309121455.GA13095@e120325.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-03-21, 12:14, Beata Michalska wrote:
> With the current version, once the _opp_get_next returns opp
> that is the current_opp, the while loop will break, leaving all
> the opps that are on the list after current_opp

Thanks for your excellent review Beata. I have been missing a lot
lately :(

Though now I have spent more time on it and the bug seems to be more
severe. This is what I have applied now :)

I was able to test that the OPP table gets freed without any reference
counts issues now.

-- 
viresh

-------------------------8<-------------------------
From: Beata Michalska <beata.michalska@arm.com>
Date: Thu, 4 Mar 2021 15:07:34 +0000
Subject: [PATCH] opp: Don't drop extra references to OPPs accidentally

We are required to call dev_pm_opp_put() from outside of the
opp_table->lock as debugfs removal needs to happen lock-less to avoid
circular dependency issues.

commit cf1fac943c63 ("opp: Reduce the size of critical section in
_opp_kref_release()") tried to fix that introducing a new routine
_opp_get_next() which keeps returning OPPs that can be freed by the
callers and this routine shall be called without holding the
opp_table->lock.

Though the commit overlooked the fact that the OPPs can be referenced by
other users as well and this routine will end up dropping references
which were taken by other users and hence freeing the OPPs prematurely.

In effect, other users of the OPPs will end up having invalid pointers
at hand. We didn't see any crash reports earlier as the exact situation
never happened, though it is certainly possible.

We need a way to mark which OPPs are no longer referenced by the OPP
core, so we don't drop extra references to them accidentally.

This commit adds another OPP flag, "removed", which is used to track
this. And now we should never end up dropping extra references to the
OPPs.

Cc: v5.11+ <stable@vger.kernel.org> # v5.11+
Fixes: cf1fac943c63 ("opp: Reduce the size of critical section in _opp_kref_release()")
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
[ Viresh: Almost rewrote entire patch, added new "removed" field,
	  rewrote commit log and added the correct Fixes tag. ]
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 48 ++++++++++++++++++++++++----------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c2689386a906..150be4c28c99 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1492,7 +1492,11 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
 
 	mutex_lock(&opp_table->lock);
 	list_for_each_entry(temp, &opp_table->opp_list, node) {
-		if (dynamic == temp->dynamic) {
+		/*
+		 * Refcount must be dropped only once for each OPP by OPP core,
+		 * do that with help of "removed" flag.
+		 */
+		if (!temp->removed && dynamic == temp->dynamic) {
 			opp = temp;
 			break;
 		}
@@ -1502,10 +1506,27 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
 	return opp;
 }
 
-bool _opp_remove_all_static(struct opp_table *opp_table)
+/*
+ * Can't call dev_pm_opp_put() from under the lock as debugfs removal needs to
+ * happen lock less to avoid circular dependency issues. This routine must be
+ * called without the opp_table->lock held.
+ */
+static void _opp_drain_list(struct opp_table *opp_table, bool dynamic)
 {
 	struct dev_pm_opp *opp;
 
+	while ((opp = _opp_get_next(opp_table, dynamic))) {
+		opp->removed = true;
+		dev_pm_opp_put(opp);
+
+		/* Drop the references taken by dev_pm_opp_add() */
+		if (dynamic)
+			dev_pm_opp_put_opp_table(opp_table);
+	}
+}
+
+bool _opp_remove_all_static(struct opp_table *opp_table)
+{
 	mutex_lock(&opp_table->lock);
 
 	if (!opp_table->parsed_static_opps) {
@@ -1520,13 +1541,7 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 
 	mutex_unlock(&opp_table->lock);
 
-	/*
-	 * Can't remove the OPP from under the lock, debugfs removal needs to
-	 * happen lock less to avoid circular dependency issues.
-	 */
-	while ((opp = _opp_get_next(opp_table, false)))
-		dev_pm_opp_put(opp);
-
+	_opp_drain_list(opp_table, false);
 	return true;
 }
 
@@ -1539,25 +1554,12 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
-	int count = 0;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
-	/*
-	 * Can't remove the OPP from under the lock, debugfs removal needs to
-	 * happen lock less to avoid circular dependency issues.
-	 */
-	while ((opp = _opp_get_next(opp_table, true))) {
-		dev_pm_opp_put(opp);
-		count++;
-	}
-
-	/* Drop the references taken by dev_pm_opp_add() */
-	while (count--)
-		dev_pm_opp_put_opp_table(opp_table);
+	_opp_drain_list(opp_table, true);
 
 	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 50fb9dced3c5..407c3bfe51d9 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -56,6 +56,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
  * @dynamic:	not-created from static DT entries.
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
+ * @removed:	flag indicating that OPP's reference is dropped by OPP core.
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
  * @level:	Performance level
@@ -78,6 +79,7 @@ struct dev_pm_opp {
 	bool dynamic;
 	bool turbo;
 	bool suspend;
+	bool removed;
 	unsigned int pstate;
 	unsigned long rate;
 	unsigned int level;
