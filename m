Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A020958CC6
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF0VNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:13:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44414 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfF0VMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so2492817lfm.11;
        Thu, 27 Jun 2019 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvMmiKBn7AEhHhpE3q3+A5FM/DLQaLbsSu9JPbCMwBU=;
        b=pZU2JmgcDyEO3ZHWHZBMzJVpJALjTJ+PeJ/S/erZCOUhWrM1BG3O4CZNbd/7TyLsL7
         ha4A/mb8TUXuXe6qutpC4vuyF0tDfA/SuBomDPnovfxHiwDR9cbZ8CHCTktVT0ynoSG2
         qfqDUFWGYE7cfHJ8opfqrKalWNy+Q3PPVOS4WjrOWJ9oHri1uWj6xNfsfCsdkWZ1cQeq
         59Vk/6onedpvPePF9q7yrzm4q+ZbDrqkx/QC5nhtvYBdP5meFeJNW6MBFDOfFhOKnFGN
         3xxTFGBlXnIjiRL5MU/3fbe88dzwAso7i2hoj30vaPJ2RvMHfzPVi2a2XZ64f3idVnS/
         E8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvMmiKBn7AEhHhpE3q3+A5FM/DLQaLbsSu9JPbCMwBU=;
        b=sOlmCRe9CTuBWxoPGnCl3x/dKlHl6neXF9RIJ01lfgxgLWE9swzAcAmSUD1MT4IvaS
         ct3sornH+nmxLcM/ljCWf1JCDIZEqJ396J4AW0APFozjn1qkF1Fhx5woTAQc0wzJyfFi
         4gQU0HVpwdVfbGHmXA6Kb3nnQX7orh2u5fQRxeDSJjmOfnTgYW/gmOYwkUh7ISml37y+
         1AFPAD8HcHsvGQ1R5iHSextGm0x1yDstbk//voXVpwNrWltT4829OX7RMSayoLIXzHUw
         vxukr4ZMGI19ARSNu066K/rR9isNfUOMI+5OOkxW/bKOifG417BcHWJqqvUDWd8FXcd7
         4S4w==
X-Gm-Message-State: APjAAAXzRXrgL4jGaiTXM1xPh90Zvn7fx5Yv1ptvKkr2Q9RaAM87YqCf
        u2CW6c4VU7MXLCidUbxp4/2Uz7WK
X-Google-Smtp-Source: APXvYqw+KhLgpl/Z+ipfy4bPfOAIIV+WwyZnVn4QV9qlXmOCt7kXkCVyZwBDJigWH7kEmz6TkEn2SQ==
X-Received: by 2002:a19:710b:: with SMTP id m11mr3204243lfc.135.1561669952804;
        Thu, 27 Jun 2019 14:12:32 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/22] PM / devfreq: tegra30: Reset boosting on startup
Date:   Fri, 28 Jun 2019 00:11:02 +0300
Message-Id: <20190627211115.21138-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1751d17f9a1c..cca2fc15bafe 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -535,6 +535,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0, target_freq;
 
+	/* we don't want boosting on restart */
+	dev->boost_freq = 0;
+
 	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
-- 
2.22.0

