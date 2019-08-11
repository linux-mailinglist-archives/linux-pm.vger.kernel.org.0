Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8501F8944D
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHKVYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfHKVYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id x4so4489350ljj.6;
        Sun, 11 Aug 2019 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHBbqbfFd0BRb3uV6lTGI/raeYIwezEYsIDJ6CAqnew=;
        b=OqFbk6iwLnqsGRMtC/MYv0suH7fPUNq7+bv5RzfXskXXP9ehrE4Zcd4CXjLboi3XBE
         uj9hrOdKWUbZTSfbcwgWa3LDVRbeF3+darWxSbn7Ze9Cu8UzBDqX4EOG6rT8NNwgGMml
         1+8UYQjW6oZqqHnbG18iMdNhdka5ELclGcTBowi3nV5KIUzyq2olHv/K5Xc4AbZlwGEw
         obEVbyfQk+xqAfsnUxJB9qu8I6/1SZGv7x7/OdF9e1PZBl62+UN0qS+/MQttemVFxyh1
         Kb4kmkDruHI6cOHKiX8q9g6wfCXvP7I7mDELr5S9D6uIzfajs58oNC0f97SmmCJPRTyp
         E+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHBbqbfFd0BRb3uV6lTGI/raeYIwezEYsIDJ6CAqnew=;
        b=QqZq3vRGp1xTUemiwAOL/wMI8YuSKsLtWjulyIWQURyPAJJazLbQXsE+evBMomGyAH
         ghhuLSaCr2eFIlRgZNV8RhakabC36yVCkswtylIPA/a5sZL0sj+5vbXezyoOu5VRshGy
         D1qyTz1FWXNx7J/to/AOhmCpvK2Ljl6fRkDgsajfggqT6u8IC3dZW8njMAhG58f32A7g
         Klpspd2zX15OTs1cnwPrpd1NbG1NplPwxr0SLpJEf/lhvmB+BbOLeSaBa9G++8cvE0KU
         Q+TCaTwySdoIb25/55zmFbjQLOPERMhi4UykdgX5q2Gm0o6Jsd0OWL14Ov6yHEn5+d/t
         kYng==
X-Gm-Message-State: APjAAAWdOep5cy3SPsE+TEEor5Rc/X2dEXEA/KAz9il+sQBAMjj2abcJ
        CU6ifOR6b/mrLZpcJYJrrXo=
X-Google-Smtp-Source: APXvYqzsQDvY7UD2ZL8jsnn27hiQ+tE+iBp/E3vQN+pBQQPB96Rlrxg1h86DWBZHQjOl3dIPHWZdPQ==
X-Received: by 2002:a2e:720c:: with SMTP id n12mr2689511ljc.53.1565558680560;
        Sun, 11 Aug 2019 14:24:40 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/19] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Mon, 12 Aug 2019 00:23:03 +0300
Message-Id: <20190811212315.12689-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4525c051f85c..70dce58212a4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -70,6 +70,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -167,7 +169,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.22.0

