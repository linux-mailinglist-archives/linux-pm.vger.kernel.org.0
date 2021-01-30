Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B4309744
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jan 2021 18:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhA3RaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Jan 2021 12:30:07 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:41251 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhA3RaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2021 12:30:06 -0500
Date:   Sat, 30 Jan 2021 17:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612027764;
        bh=Jef0sxyvy4V4e51bjeysAtFKH9/BhUi4CG0LIgwACFY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=scN7H758NYWgDlCXSVPD5gadJ2SYKpQqwWxUa/KnXQBRi+0yokF8UD4Z4jIfLaC2k
         xewkoOTJigChipX+d0+7qLJ3JTiAr0HHILUUbEiURVt+0N3Pm5tweH8UTCYn+IYTAA
         mO7T2vMK9l+7cTCSPafgsSg9OZoxsL0dTId14pPk=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 1/3] regulator: dt-bindings: Document charger-supply for max8997
Message-ID: <20210130172747.2022977-2-timon.baetz@protonmail.com>
In-Reply-To: <20210130172747.2022977-1-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
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

Add charger-supply optional property to enable charging control.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 .../devicetree/bindings/regulator/max8997-regulator.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.=
txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
index 6fe825b8ac1b..b53c5e2b335f 100644
--- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
@@ -35,6 +35,7 @@ Optional properties:
 - interrupts: Interrupt specifiers for two interrupt sources.
   - First interrupt specifier is for 'irq1' interrupt.
   - Second interrupt specifier is for 'alert' interrupt.
+- charger-supply: regulator node for charging current.
 - max8997,pmic-buck1-uses-gpio-dvs: 'buck1' can be controlled by gpio dvs.
 - max8997,pmic-buck2-uses-gpio-dvs: 'buck2' can be controlled by gpio dvs.
 - max8997,pmic-buck5-uses-gpio-dvs: 'buck5' can be controlled by gpio dvs.
--=20
2.25.1


