Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5201AFC52
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDSRIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35098 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDSRIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id o7so5006820oif.2;
        Sun, 19 Apr 2020 10:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HR2vyc2PYWWn8G5dom55PqoQEPYuAFLiyICb8T+CViI=;
        b=Imrfibp7SUXrD+MwBRpuqYNDZs2ff305enyyAc8YS5KKQNQdIvBPYV0az7L4i8cPBW
         Rcif8vDff2cY0zCXGo3drz8ydbgCgmxo7PuCPsP7QnQAQiVLqHR5KMzfiEX8PDZDVn7V
         M3EVohSvTfvbG2480kjC+G6LWcvMtTTTNmvoZ4D3AT+jJ7lxHaREUAJCgVx6fKqRCBkC
         ClnxzFddy4RD3FRsaH2fBQwxx1/CfQFTCrlES7DPM4GTBMmHrhwhv5yejjHcOiCgEM1Z
         vArAcRemeaFs/qOGJk/Es392Vi77Gas1UlnVsnS+hx40AkQdOJEgYCcH06HcKdm1ZF4b
         g1Ag==
X-Gm-Message-State: AGi0PuYz0zUzJGoIEIzHWFlAs1kfOxMq17mB1a1Bogk35YQ3XEu5xju9
        O4kngxgGZu1LGvdUgg2JabRRT+w=
X-Google-Smtp-Source: APiQypIN7x474BTSx5XNa9RZW9WcGvmIkvA4In5cY3QG7AbDCZt9ElM/lzxg5ccexbNWUlxXVVHWkg==
X-Received: by 2002:aca:450a:: with SMTP id s10mr7885862oia.25.1587316095961;
        Sun, 19 Apr 2020 10:08:15 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:15 -0700 (PDT)
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
Subject: [PATCH 02/17] arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
Date:   Sun, 19 Apr 2020 12:07:55 -0500
Message-Id: <20200419170810.5738-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The VExpress power-off/reset driver is not needed on 64-bit platforms as
PSCI power-off and reset can be used instead. Stop selecting it so it
can be disabled and not always built-in.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cfe0f9e..9c084f995e0f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -278,7 +278,6 @@ config ARCH_VEXPRESS
 	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
-	select POWER_RESET_VEXPRESS
 	select VEXPRESS_CONFIG
 	help
 	  This enables support for the ARMv8 software model (Versatile
-- 
2.20.1

