Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4CB6FED
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfISAJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 20:09:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35675 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISAJw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 20:09:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id a24so803842pgj.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jFcf9iaa7Tt4QrvMrWEeq0CzGPxx9DksNwganDUQw0=;
        b=AHzxOc1w8Ea6pHo+1TvR/i0feaAwaavrGAD9fcT7m8YnFkOJx3p43rpMLW2m/wHb0C
         c/cxBpUKn5fQNkhvjHMXRO+SDzjOurEm+Ge47N94fybQ6OHOH7/eDiQcIB3Fjmb/FIrY
         d0jlclUlTAsDoP/XloLOW3tg2nHBY8nSbSrmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jFcf9iaa7Tt4QrvMrWEeq0CzGPxx9DksNwganDUQw0=;
        b=crNzivipnsowEQcmjNmpUmbqYTASd0CC9MULeHcKAckRX8f2oNVzWkVUgGuNZ6b6b/
         Jms+yJtVkJbN+QtvyELQh4yljbfKfnELNwQKyWv7Q3MltxA56V1sT3Ob+LXC8oCUBAi3
         VcEH6HR2NyaB6vmJONMGY6D6tPEM7PTBZKeTYAHOYlY/29BdAR86/faaochVU9WPeJZA
         LL37bkF+1PeshdTBlwgX4D21dFfgakt/b1n9IfKqadXHg3pEvZSPrL1+X1ZbrCXREkAv
         BQj19IYu2quAuiXsagu6U3qlO5x6PwzgwDcaq41c7mBdLKVp1cQPGIrcm/qFVQ9dnulS
         OX0Q==
X-Gm-Message-State: APjAAAU+QJ4T+3GlGV/SakO71aLaDGon+1/s2tFFbdqGPDO70pe7qbQW
        Xf9iH4qs+7bt1lcngQlXBnZbmg==
X-Google-Smtp-Source: APXvYqyGzlz4fGaEnyzkA0gV1KKoYGKOWF3MNf0NuTCha9rCY0aacX7jNyH0uw9hH/t+v16yZw7TZQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr603695pju.41.1568851792121;
        Wed, 18 Sep 2019 17:09:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k31sm3890132pjb.14.2019.09.18.17.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:09:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] devfreq: Make log message more explicit when devfreq device already exists
Date:   Wed, 18 Sep 2019 17:09:46 -0700
Message-Id: <20190919000946.158454-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before creating a new devfreq device devfreq_add_device() checks
if there is already a devfreq dev associated with the requesting
device (parent). If that's the case the function rejects to create
another devfreq dev for that parent and logs an error. The error
message is very unspecific, make it a bit more explicit.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..0e2dd734ab58 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -625,7 +625,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
 	if (!IS_ERR(devfreq)) {
-		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
+		dev_err(dev, "%s: devfreq device already exists!\n",
 			__func__);
 		err = -EINVAL;
 		goto err_out;
-- 
2.23.0.237.gc6a4ce50a0-goog

