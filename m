Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD76C1AFC62
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDSRI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44282 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRI1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id j4so5946312otr.11;
        Sun, 19 Apr 2020 10:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUrQRwWEdT3OPVCv5XBDcWtCr3A5NYwLye3iL8Rp6X4=;
        b=OTBp3TUSEeVJzjW5vDNb+FeINyDENfmZ3uuNXAeHk1il/cAq0C1zzEU3D7ulj8cmX7
         TaDM2Zn1ZSoRFC02dJGtJcVUi9QuAM22Vvhfrox4abuWAi6sjwWoCKR/y81EDeS8ER2L
         ho93CdjEaQo/F6WA210apsm37Hfl76q/SwZgA03EcGEfW4wkc5F7qC18JqVprcEIUjnS
         JIk1eWHcriI46/RsFQZuWsdMefb7lRUpYJhDIVGeQC07JsWqunoSp7NLiLNUnCuwHspF
         /0fuul9NpsRFr+7D/EHhq3fuDsPKquc0iv77DTqEIGktQJzsIuIArC2K4ydMsdBfA8fg
         dc1A==
X-Gm-Message-State: AGi0PuY+2uRReNZPoODOca3+YrZrOTdVRRMRN/dDUeJ+q1GjWbAEKd9X
        IrtDdndTEMvXa9bwaF+jzQ==
X-Google-Smtp-Source: APiQypJGWLbEPjS2dTyxElGSO1SQkhT/chgz+TKrJJLrrB7yeocLCbZGPucP0I6nicooOJm2R+O0CQ==
X-Received: by 2002:a9d:6ad0:: with SMTP id m16mr6268800otq.122.1587316106702;
        Sun, 19 Apr 2020 10:08:26 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:26 -0700 (PDT)
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
Subject: [PATCH 10/17] mfd: vexpress-sysreg: Drop unused syscon child devices
Date:   Sun, 19 Apr 2020 12:08:03 -0500
Message-Id: <20200419170810.5738-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/vexpress-sysreg.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 0b9cc67706c7..90a4eda2ba2b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -43,10 +43,6 @@
 
 /* The sysreg block is just a random collection of various functions... */
 
-static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
-	.label = "sys_id",
-};
-
 static struct bgpio_pdata vexpress_sysreg_sys_led_pdata = {
 	.label = "sys_led",
 	.base = -1,
@@ -65,24 +61,8 @@ static struct bgpio_pdata vexpress_sysreg_sys_flash_pdata = {
 	.ngpio = 1,
 };
 
-static struct syscon_platform_data vexpress_sysreg_sys_misc_pdata = {
-	.label = "sys_misc",
-};
-
-static struct syscon_platform_data vexpress_sysreg_sys_procid_pdata = {
-	.label = "sys_procid",
-};
-
 static struct mfd_cell vexpress_sysreg_cells[] = {
 	{
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_ID, 0x4),
-		},
-		.platform_data = &vexpress_sysreg_sys_id_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
-	}, {
 		.name = "basic-mmio-gpio",
 		.of_compatible = "arm,vexpress-sysreg,sys_led",
 		.num_resources = 1,
@@ -109,22 +89,6 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 		},
 		.platform_data = &vexpress_sysreg_sys_flash_pdata,
 		.pdata_size = sizeof(vexpress_sysreg_sys_flash_pdata),
-	}, {
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_MISC, 0x4),
-		},
-		.platform_data = &vexpress_sysreg_sys_misc_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_misc_pdata),
-	}, {
-		.name = "syscon",
-		.num_resources = 1,
-		.resources = (struct resource []) {
-			DEFINE_RES_MEM(SYS_PROCID0, 0x8),
-		},
-		.platform_data = &vexpress_sysreg_sys_procid_pdata,
-		.pdata_size = sizeof(vexpress_sysreg_sys_procid_pdata),
 	}, {
 		.name = "vexpress-syscfg",
 		.num_resources = 1,
-- 
2.20.1

