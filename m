Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734C715B51F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgBLXqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35605 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgBLXqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so4438423ljb.2;
        Wed, 12 Feb 2020 15:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFoQr2efsDjC1sgE/IqBkGYRFbsY8VGMPosKnRKz7po=;
        b=conaQ3BWIMB1ZG7AlRiS1MwjCKJcLg9S4sW2ZuB6T1kOcyBMB2333AktT036+IHECS
         fNipirXJVzaRaHGreYYCzN5v6lYakEnF92nTZGO976MqcXFWAOSr3fb0JT2BC752X+tI
         Tc2MNec/SKHMWmbQ0g9SrWrwaasEN+k2bgFKsoLtJEVQcDtMAtivnTZfJijyi+NwzHnN
         xHXDsUpkq9nMI8Hil+kBGMOgv8u4uv8UAaqUA5bGITna2WrOUY3eWDxrPsVPDXjxW1X7
         u05qxPDmiGoVqg9/NGZtaXdSNZ8TH7c3OjKyNXhtBMz1DFAzlttZcxg9nn0m5k/1yT1P
         w+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFoQr2efsDjC1sgE/IqBkGYRFbsY8VGMPosKnRKz7po=;
        b=JHpYsDhZLx61BUxGpCWC3PvUxkYtCTae0cjRAVpkajA35KOjHjs28nwIIApIFnNjpU
         X33fKWpafOYemr+XFSt0VrMgyEM13OUnaCm2b5SD/pZqiqVSDPGLIJ1HVQm1idkS8s08
         2YSNAyFKgywGtrXhV2z6AxP5XN5iBPCssHnaSVmZl5L3pLTHCaZVw0qLnaT+32cqaOiM
         bhfY55B3WrnyiJTGLvn1h3KB5rGozsYozdukggavLs/n7XHpNQqkoxIuSol+NREdLlSy
         01vrJy1mqvxUGDVO/pz1L82zSFCAnX0ybMP9+gZgu/MOEMFz6ChfV5Pc1D/gLYjb5o7L
         sjNA==
X-Gm-Message-State: APjAAAVgYaURLp70N+l71w/nzspJrsBnjxDo6oQIP6RrFy4hLHO8veNj
        WdqQ10rptnBH+YuXd0xwFUs=
X-Google-Smtp-Source: APXvYqwkhcXK2XXZFAxC2fq9VgZuSYsR3hMfRl/0FMfAm26yJD4kGM3Ir5AnFGCVNQM/uiqGQTGs9g==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr9598528ljn.33.1581551197531;
        Wed, 12 Feb 2020 15:46:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:37 -0800 (PST)
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
Subject: [PATCH v7 07/12] ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
Date:   Thu, 13 Feb 2020 02:46:02 +0300
Message-Id: <20200212234607.11521-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PLLX may be kept disabled if cpufreq driver selects some other clock for
CPU. In that case PLLX will be disabled later in the resume path by the
CLK driver, which also can enable PLLX if necessary by itself. Thus there
is no need to enable PLLX early during resume. Tegra114/124 CLK drivers do
not manage PLLX on resume and thus they are left untouched by this patch.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index b897d4a433b3..c3946dbd0240 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -361,7 +361,6 @@ _no_pll_iddq_exit:
 
 	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
 	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
-	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
 
 _pll_m_c_x_done:
 	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
@@ -371,12 +370,18 @@ _pll_m_c_x_done:
 	pll_locked r1, r0, CLK_RESET_PLLP_BASE
 	pll_locked r1, r0, CLK_RESET_PLLA_BASE
 	pll_locked r1, r0, CLK_RESET_PLLC_BASE
-	pll_locked r1, r0, CLK_RESET_PLLX_BASE
 
+	/*
+	 * CPUFreq driver could select other PLL for CPU. PLLX will be
+	 * enabled by the Tegra30 CLK driver on an as-needed basis, see
+	 * tegra30_cpu_clock_resume().
+	 */
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r1
 	cmp	r1, #TEGRA30
 	beq	1f
 
+	pll_locked r1, r0, CLK_RESET_PLLX_BASE
+
 	ldr	r1, [r0, #CLK_RESET_PLLP_BASE]
 	bic	r1, r1, #(1<<31)	@ disable PllP bypass
 	str	r1, [r0, #CLK_RESET_PLLP_BASE]
-- 
2.24.0

