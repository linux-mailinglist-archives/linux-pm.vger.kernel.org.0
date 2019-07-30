Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4708E7AF30
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfG3RKX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfG3RKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so66586147wre.12;
        Tue, 30 Jul 2019 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oG72JYs8D99uhUm5H/8cmgUmTEFAp8bLzuwQQLvaPEc=;
        b=msT8UaDPxHL7k4vTcFYH8UmTrtZtTqnDR8sc/6k7qxtO9OxBJEJOwctfdst/feUBs2
         Iwb/dF+1zXd2fEn/AH1+r5qmcZ4RnmZNJJLJbzaO1Am0n6RctRjOjRreHrZnEvRWVGDc
         zlqL0ao8eGz1wujhYT/MrsExCoSjLzQOc5UWXDry1QKdQmwJNw7Rr3uNf/NtCEYbbuq2
         SwSCNk88DUiV/50mMCEG1a3pi6quU9G6imI7HZYdwE9YqE9sNiP2SEveESwcuMILu/Kb
         19pDUpaSnB4Vl02ygD80NLsHq8BX7oeMEtZ/f79aaOwXk+29rub2oE3FOL16eZFgpFi3
         jKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oG72JYs8D99uhUm5H/8cmgUmTEFAp8bLzuwQQLvaPEc=;
        b=LBxSyObrXRTwjbwUJo4x52BHyXAs/XbKxFKNIhsNPRiLPRykLZT9q1LGPZedecpVzc
         BiLZsaHCFNa/JZCFQ3PbOWei7gpGs8xiCTT8EGcK8buc2MrDObJOHBULpq2mRwbnJjCj
         jXfASpKPTtiuCV6YCbOAdXkXRaaUAzOoPjCP1vrRh0WYRQRHOViU54ub8jBKM4S95uVq
         RHMNLaLAjHYw5TkQyicP9WTfg0myfDUyiASMB6sqhN4fKxxMm9fOEG+/zOmrOs4viLd7
         ZA/Bz7/EyYfi+VWyeB7No1pTT5SobLvKl2PTco8BvLowOcAj9bOdIQDbCSSXpQ/v909D
         E2Kg==
X-Gm-Message-State: APjAAAUx9lvzrt3CiRgA10aKKPRuy6rBepMCWlYIjGQCdNigml6v40Yz
        1CrCvmM97hQ3anbSPr5tEyA=
X-Google-Smtp-Source: APXvYqyH7w4AEuh5fJ+nXr1bskVAySZyQBcPNIxwxziZapMpcFYxnTTVwEx/VIdl06Z/AfvNqT4b1A==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr128554493wrn.168.1564506621515;
        Tue, 30 Jul 2019 10:10:21 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/13] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Tue, 30 Jul 2019 20:09:54 +0300
Message-Id: <20190730170955.11987-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b0a05683f17a..e07c138453ab 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -108,6 +108,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.22.0

