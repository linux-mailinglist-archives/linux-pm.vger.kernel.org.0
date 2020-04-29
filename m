Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B821BE961
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2U6x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46051 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgD2U6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so2955664otk.12;
        Wed, 29 Apr 2020 13:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAdoTZHLltMFOVfGrqWdl37EO5vwkDwGDKM22JQICTM=;
        b=F5OknAKY58cpbfpDvtNn4umOrWJRShRr7mbLLU5eV+GlJBD57GOsa2fGJCscyrqN+/
         pEuWL8Jh2GoS/OWoS8FoaVElo7DICPokO1djBNeQJDco4oE646j0hZHXjKlGncjvdwqX
         JfpZqVORlruuEggH7osFHZ3JQpAhRgCzwiopvWd5mIRdog6ZwDz42rWuCcTUvEZML8ox
         GIfCZivZlWgufCX/MsqOvmzs2S5UmgvBaCUgVpau00LUWShNY2PgJlNbz6LTHbi1ulV8
         1RyA4MVEFxNg6Srf0KEZoNvd/nK4pG5+umjE9Z3hYJBxT4VyJyhpFyW3pTwTm0js8v6M
         iz0A==
X-Gm-Message-State: AGi0PubM77fnbWaYYB3Lg3Vb+tJsKkOjCYHNXDDDiLs0LQTEvVWwXSFc
        i6CLW+bMYlI8ttxTntVLIA==
X-Google-Smtp-Source: APiQypLaRwS1DB9c2Fr/UQVYYitfrqYIOoI7sUirq8Ad0qUr/66dbbAtO3c5FnIEbYo/svvyYQtMXA==
X-Received: by 2002:a05:6830:3112:: with SMTP id b18mr26344468ots.97.1588193931043;
        Wed, 29 Apr 2020 13:58:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:50 -0700 (PDT)
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
Subject: [PATCH v2 16/16] ARM: vexpress: Don't select VEXPRESS_CONFIG
Date:   Wed, 29 Apr 2020 15:58:25 -0500
Message-Id: <20200429205825.10604-17-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_VEXPRESS_CONFIG has 'default y if ARCH_VEXPRESS', so selecting is
unnecessary. Selecting it also prevents setting CONFIG_VEXPRESS_CONFIG
to a module.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-vexpress/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 065e12991663..8391a5b3cd78 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -19,7 +19,6 @@ menuconfig ARCH_VEXPRESS
 	select POWER_SUPPLY
 	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select VEXPRESS_CONFIG
 	help
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
-- 
2.20.1

