Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020E9405999
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhIIOsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbhIIOrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45315C0560C6
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:44 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4obyFFF9L4Kj9w7gObbJKGCJBXxZm+sliNd4+ARafe8=;
        b=ku9S/NgkN5WVJJd8tSsjACofxKPb7/t/CnBan5i6pePjQSoo8lzVFb3pGTwnVd3oXKCcGa
        VSwqtSoEChY/BwVkltO3GVHRoyoS8pi61AW/VkMbW+1Cx0ux+3oqgADnteoY0jGEWrm3YE
        EWHAht+8LDwMZxzqx7SMzr1Bu5fbJOJXBwGOsiEaxetNkuRUb4SidwCx2M71cOugro8yD2
        g6wd5NAauLFcnPzGNukReJZ79OxaCZdNvi1Bsg1S52GlBfTJzqbgjNAVshtsaNeWtfkFdF
        O6MFULYAVxTpBlOSnLpKmkqNSetzKBs72sbVoE0nOYZsK952lXeSseq8Y87iAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4obyFFF9L4Kj9w7gObbJKGCJBXxZm+sliNd4+ARafe8=;
        b=luN2BLc86WG6ge1ekaCfze4CznPqbZ8LnVmsk/8GjZWLyxpPFbKqoPWhCZVDXwqnzM8lfv
        zpUndFtpA60vvwAA==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_gen3_thermal: Store TSC
 id as unsigned int
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210804091818.2196806-3-niklas.soderlund+renesas@ragnatech.se>
References: <20210804091818.2196806-3-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <163119832209.25758.16554147476099125198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d3a2328e741bf6e9e6bda750e0a63832fa365a74
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//d3a2328e741bf6e9e6bda750e0a63832fa365a74
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Wed, 04 Aug 2021 11:18:18 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:49:05 +02:00

thermal/drivers/rcar_gen3_thermal: Store TSC id as unsigned int

The TSC id and number of TSC ids should be stored as unsigned int as
they can't be negative. Fix the datatype of the loop counter 'i' and
rcar_gen3_thermal_tsc.id to reflect this.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210804091818.2196806-3-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index e495934..85228d3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -84,7 +84,7 @@ struct rcar_gen3_thermal_tsc {
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
 	int tj_t;
-	int id; /* thermal channel id */
+	unsigned int id; /* thermal channel id */
 };
=20
 struct rcar_gen3_thermal_priv {
@@ -398,7 +398,8 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 	const int *ths_tj_1 =3D of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
-	int ret, i;
+	unsigned int i;
+	int ret;
=20
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
@@ -467,7 +468,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		if (ret < 0)
 			goto error_unregister;
=20
-		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+		dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
 	}
=20
 	priv->num_tscs =3D i;
