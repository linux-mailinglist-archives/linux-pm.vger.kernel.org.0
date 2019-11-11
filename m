Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF52CF8211
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKKVQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34041 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKKVQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id 139so15372271ljf.1;
        Mon, 11 Nov 2019 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKVJFFh8Cx/4gPPO/PGTSjqb7RA5OGONGJRuyQho6vA=;
        b=CUdOVdyv6NwXs1kKGiaBXqR9QKKyBP7/RGVAqAe7B9w+Yoh2eExovRpm2oRakIncJj
         v0wE+9j5lF5+CIWDcfjqBuJPPTTRuHTTpbUvhuibLcf0BZrO2z5I8UqFiBhfingrcVtm
         vZ1xSFk3fxxuJ7h2OmC5EO4Mjz+jZ+1TuBpbw4MqMqDiJofyeLg4jjFaWpjyqfAK8uyn
         II9M5Ap9UIVoy/olNaz5Ci+isyNbk0gwAEz4v6VJ3UWRhcUYL8EOQLJr3yrH5WpQcVEK
         TVhz4j7rQcH0WWExYAB+BmjiRoLXSmygBblOdci4Oji+dS+GYuIEzTTC40vHmgRu2E6D
         y0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKVJFFh8Cx/4gPPO/PGTSjqb7RA5OGONGJRuyQho6vA=;
        b=UaHYFRRqtNuHUkBSVPFJHYESXkyoSaO94i6q0874Qv7awzHR9tBJQD4Po8GdSVQoBt
         35UTHx8l1TFCmJ27TUXfaEprJ1C6tUD6PMc5OVquzTEF3J3rVxzwbkkAju/0TRAasb1Q
         XNt0LZMYEb32MoY2FKBjt2Z5rMOCyto5u8xLkJasCmFuVr+28uz9GgCNBeBFTXSH89R0
         yTTnQLEqrIUqHkictiFZ93ejRMQDAA7+5auraa+lol7dBjZ66CpePDwCnwFMw4oguoKi
         fKsQx/aWOaL26dXCG3Xml4w/qq/Lj2zeksFljn0VIlgsrriznQD1EdIkVE+I0XJTvY3j
         x5UQ==
X-Gm-Message-State: APjAAAVQ99GCpiPe9H6U1xzgD9YI1oF2X74l1rdQsWzt2h623BdUzS+u
        cHnHlRUVwziTYJyIyjoMvxQ=
X-Google-Smtp-Source: APXvYqzQVh71+Vj/qE1W2DoaZhiCEOLh4STnrIf0YRO5OPKOgSu5M0j58I55+7SBXX3KSb11cnB0xA==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr2220183ljo.80.1573506992564;
        Mon, 11 Nov 2019 13:16:32 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/17] ARM: tegra: Make outer_disable() open-coded
Date:   Tue, 12 Nov 2019 00:15:47 +0300
Message-Id: <20191111211556.20723-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The outer_disable() of Tegra's suspend code is open-coded now since
that helper produces spurious warning message about secondary CPUs being
online when CPU enters into LP2 from cpuidle. The secondaries are actually
halted by the cpuidle driver on entering into LP2 idle-state, but the
online status is not touched by the cpuidle. This fixes a storm of
warnings once LP2 idling state is enabled on Tegra30. The outer_disable()
helper has sanity checks for interrupts and secondary CPUs being disabled
and we are pretty confident about the interrupts state during of CPU
idling / system suspend. The rail-off status check is added in this patch
as equivalent for the "num_online_cpus() > 1".

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 7d9ef26e52a7..d1e1a61b12cf 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -138,6 +138,10 @@ void tegra_pm_set_cpu_in_lp2(void)
 
 static int tegra_sleep_cpu(unsigned long v2p)
 {
+	if (tegra_cpu_car_ops->rail_off_ready &&
+	    WARN_ON(!tegra_cpu_rail_off_ready()))
+		return -EBUSY;
+
 	/*
 	 * L2 cache disabling using kernel API only allowed when all
 	 * secondary CPU's are offline. Cache have to be disabled with
@@ -146,9 +150,10 @@ static int tegra_sleep_cpu(unsigned long v2p)
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

