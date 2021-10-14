Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1605242D4F1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJNIeW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:34:22 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:39607 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJNIeV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:34:21 -0400
Date:   Thu, 14 Oct 2021 08:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200329;
        bh=pvJWoFtndpxDhySGJMrJhaM/Z6330ccvBeIuKB/ioEw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cpjoFexp6NxmWMtKUjvrADmOmnUs+Iy0p17w5oAsAsotukZLCSeSOJy/WVaAwxZH0
         Wi+OUjMDIzsrYP4u2j7LbRN6gKdshUYfOWNILe/aVBolU4fpGLehaqa1ony2SHgMYB
         8eg2uwUxWQE9dqfW61TQiodvk3D3IqFOdkDvdg9I=
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
Subject: [PATCH 2/8] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
Message-ID: <20211014083016.137441-3-y.oudjana@protonmail.com>
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

Add a compatible string for msm8996pro-apcc.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml=
 b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index 325f8aef53b2..ad77175dda45 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8996-apcc
+      - qcom,msm8996pro-apcc
=20
   reg:
     items:
--=20
2.33.0


