Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400362B8B45
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 07:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKSGGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 01:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKSGGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 01:06:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC1C0617A7
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 22:06:20 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so3419491pfg.8
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 22:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IomRGRIUUKoHDndCyhGBwVfU4P/jhWiv1ig1BoI3gF8=;
        b=s0/jCYgwS/sLeOVNCKtlEwbgmIWthbEbn7dsveVESIfChJXh/XH1X4bVE6ZNPgk+4D
         8guC92UHS/p5N6IeEPk5noIWDovt0ShmBpLvkom+qZW3r7HCjFeMGTKWMtJ99oIU4TZi
         6q24UBIQPIFbJP2YSMvwv/b1quVaH/Yz32kq4B+oPbnoAa3wJyCCkLnO8Jizov8DerJf
         6DAVhB0jyF7QCVOsgmyrI2pGqpxPmct/6uUw6yz4fFWam+UEmAnN4NcYB/z5LmWq0s9v
         HY5YlBEGFfLjfu454o9UEt52qCCNfASF59GEvTLAt97oBsM4NgLNn56v67L/9RDj6WDj
         yAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IomRGRIUUKoHDndCyhGBwVfU4P/jhWiv1ig1BoI3gF8=;
        b=WHcDwiyLoluhCBwIKE2yWC6tmiAYhsVENyUcY7wG352+h6glacZD2qO2SzeWlbHX4Q
         1r3xi6dRoN0ZTfOHUjXqx2XHJqW6pDeAw/H0xRAIk1GKW5AeChDFz5gp05rB5jJxAvPP
         Q1dSPHsMjqlVb7FuUvUw83PpIQ3IC6k7dHgYdBwnI9T2NC6kGhpFnnA/9La4X+gwDjll
         cMr/Zar0qr8ez0jeLIBy9/bD8r3miqhXr3uVbIi5zjPxzvImeKcqZkDmNvCN6oT2AbOC
         auPEDR6onPu2oECRKFiLbYXtlBx8SlePUMxXv/Inbc8kExJ/8IPesJdJFEr4dTHBorBo
         LOKg==
X-Gm-Message-State: AOAM533sviuAyALcbgJdSM15YHg6NEBAPU2eOD7PfF+HNYZHFV2MHvo8
        prak7SwJrU/9lKJxRhjgxMfnxT2zJAr8Fw==
X-Google-Smtp-Source: ABdhPJx8lGHoI+b43W1nPNovzf7uF6MtzFXk5g3Cr/FR1KU1SQuPHGFgBpHN+rWP7wffBhlYnR4WjA==
X-Received: by 2002:a63:5758:: with SMTP id h24mr11882286pgm.109.1605765980389;
        Wed, 18 Nov 2020 22:06:20 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id u6sm906769pgp.57.2020.11.18.22.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 22:06:19 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Reduce the size of critical section in _opp_kref_release()
Date:   Thu, 19 Nov 2020 11:36:16 +0530
Message-Id: <ed40e33c0b912abb271e5b884e4e4e518326ebe0.1605765973.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a lot of stuff here which can be done outside of the
opp_table->lock, do that. This helps avoiding a circular dependency
lockdeps around debugfs.

Reported-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 94 +++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9d145bb99a59..4268eb359915 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1251,9 +1251,14 @@ void _opp_free(struct dev_pm_opp *opp)
 	kfree(opp);
 }
 
-static void _opp_kref_release(struct dev_pm_opp *opp,
-			      struct opp_table *opp_table)
+static void _opp_kref_release(struct kref *kref)
 {
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	list_del(&opp->node);
+	mutex_unlock(&opp_table->lock);
+
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -1261,27 +1266,9 @@ static void _opp_kref_release(struct dev_pm_opp *opp,
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
 	_of_opp_free_required_opps(opp_table, opp);
 	opp_debug_remove_one(opp);
-	list_del(&opp->node);
 	kfree(opp);
 }
 
-static void _opp_kref_release_unlocked(struct kref *kref)
-{
-	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
-	struct opp_table *opp_table = opp->opp_table;
-
-	_opp_kref_release(opp, opp_table);
-}
-
-static void _opp_kref_release_locked(struct kref *kref)
-{
-	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
-	struct opp_table *opp_table = opp->opp_table;
-
-	_opp_kref_release(opp, opp_table);
-	mutex_unlock(&opp_table->lock);
-}
-
 void dev_pm_opp_get(struct dev_pm_opp *opp)
 {
 	kref_get(&opp->kref);
@@ -1289,16 +1276,10 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
 
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
-	kref_put_mutex(&opp->kref, _opp_kref_release_locked,
-		       &opp->opp_table->lock);
+	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put);
 
-static void dev_pm_opp_put_unlocked(struct dev_pm_opp *opp)
-{
-	kref_put(&opp->kref, _opp_kref_release_unlocked);
-}
-
 /**
  * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
@@ -1342,30 +1323,49 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
+					bool dynamic)
+{
+	struct dev_pm_opp *opp = NULL, *temp;
+
+	mutex_lock(&opp_table->lock);
+	list_for_each_entry(temp, &opp_table->opp_list, node) {
+		if (dynamic == temp->dynamic) {
+			opp = temp;
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	return opp;
+}
+
 bool _opp_remove_all_static(struct opp_table *opp_table)
 {
-	struct dev_pm_opp *opp, *tmp;
-	bool ret = true;
+	struct dev_pm_opp *opp;
 
 	mutex_lock(&opp_table->lock);
 
 	if (!opp_table->parsed_static_opps) {
-		ret = false;
-		goto unlock;
+		mutex_unlock(&opp_table->lock);
+		return false;
 	}
 
-	if (--opp_table->parsed_static_opps)
-		goto unlock;
-
-	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-		if (!opp->dynamic)
-			dev_pm_opp_put_unlocked(opp);
+	if (--opp_table->parsed_static_opps) {
+		mutex_unlock(&opp_table->lock);
+		return true;
 	}
 
-unlock:
 	mutex_unlock(&opp_table->lock);
 
-	return ret;
+	/*
+	 * Can't remove the OPP from under the lock, debugfs removal needs to
+	 * happen lock less to avoid circular dependency issues.
+	 */
+	while ((opp = _opp_get_next(opp_table, false)))
+		dev_pm_opp_put(opp);
+
+	return true;
 }
 
 /**
@@ -1377,21 +1377,21 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp, *temp;
+	struct dev_pm_opp *opp;
 	int count = 0;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
-	mutex_lock(&opp_table->lock);
-	list_for_each_entry_safe(opp, temp, &opp_table->opp_list, node) {
-		if (opp->dynamic) {
-			dev_pm_opp_put_unlocked(opp);
-			count++;
-		}
+	/*
+	 * Can't remove the OPP from under the lock, debugfs removal needs to
+	 * happen lock less to avoid circular dependency issues.
+	 */
+	while ((opp = _opp_get_next(opp_table, true))) {
+		dev_pm_opp_put(opp);
+		count++;
 	}
-	mutex_unlock(&opp_table->lock);
 
 	/* Drop the references taken by dev_pm_opp_add() */
 	while (count--)
-- 
2.25.0.rc1.19.g042ed3e048af

