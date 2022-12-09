Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125C648520
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLIP0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiLIP0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DED8F09A
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1z2+QNf23fmRo4F2+lntxzpo4/nggAvlPMEGZCBcO0=;
        b=I6FJS+3c7iMd4Z0FHPJx8VTj4ocvBtonqIfnm9AuSelan+7EnFAbFcx+cLMUcUsDaj9hqD
        C+/efsIjJu7l8nNfiHq9+vJr6lCSDyd0F598NfLg2RIaOdo74gO+4ckZbB1K+usMRSGXzY
        SAdR4FVEbF52UBDrh5eISpUZCDrheGEqv95WVCaCuqASqv0c15Abw9MxyfJsuBw0onNbTc
        wugV2xfyy89CXnuKj4FXg8BP4R8QgHMv21apprMoZPQqq78SBZkzF28Rl4t9mdZfDHpj2d
        wsbHTJoI25pd2avHcKE18kk0LQpn5TtPwCQA1cAdQwN0+sJw00dXa+NPRut12g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1z2+QNf23fmRo4F2+lntxzpo4/nggAvlPMEGZCBcO0=;
        b=/+I11SXG0LMED1mf6ZC5pzsOduE5bKpIE68iKBonxqW5OWpVXYLj2mgs252LruhXM6Ucck
        UpOAZoeL5vsLmLBw==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/k3_j72xx_bandgap: Use bool
 for i2128 erratum flag
Cc:     Bryan Brattlof <bb@ti.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-3-bb@ti.com>
References: <20221031232702.10339-3-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958719.4906.9205514028877667500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     41a0c31149fad89fd725dd57090d65b3036a6062
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//41a0c31149fad89fd725dd57090d65b3036a6062
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:53 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/k3_j72xx_bandgap: Use bool for i2128 erratum flag

Some of TI's J721E SoCs require a software trimming method to report
temperatures accurately. Currently we are using a few different data
types to indicate when we should apply the erratum.

Change the 'workaround_needed' variable's data type to a bool to align
with how we are using this variable currently.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20221031232702.10339-3-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/k3_j72xx_bandgap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index a9f99a1..b9d2002 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -340,7 +340,7 @@ static void print_look_up_table(struct device *dev, int *ref_table)
 }
 
 struct k3_j72xx_bandgap_data {
-	unsigned int has_errata_i2128;
+	const bool has_errata_i2128;
 };
 
 static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
@@ -351,7 +351,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct k3_j72xx_bandgap *bgp;
 	struct k3_thermal_data *data;
-	int workaround_needed = 0;
+	bool workaround_needed = false;
 	const struct k3_j72xx_bandgap_data *driver_data;
 	struct thermal_zone_device *ti_thermal;
 	int *ref_table;
@@ -522,11 +522,11 @@ static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
 }
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
-	.has_errata_i2128 = 1,
+	.has_errata_i2128 = true,
 };
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j7200_data = {
-	.has_errata_i2128 = 0,
+	.has_errata_i2128 = false,
 };
 
 static const struct of_device_id of_k3_j72xx_bandgap_match[] = {
