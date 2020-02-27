Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018551724AF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgB0RJ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 12:09:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0RJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 12:09:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so40220ljg.6;
        Thu, 27 Feb 2020 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d2ikdqfSzyCyHKBwzyOB/NzazDViDKr5gLhXg7TE5w=;
        b=cBmmg033uMjVyyiiZzBQ6LYyy+VgUvpGxjDYnJbqsFA5QYw4c0+iBD+yt8NL3fyA0z
         1mhds+EI/xVyu45GOaJ12WhmGvH3xJ4r8WG8AXlPRIgvu/FZ6FEeemJCuIz+Wpwov7m2
         AT1+Y90aYC9YIILe1wY5yqYOvyStCo09yByNLSItCx+gkhB6dGCJJQdX69wXJOpMDx5Q
         kv5wJcBKwIUyY2qFVR8zCsY4CzWjhPtccyMk4ZvVFe5jsVGdiUnTx2fXJKMtD3jvKMqv
         q4UExMEqTsprti7lEPu3ezmD8PS3vUPu4YT4Xbg3onwy2gaYHmDmUzyimxrwl5kgBCt1
         KJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0d2ikdqfSzyCyHKBwzyOB/NzazDViDKr5gLhXg7TE5w=;
        b=iKTLlkwG7+GMd6i4/bGmxIuoMa+C4pZL5Oa1KxPMWNZYqihToYsjrmE94irzvYt3e9
         rqCw5XHcJIKEuKg7YGcQVzbp65b+6PjQSiwUno/GTncBxJ3G0P5Fu5chN56WhOIU52be
         eDVhRXUjYgtYURFcp7A5wLY2byjomg+B8+o7i7RaHBZZNwncR/6uWWNbexQo/kNPapiw
         UCWAzoO6zrila/m04kSwBywhIBvIrghQph6i/Y2pyamCxnBSsyW0tnC7X8c1O+q1zx5I
         NWl/v03GKW0HC35hgUA0fbwn4msA47nGJ02P7fvw8jiAu+F2jAszHgts4wfanjwVoJlP
         nhUw==
X-Gm-Message-State: ANhLgQ23NwqsGVS2ZTaYQOjhbXx9DVHsQTq3cHu8sBaN8ch4WzZaP2Gx
        FO+xb1yuQqo7dYxsHa9lAPLcqQbp
X-Google-Smtp-Source: ADFU+vvgTDPwZpbNLylJZlslLydu4OjybK/HBSQ1vL7bDA6o+HD8DhCJKwHAJcYdOChS2Co1JE4Yaw==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr59358ljp.68.1582823366131;
        Thu, 27 Feb 2020 09:09:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j11sm3049513lfb.58.2020.02.27.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:09:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RE-SEND v1] PM / devfreq: Replace strncpy with strscpy
Date:   Thu, 27 Feb 2020 20:08:54 +0300
Message-Id: <20200227170854.9949-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

GCC produces this warning when kernel compiled using `make W=1`:

  warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
  772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);

The strncpy doesn't take care of NULL-termination of the destination
buffer, while the strscpy does.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8494c5f05a73..2011f64bfa3a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
-	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
+	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
-- 
2.24.0

