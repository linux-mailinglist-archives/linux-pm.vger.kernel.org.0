Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0F12E31C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 07:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgABGg4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 01:36:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33447 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgABGgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 01:36:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 825A722221;
        Thu,  2 Jan 2020 01:36:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=4Zei3onZIbAQA
        SHFAQksIE2T7Lb45MHUrb0VzLsfOHU=; b=I+IBuo4BwUgT5mxrIoJJilvwguMb1
        akjSzlKbgwcaIOmTcCP5hArDNBR2gBHXJNcu08sNr+VY3lkHFjUBiqCt8dImr0Hh
        MNLXLJ6JA2/DHX10yofUoWOY6bctCt4l3Qaj7r75zkGi0JZg8n/KuYDuAVDLzrmJ
        VEYAZoRa3HqbyF0XMEyxU2F0Szs8bWZQcjMpuaovVovjgVWPC6GT3FQe1A9LEAYB
        iXP3d6lqEQJjgaC9B4RQAMwAqjZET8h6rDjP5l2dZm9zFJYCIJnpKihFxXmr2Fy/
        rN6dgs2caRjgRAQ2KpmeijP6S135xR/B7FUyRgKDByGafnQji666iYiOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4Zei3onZIbAQASHFAQksIE2T7Lb45MHUrb0VzLsfOHU=; b=PNdqt8Mv
        aKjtuDDXO7NjFmN3FVf/El/XZiOuJDxx6++n1n6tjxKbTUK0WCcL+9/B3UDG32fc
        anDuC9SaYHcF2yEwUNXEkSQiRXo2hZG3uPdv0OFXF7W6fVV7/olUX7BrAGiZ2oAS
        4a/2wka0T+5y7tFY7BZGl/Dhi6ehEem5lcukP8nI52rrZE7dH+CrPt6wJ+DYD/JI
        PdRtKB2/5ZcECTXp5R1chiX95LekLw38cjcmZVBPIq7wf7afGos1SDrSylcmulbv
        PIdJx7woXXWOP+GmpOpqBjpDZaZF2YB2nXsWAW0cwVlaAQU3NMmpAWLGLA/UTmNk
        2edFEZhomBn2Ow==
X-ME-Sender: <xms:dI8NXiotze41GLOmHRwqdx_o0yDXF7Ky8dXJYfk6D_3EdmNnVAfSNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:dI8NXu58IHXQyOPk-EK7ZmgZu2JIlc8P076M2btqiXSicOH5454fJA>
    <xmx:dI8NXghJyZUmwaqUBnR0dfmoADA0h6NZJpAo2or5ITqZHm31gnFAOQ>
    <xmx:dI8NXk4bltgZG8Hh70gxumNmQjWNHib4fZpRPLoacZVQDFaEvj2gSw>
    <xmx:dI8NXvsXZR8w0ubnqeaqq1aH2An-942YRZDUes4jd2AgctZcJ8mYVQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 002C88005B;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 5/7] power: supply: axp20x_usb_power: Allow offlining
Date:   Thu,  2 Jan 2020 00:36:31 -0600
Message-Id: <20200102063633.65388-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 2d7272e19a87..f49c8ff4a3f0 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -29,6 +29,8 @@
 
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
+#define AXP20X_VBUS_PATH_SELECT		BIT(7)
+
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
@@ -344,6 +346,12 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_PATH_SELECT,
+					  !val->intval);
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
@@ -363,6 +371,17 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
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

