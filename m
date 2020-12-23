Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31B72E1CC3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgLWNni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 08:43:38 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:42130 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgLWNni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:43:38 -0500
Date:   Wed, 23 Dec 2020 13:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608730975;
        bh=aKEZ6Y7hUJjLgA6UhaG9WsQDLOLZhvYODKCTOR/CdWg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aI7F5P6rOTd2EZnyyFWVpr4Rg7nqWUKDMsBU7uDXgclISt+DVRCaawPBgeFJiU9CZ
         gnvZaOSWyRnLnRcucLqSOeNbiTJbziko1JwblTe03cgL2LDC0Z8hoke0I5ZB6Gvs4+
         tQALQ3dKSOIMeJDx+nTcvtUE1fd7Ne0R7XcPvhtA=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v4 2/7] regulator: dt-bindings: Document max8997-pmic nodes
Message-ID: <20201223134221.804943-2-timon.baetz@protonmail.com>
In-Reply-To: <20201223134221.804943-1-timon.baetz@protonmail.com>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
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

Add maxim,max8997-battery and maxim,max8997-muic optional nodes.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 .../bindings/regulator/max8997-regulator.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.=
txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
index 6fe825b8ac1b..faaf2bbf0272 100644
--- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
@@ -53,6 +53,18 @@ Additional properties required if either of the optional=
 properties are used:
 - max8997,pmic-buck125-dvs-gpios: GPIO specifiers for three host gpio's us=
ed
   for dvs. The format of the gpio specifier depends in the gpio controller=
.
=20
+Optional nodes:
+- charger: Node for configuring the charger driver.
+  Required properties:
+  - compatible: "maxim,max8997-battery"
+  Optional properties:
+  - extcon: extcon specifier for charging events
+  - charger-supply: regulator node for charging current
+
+- muic: Node used only by extcon consumers.
+  Required properties:
+  - compatible: "maxim,max8997-muic"
+
 Regulators: The regulators of max8997 that have to be instantiated should =
be
 included in a sub-node named 'regulators'. Regulator nodes included in thi=
s
 sub-node should be of the format as listed below.
--=20
2.25.1


