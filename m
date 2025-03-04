Return-Path: <linux-pm+bounces-23394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45FA4E47E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8808A116F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56D292FBB;
	Tue,  4 Mar 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eVYsXFYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B54292F8A;
	Tue,  4 Mar 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101443; cv=none; b=sneH56rLq8QZ7thTvvFjbh9d0x7As9EgC5OoEGYQXB777QPKwVdaYz9iVySF/H+O6boPwvmuVPu7BkX4J3DoVW3U4ed7qylcsFjcdzhIZijzKlSuUSYHRN0hqiKyFHjStmOrfIx2zb9REIZiOJM5rMvBjDQ58PwYsBmAI7nIt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101443; c=relaxed/simple;
	bh=hn1gBR+tSRv7Ed94tUAvjpBP/2EKao1MU4M0g6tP780=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZutdxRsbeTNNnFHn8gbYN/zEu1CZty0AQ/bjAqRgAH2cfbIZwriZvIQDJE1RtzXFB5LQGW3fxK+YkSZ/cescz+C47Ygt4PyHsW+WdujeSQceg63xa6ikt6Ph1TuKKuY+zDgUqNJdwctUPlyS3nVaHKPXOfY5+nEsPTYhZbla4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eVYsXFYd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101439;
	bh=hn1gBR+tSRv7Ed94tUAvjpBP/2EKao1MU4M0g6tP780=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eVYsXFYdNpSSQzvOYviPmq4ieqK2IHsGXqvM4sw3mQ7/aEL3+58J3Zme6rtSCxYWe
	 KxmjxK8FzPSIGlvJQDl9N+nSAjzI+kSLl3DCvBkP79rqR9BFsQcU2f4IbKMSGGxr4t
	 Ae98xRXojcxe79EaFMzM1VIc2ITZDLycLTjDHQvhBeOfbssK5rpe64E+TisxGv86x4
	 DpFpTkkDao2+2g5lnt7fYUdZQRf1X/sCk3pTo2L5zSwveRnYjCd+/ExhOph/mRF1D4
	 Uufgcd26OneHdQYgcxWjDJYBb6OVkMhFF+Z3PgTCfOzWCQJAsbWqn93DgbrI569z8u
	 nBVognmE0LSkg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3E8517E0630;
	Tue,  4 Mar 2025 16:17:14 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:54 -0300
Subject: [PATCH v3 13/20] ASoC: mediatek: mt6359-accdet: Make PWM debounce
 settings internal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-13-5b0eafc29f5b@collabora.com>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
In-Reply-To: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Instead of reading a bunch of PWM debounce settings from the Devicetree,
set reasonable values inside the driver that are known to work across
multiple boards. There are no current users of these DT properties, so
no backward compatibility needs to be maintained. The properties can be
properly introduced in the binding in the future if different boards
really need to override them.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/mt6359-accdet.c | 70 ++++++++++++++++++++++------------------
 sound/soc/codecs/mt6359-accdet.h | 20 ------------
 2 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index e04cfb9a607aa5d38d46329eb1387545fda37ccc..6728f1018c992fc9d4e4133dbaf091d256567683 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -43,6 +43,25 @@
 #define ACCDET_DIGITAL_FASTDISCHARGE	BIT(13)
 #define ACCDET_AD_FASTDISCHRAGE		BIT(14)
 
+/* Debounce time = (DEBOUNCE/32768) sec */
+#define ACCDET_DEBOUNCE0_625MS 0x800
+#define ACCDET_DEBOUNCE1_625MS 0x800
+#define ACCDET_DEBOUNCE3_976US 0x20
+#define ACCDET_DEBOUNCE_AUXADC_2MS 0x44
+/* PWM frequency = 32768/(PWM_WIDTH + 1) Hz */
+#define ACCDET_PWM_WIDTH_25_580HZ 0x500
+/* Duty cycle = (PWM_THRESH + 1) / (PWM_WIDTH + 1) */
+#define ACCDET_PWM_THRESH_100PERCENT ACCDET_PWM_WIDTH_25_580HZ
+#define ACCDET_RISE_DELAY 0x1f0
+#define ACCDET_FALL_DELAY 1
+#define ACCDET_EINT_DEBOUNCE0_1MS 5
+#define ACCDET_EINT_DEBOUNCE1_900US 3
+#define ACCDET_EINT_DEBOUNCE2_900US 3
+#define ACCDET_EINT_DEBOUNCE3_1MS 5
+#define ACCDET_EINT_INVERTER_DEBOUNCE_256MS 0xe
+#define ACCDET_EINT_CMPMEN_PWM_WIDTH_400MS 4
+#define ACCDET_EINT_CMPMEN_PWM_THRESH_2MS 1
+
 static struct platform_driver mt6359_accdet_driver;
 static const struct snd_soc_component_driver mt6359_accdet_soc_driver;
 
