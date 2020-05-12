Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D081CED24
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgELGmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 02:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGmI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 02:42:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE03B20575;
        Tue, 12 May 2020 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265728;
        bh=/twyJJ9dZnGQh92dBReEWJHuGeydxSxiQp7BLmW7c7o=;
        h=From:To:Cc:Subject:Date:From;
        b=taEzXckUt0vlcJ9f68oz31J364YSwNW5+KCBizpQ4D4/vsC34fDLCcLBk7STZEc/F
         HyNU4ON4ZTdftIASirnYBNZHzkM0WcuNsi5YP3/kUJbMLARc3piOna09c6+XrbeLTM
         gahpFbWGga3D8ejRHtplh60Zq23alEdJbzz/+yWk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] devfreq: Use lockdep asserts instead of manual checks for locked mutex
Date:   Tue, 12 May 2020 08:41:58 +0200
Message-Id: <20200512064158.7957-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of warning when mutex_is_locked(), just use the lockdep
framework.  The code is smaller and checks could be disabled for
production environments (it is useful only during development).

Put asserts at beginning of function, even before validating arguments.

The behavior of update_devfreq() is now changed because lockdep assert
will only print a warning, not return with EINVAL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/devfreq.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ef3d2bc3d1ac..52b9c3e141f3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -60,12 +60,12 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 {
 	struct devfreq *tmp_devfreq;
 
+	lockdep_assert_held(&devfreq_list_lock);
+
 	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
-	WARN(!mutex_is_locked(&devfreq_list_lock),
-	     "devfreq_list_lock must be locked.");
 
 	list_for_each_entry(tmp_devfreq, &devfreq_list, node) {
 		if (tmp_devfreq->dev.parent == dev)
@@ -258,12 +258,12 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 {
 	struct devfreq_governor *tmp_governor;
 
+	lockdep_assert_held(&devfreq_list_lock);
+
 	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
-	WARN(!mutex_is_locked(&devfreq_list_lock),
-	     "devfreq_list_lock must be locked.");
 
 	list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
 		if (!strncmp(tmp_governor->name, name, DEVFREQ_NAME_LEN))
@@ -289,12 +289,12 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	struct devfreq_governor *governor;
 	int err = 0;
 
+	lockdep_assert_held(&devfreq_list_lock);
+
 	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
-	WARN(!mutex_is_locked(&devfreq_list_lock),
-	     "devfreq_list_lock must be locked.");
 
 	governor = find_devfreq_governor(name);
 	if (IS_ERR(governor)) {
@@ -392,10 +392,7 @@ int update_devfreq(struct devfreq *devfreq)
 	int err = 0;
 	u32 flags = 0;
 
-	if (!mutex_is_locked(&devfreq->lock)) {
-		WARN(true, "devfreq->lock must be locked by the caller.\n");
-		return -EINVAL;
-	}
+	lockdep_assert_held(&devfreq->lock);
 
 	if (!devfreq->governor)
 		return -EINVAL;
-- 
2.17.1

