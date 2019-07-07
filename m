Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7E61882
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGGXjW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:39:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40018 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfGGXjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:39:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so4541980lji.7;
        Sun, 07 Jul 2019 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbZ6B19tyY4HII4C1eaW75DsbbP5icZrMWL9u5GvQEk=;
        b=OlcfUPm0Wav/im2uZx4NZk4WxX9dh8CA1ibCD3ayHbX14j1lpc8V3rOaalfB8WDN4m
         XZBzowfNKh46aW5KgF31AQBxRZr32MQdoaXc2epSlyy3p6tgPDRAzp7045RkgwIEeiip
         gB8HqwJhVBRgLPm2bCRn5fuL6Oy98fSmH7AdJnNAIF6W7Wy1fhwQ1l2uL1AmdPPM+YUl
         Wtyymq1QNFFY1fdUS4u/lXgyR/Okh7ffYPGpSQuVMtUA3EhSuwAl8KzBcESRX2i7JYM/
         yJyDtxoLByH11edRKskjgymVYt66HOEyA7bAYHbMvly++ZFDyOlFzHC5RAOdpBt6M540
         L4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbZ6B19tyY4HII4C1eaW75DsbbP5icZrMWL9u5GvQEk=;
        b=bU+VtPdVvHzcyDYCwqd9mN+AOpnZK9S5y5KDfv/Y4CoJjIryM4ilIH5m2aJlUwWKaS
         6KNC7xWVf+gtB/4yxKifhkN1pFvM1s9wMeiXAKuO0mOQuaRZ4uHDjJH364ymFibCHewK
         8NV2qDgmOj4G3nsc5SbDzQs3JOGZd/VBmQ3gkDovpW3/JLvTDLhoJBP+k8g5qIqeXrDS
         T0b4+bccR/1j6QCZcy+F06ha8EqxOs2SQNw72mDWMVLEOOdG4eSn5GbpufGbRUgpTXwI
         g9ZqOqaLBB6+0pM4V+qmdCG//lXhT1xgVpUc+Y2NQb+PAGCdCoFjyGAdA/d4iDd3JNF2
         rAqw==
X-Gm-Message-State: APjAAAXpouLSQnBbg6T3Y/jNfYShCkou0e5iaf4yUo17/H1L4fAB36mE
        1SHYsQbh4aGk3fA7b6wf7l0=
X-Google-Smtp-Source: APXvYqyK/ZGsVJvye3dZHH4GH98uDb67IgGIsGi8iawhGASHqezzlcK3XTC8Wc6DJBzwfltgWbLejw==
X-Received: by 2002:a2e:8082:: with SMTP id i2mr8535696ljg.121.1562542742069;
        Sun, 07 Jul 2019 16:39:02 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:39:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 idle-state
Date:   Mon,  8 Jul 2019 02:38:08 +0300
Message-Id: <20190707233809.14400-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707233809.14400-1-digetx@gmail.com>
References: <20190707233809.14400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Local CPU timers are always-ON on the Tegra114/124 SoCs regardless of the
CPU's idle state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 31eeef22c0ff..464b2376905a 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -163,7 +163,6 @@ static struct cpuidle_driver tegra_idle_driver = {
 			.exit_latency		= 500,
 			.target_residency	= 1000,
 			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
 			.name			= "powered-down",
 			.desc			= "CPU core power-gated",
 		},
-- 
2.22.0

