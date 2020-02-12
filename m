Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B515B567
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBLXw7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39140 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgBLXwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so4437206ljg.6;
        Wed, 12 Feb 2020 15:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS4gtNJrSYUjQQXOqqY/Oa93RASY09H9Tmcfh+YVDHY=;
        b=lxqydUiPnuXLChUwnee3i+KTHQwL+gubcerAHl5rh65Fzon23/BCEBKHAtoW2/clVR
         EwFx+n+eM0aj/UwPjhuj77J/gOwEn20HKTSwTUXvGApG8ciViGailWbVQAsmFSssToOz
         8KcLhOuRpq3rxQQMxbHyjRBbVKdtBDtqWEREE8VqTXueKvp/d0imqQU35ZFdkP/ED+eF
         7nL2WWoyICbj4b9PSQWDNnwEjY2wSh4810RgyfD/5OAvVC/x705DgTPCkKM5m9aqGvph
         FiJ6UcxSZ7FbgPi0rNOcUT6luSOwMVdPMLTcYlciTprqfIKjmugNP+UL/nGPLNiTHElt
         VseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS4gtNJrSYUjQQXOqqY/Oa93RASY09H9Tmcfh+YVDHY=;
        b=Odj0K6NJHxjS9G9BXI9FWSEdeny0lnMh4V11d+YLugVwCT2JdReVJbHFvpKQQn0neZ
         /gGonjwsG4JNU1wddLFxgJVF4pHCYZe/gZzpmzzJ9NhCDWghF3YZMlVHeUgoflVhQO6a
         zOiRIEV6X3gCN+Of2Pd8v0LDfV2j3Y1q8m+QC/c9PKISg+iwwzgC3QXfGti/kL9i2qWD
         QbTRVQi+UvdlPFemJMkjiQd5/Xntit3zzJxGYFvcg9buajgNyDCDDCzZj8VhepDkmOnj
         F1lTsbzrIOE0IJ3bOKTqcGNhTJmaH/mocmBDK1M8Orj9AciCSvRKb+UQ6tEyugdtPpSz
         IOgQ==
X-Gm-Message-State: APjAAAUxEt3KuCfDMhOcf2IOvhB81s20Xd7FXFiQmq1rB5N7WGmrZzXD
        jsuHLNPSO5eLqf2y0c30iho=
X-Google-Smtp-Source: APXvYqyrlY6DZo0Cd476tLwaHEZumaspt5hBJRv94qqezEburO4GEYyMUH4Ohjm0dZHpnq4qUwo7KQ==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr9099962ljg.172.1581551537702;
        Wed, 12 Feb 2020 15:52:17 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/17] ARM: tegra: Make outer_disable() open-coded
Date:   Thu, 13 Feb 2020 02:51:25 +0300
Message-Id: <20200212235134.12638-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
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

