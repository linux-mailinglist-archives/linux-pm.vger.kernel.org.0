Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3C363AE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfFETBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 15:01:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51856 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFETBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 15:01:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E414E260D04
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 1/2] PM / devfreq: Fix governor module load failure
Date:   Wed,  5 Jun 2019 16:00:52 -0300
Message-Id: <20190605190053.19177-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A bit unexpectedly (but still documented), request_module may
return a positive value, in case of a modprobe error.
This is currently causing issues in the devfreq framework.

When a request_module exits with a positive value, we currently
return that via ERR_PTR. However, because the value is positive,
it's not a ERR_VALUE proper, and is therefore treated as a
valid struct devfreq_governor pointer, leading to a kernel oops.

The right way to fix this is hinted in __request_module documentation:

"""
[snip] The function returns
zero on success or a negative errno code or positive exit code from
"modprobe" on failure. Note that a successful module load does not mean
the module did not then unload and exit on an error of its own. Callers
must check that the service they requested is now available not blindly
invoke it.
"""

Therefore, drop the return value check, which is not useful, and instead
just re-try to find the (hopefully now loaded) governor.

Fixes: 23c7b54ca1cd1 ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/devfreq/devfreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6b6991f0e873..8868ad9472d2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -236,7 +236,6 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
 	struct devfreq_governor *governor;
-	int err = 0;
 
 	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
@@ -251,13 +250,10 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 
 		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
 			     DEVFREQ_NAME_LEN))
-			err = request_module("governor_%s", "simpleondemand");
+			request_module("governor_%s", "simpleondemand");
 		else
-			err = request_module("governor_%s", name);
-		/* Restore previous state before return */
+			request_module("governor_%s", name);
 		mutex_lock(&devfreq_list_lock);
-		if (err)
-			return ERR_PTR(err);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

