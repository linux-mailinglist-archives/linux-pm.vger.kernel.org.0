Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D710F422
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLCAnA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:43:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLCAmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id q6so1397167lfb.6;
        Mon, 02 Dec 2019 16:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ab4PnQJV3Qk8nz4oK5dDMx/W0PCWcdGCcLsEHPXnzUc=;
        b=Mvds3uxXTBA95Lcu4KDCUuoYU+vgqgoS3MsamWL8YG/LeBBRe4xglwEL08y6NyNF0t
         8V+GIEjd9zBvC/8Q4flTHC1UOnkIpT5+wbhCWdUopCBqNThISNutH7cN4PfuyhwaiIWg
         a4zmyNxbRhBp6gYyxdZ/1WtKSf5hsvxL4OxAGXWIZHUoztb6rcI4sy/p/q/LcuMmz6ba
         8reIcUeKtjV5EPF+xLueckcN0g0nuj+XJJjjI1G2zujV1VlPKl7cbpoO50IMJmUDstCP
         CprJOKkg6/60ZSBosWcB88AuV/Fkh6JOoLxrpX8KQWEfauF3JJuuOozn96sE0/TdoYLB
         Lvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ab4PnQJV3Qk8nz4oK5dDMx/W0PCWcdGCcLsEHPXnzUc=;
        b=GgVq3bKzgdO7UMeOthD10HmsNrfl5Y+Z66OKwHKK/ply0n6W2b12onFWQgQRLLaMnr
         4VHZIVgFgSLblBgcylSrPT4x3mfeXPbb2bVxjAx7kIE/j/cV7xGzNN6buUNOSZDHMQaj
         IcoM0U9TyArFo2UAKXJIxVeyCbxFebDlg2bDRCxwuIpkuWrTI6kkVwgXXVr6ghK+2SQJ
         aUmmmyx9OO9QjJ8av1U4jVEJ1+Kq1j6v6ufATq25uyo7qYWtyJOYVwI1DaegjQyRJYsd
         dOK5rJ+kHyfhv8b7N2CoyS+57aG1R9+H8WaQ7X9d0YD5A5CtB91OleDNntaLhhBdt5jy
         V1PQ==
X-Gm-Message-State: APjAAAUZd2vo9EkZVGKoBmVBX2YRSTBVhOhiSBmi0uz3JThKuU9zUjTq
        4oZHcZqHyE5lU5MeRVjEOhqATbAy
X-Google-Smtp-Source: APXvYqyv0Mp7e5+1CNUJTMnK9SGWvQOmLpir7eZ96BqQmjDFpCTBwQau+RgAQ34U+hfpoJ8x919a5g==
X-Received: by 2002:ac2:4643:: with SMTP id s3mr1045543lfo.23.1575333729822;
        Mon, 02 Dec 2019 16:42:09 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/19] ARM: tegra: Make outer_disable() open-coded
Date:   Tue,  3 Dec 2019 03:41:05 +0300
Message-Id: <20191203004116.11771-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
2.24.0

