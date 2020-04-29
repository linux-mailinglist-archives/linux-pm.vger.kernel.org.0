Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2A1BE945
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD2U6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:33 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38924 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgD2U6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:33 -0400
Received: by mail-oo1-f68.google.com with SMTP id c83so760679oob.6;
        Wed, 29 Apr 2020 13:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GEo8L05GfOsrETFUSYjrPBx8MpWGlvpLKnzBBG4Zk0=;
        b=NHT1hSFzTf2Xbv2L98Ig2TnilEqkKmvBe79VQFkb9+nONNfTK8Je6tgB9DSLDoM/hO
         v0QkkGUGNbF5QWGOflRFd4dTUB9bRdklUTsSZx3EevCLfeNcMwRugqR7jha6qga044sY
         eWQhQK8a9BbsGwX/vfBOweMrrju1iy0oOVjKUT6cvAFtXcy3sLajo5HP6zkOetFsaaKc
         jgoXOyE8UbTolmUuJXFbbXS9HBVoGXOZZrxsXoxJIEsJM+RvbbbRSG+SxSn541EAEcRQ
         1PmkiV1RYy2zMm3HA6mERm3HuPQcFmIvoonBentMBpIw2gUSrQI+JP5x9RyAtL+LSZrK
         dWZQ==
X-Gm-Message-State: AGi0PuYhRnAjrcX0qgSvWgy8MBcRewcGDP8Tm/934e157Y0XOFOxfhct
        O2tbylkEqtk/z3J3AVK8ow==
X-Google-Smtp-Source: APiQypKiIIo1iL3b/WKj8zsWqGEh+qK+DtjFWH1bOfzxAP684pSi5OWlTJPWn1gRh6hDHj5NzKd/5w==
X-Received: by 2002:a4a:621d:: with SMTP id x29mr11304095ooc.92.1588193911048;
        Wed, 29 Apr 2020 13:58:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:30 -0700 (PDT)
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
Subject: [PATCH v2 02/16] arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
Date:   Wed, 29 Apr 2020 15:58:11 -0500
Message-Id: <20200429205825.10604-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The VExpress power-off/reset driver is not needed on 64-bit platforms as
PSCI power-off and reset can be used instead. Stop selecting it so it
can be disabled and not always built-in.

CONFIG_VEXPRESS_CONFIG can also be dropped as it was a dependency for
CONFIG_POWER_RESET_VEXPRESS.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
  - squash dropping CONFIG_VEXPRESS_CONFIG select into this patch
---
 arch/arm64/Kconfig.platforms | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cfe0f9e..5c38dc56b808 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -278,8 +278,6 @@ config ARCH_VEXPRESS
 	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
-	select POWER_RESET_VEXPRESS
-	select VEXPRESS_CONFIG
 	help
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
-- 
2.20.1

