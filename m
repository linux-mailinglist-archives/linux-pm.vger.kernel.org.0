Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE819BD3E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgDBICo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 04:02:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46932 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbgDBICo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 04:02:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so2170073ljg.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vyp32wAklCO6J5UFHgfFYKkeTAHEzjD89tPlWTYStp0=;
        b=HBlPb8FkIfaQVWnUvAD2TWPaTz73C7I5gXfZE4/tbSgsUl+4s4ZShIDC8unoa6HJTb
         lX4vmMlXeC8V5BCEYreKA26zKdBSvhoffOKwFfytvwhizNhwEkWuaBrfMyBEFchJevIB
         yyUNybyVPawYhZNhiG/hr1H13VIrfk1fGK11wydOa7ccULLoRLi4VbPyKCBFPwKk5qCZ
         ySNgd5QgLemrXt+CGwdpYfi8zsY2Pea4QJAB3qaKGanP6fNZKlPVeHsyUefJTTcS1tSp
         unVxjM6PsgJ9PEVzRwTzwCjMCBsKZ1YOE83bBO8WDxo/HWY8lt6TtijW0AXJuKxUQnhq
         utJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vyp32wAklCO6J5UFHgfFYKkeTAHEzjD89tPlWTYStp0=;
        b=AScD3x6TPDx5l9ZsLmZNpBQL3akMQ6bmApDifjJWiBHZ16vGim2BP/sw/oJWHqqyf8
         u/1rVY2qYECcPFYTgEzMYDi1HETlRwnzH+xyJIE5rHWq2Hxp0BuvcoR62pM93jcVaPol
         hW7a78vAXypUkCZ02oLBPK9UammE8lgG0T0i2dq40422mudBJSdSKAdN8rrzhQyHKe2D
         l1bh5y/387vO1PWqIO1motsjOhodfRevbtl9y1C2h3X3io1cWsiWlOti672ltr2T8LdR
         9jL+9R6lkJi6ucUUqSH8Cbw0huF1DX5X+SscNXuKhoujmc3gtucvQ3/SEMCm0RX2NubB
         SmfQ==
X-Gm-Message-State: AGi0PubZwBj39PJoP/LcFqWp8tPDdMNIAHjmjYBagOiEa+Q3+qTjUPGh
        4G9CEW9bQz6A49clbn8sYmZJqg==
X-Google-Smtp-Source: APiQypKRiHheQF6ZN5f6Vy7jk9f35v3zWiX3N7C7LXyAWgdjwul7jANBM4QrgLAHDCT1hyyQ2MLdLg==
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr1242814lji.110.1585814561734;
        Thu, 02 Apr 2020 01:02:41 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id i190sm3471898lfi.7.2020.04.02.01.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:02:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: Select schedutil when using big.LITTLE
Date:   Thu,  2 Apr 2020 10:02:39 +0200
Message-Id: <20200402080239.7471-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When we are using a system with big.LITTLE HMP
configuration, we need to use EAS to schedule the
system.

As can be seen from kernel/sched/topology.c:

 "EAS can be used on a root domain if it meets all the following conditions:
  1. an Energy Model (EM) is available;
  2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  3. no SMT is detected.
  4. the EM complexity is low enough to keep scheduling overheads low;
  5. schedutil is driving the frequency of all CPUs of the rd;"

This means that at the very least, schedutil needs to be
available as a scheduling policy for EAS to work on these
systems. Make this explicit by defaulting to the schedutil
governor if BIG_LITTLE is selected.

Currently users of the TC2 board (like me) has to figure these
dependencies out themselves and it is not helpful.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index bff5295016ae..873aefd96cf2 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -36,6 +36,7 @@ config CPU_FREQ_STAT
 
 choice
 	prompt "Default CPUFreq governor"
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if BIG_LITTLE
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
-- 
2.25.1

