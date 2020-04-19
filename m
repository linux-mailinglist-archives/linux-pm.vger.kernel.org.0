Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA241AFC60
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDSRI0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39113 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so5960703otf.6;
        Sun, 19 Apr 2020 10:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lL7kUnqrt4NzPOQyXcvp2n9d+Q96MUmdmOUa848dWDw=;
        b=TbRSyoNAc/KpttP9vH5M3igKmsGsicMlwqjahmPrey+zkfBqC1BWOKMJjBgO4H/95j
         q5jPJZki5iee7ZDZI5EPMsgKqYdLf+l3Vn+xS2NwYsF+7GqVRTcQBLNmKOZlzCFQJBKG
         jSQHeoy/MKowjAVLed35kaeM2IdbcFzZsFULFfCXjgj0XwhLSFQcr7tPivfZbTGK5W/N
         dZEXw1UfG27xuNgssy/93QQBL5QATnexrWRNN/M+K/NupWlnPPvk/95h/cI51T15UAXV
         pibNom3bmK+Irt7bugE8iy4ivoaAKlhtfWgJvpV+E24MxQZ8/HQbi6EAyJ3Nu1so07qr
         R+CA==
X-Gm-Message-State: AGi0PuZ/fPVzTtpDn/ZHfibqRTYL6yF0AQGQha3AIl++QjFLOK1C2ATM
        k/2yHhLcMCeoqGcMkSpiXg==
X-Google-Smtp-Source: APiQypKx5UHUpB9QQwwicGLNrpuxItDEsWq2VRAkb1J7481iH3Fbl73Y40DGbCP6jlP+0VPeKXgkNg==
X-Received: by 2002:a9d:2dc1:: with SMTP id g59mr6383687otb.90.1587316105171;
        Sun, 19 Apr 2020 10:08:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:24 -0700 (PDT)
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
Subject: [PATCH 09/17] mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
Date:   Sun, 19 Apr 2020 12:08:02 -0500
Message-Id: <20200419170810.5738-10-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nothing in the VExpress sysregs nor the MFD child drivers use
CONFIG_CLKSRC_MMIO. There's the 24MHz counter, but that's handled by
drivers/clocksource/timer-versatile.c which doesn't use
CONFIG_CLKSRC_MMIO either. So let's just drop CONFIG_CLKSRC_MMIO.

As the !ARCH_USES_GETTIMEOFFSET dependency was added for
CONFIG_CLKSRC_MMIO, that can be dropped, too.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d3..b1311dea2da1 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2029,9 +2029,8 @@ endmenu
 
 config MFD_VEXPRESS_SYSREG
 	bool "Versatile Express System Registers"
-	depends on VEXPRESS_CONFIG && GPIOLIB && !ARCH_USES_GETTIMEOFFSET
+	depends on VEXPRESS_CONFIG && GPIOLIB
 	default y
-	select CLKSRC_MMIO
 	select GPIO_GENERIC_PLATFORM
 	select MFD_CORE
 	select MFD_SYSCON
-- 
2.20.1

