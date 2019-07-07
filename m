Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4661805
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGGWfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43689 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbfGGWfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so13115029qto.10;
        Sun, 07 Jul 2019 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8izkl+JagpZCrW+m67iAjkazRjM0cubMx9lc/bUK18=;
        b=HwiB+UzPVrvwe/IGnv+dX3XmG0dFpPLYv8lCHgIayB86aToRKa0Lq1wcBxAAd2j/gy
         nunisRtkI/Xh+AH72djQtS5l6TCNjOWpToy7vZokDQq0J+rVkOEtw1HKxqWfxNPh7adX
         Vt/k/Zef+jUIuKfWNaiqKgE0x48MjMzAJXgT8Qhl6NFLGHQtWWQ40wDEJQJNfLQJj7pG
         ljo8Pyei0rFregAgqqg+cxu6FT2CU6AjKlXyWdXxB4C73jfuXcMYxqPmnK+o8Il0VdQz
         gnzFRALXW3s+EuuvE1JW703JyCGBSUBcSKzVWicaCsAr7HciL5agXsSdOgI7C/fxOjbQ
         RmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8izkl+JagpZCrW+m67iAjkazRjM0cubMx9lc/bUK18=;
        b=sgDTGp1NxM6zpzceoW7/4X/aMb/AhRW+KyQdWAGyR0qYU9aEKJgsk/kM4BHnqgg6WJ
         ox5PMsf3fWaB5tZEoT7gJ0I+yMhG8B1VjBE6Asd2JOUmXQJoc3Ku/LA7xpxdmzYyvkws
         ZNSGKelQYV/q2Mb48xaevLhO8A3qFTgg4X41DVHTTw2wuuKkGxG9g8dIRq1MX0iOxALr
         7dU7v/P3qShIGQCPCEhG17OWjK+d8sTnyjTWnmTUbsEq9QrZY5ayRUJQh2ALwCjabJ1w
         6yQxsGCREtpNCSWjjeK2EIkHIijfdWDIfUpzJXtgNbCeZLEKROodkm7OyIwfNiye5Xxk
         a6QQ==
X-Gm-Message-State: APjAAAVFnp5ig9W0jClw64QYzv/B/y+kkD3UeecM/aezIbFb0kNXZyjD
        VcG7TeFQ8NkbxrLA4uMOz9o=
X-Google-Smtp-Source: APXvYqyl44I8ZfXdzJs+BQw8s8lArwUi6Qv0H92jERiPmNbyCCL5xaoCWKhCtC/9bM5N8rJueum/Dg==
X-Received: by 2002:ac8:2b10:: with SMTP id 16mr11404610qtu.351.1562538928979;
        Sun, 07 Jul 2019 15:35:28 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line functions
Date:   Mon,  8 Jul 2019 01:32:51 +0300
Message-Id: <20190707223303.6755-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
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
index c6c4a07d3e07..1a10df5dbbed 100644
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

