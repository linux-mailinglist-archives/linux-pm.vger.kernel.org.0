Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9009E2DFA82
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 10:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgLUJyT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 04:54:19 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:57635 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgLUJyT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 04:54:19 -0500
Date:   Mon, 21 Dec 2020 09:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608544417;
        bh=j9J3/8H1qa8Wh29MrZMYkdOvgangYejK1lwToq6kgws=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=akGsdgo2jCkS5X2KQnXW+RtE0Wt1gqLvtOlDrXoIqMsNGz7AsEDH4okDjlWZOrEQd
         3CEiPHJe44mTXEejfv3S+CfccmxRYbC4wbmfiC3bKXhpKMJxpI0x5QYmYavGBxtqnp
         QbDYi/FJVDqC9o8M9alh9A0ZxRJ5H6i+2CL3tqpk=
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
Subject: [PATCH v2 4/6] ARM: dts: exynos: Added muic and charger nodes for i9100
Message-ID: <20201221095001.595366-4-timon.baetz@protonmail.com>
In-Reply-To: <20201221095001.595366-1-timon.baetz@protonmail.com>
References: <20201202203516.43053-1-timon.baetz@protonmail.com> <20201221095001.595366-1-timon.baetz@protonmail.com>
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

muic node is only used for extcon consumers.
charger node is used to specify muic and regulator.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 56ae534402bb..586d801af0b5 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -583,6 +583,16 @@ EN32KHZ_CP {
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
+
+=09=09muic: max8997-muic {
+=09=09=09compatible =3D "maxim,max8997-muic";
+=09=09};
+
+=09=09charger {
+=09=09=09compatible =3D "maxim,max8997-battery";
+=09=09=09charger-supply =3D <&charger_reg>;
+=09=09=09extcon =3D <&muic>;
+=09=09};
 =09};
 };
=20
--=20
2.25.1