@@ -130,7 +149,7 @@ static unsigned int mt6359_accdet_jd_setting(struct mt6359_accdet *priv)
 	} else if (priv->jd_sts == M_PLUG_OUT) {
 		/* set debounce to 1ms */
 		accdet_set_debounce(priv, eint_state000,
-				    priv->data->pwm_deb->eint_debounce0);
+				    ACCDET_EINT_DEBOUNCE0_1MS);
 	} else {
 		dev_dbg(priv->dev, "should not be here %s()\n", __func__);
 	}
@@ -241,11 +260,11 @@ static void mt6359_accdet_recover_jd_setting(struct mt6359_accdet *priv)
 
 	/* recover accdet debounce0,3 */
 	accdet_set_debounce(priv, accdet_state000,
-			    priv->data->pwm_deb->debounce0);
+			    ACCDET_DEBOUNCE0_625MS);
 	accdet_set_debounce(priv, accdet_state001,
-			    priv->data->pwm_deb->debounce1);
+			    ACCDET_DEBOUNCE1_625MS);
 	accdet_set_debounce(priv, accdet_state011,
-			    priv->data->pwm_deb->debounce3);
+			    ACCDET_DEBOUNCE3_976US);
 
 	priv->jack_type = 0;
 	priv->accdet_status = 0x3;
@@ -390,7 +409,7 @@ static void mt6359_accdet_jd_work(struct work_struct *work)
 		priv->jack_plugged = false;
 
 		accdet_set_debounce(priv, accdet_state011,
-				    priv->data->pwm_deb->debounce3);
+				    ACCDET_DEBOUNCE3_976US);
 		regmap_update_bits(priv->regmap, ACCDET_SW_EN_ADDR,
 				   ACCDET_SW_EN_MASK_SFT, 0);
 		mt6359_accdet_recover_jd_setting(priv);
@@ -497,7 +516,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	int ret;
 	struct device *dev = priv->dev;
 	struct device_node *node = NULL;
-	int pwm_deb[15] = {0};
 	unsigned int tmp = 0;
 
 	node = of_get_child_by_name(dev->parent->of_node, "accdet");
@@ -514,12 +532,6 @@ static int mt6359_accdet_parse_dt(struct mt6359_accdet *priv)
 	if (ret)
 		priv->data->mic_mode = 2;
 
