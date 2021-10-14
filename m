Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5642D4FC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJNIet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:34:49 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:37014 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJNIen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:34:43 -0400
Date:   Thu, 14 Oct 2021 08:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200350;
        bh=r2jsnt/Qk/sTZ3x3CoZXpFofwOcynyE916+4+5ktzhE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZjmFs2OXDqdT1Lb6NVkAm6muTNhxOwCR2eydn/+syt4/binzYIBAJ86OvjuHefiKz
         2IoG4tiIx+hfXUun6RfMeuL+3RIp6nSKWSymJcdftgmfEc7kMMTz7BZScQgKW2Te6Q
         6IPUw1T1jXp0nwcWSTZ6Yn+3xxeOuBZIvLM2fcoI=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 3/8] clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
Message-ID: <20211014083016.137441-4-y.oudjana@protonmail.com>
In-Reply-To: <20211014083016.137441-1-y.oudjana@protonmail.com>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8996 Pro (MSM8996SG) has a few differences in the CBF clock.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: qcom: msm8996-cpu: Add CBF support
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dyb=
cio@somainline.org/

 drivers/clk/qcom/clk-cpu-8996.c | 61 +++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-899=
6.c
index 8afc271f92d0..ab2acbe74f0f 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -70,11 +70,11 @@ enum _pmux_input {
=20
 enum {
 =09CBF_PLL_INDEX =3D 1,
-=09CBF_DIV_2_INDEX,
+=09CBF_DIV_INDEX,
 =09CBF_SAFE_INDEX
 };
=20
-#define DIV_2_THRESHOLD=09=09600000000
+#define DIV_THRESHOLD=09=09600000000
 #define PWRCL_REG_OFFSET 0x0
 #define PERFCL_REG_OFFSET 0x80000
 #define MUX_OFFSET=090x40
@@ -142,6 +142,17 @@ static const struct alpha_pll_config cbfpll_config =3D=
 {
 =09.early_output_mask =3D BIT(3),
 };
=20
+static const struct alpha_pll_config cbfpll_config_pro =3D {
+=09.l =3D 72,
+=09.config_ctl_val =3D 0x200d4aa8,
+=09.config_ctl_hi_val =3D 0x006,
+=09.pre_div_mask =3D BIT(12),
+=09.post_div_mask =3D 0x3 << 8,
+=09.post_div_val =3D 0x3 << 8,
+=09.main_output_mask =3D BIT(0),
+=09.early_output_mask =3D BIT(3),
+};
+
 static struct clk_alpha_pll perfcl_pll =3D {
 =09.offset =3D PERFCL_REG_OFFSET,
 =09.regs =3D prim_pll_regs,
@@ -230,7 +241,8 @@ struct clk_cpu_8996_mux {
 =09u8=09width;
 =09struct notifier_block nb;
 =09struct clk_hw=09*pll;
-=09struct clk_hw=09*pll_div_2;
+=09struct clk_hw=09*pll_div;
+=09u8 div;
 =09struct clk_regmap clkr;
 };
=20
@@ -280,11 +292,11 @@ static int clk_cpu_8996_mux_determine_rate(struct clk=
_hw *hw,
 =09struct clk_cpu_8996_mux *cpuclk =3D to_clk_cpu_8996_mux_hw(hw);
 =09struct clk_hw *parent =3D cpuclk->pll;
=20
-=09if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
-=09=09if (req->rate < (DIV_2_THRESHOLD / 2))
+=09if (cpuclk->pll_div &&req->rate < DIV_THRESHOLD) {
+=09=09if (req->rate < (DIV_THRESHOLD / cpuclk->div))
 =09=09=09return -EINVAL;
=20
-=09=09parent =3D cpuclk->pll_div_2;
+=09=09parent =3D cpuclk->pll_div;
 =09}
=20
 =09req->best_parent_rate =3D clk_hw_round_rate(parent, req->rate);
@@ -336,7 +348,8 @@ static struct clk_cpu_8996_mux pwrcl_pmux =3D {
 =09.shift =3D 0,
 =09.width =3D 2,
 =09.pll =3D &pwrcl_pll.clkr.hw,
-=09.pll_div_2 =3D &pwrcl_smux.clkr.hw,
+=09.pll_div =3D &pwrcl_smux.clkr.hw,
+=09.div =3D 2,
 =09.nb.notifier_call =3D cpu_clk_notifier_cb,
 =09.clkr.hw.init =3D &(struct clk_init_data) {
 =09=09.name =3D "pwrcl_pmux",
@@ -358,7 +371,8 @@ static struct clk_cpu_8996_mux perfcl_pmux =3D {
 =09.shift =3D 0,
 =09.width =3D 2,
 =09.pll =3D &perfcl_pll.clkr.hw,
-=09.pll_div_2 =3D &perfcl_smux.clkr.hw,
+=09.pll_div =3D &perfcl_smux.clkr.hw,
+=09.div =3D 2,
 =09.nb.notifier_call =3D cpu_clk_notifier_cb,
 =09.clkr.hw.init =3D &(struct clk_init_data) {
 =09=09.name =3D "perfcl_pmux",
@@ -481,19 +495,23 @@ static int qcom_cbf_clk_msm8996_register_clks(struct =
device *dev,
 =09=09=09=09=09      struct regmap *regmap)
 {
 =09int ret;
+=09bool is_pro =3D of_device_is_compatible(dev->of_node, "qcom,msm8996pro-=
apcc");
=20
-=09cbf_mux.pll_div_2 =3D clk_hw_register_fixed_factor(dev, "cbf_pll_main",
-=09=09=09=09=09=09      "cbf_pll", CLK_SET_RATE_PARENT,
-=09=09=09=09=09=09      1, 2);
-=09if (IS_ERR(cbf_mux.pll_div_2)) {
+=09cbf_mux.div =3D is_pro ? 4 : 2;
+=09cbf_mux.pll_div =3D clk_hw_register_fixed_factor(dev, "cbf_pll_main",
+=09=09=09=09=09=09       "cbf_pll", CLK_SET_RATE_PARENT,
+=09=09=09=09=09=09       1, cbf_mux.div);
+
+=09if (IS_ERR(cbf_mux.pll_div)) {
 =09=09dev_err(dev, "Failed to initialize cbf_pll_main\n");
-=09=09return PTR_ERR(cbf_mux.pll_div_2);
+=09=09return PTR_ERR(cbf_mux.pll_div);
 =09}
=20
 =09ret =3D devm_clk_register_regmap(dev, cbf_msm8996_clks[0]);
 =09ret =3D devm_clk_register_regmap(dev, cbf_msm8996_clks[1]);
=20
-=09clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
+=09clk_alpha_pll_configure(&cbf_pll, regmap, is_pro ?
+=09=09=09=09&cbfpll_config_pro : &cbfpll_config);
 =09clk_set_rate(cbf_pll.clkr.hw.clk, 614400000);
 =09clk_prepare_enable(cbf_pll.clkr.hw.clk);
 =09clk_notifier_register(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
@@ -575,7 +593,7 @@ static int cpu_clk_notifier_cb(struct notifier_block *n=
b, unsigned long event,
 =09=09qcom_cpu_clk_msm8996_acd_init(base);
 =09=09break;
 =09case POST_RATE_CHANGE:
-=09=09if (cnd->new_rate < DIV_2_THRESHOLD)
+=09=09if (cnd->new_rate < DIV_THRESHOLD)
 =09=09=09ret =3D clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
 =09=09=09=09=09=09=09  DIV_2_INDEX);
 =09=09else
@@ -600,15 +618,15 @@ static int cbf_clk_notifier_cb(struct notifier_block =
*nb, unsigned long event,
=20
 =09switch (event) {
 =09case PRE_RATE_CHANGE:
-=09=09parent =3D clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_2_IN=
DEX);
-=09=09ret =3D clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDE=
X);
+=09=09parent =3D clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_INDE=
X);
+=09=09ret =3D clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX)=
;
=20
-=09=09if (cnd->old_rate > DIV_2_THRESHOLD && cnd->new_rate < DIV_2_THRESHO=
LD)
-=09=09=09ret =3D clk_set_rate(parent->clk, cnd->old_rate / 2);
+=09=09if (cnd->old_rate > DIV_THRESHOLD && cnd->new_rate < DIV_THRESHOLD)
+=09=09=09ret =3D clk_set_rate(parent->clk, cnd->old_rate / cbfclk->div);
 =09=09break;
 =09case POST_RATE_CHANGE:
-=09=09if (cnd->new_rate < DIV_2_THRESHOLD)
-=09=09=09ret =3D clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_I=
NDEX);
+=09=09if (cnd->new_rate < DIV_THRESHOLD)
+=09=09=09ret =3D clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_IND=
EX);
 =09=09else {
 =09=09=09parent =3D clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_PLL_I=
NDEX);
 =09=09=09ret =3D clk_set_rate(parent->clk, cnd->new_rate);
@@ -676,6 +694,7 @@ static int qcom_cpu_clk_msm8996_driver_remove(struct pl=
atform_device *pdev)
=20
 static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] =3D {
 =09{ .compatible =3D "qcom,msm8996-apcc" },
+=09{ .compatible =3D "qcom,msm8996pro-apcc" },
 =09{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpu_clk_msm8996_match_table);
--=20
2.33.0


