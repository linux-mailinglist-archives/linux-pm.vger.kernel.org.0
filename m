Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C93130560
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 02:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAEBYV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 20:24:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46859 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgAEBYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 20:24:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DE7D21DFB;
        Sat,  4 Jan 2020 20:24:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=aq+SCX2ysa3GN
        XpW7Iu1dniHsmrxkX+iV1kY3kri6/Q=; b=aG63STUPdUgAi83lALGXu7nDyzZ16
        9AuIrnD77aY66A2o2eGB+2PWTHjgZCptI9T49Zvd9WT2bkziAUGhJndzHPL+11BF
        om/Gu2HP+aJrCFvPP0Vo6CrKryaQZ1uNc+OIprv+XrGkBkgdDN0BR9pITC4FH74I
        j7Es278cU81EfPTrTSmbi7IkaVw6VrUJ6vVjT1Mc2ejkKjqhj/zb2ENwEsOMO6cY
        r2ik5ls6Y4gv5CiKiXtTepiUbgNeY1FQHJHs1tfetBAzrWHMJUPCUxRleerkD8/b
        gMyk58QlA0fUbbAQP4Z7Fhqf2pAeJEYG2F9HHNFyR7uVcM+KuVjZh4e2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=aq+SCX2ysa3GNXpW7Iu1dniHsmrxkX+iV1kY3kri6/Q=; b=MxUC43Y9
        KibCUcJzJxDK/qf1bn5xTutsErZVA8I0bHAZeiEwqL/Zj1uEcALsirdPaUAHcIcL
        JpZQiDBdKDLCjU9f2JMvK7oS0Qp0/rnc/QbEcCqqjeVFmIkdZPIAR100oVu3NwLv
        vk6vdX58s1xFIdS7OzQnyioep60BmXyFgFNr7jGECfJdg8h050iHIPuDqfq3CuhM
        YyRT/+tqSXVUq8M/engIZ3T3dCNqB2enelzZhj3j9bEiMf6I7xm3Sc0iIXAJJ2Hj
        g/hHBTDXY1CGM0pVf0ssHyw9cHjFf7Fe1/tSR+W7LyHkRdKlQbdtsZJea5YijuT+
        enlPIbCBZa71KQ==
X-ME-Sender: <xms:xDoRXqnoGR-VZxDIbw0-9knmTlhdY3KsHIutvX2YEXdKtuEx9NDpBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:xDoRXk58hQ4pzm1yFE8QqloT1FbXhsEhsmu2o60E8uc88g_IRQoEdg>
    <xmx:xDoRXn7HCBwyYIH9X_-mbtaeFb2PUIvCShGQ5guY2l89DJmlisegRA>
    <xmx:xDoRXsR7VMAJfGFUlGKIkcNqrXvSLCC1-rwaOp1yBUkjjmVotbZwTQ>
    <xmx:xDoRXr6eX08Wca0FgP4LCHYnLqFzYKALCO_Xe1Qzr1R3g8jqO4BSOw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75F4980059;
        Sat,  4 Jan 2020 20:24:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 7/9] power: supply: axp20x_usb_power: Allow offlining
Date:   Sat,  4 Jan 2020 19:24:14 -0600
Message-Id: <20200105012416.23296-8-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AXP803/AXP813 have a flag that enables/disables the USB power supply
input. Allow control of this flag via the ONLINE property on those
variants.

It may be necessary to offline the USB power supply input when using
the USB port in OTG mode, or to allow userspace to disable charging.

When the USB VBUS input is disabled via the PATH_SEL bit, the VBUS_USED
bit in PWR_INPUT_STATUS is cleared, so there is no change needed when
getting the property.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 2d7272e19a87..68443f264dff 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -29,6 +29,9 @@
 
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
+#define AXP20X_VBUS_PATH_SEL		BIT(7)
+#define AXP20X_VBUS_PATH_SEL_OFFSET	7
+
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
@@ -263,6 +266,16 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int axp813_usb_power_set_online(struct axp20x_usb_power *power,
+				       int intval)
+{
+	int val = !intval << AXP20X_VBUS_PATH_SEL_OFFSET;
+
+	return regmap_update_bits(power->regmap,
+				  AXP20X_VBUS_IPSOUT_MGMT,
+				  AXP20X_VBUS_PATH_SEL, val);
+}
+
 static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -344,6 +357,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		return axp813_usb_power_set_online(power, val->intval);
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
@@ -363,6 +379,17 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 					   enum power_supply_property psp)
 {
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+
+	/*
+	 * Both AXP2xx and AXP8xx have a VBUS path select flag.
+	 * On AXP2xx, setting the flag enables VBUS (ignoring N_VBUSEN).
+	 * On AXP8xx, setting the flag disables VBUS (ignoring N_VBUSEN).
+	 * So we only expose the control on AXP8xx where it is meaningful.
+	 */
+	if (psp == POWER_SUPPLY_PROP_ONLINE)
+		return power->axp20x_id == AXP813_ID;
+
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
 	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
 }
-- 
2.23.0

