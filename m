Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32119138A09
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgAMDxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:45 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58049 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387498AbgAMDxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:13 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A07A621C7A;
        Sun, 12 Jan 2020 22:53:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=RHYQj/FernzCJ
        VEio9TnwHcA6uvjDWGqaN7zZ1DFVIc=; b=FfgUDyjzi8fSdgJm28w8tDjs2rOeS
        ukQnOGsSuoIWRHfVyGN0rpWuw7AoQtVvO5ZskTBhFp4rNgmuitaQYMxpsmpTKnIB
        nuRQbJwL1kTHXHPoaH1nDR91xBq31sSi5iIlS2RLQWyTG+2jko69g/BF9U1JcE6j
        TNtKsc5wAdGIF656KnOj39OowbF6OfwQgefjpATDOvQyJclHe5Wlf2n5At1MvSPG
        6MMRIbBurqbZtXUsdBkk0519dDqlcTo075nAiIPd5qzRTry6YXd1ife0YJyRb18N
        mntQNpAZrwc0Q45jUj+CDbQpTcx/wrlvv4zlbA3bqAs3bPZ2zE28DsTmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=RHYQj/FernzCJVEio9TnwHcA6uvjDWGqaN7zZ1DFVIc=; b=D7DL0JW6
        jdOL2jQVH5/t7mreumcfxDvr8syK18bse+gd0NxnGIO8PD0suPPu3+bBThdwdrTt
        nR2UBUylZoo9ksj60S5OuMaYAATQPwviBK1sZN4W9V09FkMVQLmTFhrWpcsYm3WU
        AuGVhl993Pja1PrkgzGXMRdVb+Egf78IkBu/XBoMkwfk2sADi+5qhQlBDmBitxG4
        f7nffWOVm5qeOJmnMnxicQjTDaA3ckKSx9n5b2emgrA4SrxMoqnYwaKV9ZsTpH8a
        6TgJgEAGYKEr779gtlZaWmyRwHPW4SrH+VE8/NEDHV55RVqV8gHPR25VkJey1Nsw
        DTW6fgICDe0Ifw==
X-ME-Sender: <xms:qOkbXsWmffLPJ_RQJrcCXpVnn77jcFL4f_kkHd9T0zyMvjkp3lIspw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qOkbXqTifZTi5pJSYhst-uDQgvdK4qFgTux2V1FcnuK6y5S7t6Qb0g>
    <xmx:qOkbXvsYynl53cOlA0YPsFbIsPjqy8NOgeHtb_8Hv80QbT4aGQ7btg>
    <xmx:qOkbXjZD4y76l_9EcUKCBagETWU7INMFfo3tQRINbofyjT8-5naiug>
    <xmx:qOkbXqfSeggiHg9B3czeDp_UhVa4Puk-N4dAMN-pZyHdZAZ-S4Afeg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15BE280063;
        Sun, 12 Jan 2020 22:53:12 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/8] power: supply: axp20x_ac_power: Allow offlining
Date:   Sun, 12 Jan 2020 21:53:04 -0600
Message-Id: <20200113035310.18950-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AXP803/AXP813 have a flag that enables/disables the AC power supply
input. Allow control of this flag via the ONLINE property on those
variants.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_ac_power.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index f74b0556bb6b..3ba38f2f281c 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -24,6 +24,7 @@
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
 #define AXP813_ACIN_PATH_SEL		BIT(7)
+#define AXP813_ACIN_PATH_SEL_TO_BIT(x)	(!!(x) << 7)
 
 #define AXP813_VHOLD_MASK		GENMASK(5, 3)
 #define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
@@ -157,6 +158,11 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
 	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_ACIN_PATH_SEL,
+					  AXP813_ACIN_PATH_SEL_TO_BIT(val->intval));
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		if (val->intval < 4000000 || val->intval > 4700000)
 			return -EINVAL;
@@ -183,7 +189,8 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
 static int axp813_ac_power_prop_writeable(struct power_supply *psy,
 					  enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	return psp == POWER_SUPPLY_PROP_ONLINE ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
-- 
2.23.0

