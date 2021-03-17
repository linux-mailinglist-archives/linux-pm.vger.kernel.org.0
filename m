Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B833F091
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCQMjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCQMjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B0C06175F
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 05:39:15 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:39:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ER31mdDmvwmDD86d8hmFAkWPInNHwwcn57KtAA5oS1M=;
        b=YPlgS0dxq/Hw+psydxs1NRLE+jBrC/eXX3rdVDZXhiD/GKjP98k9GQ7BevuXh9JeOGsiee
        RdG11Fl+/eRuxV9U9fNtSo4tLnTX4GqzKn9aPd55PM14LrV1ZIAgFJcMhkBKDuYbR14jqb
        jK9KypVDhjl1TVvaPpt5WIbCvu18QX4i7snGaIwVR5qTou8QO2NizLvxcGU1JHFR6snnms
        izKL6MN0QOU3BGt2HCL8gZMxl6TVcl5HyBdZ2/a7THFNBZ3Q9wIIzICwDeWkk+At6tuYwM
        /7TLQYPZxWVTMfm6TQV56nHi+Yey0GINFi7IvY7DrelLU3dvbD5MYAkafhu+6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ER31mdDmvwmDD86d8hmFAkWPInNHwwcn57KtAA5oS1M=;
        b=uAgf4QcFzs+accl9DmYxXLh+cgJTFDqVf8+Qwcijj0p4torx7+tDYTEWju3fBoh03nvFUG
        jGitglOkLON/UrAw==
From:   thermal-bot for Niklas =?utf-8?q?S=C3=B6derlund?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: rcar_gen3_thermal: Add support for
 up to five TSC nodes
Cc:     niklas.soderlund+renesas@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
References: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Message-ID: <161598475318.398.9310711148419281636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7fd49ca05be35a85c424a3ca8df931bd70c34535
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//7fd49ca05be35a85c424a3ca8df931bd70c34535
Author:        Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
AuthorDate:    Tue, 09 Mar 2021 17:24:19 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 12:58:28 +01:00

thermal: rcar_gen3_thermal: Add support for up to five TSC nodes

Add support for up to five TSC nodes. The new THCODE values are taken
from the example in the datasheet.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210309162419.2621359-1-niklas.soderlund+ren=
esas@ragnatech.se
---
 drivers/thermal/rcar_gen3_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 75c69fe..e1e4123 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -60,7 +60,7 @@
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
=20
-#define TSC_MAX_NUM	4
+#define TSC_MAX_NUM	5
=20
 /* default THCODE values if FUSEs are missing */
 static const int thcodes[TSC_MAX_NUM][3] =3D {
@@ -68,6 +68,7 @@ static const int thcodes[TSC_MAX_NUM][3] =3D {
 	{ 3393, 2795, 2216 },
 	{ 3389, 2805, 2237 },
 	{ 3415, 2694, 2195 },
+	{ 3356, 2724, 2244 },
 };
=20
 /* Structure for thermal temperature calculation */
