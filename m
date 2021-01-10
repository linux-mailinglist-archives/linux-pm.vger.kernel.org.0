Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61622F0A69
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAJX3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 18:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAJX3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 18:29:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E66C061786;
        Sun, 10 Jan 2021 15:28:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u25so14506979lfc.2;
        Sun, 10 Jan 2021 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cjTKh3zk70/fWnN1TGeSc/TTueUPP8l3i6siZ1XPIQ=;
        b=b/yc/gmqhtcjC0idadVE4eFOHYHprCh9Lwg1g4cBYkO/zgieIMQ3wmrUz9FQEVEhBe
         SzyQ307c00ByIwogHqFMWRP2uAIY2H+DYOROvNKJn6lYnQnKYIrXBpLqnUNavr/Jwh5W
         v6aB8M9x1UYF9OxuW9rFG5AQpVM2/Uc1S3mGEiRMRM8VYBAz4Z5w2glmA85UdrNhiA7H
         pBhJlxiGjir7kc9LgJKHbxVEqW++cIHPKpN5jLNbfBcfoqlbUvM+WyOY7SJQ8JLFdBbj
         LfYhptZfH+vpA9rVF9l3XrwBh5916rab3AdZe06ymkute4tVLEuquCeO3kJChu86iktI
         rLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cjTKh3zk70/fWnN1TGeSc/TTueUPP8l3i6siZ1XPIQ=;
        b=TLOhe3/1qvIGjjolKMgUy5x8thuDM5yn1Nu0NWZHaw93CWdNF1MGMFFqWAOzb1OWjL
         YWjAKj4tMdVNuS1NWOj3eGLzpBx2kwRNV2B1nF7AOFj7vGuVYLeUhWirRU8ikiLziJVM
         tU1P7CqoPcIE2+/lVtA/AENmzQ/A4DCQKjIYqyyn09/vlh+7a5EBnHvC7tODrC0puoUe
         bNAnBP6Q4fA92Kqm6zJQl8EIJH6Oj0rKDRGVPq0PAX6cT2V7b5W5dV39dIe0wXHO6hIH
         Uu8q7oiAptoTlCEXWpCr4FYo2E/6ExOPRFyX29LOYVbZJZOF5usYvwSmGVl9BHuXAvle
         yuJw==
X-Gm-Message-State: AOAM532NUOqNRJ8r/4Qnsr1L3Q3wJ3hOHhhRcGiHdDqmAi5m4CE9Byji
        uTat+81XlhqfElP5FAwuRznTpyUpA1Q=
X-Google-Smtp-Source: ABdhPJyNVKR9Vz9QDSB2ZF6a2CbaOBBfIk1HCiv3Uy/csWtTD5/iWnpTytFs3731rXd+c1BNhFhqJw==
X-Received: by 2002:ac2:58f7:: with SMTP id v23mr5862782lfo.26.1610321317031;
        Sun, 10 Jan 2021 15:28:37 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id s27sm3220563ljd.25.2021.01.10.15.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:28:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/2] cpuidle: tegra: Fix C7 idling state on Tegra114
Date:   Mon, 11 Jan 2021 02:27:04 +0300
Message-Id: <20210110232705.20658-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trusted Foundation firmware doesn't implement the do_idle call and in
this case suspending should fall back to the common suspend path. In order
to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
C7 idling, like it was done by the older Tegra114 cpuidle driver.

Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
Cc: stable@vger.kernel.org # 5.7+
Reported-by: Anton Bambura <jenneron@protonmail.com>
Tested-by: Anton Bambura <jenneron@protonmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index ecc5d9b31553..49531939f24b 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -135,13 +135,13 @@ static int tegra_cpuidle_c7_enter(void)
 {
 	int err;
 
-	if (tegra_cpuidle_using_firmware()) {
-		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
-		if (err)
-			return err;
+	err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
+	if (err && err != -ENOSYS)
+		return err;
 
-		return call_firmware_op(do_idle, 0);
-	}
+	err = call_firmware_op(do_idle, 0);
+	if (err != -ENOSYS)
+		return err;
 
 	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 }
-- 
2.29.2

