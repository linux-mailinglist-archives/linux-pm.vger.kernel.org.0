Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1753DCC5F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhHAPZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 11:25:55 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:48311 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhHAPZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 11:25:54 -0400
Date:   Sun, 01 Aug 2021 15:25:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627831540;
        bh=7h0NTb4ejwZjqoU6a0ptx/d/UaJLqNn5OS+UhVeJG5Q=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rxmeNJBaE9f09f74GqTbNUj2HkpP0vXwp4UZxD/7RD3gy8yM0t0F0nLO3uHi7/Gtm
         cF7Km94Q91jmYc9g2Kbqfdq0mxwCkJLfVYBHqh8H2iDUyp6kUACKAtUdprtO8fru6z
         A2z5LdnGZ2g1+K11gwxjKb22kSH3kgYWNfOs35O8=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 5/6] dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
Message-ID: <20210801152427.475547-6-y.oudjana@protonmail.com>
In-Reply-To: <20210801152427.475547-1-y.oudjana@protonmail.com>
References: <20210801152427.475547-1-y.oudjana@protonmail.com>
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


