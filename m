Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31C81BE94A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgD2U6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44180 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgD2U6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id a2so3117058oia.11;
        Wed, 29 Apr 2020 13:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2qb/OvsZeuot/6uM8EwDvWFdbtAPyr2Mv3N5hc2RTw=;
        b=FaoTTTw5EODe7EUKBRKA8aNCWFKYBWzmnZD/VUjJH++D9OHtFL2Z4jROIpvmxmb2Z2
         3SJUs2XkpCCHSEJsebvIDX7BnLJ0g2mlYVu+1mMbE6nra7lmRZSyWNfOoPTFBlhrMgy/
         lLnDr8Bmx9S37poglqQ7ei1Ppd4y58qK7hCKT7Vmjj7fAppCK8CwaoAVwAct640Z5qru
         0zv+DI0eQ6juwbWrocm4YObOfcBvshNWwTDNge2+J/03BqF1UicRNciu9alaPdQqBx0w
         80rnnfNA6VXbau7keDmdiy1EqBD6nJMHy6M5lBk7TvFp9uPrgI2XSGZ3wZhL0qo9bsR5
         JVOg==
X-Gm-Message-State: AGi0PuZI6qQDsKlnG1c1WVime2D7yzsIoev0J69n0RW6ovuV/xKKIBtW
        igWD6Au2XbZgnSueVVr8yQ==
X-Google-Smtp-Source: APiQypInPg4wr8U7ru0AiPOb2rYYQ+qLy6mnlNZK1mQLdkr/zxHbjhm53Jiw7qfUFFZqUi5e6teEPA==
X-Received: by 2002:aca:b382:: with SMTP id c124mr140690oif.64.1588193915509;
        Wed, 29 Apr 2020 13:58:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 05/16] clk: versatile: Only enable SP810 on 32-bit by default
Date:   Wed, 29 Apr 2020 15:58:14 -0500
Message-Id: <20200429205825.10604-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
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
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index df0d50bb846c..a47dd6c86d2e 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -17,7 +17,7 @@ config ICST
 
 config CLK_SP810
 	bool "Clock driver for ARM SP810 System Controller"
-	default y if ARCH_VEXPRESS
+	default y if (ARCH_VEXPRESS && ARM)
 	---help---
 	  Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
 	  of the ARM SP810 System Controller cell.
-- 
2.20.1

