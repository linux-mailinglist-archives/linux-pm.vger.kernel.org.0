Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3492B7FCD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 15:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKROui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 09:50:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39370 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgKROui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 09:50:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIEoJSD112404;
        Wed, 18 Nov 2020 08:50:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605711019;
        bh=/WfMKfpfaqPhwhCkATAAiFh4DbZHut//34CHnfa7pU8=;
        h=From:To:CC:Subject:Date;
        b=ufkgw32S/4yo2MS7xBQe7neGZibn0mxh8sp5Siikv+ns+ta8Dp6HDAR7Nncpd2xd9
         1+3HXgQqWmGtZCXHlbz45JbHA4DsufHe9uChUxtMh59F9sQz9HgU6PWoXpG9rKB93I
         lHytBggqescJqQWtSv7oGuGB0rD+iDI+woCP8fEQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIEoJch055732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 08:50:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 08:50:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 08:50:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIEoJ9A113879;
        Wed, 18 Nov 2020 08:50:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <lkft-triage@lists.linaro.org>, <linux-pm@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] regulator: ti-abb: Fix array out of bound read access on the first transition
Date:   Wed, 18 Nov 2020 08:50:09 -0600
Message-ID: <20201118145009.10492-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At the start of driver initialization, we do not know what bias
setting the bootloader has configured the system for and we only know
for certain the very first time we do a transition.

However, since the initial value of the comparison index is -EINVAL,
this negative value results in an array out of bound access on the
very first transition.

Since we don't know what the setting is, we just set the bias
configuration as there is nothing to compare against. This prevents
the array out of bound access.

NOTE: Even though we could use a more relaxed check of "< 0" the only
valid values(ignoring cosmic ray induced bitflips) are -EINVAL, 0+.

Fixes: 40b1936efebd ("regulator: Introduce TI Adaptive Body Bias(ABB) on-chip LDO driver")
Link: https://lore.kernel.org/linux-mm/CA+G9fYuk4imvhyCN7D7T6PMDH6oNp6HDCRiTUKMQ6QXXjBa4ag@mail.gmail.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Mark,

I will leave it to your descretion if this needs to be tagged for
stable or to drop the Fixes tag - Side effect, if this occurs, will be
an unstable system very hard to track down - but typically occurring
during system boot - Impacts systems: DM3/OMAP3,4,5,DRA7/AM5x.

I would categorize this as "This could be a problem..." problem..
the bug is an out of bound read, and has been around since v3.11 and is
not a catastrophic data corruption kind of issue.

Though theoretically, there is a possibility that the compare may
pass and result in missing bias configuration(and resulting system
will be unstable), I have'nt heard of actual report (but, it will be
surprising if any actual instability was actually tracked down to this
bug). Any ways, I had to go to git full history to pick the exact
commit - I have left it in the patch.


Arnd,

I have left your reviewed-by from the thread, I can fixup
any further commit message comments if you may have.

drivers/regulator/ti-abb-regulator.c | 12 +++++++++++- 1 file changed,
11 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index 3e60bff76194..9f0a4d50cead 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -342,8 +342,17 @@ static int ti_abb_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
 		return ret;
 	}
 
-	/* If data is exactly the same, then just update index, no change */
 	info = &abb->info[sel];
+	/*
+	 * When Linux kernel is starting up, we are'nt sure of the
+	 * Bias configuration that bootloader has configured.
+	 * So, we get to know the actual setting the first time
+	 * we are asked to transition.
+	 */
+	if (abb->current_info_idx == -EINVAL)
+		goto just_set_abb;
+
+	/* If data is exactly the same, then just update index, no change */
 	oinfo = &abb->info[abb->current_info_idx];
 	if (!memcmp(info, oinfo, sizeof(*info))) {
 		dev_dbg(dev, "%s: Same data new idx=%d, old idx=%d\n", __func__,
@@ -351,6 +360,7 @@ static int ti_abb_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
 		goto out;
 	}
 
+just_set_abb:
 	ret = ti_abb_set_opp(rdev, abb, info);
 
 out:
-- 
2.29.2

