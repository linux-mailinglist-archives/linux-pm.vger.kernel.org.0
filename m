Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98D74F088
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFUVkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 17:40:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58768 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUVkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 17:40:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 95351265AC4
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2] PM / devfreq: Fix kernel oops on governor module load
Date:   Fri, 21 Jun 2019 18:39:49 -0300
Message-Id: <20190621213949.27018-1-ezequiel@collabora.com>
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

Fix this by returning -EINVAL if request_module returns a positive
value.

Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes from v1:
* Rework the fix as suggested by Enric and Chanwoo,
  handling the return vaue.
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6b6991f0e873..258f70c1e48f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return ERR_PTR(err);
+			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

