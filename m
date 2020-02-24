Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92AF16B474
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgBXWnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38893 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgBXWmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so11908466ljh.5;
        Mon, 24 Feb 2020 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yQMglB4vCGlQCm7ZMgMT2Lxj53zxpwTod0Ou3j2MPA=;
        b=aCyZG32WV9ULftR0U56FZfjl38mwJetGIzdPzml6rnpdFyFd83PBjxc0CnFKgEGqRS
         gwO/EPCydYn99hlqG/c4hskaiqn74hpi6KoubwuwkXu4Q/4xxAHFDEMB/8mv9Y68Js8+
         0Z1N+iEOs/9OQtkFonImSfRdjE8ud9zfd20w9XKnqQg4X78KFIm7yCQaoho2SDKls5zW
         ++xb7/JOZq3U/Odx+rRC7oZTU95vql+v9cOzosjMw/VJeoOT2/xp0BhGZhb059Db43/L
         EuJTJiXqMjIerpzELQZlWKLoXB4qvYlxaSXBqAYSrL3eWhwAHRjqMeyZRJxu71lbzLn9
         +0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yQMglB4vCGlQCm7ZMgMT2Lxj53zxpwTod0Ou3j2MPA=;
        b=JQnFQS6K0lc9q7nyNhnExCQ4aIo3LmMkzl6W5cwA5Di/FlwpUjeAtAM9xwqSBp3QeC
         I7nVwzvVDPEa37zGweHywNt/UFCquSiiySYra1DMkZyInjwiXUlz3VqOaYOmvLZMH0sa
         x8bcnAQqZH+VIDgulW/uOhUX/Ikae9BU6FbjAsLB9AKhcIHNW8GwHBQe09eL9zWpgk+t
         PS/W6NNOLUrj93uE7dioGy2C5vVkyqP4y+mG63IZBJ3OtB5pzrFTbO+VPErD7UkEO5dS
         NXI/gcO6nJeLD+kSU2BMKjU76GOq/9xyLVSgdLg0xbTogEfVp+WO5hAyr/T0DhJRPOgP
         r6zA==
X-Gm-Message-State: APjAAAVXEM51QsIqds5C8pbWybAZ6GWKMAM2Mifo/DGkpLUaxjLZK13s
        2rVCyZLtBJxgMqvByDGsNM0=
X-Google-Smtp-Source: APXvYqwuyN7R7TxkBWhN8OLpWsJfZx3xp4fMg+TfX9uk6PxYpF6XtE5DS5tYiAwhzRBCB1Q93DlZug==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr31608564ljo.153.1582584162623;
        Mon, 24 Feb 2020 14:42:42 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 08/17] ARM: tegra: Make outer_disable() open-coded
Date:   Tue, 25 Feb 2020 01:40:48 +0300
Message-Id: <20200224224057.21877-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
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
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
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

