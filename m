Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74415B52F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgBLXrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:47:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40442 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgBLXqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so4416367ljo.7;
        Wed, 12 Feb 2020 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yt7iB+8N46yIzqprXkevBuhRmPkO5WOPeg5Oq7Gq+OM=;
        b=HMEGN5A6ibF/Y9VvdzkVvGQD+ATNO1Lu6sIpUbl2kcoZnNQ1KV45gT8jtLtwkEIUz5
         94CiiGM0Wh4bLIU8A0Vho0F/EgrBfP/+rby6+EycMAZqvRjblDIjNIdWI0c7xtZOwzLB
         0W5flISWtH5EgrtFXtWYurRKGNtDDW2fgXmYgtUF0g6B2IUO8XWL2GSQ4Jb923YtY8H2
         Dpswkvk7+tXUU0tC5+ovgh7TKVuXiYZB/BoiU0q07TCn6hDwPhTS1IaIbYAswH30v3tw
         +cqpeP540xdTjA/vLeINy8/TxaJko0TrIuPaoAI1J2Y82LLrRrDHqy93r3/4rJ8oxTRE
         sCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yt7iB+8N46yIzqprXkevBuhRmPkO5WOPeg5Oq7Gq+OM=;
        b=JFMb+Te3/TTX0zNuYQBn96rou5iyjgJ90b/oFb9gF0OMFo0Lv1Q1jbd6YjOAY4pYo9
         VIyK12VovYzoxSgz3oMJFnB9KK5P9+ueL7wuLTKlMi5eNMBaorOhbmLOj242eveBiDK0
         b2CToZGQwo497iYig3/2K5wIfnpnaPT0PjByqNGdDSbMiOj+MBzymYlJVjW730rbql5R
         XilgUAIzqLQLqqBI+W5PUPuxcMgElz2m4jWF+24NSNSmztd1oq2Ld2XKQQFrx9NovSV4
         2PTe7k23uvNsSffQZds0qAQeRk3DaaEbAsRNF+4/4gNgDarnnZITxlRGHBIOExg5qwyQ
         NCxA==
X-Gm-Message-State: APjAAAVcp7jp3wyeXXtjSrojfbNhChwRGpTaBYviNiGzscHKMFGSZ7AH
        BqrUodhcx7PXd49Qr6rQYxA=
X-Google-Smtp-Source: APXvYqwUmr00KiHe7WEgw6vme2JIMo+4Umi9uwQlS1cHQXb9a+2UzVKMYPCdxXb+KiXHxE35+4H5rg==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr9246918ljg.149.1581551196359;
        Wed, 12 Feb 2020 15:46:36 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:35 -0800 (PST)
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
Subject: [PATCH v7 06/12] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
Date:   Thu, 13 Feb 2020 02:46:01 +0300
Message-Id: <20200212234607.11521-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 02cc6ff96f30..b897d4a433b3 100644
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
2.24.0

