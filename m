Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29977885B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfG2J0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:26:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34470 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2J0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 05:26:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so27717316pfo.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KZagFo33bHRnBIGPyEiPcnqVAbUxGNrJfOs1kOO0+Ek=;
        b=I55RZjyiL1kpnB00cKt8osWlezHuH6GZeJEsZ8cvhLnD1EpJMdz9+f4cC1vo7ckyoK
         POP6CM1z3BrsiN/ntLTwzvD0NtVTWNjDfz8wTXbPiJ7vmJHzKobqlbCiMzjQemFaFO8T
         YfbJVgu1Q5oMbBaQZDbG7oPEMKAvcAgjA4N3uX7v5ZJyooegiEtw7zW+lMVTWIKFz4Mz
         /iL8ReB0Sew5zC1KCoyUjTYmX0x3mgtW5s3IhxSdhPcreHAr1drvsx63/mLHnx0Bd+lA
         Zi8ScvC6kadsSpcfgNjwb7derLEn15DR21HQiS6IYF5zHdUtIMIdWfnUGGVitO0lpGcI
         ZttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KZagFo33bHRnBIGPyEiPcnqVAbUxGNrJfOs1kOO0+Ek=;
        b=T72Ygu8zNHN4A1tC1e8GiJyyh1W4mamlqNwRfo45uSQAhsNcbt+amLmqUKz0nflomP
         ybNnztYAbaV9ixMTQ5llFwirXDoAaD+vcsboknJkgU4WCsIzIlwfO1iCSVzFUYlKWEXQ
         ot4fvl4OZXdx4ia1yJignhgFmp+1VtIeIKQ57Mj4dmW1+Wd3CW+yP1HrpxQ8vxTLeCgA
         nQpapiZg8MIihgWhGnWm7r90eHHjXkGuu2ERUGI4n2Z9yv5YyDXhjm/JK0ESigYl2ZVb
         OL5nnLbtpW3CaZ4bQdDZLrZeWoUM3iviDfvQqYIgxYZhFUVcuePQIYxetHQhlqPpG/re
         kuYA==
X-Gm-Message-State: APjAAAUixrIUxfz7R7CbpsLFlziU6ku5a45iDivgaUybZrC4gv+fbC1B
        N+bCobRZlzDOWaUV/zqAaH8TftgL
X-Google-Smtp-Source: APXvYqxkGIMjjG1Ub3MSxm1vBiN05pMcKJdlpDfk0zBdIZ5UXPiIcZgdNi9gJZ1KbvRfKFoWeioTqw==
X-Received: by 2002:a62:e815:: with SMTP id c21mr36921203pfi.244.1564392401552;
        Mon, 29 Jul 2019 02:26:41 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id h16sm65206242pfo.34.2019.07.29.02.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:26:40 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] PM / devfreq: Remove list_for_each_entry() in devfreq_add_governor()
Date:   Mon, 29 Jul 2019 17:26:17 +0800
Message-Id: <20190729092617.9032-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We will call try_then_request_governor() to find a governor from a list
of devfreq_governor_list in devfreq_add_device(). Only if the governor
has been registered in this list, the devfreq adding will be successful,
fails if not. That means we should do the governor registration charged
by devfreq_add_governor() before adding devfreq for a device with this
governor. So, the devfreq_list would not contains the device which has
the governor to be added when registering governor.

Moreover, use EEXIST instead of EINVAL in devfreq_add_{governor,device},
update message existing related also.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/devfreq/devfreq.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e..104f03d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -625,9 +625,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
 	if (!IS_ERR(devfreq)) {
-		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
+		dev_err(dev, "%s: Existing devfreq for the device.\n",
 			__func__);
-		err = -EINVAL;
+		err = -EEXIST;
 		goto err_out;
 	}
 
@@ -998,7 +998,6 @@ void devfreq_resume(void)
 int devfreq_add_governor(struct devfreq_governor *governor)
 {
 	struct devfreq_governor *g;
-	struct devfreq *devfreq;
 	int err = 0;
 
 	if (!governor) {
@@ -1011,44 +1010,12 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 	if (!IS_ERR(g)) {
 		pr_err("%s: governor %s already registered\n", __func__,
 		       g->name);
-		err = -EINVAL;
+		err = -EEXIST;
 		goto err_out;
 	}
 
 	list_add(&governor->node, &devfreq_governor_list);
 
-	list_for_each_entry(devfreq, &devfreq_list, node) {
-		int ret = 0;
-		struct device *dev = devfreq->dev.parent;
-
-		if (!strncmp(devfreq->governor_name, governor->name,
-			     DEVFREQ_NAME_LEN)) {
-			/* The following should never occur */
-			if (devfreq->governor) {
-				dev_warn(dev,
-					 "%s: Governor %s already present\n",
-					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
-				/* Fall through */
-			}
-			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_START, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
-		}
-	}
-
 err_out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
1.9.1

