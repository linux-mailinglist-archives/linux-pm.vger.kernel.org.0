Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE742D796
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJNLCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 07:02:55 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:45294 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNLCz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 07:02:55 -0400
Date:   Thu, 14 Oct 2021 11:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634209249;
        bh=n4mPtVUr59VWCEZFnidSyoUyIQYDVsWqg6brIjzb/V0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hJbkHlvxKU5St/2CCdsloP3Enf4Y57xvBMKs2JmqmHQQtYkBSH9esuI96PrJFMau2
         ZxVMrNaSnlpEnJtC+/Kr3RoGYNWeFCrtfXx91bsJ1amiUxNbWkqBouKKILIK1so5Zr
         ilQgYf2ectR+fS/ku9R5a5w8CixIot5wcXHUeuVo=
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
Subject: [PATCH 8/8] arm64: dts: qcom: msm8996-xiaomi-scorpio: Include msm8996pro.dtsi
Message-ID: <20211014110024.5869-1-y.oudjana@protonmail.com>
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

Move msm8996.dtsi include to the end of the include chain.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 3 ---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts  | 1 +
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm=
64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index d239b01b8505..831cd39aff14 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -3,9 +3,6 @@
  * Copyright (c) 2020, Yassine Oudjana <y.oudjana@protonmail.com>
  */
=20
-/dts-v1/;
-
-#include "msm8996.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm6=
4/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 77d508e5164a..8ea5390f86ab 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -5,6 +5,7 @@
=20
 /dts-v1/;
=20
+#include "msm8996.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm=
64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index ea2ca271fe7d..4ffe7be34285 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -5,6 +5,7 @@
=20
 /dts-v1/;
=20
+#include "msm8996pro.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include "pmi8996.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -13,7 +14,6 @@
 / {
 =09model =3D "Xiaomi Mi Note 2";
 =09compatible =3D "xiaomi,scorpio", "qcom,msm8996";
-=09qcom,msm-id =3D <305 0x10000>;
 =09qcom,board-id =3D <34 0>;
=20
 =09chosen {
--=20
2.33.0


