Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C642D4EC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhJNIdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:33:45 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:37864 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJNIdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:33:44 -0400
Date:   Thu, 14 Oct 2021 08:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200296;
        bh=xvQBlmwCdU7fyQyVEeG5Hg3WKO2oNNUQWC2o9rpBt60=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=gXV1QQReCwCZN3+X1V+MMnkWg8gdsGOuFI4sSMMqfDxCNaqRTjMEM5kot3SdbvKRR
         QbdY/AnE7wiBICXpnn6FhfXpsT0Z2kwVVu9RAvinj3SrlB57uMVnkpqCWWajdP5BqP
         Q/RHpsdsod99aDG/bVPi+SaOuajFmYVJr6gRGVrk=
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
Subject: [PATCH 1/8] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Message-ID: <20211014083016.137441-2-y.oudjana@protonmail.com>
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

Add CBF clock and reg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml=
 b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index a20cb10636dd..325f8aef53b2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
=20
 description: |
-  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power clu=
ster
-  and clock 1 is for Perf cluster.
+  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power clu=
ster,
+  clock 1 is for Perf cluster, and clock 2 is for Coherent bus fabric (CBF=
).
=20
 properties:
   compatible:
@@ -19,7 +19,9 @@ properties:
       - qcom,msm8996-apcc
=20
   reg:
-    maxItems: 1
+    items:
+      - description: Cluster clock registers
+      - description: CBF clock registers
=20
   '#clock-cells':
     const: 1
@@ -49,6 +51,6 @@ examples:
   - |
     kryocc: clock-controller@6400000 {
         compatible =3D "qcom,msm8996-apcc";
-        reg =3D <0x6400000 0x90000>;
+        reg =3D <0x6400000 0x90000>, <0x09a11000 0x10000>;
         #clock-cells =3D <1>;
     };
--=20
2.33.0


