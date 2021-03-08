Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE1330CB8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCHLvS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 06:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHLu4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 06:50:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51933C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 03:50:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id a4so6252826pgc.11
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0vln9EeLOexpgifVFX5SnMvpXYPQ0jk7HPzWLNd3SCw=;
        b=Ng4TH0X20pZ4V6qkg+lmxqdE1kprsBQDAKhtFupR6sUJVBSpV0GgCOZApoxghZZf9u
         FzqRGHT91dVCowiiZiYw1urn5SjsNoz3+++FIakLNbp50LtCTj4zQIoGrWzqv5ClUnRO
         8blTesxPEBYbvOO90UTpBFyMmbYq7hwwwJieCRWsQ78T9B437hFSHedQmQAuyIhH8jE9
         9SEF0zmlX8QO7o4w0UxsMh9BFgUwBvlv28dUxqiT/KzexXXMdkro0LlVoN36muz7Ev7K
         T0a7j7+w+mYTgLuNoeokLDozL0UHGLqEQCsxnoL+Ezz+NsjzYkuommeJwZB3sIVRCdNC
         ZD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vln9EeLOexpgifVFX5SnMvpXYPQ0jk7HPzWLNd3SCw=;
        b=jg98VGPDJ1cnV/c3K7Fif21iK1maySMVSTP+Lld8eJX7nkXk1UvYfvoSZ/XMC9tAt2
         gvuFianpbP6IU04BEJub+l7dUqL9TkZ8SpE9Jc5871IrrjQtu1BeMEhzKUgwhPjvCbQR
         1fYiopmd3xjEPU+0WKEi7wFpDmujImcURLjBbWqpM7Z1Xg6xbPtWLSH2A6qclq1P951b
         K+5htJUc3j9UVxJwHw630lYM3lyXQuK3YLh1yKiGxQQSNq08vs/iEWtmHJWv/+u+oLno
         O1ZRmdrbuyRFUAtDmmECJFs8U0ffttcyv5xGnwXnVV6HT4+Vw9Zj0ETemiSIb7LIHPvW
         P+FQ==
X-Gm-Message-State: AOAM530MpLo4ep10F+V5mMBkpKWKMRr85JfU8t28bj6Vd70OSQQCepZV
        8FCXasdq0hwGhVnd+YPLl5OQEg==
X-Google-Smtp-Source: ABdhPJy10PIihlEledowd6Ix+nPJYamm3Yx9G7BCVAnmfEUD7yD4MIvgwD55+qTOkkUYPRx44xwEgQ==
X-Received: by 2002:a63:cd09:: with SMTP id i9mr20627701pgg.407.1615204255913;
        Mon, 08 Mar 2021 03:50:55 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id a19sm10020833pff.186.2021.03.08.03.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 03:50:55 -0800 (PST)
Date:   Mon, 8 Mar 2021 17:20:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-03-21, 13:55, Beata Michalska wrote:
> Actually, that one might be problematic: by the time the
> _opp_table_kref_release is being reached, the opp pointed to
> by current_opp may no longer be valid.
> _opp_remove_all_static and/or dev_pm_opp_remove_all_dynamic
> will release all the opps by going through opp_table->opp_list.
> It will drop the reference for each opp on the list, until
> the list gets empty(for given opp type), which means,
> all the opps will actually get released
> (only upon _opp_kref_release the opp will get removed
> from the list).

Sorry for missing the context completely, I get it now.

This is what I have applied instead, please see if it breaks anything
or works as expected.

-------------------------8<-------------------------

From: Beata Michalska <beata.michalska@arm.com>
Date: Thu, 4 Mar 2021 15:07:34 +0000
Subject: [PATCH] opp: Invalidate current opp when draining the opp list

The current_opp when set, grabs additional reference on the opp,
which is then supposed to be dropped upon releasing the opp table.

Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
will completely drain the OPPs list, including dropping the additional
reference on current_opp because they run until the time list gets
empty.

This will lead releasing the current_opp one more time when the OPP
table gets removed and so will raise ref counting issues.

Fix that by making sure we don't release the extra reference to the
current_opp.

Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
[ Viresh: Rewrite _opp_drain_list() to not drop the extra count instead
	  of depending on reference counting. Update commit log and
	  other minor changes. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c2689386a906..3cc0a1b82adc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1502,10 +1502,38 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
 	return opp;
 }
 
-bool _opp_remove_all_static(struct opp_table *opp_table)
+/*
+ * Can't remove the OPP from under the lock, debugfs removal needs to happen
+ * lock less to avoid circular dependency issues. This must be called without
+ * the opp_table->lock held.
+ */
+static int _opp_drain_list(struct opp_table *opp_table, bool dynamic)
 {
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp, *current_opp = NULL;
+	int count = 0;
+
+	while ((opp = _opp_get_next(opp_table, dynamic))) {
+		if (opp_table->current_opp == opp) {
+			/*
+			 * Reached at current OPP twice, no other OPPs left. The
+			 * last reference to current_opp is dropped from
+			 * _opp_table_kref_release().
+			 */
+			if (current_opp)
+				break;
+
+			current_opp = opp;
+		}
+
+		dev_pm_opp_put(opp);
+		count++;
+	}
+
+	return count;
+}
 
+bool _opp_remove_all_static(struct opp_table *opp_table)
+{
 	mutex_lock(&opp_table->lock);
 
 	if (!opp_table->parsed_static_opps) {
@@ -1520,13 +1548,7 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 
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
 
@@ -1539,21 +1561,13 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
-	int count = 0;
+	int count;
 
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
+	count = _opp_drain_list(opp_table, true);
 
 	/* Drop the references taken by dev_pm_opp_add() */
 	while (count--)
