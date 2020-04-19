Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127541AFC5B
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDSRIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46748 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDSRIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so2505952otq.13;
        Sun, 19 Apr 2020 10:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qrg4Kn0uV5CkM2HSImaTMyKeQJqbbeo+iRjf1bdrad0=;
        b=aMYNuyAtOhT98a2aadT7jwrwzNWnHTBT00eL2Jb6oFCB8Csp68mzynuq+Upxi00Z09
         bDezMVfmbaxll2g9UmgjIlvKVjXQ9S5sx9lZIp9EyGKcd7k5ffaUFx6oqiXw9hE3D/Il
         tmmKv+gmAg8W2tUAtgPR3Hdof/i5J/ng4lqSadMkXMbASLjyFwMH9F0iWgtrhQi7aTu+
         /5IM5knLBBI/UzKcrDU/0oSEtcOZTJjgR7iKCMl2F6t67FQEPlvPnI96Ddt+HQTK/Hsd
         Rajdt3huZGSLCz/Wd+CdIR/XZ3pqsoINqoZ7E2uDwAgKxszSb7McslXsWKnjsEkkZOQn
         H5ug==
X-Gm-Message-State: AGi0PubCB2QTF5tZpACiuGEEvE5NlweCrtV4xkjZ3m7VJv6nIsd+loP0
        +gp4fwTUicHjzEcFzcgHzg==
X-Google-Smtp-Source: APiQypLaYTQQiTq4lbmbzauI24B6HAlyxCl7rv3Xs7I3W7EGTvoW/11+mJIDtPy2Q91CLPeIch7vLA==
X-Received: by 2002:a9d:6303:: with SMTP id q3mr6861606otk.296.1587316101203;
        Sun, 19 Apr 2020 10:08:21 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:20 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
Date:   Sun, 19 Apr 2020 12:07:59 -0500
Message-Id: <20200419170810.5738-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While 64-bit Arm reference platforms have SP810 for clocks for SP804
timers, they are not needed since the arch timers are used instead.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 3465fb291998..5bdd5c98990b 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -9,7 +9,7 @@ config ICST
 
 config CLK_SP810
 	bool "Clock driver for ARM SP810 System Controller"
-	default y if ARCH_VEXPRESS
+	default y if (ARCH_VEXPRESS && ARM)
 	---help---
 	  Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
 	  of the ARM SP810 System Controller cell.
-- 
2.20.1

