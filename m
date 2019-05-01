Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F246C11060
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEAXlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:45 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54911 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAXlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:44 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so334774ite.4;
        Wed, 01 May 2019 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gSgxpoZvck6q57Fc1Ag09/Sll6e8T2kyeInAsQ6ito=;
        b=h3c3i0/PG7S5kJddW/4dh1PGYpgqEVZKJWglATzbSfonpzmU3wqRVpdyMWEZKatQex
         NKMLaXr5z6PpNWO0ktRb1hat8l6drP2anxDENEIpeK2QdBbmRLmWlDfCMOK1+Yxdnnap
         sxSlGHt0bNVct19YqoZ5J7Ha7HCo3f6eC0S0d2PpmXFn+komkoBhoPK63Q5qPQQkDYD2
         JIOFlvzr75sWMV3wPYeSdgLzgO91KjSdHIMIfAtgbOv0r1WaQdw2ChJck+jsRlC2GF3Z
         EbRad8m7Mz9La4NEzjsajg8JTuMw/Op3wjIJ3DkZdSyoYIO7yH6tKctZzvFt7khoIq+d
         ZRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gSgxpoZvck6q57Fc1Ag09/Sll6e8T2kyeInAsQ6ito=;
        b=pl5CzYr512bbNOqYT+TQ+KoyQrrPMlTy6nY6o9f0goQ7tTNxcpEToIrbiVns3V5+bR
         Nu/RMrBLqu3tysA8m3psOTmQvSCTbW6AhxK8FG61RQIhiaswCQKELfP//ojK5M8dH8Nr
         Ay5MiA3znpM8KM8tGld85qIv9VDDBHFStX18YvxkJ0f3ftEpX1638E6BYzFra3hRVGYr
         IP3CSCdpM0CiD0HH7ig1nUuc0Fq+22Vnf7TyFaoX9DIQ/+L7w2FsLR1zTp6jSTsPRv8o
         QTx/nywF1Lxgje2xI9SQV80VP07YmIyFbu6Td09zqgaq48y+NEmmogjfGC9Bkmr+WTEU
         qh3w==
X-Gm-Message-State: APjAAAXwruNGyjUt+/MJF9LypOOPKiaxxzzUni1iee5izUNiYtYh9ujf
        hgeE59pSDYdgssnJZBZChVw=
X-Google-Smtp-Source: APXvYqyDAnT9CTdwcQ+nAGTIowxydEVZjwNRuSPXvA0vxGl57E9m3N+Yecjqb1g6TP/WKPEC1EXDbg==
X-Received: by 2002:a24:1f50:: with SMTP id d77mr207848itd.25.1556754103751;
        Wed, 01 May 2019 16:41:43 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] PM / devfreq: tegra: Fix kHz to Hz conversion
Date:   Thu,  2 May 2019 02:38:00 +0300
Message-Id: <20190501233815.32643-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
frequency scaling works properly now.

Cc: <stable@vger.kernel.org> # 4.14+
Tested-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..43cd1233f87b 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -486,11 +486,11 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	unsigned long rate = *freq * KHZ;
+	unsigned long rate;
 
-	opp = devfreq_recommended_opp(dev, &rate, flags);
+	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
-		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
+		dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
 	}
 	rate = dev_pm_opp_get_freq(opp);
@@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
 
-	stat->current_frequency = tegra->cur_freq;
+	stat->current_frequency = tegra->cur_freq * KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq;
+	*freq = target_freq * KHZ;
 
 	return 0;
 }
-- 
2.21.0

