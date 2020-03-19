Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4614618BFF5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSTEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgCSTES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so3738483ljk.12;
        Thu, 19 Mar 2020 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuRqkZzuBA2/gmQ7xtdmACyr3vk58NcEc2vx8jtn50U=;
        b=fgDbP8zsUAW9bA62o3tLbYLIVEbM2eTutxjzwU3WD7St4VHgYg6sc3FbITh2C1JgJ1
         DIkXLFmvcV8rb6MQgtt2svBglbhbtkJVwK3X3rItTf6xPcPlKk6Bv6HznqLmPT3eZWkt
         0Q+k1X62dpHvSIFnda1AdpsbIySHIrKRxEZMcnJ9Qh8pHXH3ovG464TFpb0wVFtTIX2I
         AyYcJHwC0sExsxh2uyFX8VBDQ16yq39jEJ79q9XZ9xVCiSJyBc2Jx2BLIe1fc5qQ3wY8
         BSusDPzzRov1m5N3QvM35ET8xF1LACtVdUjEkc3jhDZmFTMS23ak2dKVpOXxhqoRUEwY
         GvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuRqkZzuBA2/gmQ7xtdmACyr3vk58NcEc2vx8jtn50U=;
        b=H+BoippxQhAlY+EmTat5nFJcZyWk7oEdODyXrkRnIpZeV8QvoGnVRHjqpg9cu0XvWu
         iCQf2z3j71cnvOX9B925c/3CjtVqj99ZhgXKQ908BN0FkJrJBzKQ+G0DDhNGVpQxRybw
         KlNW/cKphg5Fvi2Guc46eapNZSrpBKwwJ77dSdABH4B/iqms4UzohCuoER95OfH+vHYg
         9nFw8S6/YmTqY2rH4QtHOadD0n4dpMcYmwEcPtWhC4o/6YJI1jULa+EcFalsx3WHkRyi
         xdqjHswDSlYtFpo0/ZBpgzi3pmpluEZS3LJdM2sHK/6KtSKgAyuQkQcBE4C53qRsTeBm
         fU1w==
X-Gm-Message-State: ANhLgQ0lAZNJj5NDfc+m5sVfg/OmhM43efcqRYa/U9J+NOofdAz0anto
        baRxbJGxDBqQc595gS1PvLo=
X-Google-Smtp-Source: ADFU+vsyNXvrrCmF9RHJb8MzXpeuDppLJbR+WLUOx2J32CGevDmUiS8+zyoVSdTm79PbsRfRxQS9cw==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr3019696ljo.119.1584644654870;
        Thu, 19 Mar 2020 12:04:14 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/12] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
Date:   Thu, 19 Mar 2020 22:02:23 +0300
Message-Id: <20200319190229.32200-7-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The early-resume code shall not switch CPU to PLLX because PLLX
configuration could be unstable or PLLX should be simply disabled if
CPU enters into suspend running off some other PLL (the case if CPUFREQ
driver is active). The actual burst policy is restored by the clock
drivers.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index e7bcf7dc4675..9942265ed650 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -398,11 +398,8 @@ _pll_m_c_x_done:
 	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
-	cmp	r10, #TEGRA30
-	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
-	movteq	r4, #:upper16:((1 << 28) | (0x8))
-	movwne	r4, #:lower16:((1 << 28) | (0xe))
-	movtne	r4, #:upper16:((1 << 28) | (0xe))
+	movw	r4, #:lower16:((1 << 28) | (0x4))	@ burst policy is PLLP
+	movt	r4, #:upper16:((1 << 28) | (0x4))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
 
 	/* Restore pad power state to normal */
-- 
2.25.1

