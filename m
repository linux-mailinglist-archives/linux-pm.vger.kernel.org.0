Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7A42D4F7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJNIel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:34:41 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:19235 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNIej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:34:39 -0400
Date:   Thu, 14 Oct 2021 08:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200352;
        bh=cb0PE4wTqiF3993v3VNBom8zxNRRqaYhqY0S2fZ8dgA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Y9VAzauAVtXsG2V94dnBrYg5MiKiHf2K4YaJqS4qLPWMYWMdVPrYMbsUl8kxUcSfg
         uGnZcmkSgdxqML//StZsmPv4Y2ijvez668Kl73IzOmaSRa7oEGTHk0PkZ0BtgnS4eB
         F+zbPHsJicPT+Xl5UXbcYQSfTtm6cL+h0bz5Ek9g=
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
Subject: [PATCH 4/8] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
Message-ID: <20211014083016.137441-5-y.oudjana@protonmail.com>
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

In preparation for adding a separate device tree for MSM8996 Pro, skip read=
ing
msm-id from smem and just read the speedbin efuse.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/cpufreq/Kconfig.arm          |  1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 75 +++-------------------------
 2 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..7d9798bc5753 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -154,7 +154,6 @@ config ARM_QCOM_CPUFREQ_NVMEM
 =09tristate "Qualcomm nvmem based CPUFreq"
 =09depends on ARCH_QCOM
 =09depends on QCOM_QFPROM
-=09depends on QCOM_SMEM
 =09select PM_OPP
 =09help
 =09  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cp=
ufreq-nvmem.c
index d1744b5d9619..909f7d97b334 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -9,8 +9,8 @@
  * based on the silicon variant in use. Qualcomm Process Voltage Scaling T=
ables
  * defines the voltage and frequency value based on the msm-id in SMEM
  * and speedbin blown in the efuse combination.
- * The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the=
 SoC
- * to provide the OPP framework with required information.
+ * The qcom-cpufreq-nvmem driver reads efuse value from the SoC to provide=
 the
+ * OPP framework with required information.
  * This is used to determine the voltage and frequency value for each OPP =
of
  * operating-points-v2 table when it is parsed by the OPP framework.
  */
@@ -27,22 +27,6 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
-#include <linux/soc/qcom/smem.h>
-
-#define MSM_ID_SMEM=09137
-
-enum _msm_id {
-=09MSM8996V3 =3D 0xF6ul,
-=09APQ8096V3 =3D 0x123ul,
-=09MSM8996SG =3D 0x131ul,
-=09APQ8096SG =3D 0x138ul,
-};
-
-enum _msm8996_version {
-=09MSM8996_V3,
-=09MSM8996_SG,
-=09NUM_OF_MSM8996_VERSIONS,
-};
=20
 struct qcom_cpufreq_drv;
=20
@@ -142,35 +126,6 @@ static void get_krait_bin_format_b(struct device *cpu_=
dev,
 =09dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }
=20
-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
-{
-=09size_t len;
-=09u32 *msm_id;
-=09enum _msm8996_version version;
-
-=09msm_id =3D qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-=09if (IS_ERR(msm_id))
-=09=09return NUM_OF_MSM8996_VERSIONS;
-
-=09/* The first 4 bytes are format, next to them is the actual msm-id */
-=09msm_id++;
-
-=09switch ((enum _msm_id)*msm_id) {
-=09case MSM8996V3:
-=09case APQ8096V3:
-=09=09version =3D MSM8996_V3;
-=09=09break;
-=09case MSM8996SG:
-=09case APQ8096SG:
-=09=09version =3D MSM8996_SG;
-=09=09break;
-=09default:
-=09=09version =3D NUM_OF_MSM8996_VERSIONS;
-=09}
-
-=09return version;
-}
-
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 =09=09=09=09=09  struct nvmem_cell *speedbin_nvmem,
 =09=09=09=09=09  char **pvs_name,
@@ -178,30 +133,13 @@ static int qcom_cpufreq_kryo_name_version(struct devi=
ce *cpu_dev,
 {
 =09size_t len;
 =09u8 *speedbin;
-=09enum _msm8996_version msm8996_version;
 =09*pvs_name =3D NULL;
=20
-=09msm8996_version =3D qcom_cpufreq_get_msm_id();
-=09if (NUM_OF_MSM8996_VERSIONS =3D=3D msm8996_version) {
-=09=09dev_err(cpu_dev, "Not Snapdragon 820/821!");
-=09=09return -ENODEV;
-=09}
-
 =09speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
 =09if (IS_ERR(speedbin))
 =09=09return PTR_ERR(speedbin);
=20
-=09switch (msm8996_version) {
-=09case MSM8996_V3:
-=09=09drv->versions =3D 1 << (unsigned int)(*speedbin);
-=09=09break;
-=09case MSM8996_SG:
-=09=09drv->versions =3D 1 << ((unsigned int)(*speedbin) + 4);
-=09=09break;
-=09default:
-=09=09BUG();
-=09=09break;
-=09}
+=09drv->versions =3D 1 << (unsigned int)(*speedbin);
=20
 =09kfree(speedbin);
 =09return 0;
@@ -464,10 +402,9 @@ static const struct of_device_id qcom_cpufreq_match_li=
st[] __initconst =3D {
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
=20
 /*
- * Since the driver depends on smem and nvmem drivers, which may
- * return EPROBE_DEFER, all the real activity is done in the probe,
- * which may be defered as well. The init here is only registering
- * the driver and the platform device.
+ * Since the driver depends on the nvmem driver, which may return EPROBE_D=
EFER,
+ * all the real activity is done in the probe, which may be defered as wel=
l.
+ * The init here is only registering the driver and the platform device.
  */
 static int __init qcom_cpufreq_init(void)
 {
--=20
2.33.0


