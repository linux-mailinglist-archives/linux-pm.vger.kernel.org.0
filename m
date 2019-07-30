Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB27A2E5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfG3IML (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 04:12:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41590 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfG3IML (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 04:12:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so29435777pff.8
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AvJh1+ehJfjtQyZ/1ZF197SNbbGiZwXcUSjoIjY3cyw=;
        b=YTqpoDhogLsL+ZUdFC71YsRrwvxaMebbQbjfZxHNMlR1UXer752qiFjumw5OVC1PaJ
         KhBSMXT9/9nhgvtcw6HGM+Wl/vqdXzDZZ539cvio0VNa3k4XWEiGqgGFwMFwk8Bede1d
         hjCYQr+YnYtux5f05xkOUMzIguXlV0yIdc2BFX5SDxpDxUU6J9bcfvKBcMZSWT+ljOXV
         zpX9nZ0vYt2lhlA1CxCRSKLrVvbXWUSEQ8Q364JR7b+pogpDah4Qs3VhHxbjAPw6Mwu5
         i9GiwIen8JuF7fO0jBbVIyu1HG4LucKEeYBbwpBoP9GdN2zYWGOB9uxi3LD9jUs7OxYa
         aqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AvJh1+ehJfjtQyZ/1ZF197SNbbGiZwXcUSjoIjY3cyw=;
        b=mGqehTJh+e3Ki0xz5Kjmq1L7O/fRj/YX/1J6OEbS/KQvgzOJePOOoAn23MFtSDhzQI
         srUo99l48HNSbfc6SC9Z9ytVV0dbafhd2UqJMGUr4amNjzh79xcR8I+wMZR7VAyGQeHg
         y/6WMzV26yPWZChDpCze0aoNMd/HItIFV6RQkD/uEtEasPZk57tfLkKQ5IE/F9TI4LE+
         ZY+pxUUgTOQTUYaMxjRI0V538QEHnLOGO566bMwJxpyjns0Obu/aCAnr5AUCxGdhKsDw
         H1qo6CLFWSw0fF/u0tSwMa5DD8odgSVt+GvD1sW/w2VioIKsS6qNN3OLZlswdjYJS0WH
         SEYw==
X-Gm-Message-State: APjAAAX/tOH6h4jy6v8XiqlUxCqTALue2lg1+Yh7CB14UDzFQuqQoh3n
        klSrxC8g8uJ/rOOguZBBYiuSlBiL
X-Google-Smtp-Source: APXvYqxoOe2l858p/NtPCIgJTWwtcjdO/3if0Js98pAyNcSNAbmvGmB9mRGkCtIuDYlr+ZOk3pQfmQ==
X-Received: by 2002:a63:101b:: with SMTP id f27mr103901110pgl.291.1564474330786;
        Tue, 30 Jul 2019 01:12:10 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id b29sm101143910pfr.159.2019.07.30.01.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:12:10 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH v3] PM / devfreq: Remove list_for_each_entry() in devfreq_add_governor()
Date:   Tue, 30 Jul 2019 16:10:41 +0800
Message-Id: <20190730081041.11528-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

If one governor is built as module, check calling logic below in
successful path:

  devfreq_add_device()              try_then_request_governor()
    try_then_request_governor()       devfreq_add_governor()
    devfreq->governor = governor;       list_for_each_entry() {
    start governor                        devfreq->governor = governor;
                                          start governor
                                        }

Obviously, we have duplicated governor operations. And the relevant
check like name in list_for_each_entry() is needless also.

For built-in governor, devfreq_add_governor() will be called before
calling devfreq_add_device(). That means ->governor_name would not be
equal to ->name.

Thus, let's drop the list_for_each_entry() in devfreq_add_governor().

Moreover, use -EEXIST instead of -EINVAL in devfreq_add_{governor,device},
update message related also.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: correct syntax error in description
v3: update the description totally

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

