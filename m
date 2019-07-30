Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C721B7ADB0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfG3Qco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46916 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbfG3Qco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so66453135wru.13;
        Tue, 30 Jul 2019 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4cjr07AsirEz91eg9mFm8o6OseSrE7ayitU1YySAxU=;
        b=adZyrNzXUPH6z65oVJ2iq2t4BMP5bIIVNTRVWLaTw+Wuq7M6NSo2zrbkofCsehR4oT
         1fW8zX+pI2p0doHQ8moz3SSd4ScZXdBF0cC2NWxWAdX7zo9FUyCTR8U4owXw642Da6wv
         hTpGE0mDjratFeWcMuqlDcM6Mdq+c2P7X2/EIVnpp5BE41kBeRzuPLb5Dd4gIGibhRwN
         FL/TG1aQ+ExLnOUqbno/9tZZXm5Mi912EcNYNx3sZQFImLNgi932He5jgmcy+1mUiwH/
         QzgjCfEXSkGpMTl/JlNSWKy54xS6Yk9RLW2TQyGP6k2+2UP4I6pWC3NANZlbhx4iSKdm
         EiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4cjr07AsirEz91eg9mFm8o6OseSrE7ayitU1YySAxU=;
        b=LnMNkUVuq9cNjfzxi94u5VMRe49rW2DYy0dBhzxURl6Mu48sy9iPiK/kw41KIiGbwv
         OJzYfdRWEL9g3IS8ybw9e+c9sXI8G1lZRun8k6HDpVEV+GqgZEosAqR/5gQ27bSofdva
         X2wdGEKdVTfjc8rL3lAxXp/1/82KU0ljALt8fPnDEgvpWI1WbGKmWohjv7D8RwIwLupl
         NS9wIS5vOr7tkloRPej3IpADiuSxHGY7lqJ7+qqYKal8SiG8VEvKhKcSqTiSaqFXe4+v
         hv/yPL0YmV+UCU7gzaoLz5cQMEzb2gxKHhM5jvbVCx9r2qPEFOFr8WkX1mJsi359Rr2T
         RnQA==
X-Gm-Message-State: APjAAAW/sZQAvdgcExQO3mGSECWYKUMzcEpHzm/LfLyJ7PpKQuEF2W6K
        yZ6ClROq7DtG7PqPFQpWWpU=
X-Google-Smtp-Source: APXvYqzBNTWBRAmBYoyVRsTlnA0EiMpuZZ5pGyv/H1nkJ2W314/JYJ1iZhIz/i4c5qfWNrga+gAhTA==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr40300335wrm.265.1564504361969;
        Tue, 30 Jul 2019 09:32:41 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/20] PM / devfreq: tegra30: Define ACTMON_DEV_CTRL_STOP
Date:   Tue, 30 Jul 2019 19:22:34 +0300
Message-Id: <20190730162236.6063-19-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add verbose definition for the client's device control register value that
makes ACTMON to stop monitoring of the device.

Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 3543fba74b52..8adc0ff48b45 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -35,6 +35,8 @@
 #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
 #define ACTMON_DEV_CTRL_ENB					BIT(31)
 
+#define ACTMON_DEV_CTRL_STOP					0x00000000
+
 #define ACTMON_DEV_UPPER_WMARK					0x4
 #define ACTMON_DEV_LOWER_WMARK					0x8
 #define ACTMON_DEV_INIT_AVG					0xc
@@ -714,7 +716,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 
 static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
 {
-	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
+	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 }
 
-- 
2.22.0

