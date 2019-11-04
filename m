Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3BEEF2D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfKDWTi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:19:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34811 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbfKDWBC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so19446965ljf.1;
        Mon, 04 Nov 2019 14:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=WlvVqbk/liqG+K0UazXBD82hDz7hN4WqmsdFdZrNXEqvEEqYJQBRhIPdnXeBM1bgas
         kGInSmGqK/nzGxfsyHmJ1SE0m5t+xOCcaORqijgtWAVPx9f9AqLqoXY5K0rqPN/QrS69
         ScLGhO9Xs6XMldR0q9HYnUnIjQQYNWSyt+qfWC33su0WeNtcW9SXx03TdgPEoQhKSTa5
         AmTqTcLdP+hphVixw3WcX+XAqBqBbYUuao3Jc+sBPvGBudULEdcVlAdERoybkGmlhl4F
         SmVBMjP5cvoc6io0dLsEmXRNYmdEW9sQLUsr46CkHAmLT3sLDr4kLEwU9yXIrM9r7AUo
         mGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppdzoc/V97ChcXO7v2Rn6eiJN21LngJ2PFR09uQ6kL0=;
        b=lvWASNYL9iM59Ce9LFBF768udf0g8x5g5VLMQMdcdQleBsNTSSlllj0Hc/hedu5jVd
         9cRcSQvstjasDwM7zzc+/xe5vWGc1FZGbd0EHyCr552dQ+KJqhQO7fFDFHGSZMtEqbOX
         akAKFou/5KeJ3Pd41YQo22RQnsc3EvenDfbdHlpWpwQJg0kDXHRz0EdPL8UtKnZ52tCP
         3WCdVOPLcqt0TwdBsfYmg5xM9xHikQL0Wj8GPtDVIGGIYAxkSyPjQUizwcytRdKomJ2V
         DL01cV2Ki0sm9mNj6hnVfK1ToatiGwFr8fwB35UC9pvIKAx2Cj+dFMdwVszRPuB/5dYX
         BAlQ==
X-Gm-Message-State: APjAAAVlVU4pSM8JdDMLTdNHf3S3REvXlcIwj+f3CEpinrnTw/qLkv6f
        gWT1+Gj3yrALR4NPc2F5X9g=
X-Google-Smtp-Source: APXvYqw2UgPu4ftgWC6oZd3FfT5EoMsGb1gPhZoPlY9vWUQao96k5UnzkdIvGn459OLOyUQ5LxBgmw==
X-Received: by 2002:a2e:85c3:: with SMTP id h3mr7393258ljj.122.1572904860068;
        Mon, 04 Nov 2019 14:01:00 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:00:59 -0800 (PST)
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
Subject: [PATCH v9 01/19] PM / devfreq: tegra30: Change irq type to unsigned int
Date:   Tue,  5 Nov 2019 00:55:59 +0300
Message-Id: <20191104215617.25544-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IRQ numbers are always positive, hence the corresponding variable should
be unsigned to keep types consistent. This is a minor change that cleans
up code a tad more.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index a6ba75f4106d..a27300f40b0b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -160,7 +160,7 @@ struct tegra_devfreq {
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
 
-	int irq;
+	unsigned int		irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -618,12 +618,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
+	tegra->irq = err;
 
 	reset_control_assert(tegra->reset);
 
-- 
2.23.0

