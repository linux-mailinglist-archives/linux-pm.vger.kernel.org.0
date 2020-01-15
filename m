Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F413B83C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 04:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAODlM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 22:41:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56633 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729048AbgAODkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 22:40:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 957DD22131;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jan 2020 22:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=xScHInzV3pGYC
        GSlKPZMPOWxtY3Fnc4q0/FsYlG3OLs=; b=ahJ0WMUaBq5GJoBURKIBPxBWo+VkF
        SsOOGKRlG2c+CR6dyZR7Eft4RVTDgPdLZu8zIHTgTZDn0a2ENIKuUNTLlBYkPbli
        dfYpSiQ2m3RTHaeRer5YgoTmDfQIz3nJa3t2Yv2ugHqFUyD0+Ac+rZTFHUUMe1gb
        YNyoKHmZ5T1y7uRJw0Fsn69dokf/wwYOWiAhAvWW6rwi1C42qUd7gFOTgYwGR9Sk
        l65zfDLsCmDYDaPj7RURLF09kV8V/S8BCkbC7QeZjY24fLwHRw+eT1DKHZMQ6CvP
        7OFqneqa2pf7AaR9yzvlEP7lKkBwTQC8mm4Ds6adjiTJ7y2OwdA2sW44g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xScHInzV3pGYCGSlKPZMPOWxtY3Fnc4q0/FsYlG3OLs=; b=wXzqhRwu
        k4x5z8PuP1ucVTKBjnwPRyG2sWniGCl1O7GFrUvRMvM6IPwQ9PnstkxGSXhJUtjA
        KHH+An/Ie2dnRlN2DkUC5gSV8UVxVO2GwfU1jYm8gzdJpP3Q2NdaLXdvcZcSvTw0
        2WdLGZs4NE8xz5X4TOG4pvB3Bm7MsfKYkYEky+73SVYWOfQuxoUPi2SX5jPz3y1y
        gJW1xW2V5+quCyCeDp4Yt7FnNBroy8e4f9oq9VdtBpdXsUigdnYzwzrRwDHRBUAN
        P7PLG5LLCdfgJStGYywGTPw8cBI2VZxUL4uYnFE1nvxJmQkKKR8csfqBcWXNilUU
        xw1QD2TYAD42Vg==
X-ME-Sender: <xms:wokeXvpoO37uIL5n04N2WI6qZm9i72SF2tVIKxuE4NYKl2r0w8QXvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wokeXhAUaetD-urlZghgWgtQe44fqbnYmjDAINQgs6uZQnbJdovmtg>
    <xmx:wokeXoM483QPS5a2ii-TRFxxuU6j4i2LAh5403H-0JmAsIagKPFFIA>
    <xmx:wokeXshWnvZbhRnjF4fUMjYe3XtYzUp3cm24lSE1HqptfUo2OKsipQ>
    <xmx:wokeXlxEyVpqA8c6bwBMB7nSx9N1YpWNRXoHu1gGoi7HIjFcYhIAzg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 259FB30607CD;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 2/4] power: supply: axp20x_usb_power: Allow offlining
Date:   Tue, 14 Jan 2020 21:40:46 -0600
Message-Id: <20200115034048.24901-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115034048.24901-1-samuel@sholland.org>
References: <20200115034048.24901-1-samuel@sholland.org>
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd7071057457..f14736041c41 100644
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
@@ -344,6 +357,11 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		if (power->axp20x_id != AXP813_ID)
+			return -EINVAL;
+		return axp813_usb_power_set_online(power, val->intval);
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
@@ -363,6 +381,18 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 					   enum power_supply_property psp)
 {
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+
+	/*
+	 * The VBUS path select flag works differently on on AXP288 and newer:
+	 *  - On AXP20x and AXP22x, the flag enables VBUS (ignoring N_VBUSEN).
+	 *  - On AXP288 and AXP8xx, the flag disables VBUS (ignoring N_VBUSEN).
+	 * We only expose the control on variants where it can be used to force
+	 * the VBUS input offline.
+	 */
+	if (psp == POWER_SUPPLY_PROP_ONLINE)
+		return power->axp20x_id == AXP813_ID;
+
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
 	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
 }
-- 
2.23.0

