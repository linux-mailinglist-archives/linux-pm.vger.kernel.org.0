Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C619CCCF
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbgDBWZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 18:25:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43047 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 18:25:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so4936586ljn.10;
        Thu, 02 Apr 2020 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2mkX6A1G0+Xunn7PHZuiJIRUkyKCyujbbSwAgY3fow=;
        b=ec3n5LsmhX/SkYSDvUqFz2mqyPUykh1na58jXLUYuGXFEG8bRsoTDTZBV13aEU6PeT
         yNSIW7mCAu21B8zCC33+jdKq4ysCjUxIkOcjh1wtmUQm8HOGNR3qzP6NJ7rxnuOqGewM
         YNXva8VfwcxLHO+VPD250rbWLsQ7UNRI8tsdqJzcJqPhgYXbCPVt2S1CMI8GUL0k54k6
         xR8TTJqBk+FLCRvWztq23pK2sU6FrCygjEHPSW/zHBATd020+VGZT6/1FNh/mS/07E/V
         DdcT4ego7E57+JBT0Zn6LbuUOMwkHrUNU+/2klymqriu3rerFml5JFDBGfEUTZzS6TlY
         4nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2mkX6A1G0+Xunn7PHZuiJIRUkyKCyujbbSwAgY3fow=;
        b=H4hfI60PH5RlhVeIl86hMYKJP/EGNp3ZxoTQi9D7Gw9gsxIb3kHTMutB4mkT+ZqnOB
         DCZ1tWIeV27CyqJbk54wSjWoGtTfeXwtLMavHXGmLFE9dg55ec0NbKCy9Izz18ecOzTf
         99f8AUiZGfZ9dOsQO2huLRe4h+6PJAyeNoZLr30Ygt7St6nwHoGoNnmowGowqLPzclDl
         21d0SspfULSUj9/GZXkFs+hrVDo1caf6Id1loGZ9Jxy00H7iiuQQr1eQQZTgIC4/Il/j
         WbZSIj7mJN0bieQtXQG7YQYvHgYge+YkuAc80Rb/MPajoMs2Fme1o6NB8kOuPJhrl2AZ
         Ne+A==
X-Gm-Message-State: AGi0PuY5vG4vrP3BXBvwoFySDAYPvSbFPfW9FBJ359+n52efTLMNtgHk
        0ck5s6BIMrWTkFu3fTaXM/o=
X-Google-Smtp-Source: APiQypJaPAIFHdbwM+D0QNz2MEwt3chQSs6xKziRxQLOyy1njFAJEDdYnh/QPGAKUZ6eSiC0Q//FSA==
X-Received: by 2002:a2e:b6c2:: with SMTP id m2mr3201743ljo.59.1585866315290;
        Thu, 02 Apr 2020 15:25:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f6sm4815139lfm.40.2020.04.02.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 15:25:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: tegra30: Make CPUFreq notifier to take into account boosting
Date:   Fri,  3 Apr 2020 01:24:48 +0300
Message-Id: <20200402222448.8320-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're taking into account both HW memory-accesses + CPU activity based on
current CPU's frequency. For memory-accesses there is a kind of hysteresis
in a form of "boosting" which is managed by the tegra30-devfreq driver.
If current HW memory activity is higher than activity judged based of the
CPU's frequency, then there is no need to schedule cpufreq_update_work
because the result of the work will be a NO-OP. And thus,
tegra_actmon_cpufreq_contribution() should return 0, meaning that at the
moment CPU frequency doesn't contribute anything to the final decision
about required memory clock rate.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Made commit's message more detailed, which was requested by Chanwoo Choi
      in the review comment to v1.

    - This patch is now made to be standalone because there are no dependencies
      in regards to this change.

 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 28b2c7ca416e..dfc3ac93c584 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -420,7 +420,7 @@ tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
 
 	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 
-	if (dev_freq >= static_cpu_emc_freq)
+	if (dev_freq + actmon_dev->boost_freq >= static_cpu_emc_freq)
 		return 0;
 
 	return static_cpu_emc_freq;
-- 
2.25.1

