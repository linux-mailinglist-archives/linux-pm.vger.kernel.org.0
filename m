Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BA130569
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 02:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAEBYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 20:24:43 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42023 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgAEBYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 20:24:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A1FC21CBA;
        Sat,  4 Jan 2020 20:24:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eR/RTzq+jdWmJ
        Il0pyBHpgF8i6B4qMRvVJ2hxPiiC9Y=; b=H2bybVP7T3rc77Vr+cGdbZti7LXhL
        Rpkk/4WZbExkZKqfu/GqE0aeOaSf1rDjPX4vQUnVCDoNO84VnJrziXqgZDvu0b4W
        uYhtS1gGGLIFnjw8WMyqglnP0ESvgH1c44ea9ewchHgwKnNLOo4MzTTYe2wwfjiG
        IM/AKE48IDg9DeQR1HNRrGAtIZo8iE4sToCkSmL1GrpF76CK5gSYzsAFEReRa9EQ
        zK7O2QkU29YSde4mDMzpwrURfhCzujZjLrIlkECxvaOKKYyQtEtsw3pvm/PB13+L
        /M+7vkKmYCJx1Wje6uEkjks5T0ML0BecOc8oe9nUDX6qeUGrQ4783YClg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eR/RTzq+jdWmJIl0pyBHpgF8i6B4qMRvVJ2hxPiiC9Y=; b=a7mfwQs0
        K/hQoxhyuqH4cIBI5TqzDyTdglHMR3ObdJ/6kNATi/VudK7Ea/kLlJMb70KJYQkH
        72lD3/U0c03lZgJwp+hUMceLOcxcyXbIVb5+MLyTlSMnKDKne6rjFh2G0OlmD19x
        Mc4lmZrkCrUKBUKFo0rBO4Kw/nJQG90FIa/ufHVzTSVZ2MvMZgSxEny62oDpj2yk
        0/lmpQ8hyDE6Tt+OJSwrNeZ+lcTyExf9u0cpDKy+QPhsdRBcusbhfvkxmqLjNCZ+
        TH/7vaiSwANqbUKwOFqVVbhcFXv6FZFg03HpSecquX66NHjAp6AN7h+srb+QOzg4
        dC9SkBWeRShvOw==
X-ME-Sender: <xms:wzoRXsoljz8CNrFL8AYlTl2d8I9Wm8la7oKqcCvrNMDeunLKPbyxwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:wzoRXj9E8Et6Q_ZHc0jI_AzYWKeo7o6yYUlY1Cl_T5yU-2y0lIIMPQ>
    <xmx:wzoRXl2t4FlYPO1qlb12yY_aP2x9CbC_wTOfjgchHd8pLwZimJAECg>
    <xmx:wzoRXmkG40KBNgZEK387xx7D1A_YTMdPs8viY2fVdhuGm7LRx49INA>
    <xmx:wzoRXgfaB1ifxZxqlka_qQFzRpzmqN7BIzZdUte_IhpdYEO1-J3QLw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 766CF80059;
        Sat,  4 Jan 2020 20:24:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 5/9] power: supply: axp20x_usb_power: Remove unused device_node
Date:   Sat,  4 Jan 2020 19:24:12 -0600
Message-Id: <20200105012416.23296-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This member of struct axp20x_usb_power is not used anywhere.
Remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 5f0a5722b19e..dd3f3f12e41d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -57,7 +57,6 @@
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
 struct axp20x_usb_power {
-	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
@@ -465,7 +464,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
 								&pdev->dev);
 
-	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
 
 	if (power->axp20x_id == AXP202_ID) {
-- 
2.23.0

