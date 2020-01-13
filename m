Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A141389FC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgAMDxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32957 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387529AbgAMDxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5773E21D51;
        Sun, 12 Jan 2020 22:53:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=E2VT4smkLJvvL
        CTwbrl0b23jYPIrIWVYMPPD7+wh59A=; b=kMs79o+6MQIjrnW9pDnxCGXZbMSrr
        XYKsZ9h0xYdLDWZFuYK0n0dxrpr/fp326t1giOnFF8lHYjDrflM2OXQFYDYuXjzk
        midQqRo0+93Z+ZddqpZzA6XtK8xCeax56njs33OP6VuDsyUwpgcfIC98xSYX1vsU
        0eTIxTxY8JSz6fr9irxbfYiiO3C2AXTD9fG8DezvTokrWAwNfpqqyHvtFoMkJyRq
        iOIV4fo70E8iI/MntOvcGZTk7OCujXYtRAVTMvBykMUCBdbzbnngD0t0pe4gNusf
        niBBpBHQjpEJwCGErXcGpvo/j3T3PWpf15I5sqcNWN3kOKWzcpBY2Ln/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=E2VT4smkLJvvLCTwbrl0b23jYPIrIWVYMPPD7+wh59A=; b=dnffBIbP
        uCLkgC/29lF41SmCLvSpSICSfStfRVjtjOYMckW9zVwy+QquTB4T/YgKUeSGAUTC
        WgR/2ohIMj2rwyN522llAxRx0SsIUuT7D55AKMbDn/KQx5/w9TGt1RqOXVR8W7vT
        Xx+oVBncD6DfM29FlFjELiGXSLwq3WeIwn17CQd2SoDTtOvwP+bV1srxXP2xRG/a
        9mUnJuH+94EPqP6/V/MQ3ug1H9+XEmwK/LUrXdwgFcwVLrhA2rhnjq5+Nj/PdxLa
        f8WkLxiHJSKjBnxa43X+Mb8Pzawj0wRelBWPhtFunZndGDb38YEJHV/L3lbfmmA4
        RaQX7ecvGjwlvg==
X-ME-Sender: <xms:qekbXo8sTbMiT0X_mji1rjjGuxtuXYUUS8GxL0_dPm-WdvkPyb3rjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qekbXn15VfEcUfqcgZQX0QoXrSEoo30hv0VyNSz5NGIiOMYjQSJh2A>
    <xmx:qekbXgXfXrXAI0mHosj_-fyPCqGeele_ej2cQGeb2rDK8HC49dCgLg>
    <xmx:qekbXhMWof38RBbhj5aSjVYdM4mhdPGr4IEYFiLCHbBUMHhoFdA8lg>
    <xmx:qekbXv4M7mB4V3h7dNV_GNIi5wf97gILcpaoBoev9Ymhld_pueUCHw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D66528005B;
        Sun, 12 Jan 2020 22:53:12 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/8] power: supply: axp20x_usb_power: Remove unused device_node
Date:   Sun, 12 Jan 2020 21:53:06 -0600
Message-Id: <20200113035310.18950-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This member of struct axp20x_usb_power is not used anywhere.
Remove it.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dc4c316eff81..2573de2a0adc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -55,7 +55,6 @@
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
 struct axp20x_usb_power {
-	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
@@ -463,7 +462,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
 								&pdev->dev);
 
-	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
 
 	if (power->axp20x_id == AXP202_ID) {
-- 
2.23.0

