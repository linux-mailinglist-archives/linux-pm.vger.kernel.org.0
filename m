Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7848211711
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 02:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGBAOF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 20:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgGBAOE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 20:14:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60272C08C5C1;
        Wed,  1 Jul 2020 17:14:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so14780867lfe.9;
        Wed, 01 Jul 2020 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwC5VoRk/JW1ACEw8wj5QHRKmXQhWpl/5jY/IQUHYZI=;
        b=DZ6yKn7ZCd1bwWIDWqUrnKYfMobOFcvEmmW9+q90u9NzwqYvKEWP/nQT8tpG5/0HtN
         CDqCSk4KdPrR0KCaEqIKw3K8aEC5OgjlI9pKw+V4JDEzF/Jvof2qAwByZwklLZ27c5vA
         42rpsl1OfrjFeoHaETeutJz5fkIc6cImUkVjr8WXONpiYuZOcZEQrcD9p3bxCeLI6j0u
         2mDln3azpxjBIi4KYNmZD0X1n5zJRJ6C7U402Jn+g6MSCzAO+ktOSLeGNoreXpQdl/A7
         HP5lotlqjpG2O21hYrsTBKXdi0etb6N44FyKOUQjqhEzW/1Msef/VHRr29DBqfI4PVH+
         6wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwC5VoRk/JW1ACEw8wj5QHRKmXQhWpl/5jY/IQUHYZI=;
        b=h9Hvv0moyqs1qiZCwp4vtZ2Fx9wuZGdP3uNlYw5yN1HRSkNKS6ZQVXs4uB0iiQmP5+
         Apuj7uFHemkJo7ojKMlL3llOAUpQDg2BU30cNwFBspY2aEG/19bnkqFsCs0pJmzLfwba
         u9Rsemdm17TFR/s+DjolgrCn07jXYkNbRrbfo3yWDl80DfJw6l77wMTIiZ3UHR1cxQiU
         X7mGdLVhaax8llsbKr+rVjJB2q3c8td7n0GJA0k9TMdvFm2mqUItZ96J8ioL1ktZ24cQ
         eALmSldras+ahN6TpUSO6v1W7UaDYNyuI6l8FbbjZH9p4jNJd87LA0rhVAy9uommRnp7
         TR8g==
X-Gm-Message-State: AOAM531Ruo8EY6JFBnQr3hpXIsO/CZA1MlixyppmwqKBP72M65/Cf6zm
        xSJU34vB5RNfSZdgvckz8SM=
X-Google-Smtp-Source: ABdhPJzLCJL/RhpcJjPMyewDvWkytr2F2yYNIDdjXhHliV+t4O2mgzPqCSlkb2uI8/ku8ybXa0RGbQ==
X-Received: by 2002:a19:a8c:: with SMTP id 134mr16897823lfk.128.1593648842804;
        Wed, 01 Jul 2020 17:14:02 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x22sm2339948lji.133.2020.07.01.17.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:14:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2] cpuidle: tegra: Correctly handle result of arm_cpuidle_simple_enter()
Date:   Thu,  2 Jul 2020 03:13:54 +0300
Message-Id: <20200702001354.27056-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The enter() callback of CPUIDLE drivers returns index of the entered idle
state on success or a negative value on failure. The negative value could
any negative value, i.e. it doesn't necessarily needs to be a error code.
That's because CPUIDLE core only cares about the fact of failure and not
about the reason of the enter() failure.

Like every other enter() callback, the arm_cpuidle_simple_enter() returns
the entered idle-index on success. Unlike some of other drivers, it never
fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
driver, and thus, there is no problem for the cpuidle-tegra driver created
by the typo in the code which assumes that the arm_cpuidle_simple_enter()
returns a error code.

The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
see the error code from arm_cpuidle_simple_enter() today.

Of course the code may get some changes in the future and then the typo
may transform into a real bug, so let's correct the typo in the code by
making tegra_cpuidle_enter() to directly return the index returned by the
arm_cpuidle_simple_enter().

This patch fixes a minor typo in the code, it doesn't fix any bugs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: Improved commit message by clarifying what values are returned by
    arm_cpuidle_simple_enter() and when. Thanks to Jon Hunter for the
    suggestion!

 drivers/cpuidle/cpuidle-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 150045849d78..9e9a9cccd755 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -236,14 +236,14 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
 			       int index)
 {
 	unsigned int cpu = cpu_logical_map(dev->cpu);
-	int err;
+	int err = 0;
 
 	index = tegra_cpuidle_adjust_state_index(index, cpu);
 	if (dev->states_usage[index].disable)
 		return -1;
 
 	if (index == TEGRA_C1)
-		err = arm_cpuidle_simple_enter(dev, drv, index);
+		index = arm_cpuidle_simple_enter(dev, drv, index);
 	else
 		err = tegra_cpuidle_state_enter(dev, index, cpu);
 
-- 
2.26.0

