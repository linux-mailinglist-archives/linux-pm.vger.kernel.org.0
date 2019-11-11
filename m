Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B84DF8202
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKKVQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40818 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfKKVQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id j26so3900530lfh.7;
        Mon, 11 Nov 2019 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ELepBHVlKFvQmIwa3TMR1p4WZDGEN0F8p5dYNSERY4=;
        b=je45aKNae2pljDbxkvlpNWV6W6FH8uc+ujXe+mvyt5VRECNgLpV+tueubWNpwf/JRK
         at2r0iVYULNwO2nlZdLcp/IW5H2xKPQEugGdgtZPujKjeXPmIua7Aolg3eSnTu7AlmPD
         cINXN1/tP3rto/U/DyFN3CAzVabk0EDAeg78S42bDb1Usnef+oFYydApDN5wSMoGFfMp
         kwYl0LRgkkx02WfSoOI9lccp5ZjHbyi0yVTRM1YJ9xcGFLev9YwWkLz55MkvHeHf1lUf
         Real7u4w4ILWoRgnHybDsWqBcaMxvnv0m7TAMEaPSDcnFyJR8/ktquaA5+RLnLmWUQmA
         pDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ELepBHVlKFvQmIwa3TMR1p4WZDGEN0F8p5dYNSERY4=;
        b=amFXbI3MG+UdOsTHIn8qIYj09Zsf1E/S47m8WnbweYHUAGx5qFneBzq5Uow360Enlz
         2cAr0L+KYqfPQLf5zz7qChlNVfJBAciT5ByM1mwQFPxqoyZ4t+36Tuj8Hd9lL5m3tQ9E
         jBn1AjZjHyMbion8ChWujtpXwL1tuUwqkUswQlIhOdRKYOrHoNHzSKx2AltBkl72JLKd
         O1r/9bzpM5118PvgZpLeJ8CNR6DELXKHSLHBfb/qcoESD45zbRyLPuAQfFkfNQe/DZK4
         l3kHX8Y0TXd96Ktv19ZOwtT9LSs4CneHNG+3tLe3Ay3ZufasIBkqeiNMIJLKZLe8se5P
         KmGQ==
X-Gm-Message-State: APjAAAWt2LS7K029B+iGFjrhlbKqnLIPH4vpz/Tt44cA7ekJwY+ClHdY
        a3sHfzGjc/z5gpET2ZfagS4=
X-Google-Smtp-Source: APXvYqwfydkptZ1HSUY9NGx7nx6TmQfDH36pzRlDi/LLSWCSaR9VUQm/O1pf1SqLQKXlcIZXyzpk3g==
X-Received: by 2002:a19:9146:: with SMTP id y6mr16491095lfj.11.1573506998423;
        Mon, 11 Nov 2019 13:16:38 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/17] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Tue, 12 Nov 2019 00:15:53 +0300
Message-Id: <20191111211556.20723-15-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Tegra CPU Idle driver now has a unified code path for the coupled
CC6 (LP2) state, this allows to enable the deepest idling state on Tegra30
SoC where the whole CPU cluster is power-gated.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 4034eb46ddf4..60555374b615 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -315,7 +315,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.23.0

