Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4094C3AE66B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhFUJtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFUJtG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:06 -0400
Date:   Mon, 21 Jun 2021 09:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNvyRCodp4v8IT1QL2PWhc0vr07nnZK8qgyitjDE4aw=;
        b=i4DPdu3iUOlxD0ni9qo0cZLvmYdB2vkTXOmQ3+cZMqMLj8mDpBVLrwpIhs0Tl5vIcjPrLo
        0KjOkHIVmzJ17FcoN39nu/05Ct/ya5qxD86OhwwdW4TpVDsA4xjeWNWyJsIALIUlgowe9U
        9XMA+wjc+dqczGIaEpVfZVr9RC3pTSi6lKYkWDsa/mRy2o+HpsOZm7l1jMWRfIBafCqjKk
        4KfFLoS4tWWoo9QlSCA6eQKjQPZFbZrzOqI88+UvJZOXzZr/okJAM5sRK+IzZxnFlL1A89
        C2EOyp5WgdB3okAEfFJvCRK1a8xJJvbxx3ddRQyrWezxAiA11XKLU1oXtp0yVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268807;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNvyRCodp4v8IT1QL2PWhc0vr07nnZK8qgyitjDE4aw=;
        b=KZrWMm33n1wwsxlFyY6EQrGBuvre0GwXsOjzmz6xBTOXXgVSSoBiJBSpSWonOsYSKKy4Ir
        81CGkGKqzs+8EhCg==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_gen3_thermal: Fix
 coefficient calculations
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <162426880669.395.3531147058445640547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8946187ab57ffd02088e50256c73dd31f49db06d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//8946187ab57ffd02088e50256c73dd31f49db06d
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Sat, 05 Jun 2021 10:52:11 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jun 2021 19:02:55 +02:00

thermal/drivers/rcar_gen3_thermal: Fix coefficient calculations

The fixed value of 157 used in the calculations are only correct for
M3-W, on other Gen3 SoC it should be 167. The constant can be derived
correctly from the static TJ_3 constant and the SoC specific TJ_1 value.
Update the calculation be correct on all Gen3 SoCs.

Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of Tj_1")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210605085211.564909-1-niklas.soderlund+rene=
sas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index e1e4123..1a60adb 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -143,7 +143,7 @@ static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3=
_thermal_tsc *tsc,
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * 157)
+	tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * (ths_tj_1 - TJ_3))
 		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
=20
 	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
