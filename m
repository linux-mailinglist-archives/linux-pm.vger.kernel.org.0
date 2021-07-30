Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991BC3DB846
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhG3MHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 08:07:38 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:41726 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbhG3MHT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 08:07:19 -0400
Date:   Fri, 30 Jul 2021 12:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627646831;
        bh=DlAaKUEEimKTCv4vo156aUl4/sao6sK0Mzn0cpFq5m8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=GEWyvyLqrXC9EGejOjHBvTupauKCCiC433ggKtywkLJkvfCSXHADkOIHh0H9Iwmei
         AoKdfEOwK60kzEBKimRmdW3c1Np+HIDD/786vZIocWSpB53B5mmEFbLEfbfctkLsI1
         sbxtuUQnvhOHvCWrLBCl//T6YNk95+i6lRM52+V8=
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 2/5] dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
Message-ID: <ZVvAExe4M0FBjFki0qOT6xN24Q9mk9yw0QU7A5uGxo@cp4-web-027.plabs.ch>
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

Move SDM660 to a new shared file to allow for adding other similar SoCs.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../interconnect/{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml} | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (91%)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yam=
l b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
similarity index 91%
rename from Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
index 29de7807df54..ea80bd50fd50 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
@@ -1,17 +1,18 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$id: http://devicetree.org/schemas/interconnect/qcom,rpm-qos.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Qualcomm SDM660 Network-On-Chip interconnect
+title: Qualcomm RPM-QoS Network-On-Chip Interconnect
=20
 maintainers:
   - AngeloGioacchino Del Regno <kholk11@gmail.com>
=20
 description: |
-  The Qualcomm SDM660 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
+  RPM-QoS interconnect providers support system bandwidth requirements thr=
ough
+  both the RPM processor and direct AP control. The provider is able to
+  communicate with the RPM through the RPM shared memory device.
=20
 properties:
   reg:
--=20
2.32.0


