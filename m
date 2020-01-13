Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5109C138A03
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgAMDxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45297 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387569AbgAMDxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:15 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3ADDF21D46;
        Sun, 12 Jan 2020 22:53:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=QsrYjH3pog1x9
        Yu7X2EoVn84/WFrvdNx4X6XL4205Xk=; b=eVtmgj42u4UmlaLcrp2/OMZbazRg9
        8CPWcovnBhkxK3CetXjnPx9eQB6nVMzam7Xl9l8jbZjv1O7t9XYZjaV9B2msVZTr
        4IF3zJfo/mObId+hHKDukSX+Mqo9Ko20enZ4HDywTRr0CnLdw0cMGrhiTvnvCKzo
        UsAf7Ytsf/u6ikVpw9OQXLyd50PsLXAI2jfbQQH8QvbYM0RxJZbyLuMnkIqVi9Wr
        X1QH1beimpKBo3dU7XYLGykpdnye9vScS/Ga/LLyYv9MjwwvGmejMqpYydiPOd5O
        jF2WzC0e0QspnJdRo/jpqKm9LOI5N7Zu9vtCGXxtNfDf6qwlz0h5TAxuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=QsrYjH3pog1x9Yu7X2EoVn84/WFrvdNx4X6XL4205Xk=; b=JAg9WQO1
        BhVDnSn12bWD6RmzG3CBXwQtf0HNy0F+mJyLyIfCo4swS1th+a7sSw5yGhFkbU7C
        6wIfpTUmtYWurwGmvBTPfe3mwrNfCcelQjaQaRDR7c7DA+d24Xb1fqpOvPkSGOwf
        fCyzm3/fFatA/3Bq/FBBuKuSVjFWeB+D9n8FS9YuwiwIFwrQ2VHBDqIp1Ab69xFA
        Ae7iEaJmFAWFdJ4OEI8ZsnDUS9XYInpDds+LS8w5N6ufZBopHfMk/sUfIgjrsxFW
        IYcmDW9rv3mJge8mUZgJE4hZKdUhQaHmjRLIqblLC0jgQbTLTol6NxXujlpGIRh+
        1CpmHw8p36vGtw==
X-ME-Sender: <xms:qukbXslNx86JoT0pghsAJXWz1LDZ8tB0O0Ib6TeJihH38VlxfYD5cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qukbXg1SMGQQ3jXQk0vcHGGOw15XPH_dKz9L8OrAcFLvBXIwZ23cNg>
    <xmx:qukbXrhksxeKzBA__Lb0pngPphPUnoSfDJnYxZgPyR_iDu_tOQzxNw>
    <xmx:qukbXuV1PYJ6kwGzMoGSWl279ImwgmO7zAHAHw52UVD5n1rYGAfyGg>
    <xmx:qukbXuc3f_If9sE8BQwQ1bZiB5sS3EZEUTav4jKCj8ErDmVeuUQO9w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FF8D8005B;
        Sun, 12 Jan 2020 22:53:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 6/8] power: supply: axp20x_usb_power: Allow offlining
Date:   Sun, 12 Jan 2020 21:53:08 -0600
Message-Id: <20200113035310.18950-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
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
 drivers/power/supply/axp20x_usb_power.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd89ee12dd18..3b3cc1e33f19 100644
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
@@ -261,6 +264,16 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
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
@@ -342,6 +355,11 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		if (power->axp20x_id != AXP813_ID)
+			return -EINVAL;
+		return axp813_usb_power_set_online(power, val->intval);
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
@@ -361,6 +379,18 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
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

