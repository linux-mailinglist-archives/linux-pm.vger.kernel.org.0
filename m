Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EF78942
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfG2KIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 06:08:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47001 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 06:08:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so27294645plz.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fEW7+SbxzCoi91sgqoZtF3yOSneHk+JvM7yQhAXJHCs=;
        b=HmseaTTmcgTcjq0JixMYiUyyeZqlLv0Erxz8MwOVHB3bG2OSRlcZYPxp2HFwKuxmaX
         MazvSOS+AIyud5Thwr9MknkMOaeqwM79fNcGThy8VdfJU6jqr6/5MkQQvSKLYI90ryZ1
         BQdtRmTnefC3QYOzeDuAocFfoE/Xx8aV35GZBk5z7mJ3vSVm/ts8Q43l3RDXRba8mUcl
         7a4zhfzE03firC9Wa5JwdPMF6RZRwXmDFezqVmS9yMc3eKJIiQpnV+L3ffK5UewCIug1
         kSB9DcJW0SCDDYd9WNmELN5KSR+5Zylb1vGkF+aEObDZgzVPW997yqlouQ4H3CiryacB
         vP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fEW7+SbxzCoi91sgqoZtF3yOSneHk+JvM7yQhAXJHCs=;
        b=Xd/fReL80Tvc2OCKNX/aHyLJ3uH4Q0Aeg5A62wqs32Si5nm+yLLMoh3FdUmqKhR908
         rvFh15sadpppEu6iLefGocEazbkmkQBAqHzNyo755ccA9CbWeQiHCSbS4dXz3aT0hhbj
         tIWLKpirk+XHf3qjboDTQn9j1s1IqQLZszww/7YPyjhQyy/8IzB0q0IUpLUdVw8Q5gIY
         zIYvqET0oLsUD8HJkctI7kld0SRrwhOG4h3bBq6q2U6AwKIJ9s/xCOvSAe1+1R0gjU2f
         RJu4iwdCr+FVA4KqE/aqQNdhATYm/Dbr91roGxXDBd1l3yIErgc4LJhXl260Fi+AMEuR
         W5iA==
X-Gm-Message-State: APjAAAW6pQJxKweykN9ssCcYgI/bsDiM70HXNZGp3YcI2DDnXRCqhwmd
        vHFTyxRSKduagGI028Ss7zM=
X-Google-Smtp-Source: APXvYqwuMYnCrY+bY1H5UCK71VEsJ8Zw+/SHwQieCR+YfK5//a1nTu3XLWjnd2UUKtWSzJTOPRM8qg==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr25401303plo.278.1564394929300;
        Mon, 29 Jul 2019 03:08:49 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id g2sm76981953pfb.95.2019.07.29.03.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:08:48 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH v2] PM / devfreq: Remove list_for_each_entry() in devfreq_add_governor()
Date:   Mon, 29 Jul 2019 18:08:34 +0800
Message-Id: <20190729100834.8072-1-zbestahu@gmail.com>
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
governor. So, the devfreq_list would not contain the device which has
the governor to be added when registering governor.

Moreover, use EEXIST instead of EINVAL in devfreq_add_{governor,device},
update message existing related also.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: correct syntax error in description

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

