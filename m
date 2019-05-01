Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7411059
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEAXlw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40143 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfEAXlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:51 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so338074itb.5;
        Wed, 01 May 2019 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBeRh1VWxUcZpZoxg+JTMh0fa13cOmkGOiGjOtDcUPc=;
        b=f21c8KijHLjKlb2s8KKRz4TxG0PkTUVE/rBshjDh+2GIM8E0zHvg9ZnnTUUvTOoUFZ
         Exm5GeLnfbRx99cZy1/DkYy243vH4NnUtae7VBhwcjKNaaU2OTfqLbkcQnZL2YCggs7X
         GyN/5SkOugTIgkgErO61EuqG0VTX+3zA8AJUgnoF8Je3poyixbpL3NIsUVQMQuHLULzl
         zdfrgyunaUjJ8aMcEkxcotqryEYG40/No4Lxjf8rHZ42HtMw/vmEyy63zo4Ryp6eFHsS
         9wKQ5bz3bCGuMqmZKMAOzqTp9uuwtfkn3wB1EDwQKy1dyq8V+NsY0/p4iFd7g0R2gIDJ
         rD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBeRh1VWxUcZpZoxg+JTMh0fa13cOmkGOiGjOtDcUPc=;
        b=HWWHVhWvYG/WlcryhSduzJXOBr/ltF1N+Tgxahdbpxm8FofJuf65cy/moc/UX36Y+3
         PV3KWOxcRbV1aG9Nil5Jm6hVSYOc6piRzMsIF6eukS8wV7l5cgvpWRdyp1EuVWdUTTLg
         3F5WtqMMW3QH7Sc6Oo5DmlxRPhDCK8jmnkMftcI7GNZvbvyC3lVahaPKerQATqeQqhqD
         a+rtTCH7Y0lvuUoxWUoKN3lZBqIDdjS3FI9WbWy54+VOrIDNAUAiu5/JOMyJzi5RS1bc
         7xrtsfHLlGEaOzvJsh+hvt2JNn6L8oXdJR7K9NLBz92aidrHNTfsqvfOwLPQwihJKlGU
         /FKA==
X-Gm-Message-State: APjAAAWwOiIecOyppXtJlCR9xc3jT3OLKdMzkM5zSmpJsoGrmFv0rMxK
        p0tFEojWuYywpdCQ5LkCRUI=
X-Google-Smtp-Source: APXvYqzC0r26LvRitPC2xl7GCtjwj42emsuQ6UXfRNjr/7oCRriUkKIvOcsYT+yUULu8tbSNIRO5gA==
X-Received: by 2002:a24:8a83:: with SMTP id v125mr198592itd.168.1556754111087;
        Wed, 01 May 2019 16:41:51 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/16] PM / devfreq: tegra: Don't ignore clk errors
Date:   Thu,  2 May 2019 02:38:03 +0300
Message-Id: <20190501233815.32643-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_set_min_rate() could fail and in this case clk_set_rate() sets
rate to 0, which may drop EMC rate to minimum and make machine very
difficult to use.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 7d7b9a5895b2..c7428c5eee23 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -484,8 +484,10 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+	struct devfreq *devfreq = tegra->devfreq;
 	struct dev_pm_opp *opp;
 	unsigned long rate;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
@@ -495,10 +497,20 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	clk_set_min_rate(tegra->emc_clock, rate);
-	clk_set_rate(tegra->emc_clock, 0);
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		goto restore_min_rate;
 
 	return 0;
+
+restore_min_rate:
+	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+
+	return err;
 }
 
 static int tegra_devfreq_get_dev_status(struct device *dev,
-- 
2.21.0

