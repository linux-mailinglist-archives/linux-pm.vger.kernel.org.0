Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA13455D9F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFZBfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35866 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFZBfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so373583lfc.3;
        Tue, 25 Jun 2019 18:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WV5ZDccemhlsje66eKSsM4F/JJGKn8RfQodo1mruSeM=;
        b=AbH4pcNdyPt06Z0mmSeEmnN8W31BrZk1kgBX8vstDU/ZZq5f2eSFNswN4LjuAMuTAS
         YYl8x0uc2MQVRVt7zfWUVE4aH32796WquEWOtwTqy0v3H7rIXuMB1p6Z3HM4LBOOXc43
         jNW5ziVmnXjFIgmh4q8oL/XL/Zpz+HOuMAA/a7SFcrP/xoQmGS1Wl6ZuH4LhYO3tyakA
         HBQH9SxWgWTqc8sv6stocy3I3NIbEiFg+4Mk43sZL32bio3KcSSGLXToyXTPzNfPHp0z
         vzs1zv3Bbo42TGZewmopa1TCSoqeWDTXgYYg/m8e5Pg9vdADuQB8kp6c8cw9RSpWiuo1
         jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV5ZDccemhlsje66eKSsM4F/JJGKn8RfQodo1mruSeM=;
        b=nCmbx60UWKWoiJusl3IuwZi595PH9A5/ayDQx18BlBH948aMk9QjYAZ61cUCa2zzIT
         KeVyaPQ4QQbgCUFvnW5yFmxpV+TtcXcZTv+UpyNvH/4PVWxx7rOdAaAz1tZTo6NQfVw2
         9sDHrTjxm9HPYAJk/IPUqRASrIA7galeWaOucw8X9ZXlEv4ZD0IcovD7uzi4QZx2AaKh
         iqg5ic8uNUOdhFNU60PIiTHWN8h6e2C9cmDifGRNczTB/Bt0fhWTTt9/Ikz3Kc8fUBJj
         u23ubl4WFz9cZLXdfGMHGgRbz/ZReisGOmC+bI2hRw/yiOPY0ChbxNtqDy+KdJ1hyhVc
         Jzew==
X-Gm-Message-State: APjAAAXBVBJv22FTjWc5+wsfxy2de0ZwVv5DF7oj6F+hBBNC8/LY9IZ+
        cyrdIC1QWUUAvvdIupv/tEw=
X-Google-Smtp-Source: APXvYqz3L26JxFW4sFzJhMVbOMK22ERvHOgsTDgmV/iPSQO3qUBMRetsfZRIkFMvAapV+WjHNw6WFg==
X-Received: by 2002:a19:6519:: with SMTP id z25mr921099lfb.73.1561512908645;
        Tue, 25 Jun 2019 18:35:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] PM / devfreq: tegra30: Inline all one-line functions
Date:   Wed, 26 Jun 2019 04:32:46 +0300
Message-Id: <20190626013252.30470-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
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
index 8ef7ed8d7e10..8630dca99905 100644
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

