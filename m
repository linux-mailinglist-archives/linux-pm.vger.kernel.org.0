Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB93818BFFC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCSTE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36155 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCSTET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so3798190ljj.3;
        Thu, 19 Mar 2020 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuQCFAUGgCNgfRWuRofqyV6Hacg6YekuN6dbxQCNP6M=;
        b=RY2paf91r5jWzSsQNP0zg+H0SLHwnzcSyzLAd6c0M+q22ayiEhFdHhwEH6NgeZaIoo
         lm7T7ath6xuVnESAC8jjH9rQCs52R70pEXBGdgstnEWQePXZo359EqVl+VL94Jc2zfNP
         pFfFbPBeUZIA3DU/RxsfgqwnKMFT2Zeg9jYrMWsWjsUzLgHI5jmc4b1wAwOQwTp2x5YU
         YnWTziG6x5/aTumOvNYJbvOgn1PsObQaOxcSucSxWPUiKxdvL49vzeyQPJqwhC7+UU2w
         hUqIx1ns5LkZLkmXWWMooozHfUZi+ibu1hBEh+EmfbZ3+Fjo/f3ikxxyJDIwn24LDjvq
         sBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuQCFAUGgCNgfRWuRofqyV6Hacg6YekuN6dbxQCNP6M=;
        b=blDl6PVVEaWXO44i7giNqBSKBABfIdj/Y/3JV+RV8HhFHsDB5QCyXdCxmVycFnJ5HQ
         Beh/hRYhEnR+EzFTk2YsBQz2d2MxloRQtE8t3BtsTQ1wbxUnC+IOFKQ6RB4T0EUzAe04
         2Be0ROIxc8v7vgpK9VZ2ZhscZ7LIYI5eI1QjvvuflPbu2Z+GeGNlVlgTZNz5M+GwfWLb
         5OJ67i7Tpm6wbIXngTL0WRcj5VniNM+l2UyhysVBKwrA5xkHPDgWtfAhI9h6E79SsMQr
         D2z65wfIB5zXI1W91GOJOv/ckfmeGEEJGNmvPEBmIsN8ZdaZFSWqr+DN4K0cAiTo7WWd
         Prsg==
X-Gm-Message-State: ANhLgQ2D+bIGcmIGU2JWZxaiL57SA0DwxYDJHaESu/9IxUPLNlgMth8U
        1lhFSah+f7P7gPMfJFb9pi0=
X-Google-Smtp-Source: ADFU+vuAcWsH2NpVCmk1A29yzI5t9CR3MACNcvLowJJ5OPnvquLwIHYssOw/2X3SNkhRKIDFN3uADQ==
X-Received: by 2002:a05:651c:2007:: with SMTP id s7mr3146298ljo.214.1584644656425;
        Thu, 19 Mar 2020 12:04:16 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:15 -0700 (PDT)
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
Subject: [PATCH v8 07/12] ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
Date:   Thu, 19 Mar 2020 22:02:24 +0300
Message-Id: <20200319190229.32200-8-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
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
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 9942265ed650..2667bcdb5dc6 100644
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
2.25.1

