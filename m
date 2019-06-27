Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7A58CC0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF0VNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:13:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34125 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfF0VMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so3822203ljg.1;
        Thu, 27 Jun 2019 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbPe+VqVcrqwEQ5tpDgvU/TNvhCV4Bhdcanwbag91s0=;
        b=rXrrmE2L5dsC1Vz5TK1SD/mPURHFt9Dq+gIrR9NWdexECLupqpZGTYPgO5WT9ohdUp
         pEuXg5uGOraVVN8iRXi5beokP6rysopDG0XwsrNP7kBJLXJOC9IhbZnDDg9AoygEs23z
         BGTEsfs3Fgh3vVSX+ApR9AF+F1Bnyw/T5wPNydQdvaUcGU4VgtUtl5x87GHQBGfwj5GM
         yUUlX4DfJVdViTbFoVydwmpDuXMxxdt6/XIURD/U5AjbrhRpFkzurTlOoKzNy6IFod8e
         KP4RDJtP76lzlsxTrubYjkSKrE6/LIhmxi/ryHJ/y/9usSAjtWoVQRgpz91OktcHBZOR
         S1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbPe+VqVcrqwEQ5tpDgvU/TNvhCV4Bhdcanwbag91s0=;
        b=UffW/Js7xmOJ9eLHqtmg+KyKFTuFSfhyf2TpxvtlBT+qDbTYl3DUUwm6YoXcGrp/99
         VZ4ZiluvwXTFR1yR0SrYM/RPb80AAQTdCLzsOr6GxSAWMZEngrTLOnCSP7u1R6sQWO2X
         2QkMffjL/wMm6umK5rKWOCWdCux4khoCC6rDYI1BLqmm8mH3OzJxAHV5r/iuhcw8Bs4/
         rv3DE6kt7jtnyigmJcINXpKBoNa0OhFB0UAYQmPzYBxZCJOE3tXNgsJKJ4YvyISjcyP4
         FrxFGyAtDewCQF2UfXyJKHJYTTL+HNh+AL1vNHT2VTqmFuEEcwLBsTiE8KKiHyBSq5nf
         irAQ==
X-Gm-Message-State: APjAAAU9oThKCfp5yQ5DPfhwerh5YXWKtyR+F8H9c9V5pMKA7o30/C6x
        bkxMciY8gUuoqLQf+/a/viQ=
X-Google-Smtp-Source: APXvYqyhN/BSvQ96wCF/uSn0yenYUY0+la0oXvUDjxy4bi81XZNuvQjDOWA+0CsjucEKu+jF/2lFzA==
X-Received: by 2002:a2e:551d:: with SMTP id j29mr4004389ljb.213.1561669956084;
        Thu, 27 Jun 2019 14:12:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/22] PM / devfreq: tegra30: Inline all one-line functions
Date:   Fri, 28 Jun 2019 00:11:05 +0300
Message-Id: <20190627211115.21138-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Depending on a kernel's configuration, a single line functions may not be
inlined by compiler (like enabled ftracing for example). Let's inline such
functions explicitly for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 47a47be276ee..ecbd58504cd8 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -181,28 +181,29 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{  250000,    100000 },
 };
 
-static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
+static inline u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
 {
 	return readl_relaxed(tegra->regs + offset);
 }
 
-static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
+static inline void actmon_writel(struct tegra_devfreq *tegra,
+				 u32 val, u32 offset)
 {
 	writel_relaxed(val, tegra->regs + offset);
 }
 
-static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
+static inline u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
 {
 	return readl_relaxed(dev->regs + offset);
 }
 
-static void device_writel(struct tegra_devfreq_device *dev, u32 val,
-			  u32 offset)
+static inline void device_writel(struct tegra_devfreq_device *dev,
+				 u32 val, u32 offset)
 {
 	writel_relaxed(val, dev->regs + offset);
 }
 
-static unsigned long do_percent(unsigned long val, unsigned int pct)
+static inline unsigned long do_percent(unsigned long val, unsigned int pct)
 {
 	return val * pct / 100;
 }
-- 
2.22.0

