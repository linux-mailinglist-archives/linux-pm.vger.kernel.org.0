Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7913B833
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 04:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAODkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 22:40:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38093 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgAODkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 22:40:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 422AD22139;
        Tue, 14 Jan 2020 22:40:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jan 2020 22:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Zmlb3PnzNuoK+
        2LPTUjNJAzFl9+II7eFSLO3XnnS27A=; b=IieO7eXKZqxx0fy3qymRj23Uteh7L
        iDCLZQ8kHa9H0AQmVQTQ/gWT4Do7lZ4CUD6EBChy3hlvq93hpiNjymAGli1ce4GI
        863oISQYFjCuPuhOrgClHsOrF8LI+faJPa+Y8H1nphH3WZ/BOeOZ5iCbXFOL1MQD
        NAWJwBfaLRMwdqbK0SZdaFpu1nh3XfItqPi5J9BTZ5wYXUuG9Q5WLptZer3Cpape
        +HaYz+/mRdosD844XSrzEZXeNy0HFZqNSDHzDTeM5TXvA8XCO69YmNrniw4WZqE2
        /P8l/jTPLSlGB8KemIk7a0syfzMoT2yi0DfxQQSJZafWt1YBiJ4PnYGeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Zmlb3PnzNuoK+2LPTUjNJAzFl9+II7eFSLO3XnnS27A=; b=CnqsbRPU
        mazQZmpw5MqgXc8McNp2AqNohxEDbY9AOy3AZIC+f0RmGygTUR/sb38lT8JHxClj
        BVPk6CbXM8TlvDCSIq3lD98on4A2Ulfmk2RZ5I6GvvjY6BKUXyTosP+SxtUzvKHi
        ejVohwqkPNvGqFrg0964OTs0PzEkdrMv3OUOUjckJmfgz6FwYwBCv0XGJ9E/rHa8
        COAwJX8z6/LqOoEbi3L2CoGNH1AMpIWbce6WIns5DA+BWoSEloym0bmWLXtx2etC
        OPGNaUIJGvBGmzCQgvrOAb+wJ1jBeJx7AeetDfKndZZWTRjaB+ZAQnQT4Y5IoB0E
        /7qQImf/d74pnw==
X-ME-Sender: <xms:w4keXkRxoafwSxP0KLNQbxr895fzcuxsulD7bKIjp0deDVXsW7MVBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:w4keXgp5oNEsZvfI0_dYYqpizp8D-SYmdM9G62VpqQdlaiLGOoSfQg>
    <xmx:w4keXiMRwZS8vk1iKI5RO-XUA6G8H08X4Yqp9ltsRcjexvIymGxSNQ>
    <xmx:w4keXtDGIh0WBqdLAAXaapzovdoy-Q8oH_RFnWxPsvsdGpkZcl6WdQ>
    <xmx:w4keXoERIz429ytckg4sUwSMe6cjSkeXfrKHSdIg4qPcP9KCGCemmA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA4C530607B0;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 4/4] power: supply: axp20x_usb_power: Only poll while offline
Date:   Tue, 14 Jan 2020 21:40:48 -0600
Message-Id: <20200115034048.24901-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115034048.24901-1-samuel@sholland.org>
References: <20200115034048.24901-1-samuel@sholland.org>
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 30 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 1732304bc96e..4fde24b5f35a 100644
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
@@ -515,6 +525,8 @@ static int axp20x_usb_power_resume(struct device *dev)
 	while (i < power->num_irqs)
 		enable_irq(power->irqs[i++]);
 
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+
 	return 0;
 }
 #endif
-- 
2.23.0

