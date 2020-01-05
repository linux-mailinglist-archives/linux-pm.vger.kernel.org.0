Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2A13055C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 02:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAEBYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 20:24:32 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56563 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbgAEBYW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 20:24:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2671721E92;
        Sat,  4 Jan 2020 20:24:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Jm4NPFOs74xdA
        A/X94Ro/cYVSaTnCwH5Zv4H2w/Sd+k=; b=myTbfkLwBhF9nDCF3lhUHSpTKDKQt
        v3I2TM2h7PQT62fHiQQf6K94v5eSaCrx1pvfiYoMTY5CH+PCa0NLQP6ETdS+NBlu
        UfhfGBAJognk8gcwiHpsl6c6Hy4NeF2ZmaHCQQ9j/7mF9t1X+yIZ9mWxzX98IJ8B
        g+iUmNorCzOPvi49YNh1Dn0zp+2tTN9aVmlZp7ZFIbUuJAXC7ZM9Gmji8IBRS41N
        ipHHCBvgcDq7EeWn98GoqxUCFlBklKnJ7yQ6hxH3MmxvZPvWEN2Z0hewpA4Hqmf/
        NdhPpMV5PoxYU+eDrz00aKyMhf6fPXRvltcdgf7LJxWE9n2xTtup900xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Jm4NPFOs74xdAA/X94Ro/cYVSaTnCwH5Zv4H2w/Sd+k=; b=pOWEEMBo
        Fc/4T80lDtuVNJCevjvsdZm8YT5uJfa1ToMLy6ypyCkuRq/NDRw85RdpeNKl9qEK
        yB7QkZt0gNy/ogiyY8lxC0G6SpWnrAjpIl2NTSA8+Rz7pSmdMf5J5MqttRC+D4uM
        0LZe5DfmTJuScRZPZQ/LbxeuOwYsXWvH9E8OmUQFdgy6DecRV4TwR7hSeV7z4bd5
        0WG7W5vu26gqp5ke1w2kqRbkRjXJHZz9TW0lfJjDtkLTt6z70fThgvaOpELyZEyT
        Tq6UuCxSgqMUZjAIX0LI+UR3g2I/XKa1IXnCR/bHZMrrIO6KCa23WMCCuI0T3hUQ
        agUctgpmFI2wOQ==
X-ME-Sender: <xms:xjoRXkRYCZJIqtsqF6pUFM2gl_n0FLnYF_kw8l4vsOnFv_H-c9zB5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:xjoRXpF9vctkvkFkMqDBHHoQ2tyxLLk7eJFQkcV_-S80FBGaLEKyeQ>
    <xmx:xjoRXmh52lgznPKV3hKZz-wN5VAAxosSOrDKTPR51xMawlL9dGt6GA>
    <xmx:xjoRXhAQmU-SD_ISoJfu8d0hfNc0PNKkWuI8UY2sTYgHBrw8EJy5RQ>
    <xmx:xjoRXj5z7tF2GK98bOgikqg1EopS6lDVQ7F24fF35-SkbUH4K_JyQw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70BF680059;
        Sat,  4 Jan 2020 20:24:20 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 9/9] power: supply: axp20x_usb_power: Only poll while offline
Date:   Sat,  4 Jan 2020 19:24:16 -0600
Message-Id: <20200105012416.23296-10-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
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

As long as VBUS is online, a present->absent transition necessarily
implies an online->offline transition. Since will cause an IRQ, there is
no need to poll while VBUS is online.

To ensure the driver's view of VBUS online status remains accurate,
unconditionally poll once when receiving an IRQ and when resuming. If
VBUS is still online at that time, polling will cease until the next
VBUS_REMOVAL IRQ.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 0d033954c4dc..4bf119082e91 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -68,16 +68,32 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	unsigned int online;
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
 
 	power_supply_changed(power->supply);
 
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return IRQ_HANDLED;
 }
 
@@ -97,17 +113,11 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
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
@@ -512,6 +522,8 @@ static int axp20x_usb_power_resume(struct device *dev)
 	while (i < power->num_irqs)
 		enable_irq(power->irqs[i++]);
 
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return 0;
 }
 #endif
-- 
2.23.0

