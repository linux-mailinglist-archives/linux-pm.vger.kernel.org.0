Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88D89432
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHKVYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35756 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfHKVYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so72932747lfa.2;
        Sun, 11 Aug 2019 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKUZF2FyqOuJG4YssHrLj6QM+BeSa8vzOdT/eItzhxo=;
        b=OUJSTFxcMTtokWOHIwkTbrYYBHXEsYMfNzi6hOENx/wwads+EHnyF6dPILvT+RCHca
         Pg/jZQuCaR0rE6rduarIKzKkJfmnG6G46pl7hocVBJ/AoRWRfhAOSywtwa8frbi1qGnl
         Ms556rmhS+JEsNw+py6Q/FXlpvSLe9SMQyY2M3auLVOpBUw9kOYKsf5zraHau76/poGI
         lSyQMdaMA9GvUBKHls7oFrtTmkj4+169crgKkG1Wi8Bx+s7vdid35no4EEgFLfjBGc74
         oBlPZscv6RLgBT9oSJZmuE6p3ESgrpBPNdk6JNQYt7MFM5JXmmJMte5FQzLqj/HRtSkq
         hIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKUZF2FyqOuJG4YssHrLj6QM+BeSa8vzOdT/eItzhxo=;
        b=Pn9IJAsxLb5A/7EnaMNpitFNqblKS6i5fCUayQAQF3cCeMCWPFp4mBPVnYRbTzqwH5
         V/EEPnEW1SGHg+XXlTT3bfrmaBVgAxSECuuY7bfiyndNupKMQQ0RFSEep691i87qt/Ea
         32FTvovYdZOu/1WaFA5rXEoHOehUwfZx7jPzmxdRFa2Wush+Tw1HdipVsJbi6O3N93hT
         S26Wvgg1ptbeWo/7T8NfraQGajpWcD8vFZnEFLjSNU7I6xbrOOC7wCN5DfPriHnru/XZ
         BmlPxT3hEwmrARaNYu+EyZVydENtCqw81krFKznyJEMrxCjweU+bJbuBRwVAtOT2RUl1
         opZQ==
X-Gm-Message-State: APjAAAXeFp2FzkYkKGGBKNARq7obzWvNN7dyURdUkNMaGRjWYYQRElpR
        nO8kpCVFhHwbsc1ZA6YX3XE=
X-Google-Smtp-Source: APXvYqxyCbTtr3F2c5qyx23V9a3mg+QuEgFDHiuEHZ75u4VumkSDxnKNZ4jJfMRcJMG1gXDOhT5VqA==
X-Received: by 2002:ac2:4157:: with SMTP id c23mr17799835lfi.173.1565558687140;
        Sun, 11 Aug 2019 14:24:47 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/19] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Mon, 12 Aug 2019 00:23:10 +0300
Message-Id: <20190811212315.12689-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5002dca4c403..a0a1ac09a824 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -708,7 +708,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

