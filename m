Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C343FD955
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbhIAMRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 08:17:09 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:36307 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbhIAMRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 08:17:08 -0400
Date:   Wed, 01 Sep 2021 12:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630498568;
        bh=J6BObm/9eXOSfiRQZ9X59U6JXwyZYca747tXZKGmQOk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ae8fjpaIkHyocAA0Vla39S6G+qg4iE25xgV4bjPyntnwqpxDZ72mO4OsU85Yej2NG
         +ZOHH6KeyIFMh64M+5nGGnMeLrHCoJsuNqkjSPsFoBPKu0aa7sFflgzsgGTzI9Cfal
         P8oZ9/TIHKHBswxhgqEs0YXrL7ZgbedGtBTgl6JU=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v4 2/5] dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
Message-ID: <20210901121518.152481-3-y.oudjana@protonmail.com>
In-Reply-To: <20210901121518.152481-1-y.oudjana@protonmail.com>
References: <20210901121518.152481-1-y.oudjana@protonmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.33.0


