Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5819E1BE94D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD2U6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46313 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id q204so3107167oia.13;
        Wed, 29 Apr 2020 13:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoRdXSXyDk/x1mGGqjsqWksS6mCyDXiHkJ0dVC6MTqs=;
        b=XEWib+bhJcgyXc/k32lnfr6E56uNc6lED+lKW4cz7BsCEBFpMlGwW6B0eFc/bFDCni
         w7X7R5e0rO33RKfrf6U69sYKprNxfjWdfAkf7VydxX5HK8k/Ze9QPgXfc4PWra0RvUIo
         a1g/utf5pzrH3FgZjEjJGmXmybaNT79g97LaG6hcPmeFHRti6KVpJxwqk2eEMeXJjjun
         ZcQyQ9q9dyXiG2EcM7IiqzC/VE/lVzX2ruD7npJqsAXNUkvSmwlA2ixOu0fldnGaQZK/
         srMnZK6wo0pQA+BvzqNlck4PwgFNkR5DLtB1OmX8xNl0gDf7ycJDxxweKUi4/5qkQkh4
         8UZA==
X-Gm-Message-State: AGi0PuZ6evyJBvCLj+Ad+S51GOZm70QrWwj9r5PWBX2wcgwrcJ0XtUjZ
        qCyPc10sAygXEPFsWOO8YQ==
X-Google-Smtp-Source: APiQypLdCoQOqyhUOrgVpALW16PrMgDTQhtSkj/rPf8nCMNL3vEltambBtSQoCpAq6uy/8hcmIv3FA==
X-Received: by 2002:a54:4801:: with SMTP id j1mr108023oij.101.1588193916924;
        Wed, 29 Apr 2020 13:58:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:36 -0700 (PDT)
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
Subject: [PATCH v2 06/16] clk: vexpress-osc: Use the devres clock API variants
Date:   Wed, 29 Apr 2020 15:58:15 -0500
Message-Id: <20200429205825.10604-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation to enable the vexpress-osc clock driver as a module,
convert the driver to use the managed devres clock API variants. With
this, a driver .remove() hook is not needed.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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

