Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E34591F0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 16:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhKVP6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 10:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbhKVP6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 10:58:46 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45DC061756
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 07:55:38 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by laurent.telenet-ops.be with bizsmtp
        id MTux2600K4yPVd601Tuxk9; Mon, 22 Nov 2021 16:55:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBe6-00EL3j-Vr; Mon, 22 Nov 2021 16:54:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBe5-00HGzT-Qs; Mon, 22 Nov 2021 16:54:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tero Kristo <kristo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 13/17] pinctl: ti: iodelay: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:54:06 +0100
Message-Id: <60257a3c5b567fb5b14d6f9adb770899bce88f7a.1637592133.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the field_{get,prep}() helpers, instead of defining a custom
function, or open-coding the same operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 35 +++++++------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 4e2382778d38f557..b220dcd9215520db 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -155,18 +156,6 @@ struct ti_iodelay_device {
 	struct ti_iodelay_reg_values reg_init_conf_values;
 };
 
-/**
- * ti_iodelay_extract() - extract bits for a field
- * @val: Register value
- * @mask: Mask
- *
- * Return: extracted value which is appropriately shifted
- */
-static inline u32 ti_iodelay_extract(u32 val, u32 mask)
-{
-	return (val & mask) >> __ffs(mask);
-}
-
 /**
  * ti_iodelay_compute_dpe() - Compute equation for delay parameter
  * @period: Period to use
@@ -233,10 +222,10 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
 	}
 
 	reg_mask = reg->signature_mask;
-	reg_val = reg->signature_value << __ffs(reg->signature_mask);
+	reg_val = field_prep(reg->signature_mask, reg->signature_value);
 
 	reg_mask |= reg->binary_data_coarse_mask;
-	tmp_val = c_elements << __ffs(reg->binary_data_coarse_mask);
+	tmp_val = field_prep(reg->binary_data_coarse_mask, c_elements);
 	if (tmp_val & ~reg->binary_data_coarse_mask) {
 		dev_err(dev, "Masking overflow of coarse elements %08x\n",
 			tmp_val);
@@ -245,7 +234,7 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
 	reg_val |= tmp_val;
 
 	reg_mask |= reg->binary_data_fine_mask;
-	tmp_val = f_elements << __ffs(reg->binary_data_fine_mask);
+	tmp_val = field_prep(reg->binary_data_fine_mask, f_elements);
 	if (tmp_val & ~reg->binary_data_fine_mask) {
 		dev_err(dev, "Masking overflow of fine elements %08x\n",
 			tmp_val);
@@ -260,7 +249,7 @@ static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
 	 * impacting iodelay configuration. Use with care!
 	 */
 	reg_mask |= reg->lock_mask;
-	reg_val |= reg->unlock_val << __ffs(reg->lock_mask);
+	reg_val |= field_prep(reg->lock_mask, reg->unlock_val);
 	r = regmap_update_bits(iod->regmap, cfg->offset, reg_mask, reg_val);
 
 	dev_dbg(dev, "Set reg 0x%x Delay(a: %d g: %d), Elements(C=%d F=%d)0x%x\n",
@@ -296,16 +285,14 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
 	r = regmap_read(iod->regmap, reg->reg_refclk_offset, &val);
 	if (r)
 		return r;
-	ival->ref_clk_period = ti_iodelay_extract(val, reg->refclk_period_mask);
+	ival->ref_clk_period = field_get(reg->refclk_period_mask, val);
 	dev_dbg(dev, "refclk_period=0x%04x\n", ival->ref_clk_period);
 
 	r = regmap_read(iod->regmap, reg->reg_coarse_offset, &val);
 	if (r)
 		return r;
-	ival->coarse_ref_count =
-	    ti_iodelay_extract(val, reg->coarse_ref_count_mask);
-	ival->coarse_delay_count =
-	    ti_iodelay_extract(val, reg->coarse_delay_count_mask);
+	ival->coarse_ref_count = field_get(reg->coarse_ref_count_mask, val);
+	ival->coarse_delay_count = field_get(reg->coarse_delay_count_mask, val);
 	if (!ival->coarse_delay_count) {
 		dev_err(dev, "Invalid Coarse delay count (0) (reg=0x%08x)\n",
 			val);
@@ -326,10 +313,8 @@ static int ti_iodelay_pinconf_init_dev(struct ti_iodelay_device *iod)
 	r = regmap_read(iod->regmap, reg->reg_fine_offset, &val);
 	if (r)
 		return r;
-	ival->fine_ref_count =
-	    ti_iodelay_extract(val, reg->fine_ref_count_mask);
-	ival->fine_delay_count =
-	    ti_iodelay_extract(val, reg->fine_delay_count_mask);
+	ival->fine_ref_count = field_get(reg->fine_ref_count_mask, val);
+	ival->fine_delay_count = field_get(reg->fine_delay_count_mask, val);
 	if (!ival->fine_delay_count) {
 		dev_err(dev, "Invalid Fine delay count (0) (reg=0x%08x)\n",
 			val);
-- 
2.25.1

