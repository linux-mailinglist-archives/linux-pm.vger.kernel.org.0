Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E91BE94F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD2U6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41114 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id 19so3121315oiy.8;
        Wed, 29 Apr 2020 13:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qg2zxc590nC56Olu/LMLIdebNTiQLSp6hgsD/Wgzqhc=;
        b=jGCOmzGqVtaMZ+AgL4r4UTSJEoMJEHCOHSLCsqRpCIlbrddNLAfMmSTlVbtKqqcHLl
         GCPzv1dycCZAezM/Yqcu3PQUCHxxoC7r+C0Qg1Ly53zy84WQgZw4d1d646LzZ4KTaJOu
         FX3j4TKg8VOUWbeXy8lpTHwSYyvdQ57a1wkw78KZBXJUAUt2dKcciNrlHbknh+3vweUa
         inANULWtepxULwIi7IyQiXzfjcbLqu81L5KYo+PN7K1HuL3T85icvvO5dw2QVJLpNpYz
         UjVrPoouOm25XLTdR9FD4ybALUOKaDoUoL0iUzzb1QYgqZOgH7DbKA5u5WV3OXqd8+/2
         WLfQ==
X-Gm-Message-State: AGi0PuajgC+iTW02vZ3Nju4nTeOyT21YIiYbGLhNxPDgh12DMgOIdhuQ
        ToJ8UMCu+OH9cLKsPj7q0w==
X-Google-Smtp-Source: APiQypLrWJY7pYSRXhfCSOB9FxS2TVlt5Ok67NnxttN2E8ckgZPz2Ph897iAX8kOYgBQBWEzEAcFZw==
X-Received: by 2002:a54:4619:: with SMTP id p25mr128029oip.122.1588193918475;
        Wed, 29 Apr 2020 13:58:38 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:37 -0700 (PDT)
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
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v2 07/16] clk: vexpress-osc: Support building as a module
Date:   Wed, 29 Apr 2020 15:58:16 -0500
Message-Id: <20200429205825.10604-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable building the vexpress-osc clock driver as a module.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/clk-vexpress-osc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 5bb1d5a714d0..b2b32fa2d7c3 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -7,6 +7,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -108,6 +109,7 @@ static const struct of_device_id vexpress_osc_of_match[] = {
 	{ .compatible = "arm,vexpress-osc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, vexpress_osc_of_match);
 
 static struct platform_driver vexpress_osc_driver = {
 	.driver	= {
@@ -116,9 +118,5 @@ static struct platform_driver vexpress_osc_driver = {
 	},
 	.probe = vexpress_osc_probe,
 };
-
-static int __init vexpress_osc_init(void)
-{
-	return platform_driver_register(&vexpress_osc_driver);
-}
-core_initcall(vexpress_osc_init);
+module_platform_driver(vexpress_osc_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

