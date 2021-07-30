Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0A3DB84D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhG3MIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 08:08:12 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:23630 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbhG3MIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 08:08:07 -0400
Date:   Fri, 30 Jul 2021 12:07:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627646879;
        bh=7h0NTb4ejwZjqoU6a0ptx/d/UaJLqNn5OS+UhVeJG5Q=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=QlQPFV7aPHxlvFq9Mv6mV+M0u+7/bOU4VuyNhwf34zVkyeWYORYA91oDNQpW4VVWW
         yzqi0yiPVpL0f82PQfVVjti88mrlIB0oeGWaEAP7owS5hJ4t5fpSZzIUA72bjdGePq
         MR8ZkgDiiB8ZiKIFcM/UO7qHofmz796p1tPqi8bc=
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
Subject: [PATCH 4/5] dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
Message-ID: <D3IjaMUHO8ZiIM1zUenrvbqButohtsrh0s2PozDO0@cp7-web-046.plabs.ch>
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

Add bindings for interconnects on Qualcomm MSM8996.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/interconnect/qcom,rpm-qos.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.ya=
ml b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
index ea80bd50fd50..3e376ca413bf 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
@@ -20,6 +20,13 @@ properties:
=20
   compatible:
     enum:
+      - qcom,msm8996-a1noc
+      - qcom,msm8996-a2noc
+      - qcom,msm8996-bimc
+      - qcom,msm8996-cnoc
+      - qcom,msm8996-mnoc
+      - qcom,msm8996-pnoc
+      - qcom,msm8996-snoc
       - qcom,sdm660-a2noc
       - qcom,sdm660-bimc
       - qcom,sdm660-cnoc
@@ -53,6 +60,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-mnoc
               - qcom,sdm660-mnoc
     then:
       properties:
@@ -72,6 +80,12 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-a1noc
+              - qcom,msm8996-a2noc
+              - qcom,msm8996-bimc
+              - qcom,msm8996-cnoc
+              - qcom,msm8996-pnoc
+              - qcom,msm8996-snoc
               - qcom,sdm660-a2noc
               - qcom,sdm660-bimc
               - qcom,sdm660-cnoc
--=20
2.32.0


