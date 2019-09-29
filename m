Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA9C18B3
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfI2SAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfI2SAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so7129257ljd.0;
        Sun, 29 Sep 2019 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruFgZjU6gpk8s8XpOqnNEi46GBIDFW073D2rWvcyP3o=;
        b=hDKvLK+oc73wzZgO6xGdFSHze+dv/bUhThfzSJY4usVgr+HPamFf4bJxwIuwGypYx2
         8nlgw9IyFc+n/ZSL+HetAut71WUYMA0I1Nqh3TckdH3nxJJkvRCSSTdbUkmVCVU0HZVR
         3TUonqT80nPmu9MbWgMs2yGHIynAOycJ5+8f+cuYXGPVsgQKNuAWquBdQkC2B5Uv4guP
         X1e/TacoUoCu08nI+Ma7qjRxzRMnlcG1/cmt+G0BvrFdpDtZUdgY4mj3ltwnQ4Y3j2lQ
         FFQzc1N/bbwUsUk0264Nk55hKu1Ojdmo7vrvXCwVrRybsR7Bp40vYyJd20FhYJHn3QJ5
         crKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruFgZjU6gpk8s8XpOqnNEi46GBIDFW073D2rWvcyP3o=;
        b=qE1HrPnMyXpNdDYQFE4L9CcfATNazbS2J57C25IwE1GcuMHtKSHpAU308b7SpIwNt5
         hszfYJFoHHps7/XRtoWjK6EwZvCY2JubgZGrdF5xFMuQzTM1xlJF6UdPhTNOOYpVj2ym
         eE6sxlPwrlIM1c59pJ06wwHScMe2Ao/z8hry6s9n41T4Y9xBqw0EQrsqpHfRwpAQg2Wi
         a/7cnzZfmC33k+urBHTQnYx1aWl8TDFNVjg/K35A6RxAXQiaIcsmTWYdTpzeN5Uj0yb8
         nefxiUS2vN6ZVGYQCgrL+slZZV4K/iuzYMwRT1H/KISdagXEmUEJIX0MuAMkRhPynVf+
         /yPg==
X-Gm-Message-State: APjAAAVdqYcLSMhCaN//PSYtFVNUB7ZRex8pQVWTuPDWZG0h5rdFIWSY
        FAoVTnfj3ppDx699Fs8hWk5EGakA
X-Google-Smtp-Source: APXvYqwQjO+zs6wRJRpv8uh0LUlNPiZsbOMHWWiDKQuTC2ClgtgeAWFiHCTXq34/3ZegINTqvjpuGw==
X-Received: by 2002:a2e:6a13:: with SMTP id f19mr9534607ljc.17.1569780015486;
        Sun, 29 Sep 2019 11:00:15 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/14] ARM: tegra: Make outer_disable() open-coded
Date:   Sun, 29 Sep 2019 20:59:46 +0300
Message-Id: <20190929175952.22690-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The outer_disable() of Tegra's suspend code is open-coded now since
that helper produces spurious warning message about secondary CPUs being
online. The secondaries are actually halted by the cpuidle driver on
entering into LP2 idle-state. This fixes a storm of warnings once LP2
idling state is enabled on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 7d9ef26e52a7..16a02937d3da 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -146,9 +146,10 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
+#ifdef CONFIG_OUTER_CACHE
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
+#endif
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
 	 * call may also do the following, depending on the FW version:
-- 
2.23.0

