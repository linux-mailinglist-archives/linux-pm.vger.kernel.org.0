Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD2211412
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgGAUMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAUMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 16:12:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7BC08C5C1;
        Wed,  1 Jul 2020 13:12:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so2033640pfc.6;
        Wed, 01 Jul 2020 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W20vV3JALPph0VU9IgzKjMWKb8lzvjhb2qzVsECrclc=;
        b=PwUM0eTjfKWO+jB8QSaTySZ+dZS/8QftYHEPdbAVqrVd0LEVff3jx4meWpTLeCl1hE
         5gfuTC466r8MFk2xWA4FfJFIpM7LjM+j44fTqrhdbMn3gj4nIwRghF67wpiw6IAJWLlg
         u3zW1kF0k7Pik9gBHN1jeFzaZGaR7g3SqqOuKYwu7hOyi9sNpM0jPKOTTuEM65We+h20
         hlpRnyC1mAAoy235GOZNMzUoErceWpALCSwVJAXmlidlStfdVLpKNKWur+HG8XNqKPAe
         24DK2nZQ9e82HU3PRfA2VcyJn7Xw3bf+HKHz2aU0p1JFrfG3e6OJBv8onRc8MgQddgyF
         Tptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W20vV3JALPph0VU9IgzKjMWKb8lzvjhb2qzVsECrclc=;
        b=F+0vxQ12ie9nrxt1fc333Za6UtGee49X5GLW4ziHN2UWelQfpKt0TybGUWZYu0ka6f
         XaQNpHusqOLxgtnG5F46j1NnOZl2MrjGAKd92dzYlIVs/oisWnHNsZfmQdYgcgzhKigE
         eC7R5AunkA6up24u46QOPbznmKT6skxNfaSnmjrR33bjU7Ygcy/2qTECMKFxLHY7oO4B
         jXrgwmdcwbq2p+CNwTyzV2dm1+iLNxuckvlM4Xujn+tnFKpxkcnS87qPcMhhnEVJ/Xml
         rXCBvXubymGoxEbhj+9szHQWNebdrgPxQglNvN/qXLuyLICG8o80/Ebj6+7YSH4Pg7qp
         n3iw==
X-Gm-Message-State: AOAM532dZEGVTJ3MsUEmrNh6J9bKBA7pZDRTYJs2zOBCdsvx6zVHpO+C
        DmQ/dGjWv0NVPm8/Va0xxjg=
X-Google-Smtp-Source: ABdhPJxG1F06kx2wFpILNOql/nZRFFIvn7l1Is/5noNfiyyyoZFJEEWzYUymfaV0XOdlBKmiLMjgXw==
X-Received: by 2002:a63:2104:: with SMTP id h4mr22094734pgh.427.1593634371657;
        Wed, 01 Jul 2020 13:12:51 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id c30sm6654332pfj.213.2020.07.01.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:12:51 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] clk: mvebu: ARMADA_AP_CPU_CLK needs to select ARMADA_AP_CP_HELPER
Date:   Wed,  1 Jul 2020 13:11:29 -0700
Message-Id: <20200701201128.2448427-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building arm32 allmodconfig:

ld.lld: error: undefined symbol: ap_cp_unique_name
>>> referenced by ap-cpu-clk.c
>>>               clk/mvebu/ap-cpu-clk.o:(ap_cpu_clock_probe) in archive drivers/built-in.a

ap_cp_unique_name is only compiled into the kernel image when
CONFIG_ARMADA_AP_CP_HELPER is selected (as it is not user selectable).
However, CONFIG_ARMADA_AP_CPU_CLK does not select it.

This has been a problem since the driver was added to the kernel but it
was not built before commit c318ea261749 ("cpufreq: ap806: fix cpufreq
driver needs ap cpu clk") so it was never noticed.

Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I do not know who should actually take this patch since the problematic
patch is on Viresh's cpufreq/arm/linux-next but the problem originated
from a patch in the clk tree in 5.4. I assume all that would be needed
is a clk maintainer's ack? Please let me know if I did something wrong.

Cheers,
Nathan

 drivers/clk/mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index ded07b0bd0d5..557d6213783c 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -42,6 +42,7 @@ config ARMADA_AP806_SYSCON
 
 config ARMADA_AP_CPU_CLK
 	bool
+	select ARMADA_AP_CP_HELPER
 
 config ARMADA_CP110_SYSCON
 	bool

base-commit: 0363635faa1da1560d2a84e2229c3f3ab108304f
-- 
2.27.0

