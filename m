Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0D5000E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 05:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfFXDJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 23:09:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFXDJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 23:09:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so11079593ljg.0;
        Sun, 23 Jun 2019 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y381zs7JqUeO4ZbV4kzg6cbvTaILm3gppCIZ9QaFOsw=;
        b=KLKEEFV7vyQEtxZ0uYEFUUY5ay9LG072nBkWBGisDQoh237JAJ6TnNhz4qsxgAGK22
         YNFSxBL5c+kfsqSm+FEwy4tdVxBIPEC5Dz/4fbi4gx0NTUoGuGOnHdKG6AvZ8gAuLLBT
         FthFg8LiYixseIyfokMbAhKy0/fG2R5y40iC7A9pvKuE2dCAzxOGEoADpz1/gnKHdmgA
         Mlexq03Pe5YwnT9xH0yosgCWaP2TDN3CAM1SCK9kHzDCYkBmtiKgYbUgjyurURDmPqDe
         To/wh7jkGuUiJIIAU3QuGjUiiyRenvhT9dc+Jh0yg89XDyTXt3HIsMBxhcneBn3SzVk6
         dBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y381zs7JqUeO4ZbV4kzg6cbvTaILm3gppCIZ9QaFOsw=;
        b=llfoXSjqqAZsiV5PQLMguB7WTLH4i1UbRg+pH3Iasghf9h0JHGIHoXtb9OjzUGpBIW
         AU5tp5W7/xe0y6Dk+WH2fLntCaKksry2ehN+jhdnKaI9M9hA/BvUjvl7uwWciLFY0f+o
         G92Eg1kHWdhrkvTPreHDKxFdMTt4K0GcPk951mBPqV0VCHL/XEsQGm5hTdIZLJVKwBfP
         0UVrhjqXtPh0Foc9RjwrGD22dUHvhX087pqvl7UT9rplOpA60+nrS91p6ahrcBQC75zU
         IORlUHJgP6d46cmyxoXelohEYuMpjnJ+dyk4RrUb2hucT+4yFS0UFgC/HHxdiTUlFrpf
         qn2w==
X-Gm-Message-State: APjAAAWvf2V95Z44T0VZCrVa0BILC3HZDDKd3lU22gz1PF+VQwI0cvoC
        TUSQkphZ6bhdyxYY/djZ3GL21IwX
X-Google-Smtp-Source: APXvYqwMtcEyUBqTG0OrMlZmNbYr3qFE2ieb5bqL32t92m479TGx4QU6qZIPGEn0PHf+rKxTEBwdpA==
X-Received: by 2002:a2e:b1c1:: with SMTP id e1mr14060925lja.228.1561326523122;
        Sun, 23 Jun 2019 14:48:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/11] PM / devfreq: tegra30: Stop de-boosting once it's finished
Date:   Mon, 24 Jun 2019 00:46:55 +0300
Message-Id: <20190623214658.11680-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Once boosting value is 0, then further consecutive-down events won't do
anything useful since the only purpose of those consecutive events to
boost the freq and de-boosting is over in the case of 0. Note that upper
watermark is infinitely high in a case of frequency max out and thus the
upper events are stopping by themselves. In a result of this change all
parasite interrupts are fixed now and interrupts activity is nearly
non-existent now!

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6fb3ca125438..81449cc1392b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -424,6 +424,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 					     dev->config->boost_up_coeff);
 		dev->boost_freq += ACTMON_BOOST_FREQ_STEP;
 
+		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+
 		if (dev->boost_freq >= tegra->max_freq && !low_activity)
 			dev->boost_freq = tegra->max_freq;
 
@@ -442,6 +444,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 		tegra_devfreq_update_wmark(tegra, dev);
 	}
 
+	/* no boosting => no need for consecutive-down interrupt */
+	if (dev->boost_freq == 0)
+		dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
-- 
2.22.0

