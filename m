Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958120E8BF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 01:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgF2W0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 18:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgF2W0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 18:26:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09794C061755;
        Mon, 29 Jun 2020 15:26:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so10146078lfb.0;
        Mon, 29 Jun 2020 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cP4sHdE6sVU4pAKA0exheCdKvDd6a6G7XmSgVWtBEvc=;
        b=PzOv3n9Gm5zmFnKCTSTUyKIYFXig6ahMHvW0EniFX7RW08ZtlI4/bI3fd+Kx4hZH9O
         OOjsRDkX+vZbVDPHYpcF26s6FzHOi5P/6Kdv3fufLA10Agt9o1sCW83RK/OFwNDzDgnV
         o6+ZrDhxUvzIDzqTPnMtqE6lgZ7qd19KvkwPLhUd5sSjKaES7I2JppBLPZkM143gnmGI
         B/nVeJPSM+af412HiidnzsyLr8UQtyiQyFEmSp864fyM9JLDJ8K/3P+iEJxuchJxDgtr
         M2rz/Ft0OLlGr29VWq0wyDOWqFcq9SvKrSJaf0H4lDwgyoy6RBxkiSBv2vQIop4osUx5
         ypaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cP4sHdE6sVU4pAKA0exheCdKvDd6a6G7XmSgVWtBEvc=;
        b=eIPEvJExXMDSyGMf4yA8Fer2uiYyb8orWymY+1axEx/BJpyjt0+xAB5cmWD1hEq/P4
         SU4KsiW2vOCoCWBDREbm8G5RaCsokMVaBMtHiryU/iMr4CLyzKeyoj6UhWktWzk+leTX
         wRqiO3uxLe4ZeVPSiTAqxH9BfW828eO71yzat53vZGFxcxgHNHiLIyPj94NwIBvdwpEi
         v84NHfPmkvPMgCabBYQPpK4LzBYyaBGNxJ0oHdMJEhXKbPG4MJyywlK/VZkMaH8IY5+a
         v7IPqPEqTvTYeDeOiXpQ0z1HWUyiQj6SVRNxpcBr/UAU6AsS9DyfZ4KyBHmT/GCrT0ek
         12sg==
X-Gm-Message-State: AOAM531Ay2FX52Z9gh5zJey94kuyo8Ulr3HdY3UbE25zv7439EUYMYda
        CJ5LvB9hO7Yb1ChhY2Pg/DY=
X-Google-Smtp-Source: ABdhPJyHSgWGq7dLLjGmmpq05cDht4MErm/JFYc9yuMAz773WGNp6QbxwwEY/aAyrCXd0P0fcp/lOw==
X-Received: by 2002:a05:6512:110e:: with SMTP id l14mr9720085lfg.25.1593469596449;
        Mon, 29 Jun 2020 15:26:36 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 25sm222649ljh.139.2020.06.29.15.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:26:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1] cpuidle: tegra: Correctly handle result of arm_cpuidle_simple_enter()
Date:   Tue, 30 Jun 2020 01:26:25 +0300
Message-Id: <20200629222625.674-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The arm_cpuidle_simple_enter() returns the entered idle-index and not a
error code. It happened that TEGRA_C1=index=err=0, and hence this typo
was difficult to notice in the code since everything happened to work
properly. This patch fixes the minor typo, it doesn't fix any problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
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

