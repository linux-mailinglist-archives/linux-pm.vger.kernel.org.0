Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27158435C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiG1PmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiG1PmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09968DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:01 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ11RQURvQ+Agip/Q8/1jNVfJFietfyYULJKV+Ffa/4=;
        b=0Z8D7TzN4i4gnsUiQ8NswiLtfroyXEczIDcW6KeGvHPWafM9vBRY5gLZT9DuGQrrwavH1z
        4GOTSm9qliqd5C7hU+cXMVOXS/hPGdBBIZStOy5I7Xig0AY+RQc2HhQoi3nF78sBRQ4Qv9
        x10SjWS1ef2qjiPDV5DLa6RLp0WydsUD4qaS/SWLnKy3ck//rt1vBkQ8fjre87w2wayDbv
        gLBeNHAFBHFQdwC3irkgFWFby/e3iYMYCz06wokD2hgOoVI9xUQ1MYQ6qbBGWoBM7B+RiS
        Tjut8xy+KloWQUKt2I+E9sOvwOOOU3u2iIX0kGSt9nxx82IA3sOiqPiYRV2sCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ11RQURvQ+Agip/Q8/1jNVfJFietfyYULJKV+Ffa/4=;
        b=e+l/hUkHRAwmCVygCMyu7tNiMCvBLx6QsyiOidM8lRxWuYeeFhDolhPA7XOqvgolYwbmaf
        fz/8NTT5G2GCv6Ag==
From:   "thermal-bot for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/rcar_gen3_thermal: Improve
 logging during probe
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220610200500.6727-1-wsa+renesas@sang-engineering.com>
References: <20220610200500.6727-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165902291926.15455.9349901822229270872.tip-bot2@tip-bot2>
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

Commit-ID:     404dd7dfb13028d315514f63ed3cf9da46307a39
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//404dd7dfb13028d315514f63ed3cf9da46307a39
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Fri, 10 Jun 2022 22:04:59 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:44 +02:00

drivers/thermal/rcar_gen3_thermal: Improve logging during probe

When setting up a new board, a plain "Can't register thermal zone"
didn't help me much because the thermal zones in DT were all fine. I
just had a sensor entry too much in the parent TSC node. Reword the
failure/success messages to contain the sensor number to make it easier
to understand which sensor is affected. Example output now:

rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 trip points
rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 trip points
rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 1 trip points
rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20220610200500.6727-1-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 43eb25b..e2020c6 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -507,7 +507,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
-			dev_err(dev, "Can't register thermal zone\n");
+			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret =3D PTR_ERR(zone);
 			goto error_unregister;
 		}
@@ -529,7 +529,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		if (ret < 0)
 			goto error_unregister;
=20
-		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
+		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
 	}
=20
 	if (!priv->num_tscs) {
