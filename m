Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1512E317
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 07:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgABGgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 01:36:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60603 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727599AbgABGgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 01:36:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 453FC22243;
        Thu,  2 Jan 2020 01:36:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=zxPdAkBputxnF
        mY5pVDOtjLOR8UJ/5300HQ4rXzRbxo=; b=itbbQleIjC1yzOo16qRh0AnAfa9PP
        xH9CvXXhakO1/iIY+PdhRAdJhsuLxoPgU3jiCqHHi7Y/oMbnq100cT6j1/Lv6EUZ
        CPKXmm5rpiRSrD9BF8AnINwR9CLhV2W73i692BBZGMg8dV6q273R3hhb8Nb6M6+i
        PQssMIoEjbPCeA8FSag30GC+H4KxG7w2TPYyhSqw+7xitF79FbYGwKhNfyYA2eDR
        9IGJsTxN15/MFplge0V9GJj5+jlZ1P792S1cRozex+NfPPI9/ZF8Xt+QEqUe0dZg
        rSKgvqP0JoyLUS4YmS8EnktSB+obGlhKfe++PLqmW+i60ffQPYlC2nzgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=zxPdAkBputxnFmY5pVDOtjLOR8UJ/5300HQ4rXzRbxo=; b=Coku/YPW
        PcC/nqmMvas+nc+2UKx2sRy2pSymoikmrWJajPn4x9mJJ5wLIZT3zDUF4aOjIAIM
        rpOnShcy779UbjsvHLnWV6waBsWXZ9f5Lc1LAoZHZOS4dYq4fN3wSfZ5wIaxZ7d2
        N3d5xKHTMfjnz+9J4R3AJSDV6kI6Zl0UyzSCEMb5LpxMQqkCGPPqlDWgCaX3Zv5q
        ygJRK7Se/+N1joMK2g1BZqQ979O7IY599G8OsUDuXy9gUeVV6/buu6GbyD//gO+i
        uJOM5qc87LE7QBUWUwYbGhffv535BuL1DJkTyokwkuYd5rBo8QU0JaAWx55KO5N5
        XeZdJtgbkQPjvw==
X-ME-Sender: <xms:dY8NXt_yvePXxtX7hrbQrrCbGgwz7SFDD0cts1zwErMfUIjWOaupmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:dY8NXiI2Uxve7un1f5PUIbPW2R7eYp0NE7_fLCSpOru9L8uYMBKYhw>
    <xmx:dY8NXqwITCmuxGl6ZWDqJ0HRrOzhMys81ASxqa5nRN-gNGjh68kXKw>
    <xmx:dY8NXt0ITGIH44c5T30SfdN_UG08h4eVrhu0I77Mhnrh2xJHIk1p0g>
    <xmx:dY8NXk4tMozwV4hDLIGXFShmVN5wITz4gJVGHLu9mqdDPB38rlfQ_A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5DF08005B;
        Thu,  2 Jan 2020 01:36:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/7] power: supply: axp20x_usb_power: Only poll while offline
Date:   Thu,  2 Jan 2020 00:36:33 -0600
Message-Id: <20200102063633.65388-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Investigation on the AXP803 shows that VBUS_PLUGIN/VBUS_REMOVAL IRQs are
triggered on the rising/falling edge of AXP20X_PWR_STATUS_VBUS_USED. The
reason IRQs do not arrive while N_VBUSEN/DRIVEVBUS is high is because
AXP20X_PWR_STATUS_VBUS_USED also never goes high.

This also means that if VBUS is online, a VBUS_REMOVAL IRQ is received
immediately on setting N_VBUSEN/DRIVEVBUS high (and VBUS_PLUGIN shortly
after it is set back low). This was also verified to be the case when
manually offlining VBUS through AXP20X_VBUS_PATH_SELECT.

Therefore, as long as VBUS is online, a present->absent transition
necessarily implies an online->offline transition. This will cause an
IRQ, and so there is no need to poll.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 35 ++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 16062b2c7ea8..0993ea03f303 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -67,16 +67,39 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	bool online;
 	unsigned int num_irqs;
 	unsigned int irqs[];
 };
 
+static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
+{
+	/*
+	 * Polling is only necessary while VBUS is offline. While online, a
+	 * present->absent transition implies an online->offline transition
+	 * and will triger the VBUS_REMOVAL IRQ.
+	 */
+	if (power->axp20x_id >= AXP221_ID && !power->online)
+		return true;
+
+	return false;
+}
+
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
 {
 	struct axp20x_usb_power *power = devid;
 
+	/*
+	 * VBUS_PLUGIN/VBUS_REMOVAL are triggered on transitions of
+	 * AXP20X_PWR_STATUS_VBUS_USED.
+	 */
+	power->online = irq == power->irqs[0];
+
 	power_supply_changed(power->supply);
 
+	if (axp20x_usb_vbus_needs_polling(power))
+		mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return IRQ_HANDLED;
 }
 
@@ -96,17 +119,11 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		power_supply_changed(power->supply);
 
 	power->old_status = val;
+	power->online = val & AXP20X_PWR_STATUS_VBUS_USED;
 
 out:
-	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
-}
-
-static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
-{
-	if (power->axp20x_id >= AXP221_ID)
-		return true;
-
-	return false;
+	if (axp20x_usb_vbus_needs_polling(power))
+		mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
 static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
-- 
2.23.0

