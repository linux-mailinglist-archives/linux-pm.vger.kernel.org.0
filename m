Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DD2D7649
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436592AbgLKNK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436593AbgLKNJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:46 -0500
Date:   Fri, 11 Dec 2020 13:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ENzvf1Co5c/VBCGiVedyWAVyPqSQdzu+iY5e3wWwo0=;
        b=u3p/8EztSlkRT9jnlvkD4Yo+8P4q+z2jr7OrHlSBhMC4UxY+kUUydtAxHTlb7c887R3bUz
        Sh+Zpj4mShrN7SeOyfk850VkOtnJEWdcct2eAv6CyGIEgaL6sVkZoDxvbQGiISHzwh5chi
        YdAvcLVlp7JsVsuFcqXq1Qg7iKhQagkRtM8j5W2h4Bl/sDCDc8bSJAOIDZfK5g6+Pccz8J
        hGtjjb1POMfYMDwkp4PqUykFRWm+dvLWyQLGyETSWNn1DdeDj7ox4swXwjiC+vo0vO85lC
        7EtWcQjIJyLifoN+1TcrJA1RHgWV4DnWrjAtA7PcSqp5tKBpao+JWk5zPDA9Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ENzvf1Co5c/VBCGiVedyWAVyPqSQdzu+iY5e3wWwo0=;
        b=+kbg4uFirHoH86tuJLxpm9f7VXIEDC28nRq01WcUyjHuFmZDYf4aRsPFHbEx5eOFMD8aPK
        +yCsvnQm6738H+AA==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: rcar_gen3_thermal: Add r8a779a0 support
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126223028.3119044-4-niklas.soderlund+renesas@ragnatech.se>
References: <20201126223028.3119044-4-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <160769214302.3364.2724296070601075355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e854da4f51117d7340ec621face92e775bcd4d22
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e854da4f51117d7340ec621face92e775bcd4d22
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Thu, 26 Nov 2020 23:30:28 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Dec 2020 21:18:01 +01:00

thermal: rcar_gen3_thermal: Add r8a779a0 support

Add support for R-Car V3U. The new THCODE values are taken from the
example in the datasheet.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126223028.3119044-4-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 94f2c13..75c69fe 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -60,13 +60,14 @@
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
=20
-#define TSC_MAX_NUM	3
+#define TSC_MAX_NUM	4
=20
 /* default THCODE values if FUSEs are missing */
 static const int thcodes[TSC_MAX_NUM][3] =3D {
 	{ 3397, 2800, 2221 },
 	{ 3393, 2795, 2216 },
 	{ 3389, 2805, 2237 },
+	{ 3415, 2694, 2195 },
 };
=20
 /* Structure for thermal temperature calculation */
@@ -276,6 +277,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_id=
s[] =3D {
 		.compatible =3D "renesas,r8a77980-thermal",
 		.data =3D &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible =3D "renesas,r8a779a0-thermal",
+		.data =3D &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
