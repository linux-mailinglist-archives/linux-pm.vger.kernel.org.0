Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4458434B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiG1Plq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiG1Plq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674E68DF0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:45 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z14idYguFTkXArVRsUzULRTJMUFCOLsLk1Z2bdf04tg=;
        b=fBjSh/3YZX2nr8g8SfHrxFi4bm+TjvASRTRWQrJ8o7ovhGNiJz3e56l/NedveG/ji41igt
        vi04J94qU7o95RE5rId2y0uA9YXT6fKlZJi/hZgGa+EIa9U/vN8yKyVr/xTYO4v1YJr4Zk
        ONeRYDONGGBts4U7pm2p1Vb21Ua5RLuRHuQ0qV8RfEGC75N/l2EXTWzNn37RE8EgNtHsnp
        lmzmGS/WL5qy8Yz+Xa1tUPD0NMr3onynAli3v14cNDQdr3x2SOPb7lTIYf9NrrJAFUVEid
        3aOLFZZgKONMbOtbPi0mLb0/EFOdlBfuhEW1q0xN0mrxxnuMC6Lg2qkHWmR9Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z14idYguFTkXArVRsUzULRTJMUFCOLsLk1Z2bdf04tg=;
        b=6FVwjPk4GvT8SkHuniR2hEqLXwMtXJSDQBfvoeOH11Na59SsTmQicZRiqx/U4BE6Bvuap5
        axtGz1g9RfIGISCw==
From:   "thermal-bot for Jason Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/ti-soc-thermal: Fix comment typo
Cc:     Jason Wang <wangborong@cdjrlc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220715051829.30927-1-wangborong@cdjrlc.com>
References: <20220715051829.30927-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <165902290304.15455.5419268814085809922.tip-bot2@tip-bot2>
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

Commit-ID:     8b74a003a94134c791fb9bb3d474d1bce6a05b2d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8b74a003a94134c791fb9bb3d474d1bce6a05b2d
Author:        Jason Wang <wangborong@cdjrlc.com>
AuthorDate:    Fri, 15 Jul 2022 13:18:29 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:51 +02:00

thermal/ti-soc-thermal: Fix comment typo

The double `and' is duplicated in line 229, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Link: https://lore.kernel.org/r/20220715051829.30927-1-wangborong@cdjrlc.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ea0603b..67050a1 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -226,7 +226,7 @@ static irqreturn_t ti_bandgap_talert_irq_handler(int irq, void *data)
 		/*
 		 * One TALERT interrupt: Two sources
 		 * If the interrupt is due to t_hot then mask t_hot and
-		 * and unmask t_cold else mask t_cold and unmask t_hot
+		 * unmask t_cold else mask t_cold and unmask t_hot
 		 */
 		if (t_hot) {
 			ctrl &= ~tsr->mask_hot_mask;
