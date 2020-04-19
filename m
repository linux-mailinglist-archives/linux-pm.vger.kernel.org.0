Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2118D1AFC54
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDSRIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43637 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDSRIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14so5954670otg.10;
        Sun, 19 Apr 2020 10:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4W1MOddjCCw9dJQYLiEdJO8bx77R5HtOxEd/Z5DPRs=;
        b=dG+WO6E7anSCss5mEEnTN7NJVeuVofNwCgYn7tNI+xTsFZKzZR/CT5OIh/LbAR3nx2
         /mEA+U5/x4CSfTLi++D6jojfO3nGVZXZ+Q/lKTAve38RF2mQPb/q9Nk4JjbMXPP/aEJz
         aQ9BkVD+8Rq9Bjuw2MKBIWEpvdXS4GgV8sBx9MpyYBoOrX70Sb3ZfPZUmhkXqRBZRg+p
         8KO2l+O8cbGppYhbYXhy7DktE3xhVbEfwZAEQcqe3stYNpr7UjPoRUQBHjfHBWydh129
         oASC//RA/0vUFW/n1g3lM6cX5ASMQg0SP3GEA975cFWrDq6PSKIK5s2uocBVPz7cLPxP
         KirQ==
X-Gm-Message-State: AGi0Puaspczsl0XQ0IygxACza2ng7uCUyFzzkGpMn5M3cUEfd8i8Iy8d
        OcpLejX5wcUfbAwUqmY5vw==
X-Google-Smtp-Source: APiQypK0fJJhWegtefihZ3xqlHSSIU1Y4BN4GM5zgOcJ5aHxuge40tlIXHFeRHdB9gUqefM8BlqeQw==
X-Received: by 2002:a9d:423:: with SMTP id 32mr6922257otc.334.1587316097257;
        Sun, 19 Apr 2020 10:08:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:16 -0700 (PDT)
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
Subject: [PATCH 03/17] arm64: vexpress: Don't select CONFIG_VEXPRESS_CONFIG
Date:   Sun, 19 Apr 2020 12:07:56 -0500
Message-Id: <20200419170810.5738-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_VEXPRESS_CONFIG has 'default y if ARCH_VEXPRESS', so selecting is
unnecessary. It also prevents setting CONFIG_VEXPRESS_CONFIG to a module.

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
index 9c084f995e0f..5c38dc56b808 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -278,7 +278,6 @@ config ARCH_VEXPRESS
 	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
-	select VEXPRESS_CONFIG
 	help
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
-- 
2.20.1

