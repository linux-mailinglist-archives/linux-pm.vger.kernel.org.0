Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4CE92A9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfJ2WG7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37825 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbfJ2WG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id b20so11721049lfp.4;
        Tue, 29 Oct 2019 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D11VVY4Rxxm/W54Uqk6BFbiOvSAgZpDrlyvTJkKD0Sw=;
        b=jXH9ZKZPkIc26Kl4neZ4IIyKLIbmcTQgjlMy9HVZyaSBJyTKKB5TWMLjb01usctBJR
         tuDBFgBAgcQ2C7c4CrWspt4ujLHfygXR1g3XJdhMg6SHj362gpK0gUr2vkYFbg2RtMUH
         FXNJ6zfcNyAzpZRHlVEPhLw4Q0EqhZQeUmPxv4WPiEYRxg3V/aHT734BJBAol/VFh6g2
         cC6zXWUHVBzRySi5Z7wrYecjzjt/x5nAWSq5r3EHAMuCBUURCSGbzxbuGqAS82CJrftj
         tC3mAFg2G4f1iCV7m7wkVBrn5rEKGVfyfVZeY0TiUZ3QDBZpBREjFudJziv8CSnKudnk
         LOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D11VVY4Rxxm/W54Uqk6BFbiOvSAgZpDrlyvTJkKD0Sw=;
        b=Fq8ucnISf7o3KK7MkpKjY4C849+M6eqt2L6LnY7JmIzlLP+e2iOF4AAjnHrax8aqxp
         QJtvEtEAPaqbs2S4f5wB4uI2Ir0TDFuTr2Mxm1DmTvHxE3WkANbWyU01Hx8pAAhmVIYn
         lLwadE77DYbIRDkHWR8RiBba4JZQ2oNnfEO5GYgKAn2x9WnY3l12tnIo5vRvIC0wAipl
         596P3ejCZAIl2lWTTa99PfjBCwQnehMWH2KV6mTnoaDOc9sawF4O7N7XAlIKLO3BhWOt
         m8kTQqDwfl8qWxgkuD9UvlKzY9W32+6+p8ga+0439QSlOW48FdO6/vq/QtOPbL5fX1u0
         KI6A==
X-Gm-Message-State: APjAAAUjoe9l2wHjwTu+WhDfRjcbkz3s1IXnKqys1V7RJtUWY3+UbzRN
        Hy/1uCO7bWebRUzOgbj01Cc=
X-Google-Smtp-Source: APXvYqwV9uLlqA5CnvxwBGpmgt3v1zyI90Zr39IZSpxa3/SUYck98d4ynMWgQTWnsUiQyoq3y6eAzg==
X-Received: by 2002:a19:7f15:: with SMTP id a21mr3847976lfd.169.1572386783589;
        Tue, 29 Oct 2019 15:06:23 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/19] PM / devfreq: tegra30: Don't enable already enabled consecutive interrupts
Date:   Wed, 30 Oct 2019 01:00:14 +0300
Message-Id: <20191029220019.26773-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Consecutive up/down interrupt-bit is set in the interrupt status register
only if that interrupt was previously enabled. Thus enabling the already
enabled interrupt doesn't do much for us.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9cbee82880ff..a9336cf4b37a 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -261,8 +261,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq >= tegra->max_freq)
 			dev->boost_freq = tegra->max_freq;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
@@ -275,8 +273,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	}
 
 	if (dev->config->avg_dependency_threshold) {
-- 
2.23.0

