Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60E1AFC5A
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDSRIY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41521 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so5953476otp.8;
        Sun, 19 Apr 2020 10:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qR3APrxTNCGqJRTKnyGqCjhSnTFRpHkLD/ZqBvxeFJA=;
        b=HufbYbquHdoFv8LncRJ9dohMGRDUePppp2/s0w9TQhq/7U18i0w0cz6k5WsSmr8acb
         Kj41vMzsGcHH0ci3T4PcPwAfZV4g4C4na9qzDyBqQkdoZATD9LUHLN+rRRPCFSWzZ6i8
         N78/6BJ2cgTHyYrGcmDXV1T7mumxIZhD2rLn5Qu8XshNLGGM2nAMtYVGBMibVESVbWOJ
         ow5OcqYn/7jhUf//i0F4B30aGv+tzzpLWmIpjXt6dbQ9IP1UYhFM0O33VmnuuHUCYL7a
         2zL1IBGCjQyYQ44J+3d6pmIbJgWwp+o2SRq1vypAPLCvbXDGV+NBz4MWpwUzA/P1oXQS
         Vnfg==
X-Gm-Message-State: AGi0PuYwQYO1B3+KCpbefSTUOyoA99VjIQ/nIirpWQPJY5q8qy5E5C3s
        Znl6chlKPhWedXx2ElfZcA==
X-Google-Smtp-Source: APiQypJRBqdugWx8PeDgR8OJglN2KN7qjTUoljyMmF8u89tlJuk3/msimvMwYF6xrm67UkXj9aqsmw==
X-Received: by 2002:a9d:805:: with SMTP id 5mr6859221oty.111.1587316102393;
        Sun, 19 Apr 2020 10:08:22 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:21 -0700 (PDT)
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
Subject: [PATCH 07/17] clk: vexpress-osc: Use the devres clock API variants
Date:   Sun, 19 Apr 2020 12:08:00 -0500
Message-Id: <20200419170810.5738-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation to enable the vexpress-osc clock driver as a module,
convert the driver to use the managed devres clock API variants. With
this, a driver .remove() hook is not needed.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/clk-vexpress-osc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 7ade146a3ea9..5bb1d5a714d0 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -65,8 +65,8 @@ static int vexpress_osc_probe(struct platform_device *pdev)
 {
 	struct clk_init_data init;
 	struct vexpress_osc *osc;
-	struct clk *clk;
 	u32 range[2];
+	int ret;
 
 	osc = devm_kzalloc(&pdev->dev, sizeof(*osc), GFP_KERNEL);
 	if (!osc)
@@ -92,11 +92,11 @@ static int vexpress_osc_probe(struct platform_device *pdev)
 
 	osc->hw.init = &init;
 
-	clk = clk_register(NULL, &osc->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = devm_clk_hw_register(&pdev->dev, &osc->hw);
+	if (ret < 0)
+		return ret;
 
-	of_clk_add_provider(pdev->dev.of_node, of_clk_src_simple_get, clk);
+	devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get, &osc->hw);
 	clk_hw_set_rate_range(&osc->hw, osc->rate_min, osc->rate_max);
 
 	dev_dbg(&pdev->dev, "Registered clock '%s'\n", init.name);
-- 
2.20.1

