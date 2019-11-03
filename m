Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF6ED4C0
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfKCUmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35830 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfKCUmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id y6so10710742lfj.2;
        Sun, 03 Nov 2019 12:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjmXiphEj07PA2UBQ1Hu0F6jo40/2DwonMVrwbYxHC4=;
        b=Q6Wu65KyBARXDH06LeLB6WrGcxY4/mrTQgOg9L0n0YC18vyXyYb3ucw9D3PPkUg/2G
         MwPgH95nNTjmnLnFWyQe0O/2cv27PVRbj9XQdNRSIrCF6W80dYMXoUMkn5qdAyVdTQDF
         pxAzm4tYXu5h0JVl9F6tDSLQFFu8b2vdOuNePdzovxV5iX2X/21cvJ5h1V92atH3vI7n
         YRfNQXATU7Iopsl+hnDIpQQFHphOgDDrualKgYgSvs9SwSMzOSM+skXZG6rSfQys1eQU
         vQETpi5l72NICXgwJerkoD8vkIOv8RdEMZ2epVl+Wjc8wPOdOEGJaUWOC2kt0/PXnKqu
         RvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjmXiphEj07PA2UBQ1Hu0F6jo40/2DwonMVrwbYxHC4=;
        b=dTLF7QZ9CvSOY2tM+eWloasdXoVVwJPOUl5I+QLIG5dLbAiF9ANh8FttaFSmO84j87
         fh55CWUTF6p+C7uLrNKJeq79uLeUI7fXmzvcIFnnpX70UlKG79hNedKZorL1FQDYG4+P
         IoFaE/OOasfqnbMv+WKnmTyh4TyEryqnViG6eTtdqMdcFCMDPkVBpIU5ebfMCLfo2+aB
         BGCvdU3ThuK0P8sFpJQ/yu9jvtywavPXvPHHWQJKSPLabWNuo2gzAj1ROQWGa4eK9/fj
         Mx5PMlRol6Ba7hWNKfpRAfBv9PpJP8fcVfJaOsE02XZxx4GFR33EHHs570l/TM1NzHk6
         i5KA==
X-Gm-Message-State: APjAAAW39mr89M9GYJucFXsB3S7ya/fyOqNgH4HVAZibjA2nUvJ1D3tO
        hoCKIvL9oS2hYNsRUeuOXN4=
X-Google-Smtp-Source: APXvYqyF0fSar+FgM18QXcoBsZNv5ru4RdvlerDHPIp2TDKA0lQbqw8J3J4zZGvpbQBDmYG+IhKZww==
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr9732752lfp.182.1572813733191;
        Sun, 03 Nov 2019 12:42:13 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:12 -0800 (PST)
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
Subject: [PATCH v8 11/18] PM / devfreq: tegra30: Constify structs
Date:   Sun,  3 Nov 2019 23:41:23 +0300
Message-Id: <20191103204130.2172-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs, for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index bc46af155b99..9bd4dd982927 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -108,7 +108,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -177,7 +177,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000,    KHZ_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -295,7 +295,7 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 					    unsigned long cpu_freq)
 {
 	unsigned int i;
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
 		if (cpu_freq >= ratio->cpu_freq) {
-- 
2.23.0

