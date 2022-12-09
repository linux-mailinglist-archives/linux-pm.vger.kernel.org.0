Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E064854B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLIP1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0ED8F084
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxpkh2UJmrJk4UXuhFtQn8AHIQ6tGYc2nlLrue/w+QI=;
        b=M03YIxKVCC1bSpK5PLBlAHc0mMWmTlJYumMHyCvZsfpKMZlootzhGGfC6JoGrGjD5OGcAC
        FOhJZs/2VDNCix6lcv23UypgQnW/k394vmL9ZzWKaDth7TdKK0IdPioKzCM860+UcMt+5V
        bFPEkHGTWulKMVZCujuMHLRr8+xgsfqgo5NKKW3IpMaJEv2HWXswkwIzRjt+PYeoTyl+uf
        SSTHDIMaZrpqawxropodkVjdxGlI9hMO71lLSASlLk1Eg0uf41dCIOJwgsHUFLs1rHgtCy
        ZioqxB+6Z23uj/MVZqhnRLkYvoSLPwGkRa9NtSO0KbRZxHrEQQIDKvgwConAUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxpkh2UJmrJk4UXuhFtQn8AHIQ6tGYc2nlLrue/w+QI=;
        b=qxhhx+usVS/PEhefeYFqRFmZn/Q+Kl1VeydliOI+b94dP+CdC1OnbI6siyjGj0xrQOIh4p
        oKnKJuusKx4mdGAg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_gen3: Use the generic
 function to get the number of trips
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        niklas.soderlund+renesas@ragnatech.se, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-16-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-16-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959426.4906.15902484802673936998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     237ee9f6006e793b28e841e08152abfb00ffb33f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//237ee9f6006e793b28e841e08152abfb00ffb33f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/drivers/rcar_gen3: Use the generic function to get the number of trips

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20221003092602.1323944-16-daniel.lezcano@lina=
ro.org
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 4c1c6f8..4ef9274 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -529,7 +529,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		if (ret)
 			goto error_unregister;
=20
-		ret =3D of_thermal_get_ntrips(tsc->zone);
+		ret =3D thermal_zone_get_num_trips(tsc->zone);
 		if (ret < 0)
 			goto error_unregister;
=20
