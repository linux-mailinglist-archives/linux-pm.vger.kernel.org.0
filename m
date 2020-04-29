Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1221BE951
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgD2U6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36120 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id b13so2991894oti.3;
        Wed, 29 Apr 2020 13:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hakhZUZroxvAZ8LX2cygtT4A2MYBSWJTm8hRJv5ywvQ=;
        b=sm3F4qNVbasO52YN8jKFZ4Qeq6QshhjBsSGfJHH+Lmh4AQMp2qbkItjWt0Np3CctER
         SZyjShur40Bzk4DCeNkH1v9nNN/L+eGukiYYR7XWaKFZgcPrAcVcIMqoAYEirPpWOZnm
         7LT/1HAp3kVogsCoYCNGcuiA6HniOTjmZlHo33wUDP0PwYRYpeiIBhu6PEBpnkv5S/hl
         i+l4Radn2ZDb9S2frfx8h1kj7gJs5xqxcAyRZPY5UtS78vQD/supZdOSEjS5ae0Kro3z
         up3W6haEeWb2N9qdfl8Lei8XwsvKNWvHPdJTi9/OGS8pTJ3BdjsRTae3S7uzNSacbO1G
         Qlyw==
X-Gm-Message-State: AGi0PuYBlNXhYqIl3+OPoVtldzFI0ZJIRHDIr5IIRZPU673PRJ9Yk2lt
        ewTak6cW6JDz7ummlC6z/A==
X-Google-Smtp-Source: APiQypIgNRez4TEHYcezYK5SwxhTnNcYbS+rD9SCdgQFKtZmZsnxMPq9TxJ46RQV5tla7GggKhl6iQ==
X-Received: by 2002:a05:6830:16d9:: with SMTP id l25mr27963192otr.108.1588193919798;
        Wed, 29 Apr 2020 13:58:39 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:39 -0700 (PDT)
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
Subject: [PATCH v2 08/16] mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
Date:   Wed, 29 Apr 2020 15:58:17 -0500
Message-Id: <20200429205825.10604-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
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

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
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