-	ret = of_property_read_u32_array(node, "mediatek,pwm-deb-setting",
-					 pwm_deb, ARRAY_SIZE(pwm_deb));
-	/* debounce8(auxadc debounce) is default, needn't get from dts */
-	if (!ret)
-		memcpy(priv->data->pwm_deb, pwm_deb, sizeof(pwm_deb));
-
 	priv->data->hp_eint_high = of_property_read_bool(node, "mediatek,hp-eint-high");
 
 	ret = of_property_read_u32(node, "mediatek,eint-detect-mode",
@@ -554,8 +566,8 @@ static void config_digital_init_by_mode(struct mt6359_accdet *priv)
 {
 	/* enable eint cmpmem pwm */
 	regmap_write(priv->regmap, ACCDET_EINT_CMPMEN_PWM_THRESH_ADDR,
-		     (priv->data->pwm_deb->eint_pwm_width << 4 |
-		     priv->data->pwm_deb->eint_pwm_thresh));
+		     (ACCDET_EINT_CMPMEN_PWM_WIDTH_400MS << 4 |
+		      ACCDET_EINT_CMPMEN_PWM_THRESH_2MS));
 	/* DA signal stable */
 	if (priv->caps & ACCDET_PMIC_EINT0) {
 		regmap_write(priv->regmap, ACCDET_DA_STABLE_ADDR,
@@ -675,22 +687,22 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 	mdelay(1);
 	/* init the debounce time (debounce/32768)sec */
 	accdet_set_debounce(priv, accdet_state000,
-			    priv->data->pwm_deb->debounce0);
+			    ACCDET_DEBOUNCE0_625MS);
 	accdet_set_debounce(priv, accdet_state001,
-			    priv->data->pwm_deb->debounce1);
+			    ACCDET_DEBOUNCE1_625MS);
 	accdet_set_debounce(priv, accdet_state011,
-			    priv->data->pwm_deb->debounce3);
+			    ACCDET_DEBOUNCE3_976US);
 	accdet_set_debounce(priv, accdet_auxadc,
-			    priv->data->pwm_deb->debounce4);
+			    ACCDET_DEBOUNCE_AUXADC_2MS);
 
 	accdet_set_debounce(priv, eint_state000,
-			    priv->data->pwm_deb->eint_debounce0);
+			    ACCDET_EINT_DEBOUNCE0_1MS);
 	accdet_set_debounce(priv, eint_state001,
-			    priv->data->pwm_deb->eint_debounce1);
+			    ACCDET_EINT_DEBOUNCE1_900US);
 	accdet_set_debounce(priv, eint_state011,
-			    priv->data->pwm_deb->eint_debounce3);
+			    ACCDET_EINT_DEBOUNCE3_1MS);
 	accdet_set_debounce(priv, eint_inverter_state000,
-			    priv->data->pwm_deb->eint_inverter_debounce);
+			    ACCDET_EINT_INVERTER_DEBOUNCE_256MS);
 
 	regmap_update_bits(priv->regmap, RG_ACCDET_RST_ADDR,
 			   RG_ACCDET_RST_MASK_SFT, BIT(RG_ACCDET_RST_SFT));
@@ -705,12 +717,12 @@ static void mt6359_accdet_init(struct mt6359_accdet *priv)
 
 	/* init pwm frequency, duty & rise/falling delay */
 	regmap_write(priv->regmap, ACCDET_PWM_WIDTH_ADDR,
-		     REGISTER_VAL(priv->data->pwm_deb->pwm_width));
+		     REGISTER_VAL(ACCDET_PWM_WIDTH_25_580HZ));
 	regmap_write(priv->regmap, ACCDET_PWM_THRESH_ADDR,
-		     REGISTER_VAL(priv->data->pwm_deb->pwm_thresh));
+		     REGISTER_VAL(ACCDET_PWM_THRESH_100PERCENT));
 	regmap_write(priv->regmap, ACCDET_RISE_DELAY_ADDR,
-		     (priv->data->pwm_deb->fall_delay << 15 |
-		      priv->data->pwm_deb->rise_delay));
+		     (ACCDET_FALL_DELAY << 15 |
+		      ACCDET_RISE_DELAY));
 
 	regmap_read(priv->regmap, RG_AUDPWDBMICBIAS1_ADDR, &reg);
 	if (priv->data->mic_vol <= 7) {
@@ -806,12 +818,6 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 	if (!priv->data)
 		return -ENOMEM;
 
-	priv->data->pwm_deb = devm_kzalloc(&pdev->dev,
-					   sizeof(struct pwm_deb_settings),
-					   GFP_KERNEL);
-	if (!priv->data->pwm_deb)
-		return -ENOMEM;
-
 	priv->regmap = mt6397->regmap;
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index 99de5037a2294b62cb8535fc45dbf4c6fafb5c7f..287201eebe0330fa170093fd6192bf5694c30469 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -50,30 +50,10 @@ enum {
 	eint_inverter_state000,
 };
 
-struct pwm_deb_settings {
-	unsigned int pwm_width;
-	unsigned int pwm_thresh;
-	unsigned int fall_delay;
-	unsigned int rise_delay;
-	unsigned int debounce0;
-	unsigned int debounce1;
-	unsigned int debounce3;
-	unsigned int debounce4;
-	unsigned int eint_pwm_width;
-	unsigned int eint_pwm_thresh;
-	unsigned int eint_debounce0;
-	unsigned int eint_debounce1;
-	unsigned int eint_debounce2;
-	unsigned int eint_debounce3;
-	unsigned int eint_inverter_debounce;
-
-};
-
 struct dts_data {
 	unsigned int mic_vol;
 	unsigned int mic_mode;
 	bool hp_eint_high;
-	struct pwm_deb_settings *pwm_deb;
 	unsigned int eint_detect_mode;
 	unsigned int eint_comp_vth;
 };

-- 
2.48.1


