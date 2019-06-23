Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD44FF12
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFXCHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 22:07:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39240 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFXCHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 22:07:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so10929677ljh.6;
        Sun, 23 Jun 2019 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUoP/TwInzxAmI5FyuGeNL3uUUuvUmrAozelA40npDc=;
        b=dt+IpZnL/XkzkPQ85iZLZb0U4PuL4OW2ARGM6x5a/ce/Z9BAiTRuRC791zCzc7ohtC
         hfBSDLl0bFhdPH9bYXaIMBNZp9+qd9XYbK8ewIEO22/NanxYiIxnSoNmDHEXL+UFNyoP
         ROPtppJ+CYqYfoJ/GVNBD1JoE68W8lpaEFqaqxzTR94N/tLJVk8o2JKrQU0MnRm/Bs9N
         NIJOn10u61/rk6jDxcbcvTF3gbPgXIhgokbjjzZdARjOGum0ubklpt1AjLFO1wyYA8vS
         jh0Hyg3ti5uGjKL0YfnMFhM0+kEE6JktQ2cXEgDAi2mOtkULLqJtKUyjaOAGcWVfQ6zv
         ebRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUoP/TwInzxAmI5FyuGeNL3uUUuvUmrAozelA40npDc=;
        b=mAbtexs2GWvjJuT2VkEY9uEILOCy9UCSYFqxmRXtPYlHwXY36hK1pS/xxbD6RvvY0R
         c6tDeTcIZGQYD8/teuauUnEC4m6Y9C95GYFLw2ZvrQ8ienZGQuZ8SqMLmZyDi4aJ2CJe
         /x0CYP7R2W27ij2Ob/Skdxn286L7DyRHvCX8JuikzaJWRBqzQHR6ZTbjAYOn/u4iSb+M
         Ji0ki4Z37LHI+b4yNLjSOUc6K8blUOw1tVrwI9M5ABNp7ELekdzeP28ezkks/otsFaSp
         8zKNkesHvnjywd82Y/HF2b7pWS5QVZXQVLB4/4V8cAR33/dGVXCi4VI+Z/aJ167+FWhB
         UE2A==
X-Gm-Message-State: APjAAAUuRgOrNubbfcVSvqZQ5OQLuoXdgofW7eAmO0OkN96AHRNAtMmq
        4msEnLtySqcyb6DeLnKIZqsYtN/B
X-Google-Smtp-Source: APXvYqxFy4zg5sP10Iafd/jsNiR3o5hlxirUmF1MYJHuLe2fXY8cSySzySVjvsOXYv6vKN52CUHDUg==
X-Received: by 2002:a2e:8793:: with SMTP id n19mr37244573lji.174.1561326524110;
        Sun, 23 Jun 2019 14:48:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/11] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Mon, 24 Jun 2019 00:46:56 +0300
Message-Id: <20190623214658.11680-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 81449cc1392b..168bfe78e525 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -572,7 +572,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

