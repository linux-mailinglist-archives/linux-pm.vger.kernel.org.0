Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3081FEEF21
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfKDWBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44658 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbfKDWBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id v4so13446560lfd.11;
        Mon, 04 Nov 2019 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GPUilwynfX5AA3QRvL7JTfGxSIPwXWj2mMjnwonars=;
        b=tT6Ua0eIe1YeVJOuEJnrdE//COac9LadoKtkDAcrDAelaC2i+NC4Iu43R3yY4aGq8e
         bDhSQzgSuc/164sHiOlovDwb8GYJcFcxV3qRcEYUH7sfDgpYLb6NNkGszmr+7l97eurv
         oTU8Yx0HVMrFJwFG4KUPJu+5J2tmbJpORQ/MZUQYTxubEucN6cGB3kYFGLMIsAxCGhE7
         XIkhWg4C650pI+KmULnwdINJUcOSBohBxtYdFhEmbzeP58ltOY8WQckaVCCGp4kFdlw+
         ErBkLz2aFBRfmgg3rhKYcyMwTgPisl84jceZKyGZ87xaR6EWptuZuomClMhiK7yO76c7
         gJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GPUilwynfX5AA3QRvL7JTfGxSIPwXWj2mMjnwonars=;
        b=EmsvJFJUjsD6R4/5ayvSMqzDzJaWdFPoxUvuZAtGzoqXp3EDXK7t2nAnBW2FrsIqns
         idDaZypou+8s78xm9ITkEzp1WPi9Nl6hADwLc7uiajTapYkOLIa0Bg05LFVXC0lva4I3
         DFqeIFmsaJ2btRX3P8GaLCg6Haeepv4iCrIek5Loh1AdHiT4KDmhhRd8/86eyjL52hXV
         YXonPk93bXItD2RsIpbPseJDLQSmRe/o/okwAvUqseC4Sm6jV1qcitgPHFOewZNzb7GP
         ENBEWEPxtXYURy1skJsVhNx6uq3IVESgy/CyWZLSOSiT7z1nAfLS3zXm8dzv5O9EKDU8
         bISw==
X-Gm-Message-State: APjAAAUXVoEmvSc81meu3MHuRruIPwkx227EmqGSTGW4f4iucvX+ya2H
        Tx7GiM/GjMofrL6HK19fiyTOoDs0
X-Google-Smtp-Source: APXvYqyn0V/Lm0MW8Mou20GI1j4QbBM3/gGmxDrN+tKzQNWBp8wrBL5TINcz53WLuhWYtMqU+VvtMg==
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr18358816lfn.134.1572904864000;
        Mon, 04 Nov 2019 14:01:04 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:03 -0800 (PST)
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
Subject: [PATCH v9 05/19] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Tue,  5 Nov 2019 00:56:03 +0300
Message-Id: <20191104215617.25544-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
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
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index b50bd1615010..7d7b7eecc19c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -69,6 +69,8 @@
 
 #define KHZ							1000
 
+#define KHZ_MAX						(ULONG_MAX / KHZ)
+
 /* Assume that the bus is saturated if the utilization is 25% */
 #define BUS_SATURATION_RATIO					25
 
@@ -170,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.23.0

