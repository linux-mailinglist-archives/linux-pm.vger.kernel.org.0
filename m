Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E49ED4E3
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfKCUmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42090 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfKCUmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id z12so10696926lfj.9;
        Sun, 03 Nov 2019 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9RKaIiF4lILXf0g5OU6lPR/hR2F0oEkesL+dfO7WO0=;
        b=bIr2c2XLqMWyWx8Q+YXSYy/FSwr24LNauoauFUdjS9vxY6/g53rWhD6J25UIkWcj3q
         hiOsrTQvx6rmN/tHzv3znYROLoxXbYj7LnSlFlRx4KwH04jAjIRKi7OVMuKzR0/hbmZT
         LMFHFKZzsTemkMGHWHlu1k1sJDbBjOlcbMkcTXqihi9/3wOvoVExEoO7/spwvJkVrWkv
         U07HoRB6pwV/tkzdk4+BfVFQgX24Azcn513umw/e1GmCLyZfaGWLVbe770g8EG1gzfKE
         Lnd1BGOlprA8JQZ2eeE0YcINAOLrr3F2ur689h+5ek8kle26WWN2WmO9Uly38D1JrAr3
         7zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9RKaIiF4lILXf0g5OU6lPR/hR2F0oEkesL+dfO7WO0=;
        b=bd0g9S1wfpPPOJmGx6+hFVVKbOE5ArH0Pnx5xkAzXSKX5QxGz0DHj9HwlPhDOTXFBy
         lxJPDcwTtIg7A//9e6EtLRWt4QpqhkBkpgTcpd+uYfQxKMBI7dj8JL3yv2R+oblUr9IK
         632Hqrpd7LRu+1/Z4eShJ9LOjonJuuTTQsRvzg+djegqlKTBkr1VokJ2LwRr36m5dyU3
         YBUCsNHmtyXWTxUFAijBJ74hqnYvCf4Phmbm5W2+zYoUxqF10Co4ybzGxTzM124r6927
         gVZLorwqKqGCIvEpUyJ8Su/nqEI5x5j8KJ49ElVfMvqL6rxQghGwGpbTPBppeq4sYAQK
         FUNQ==
X-Gm-Message-State: APjAAAV0JVgDWDF7GRrRV19oQZ6UPFThfB7NAQ6vPobDghsVOWdgfhdA
        31b7dtvS/+mPBxKkNWXRoKg=
X-Google-Smtp-Source: APXvYqwfyA5T0mNQ52g3uoETq3AQ2tim5RXnKNMu+dKN65N13dy2INlDVctzYl2KocIIlDNMzWHPdg==
X-Received: by 2002:ac2:4c1b:: with SMTP id t27mr14008746lfq.55.1572813732257;
        Sun, 03 Nov 2019 12:42:12 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/18] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Sun,  3 Nov 2019 23:41:22 +0300
Message-Id: <20191103204130.2172-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9cb2d6468175..bc46af155b99 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -490,7 +490,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.23.0

