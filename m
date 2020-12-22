Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0680F2E06D6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 08:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLVHcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 02:32:45 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:36846 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLVHcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 02:32:45 -0500
Date:   Tue, 22 Dec 2020 07:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608622322;
        bh=2J2HkMO1x6s17YhUEXyxsyS33PdVMCQ5VOjC6KfqhmA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aVvdIMuIvl9eX60Lfs0XVBeA8wxoTq79qCCHbtgWNN2LIDx8wYCCLLPisQtc/cvnl
         2r4rbweGSMJxxe2US2etcOFm3x8xbv7fkLEWMZ1tQffs8yivInZ5b32Z7Awi53ZuHC
         ztbw1nW2kF8XXfLIjc9S1Htnfl1zwodil54vGk2M=
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
Subject: [PATCH v3 6/7] ARM: dts: exynos: Fix charging regulator voltage and current for i9100
Message-ID: <20201222070520.710096-6-timon.baetz@protonmail.com>
In-Reply-To: <20201222070520.710096-1-timon.baetz@protonmail.com>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
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

Set CHARGER current and CHARGER_CV voltage according to Galaxy S2 Epic
4G Touch SPH-D710 Android vendor sources [0,1].

Remove regulator-always-on. The regulator can be enabled and disabled
based on extcon events.

[0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/power/max8997_charger_u1.c#L169-=
L170
[1] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/power/max8997_charger_u1.c#L390-=
L391

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 8fa704babd5e..586d801af0b5 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -562,15 +562,14 @@ safe2_sreg: ESAFEOUT2 {
=20
 =09=09=09charger_reg: CHARGER {
 =09=09=09=09regulator-name =3D "CHARGER";
-=09=09=09=09regulator-min-microamp =3D <60000>;
-=09=09=09=09regulator-max-microamp =3D <2580000>;
-=09=09=09=09regulator-always-on;
+=09=09=09=09regulator-min-microamp =3D <200000>;
+=09=09=09=09regulator-max-microamp =3D <950000>;
 =09=09=09};
=20
 =09=09=09chargercv_reg: CHARGER_CV {
 =09=09=09=09regulator-name =3D "CHARGER_CV";
-=09=09=09=09regulator-min-microvolt =3D <3800000>;
-=09=09=09=09regulator-max-microvolt =3D <4100000>;
+=09=09=09=09regulator-min-microvolt =3D <4200000>;
+=09=09=09=09regulator-max-microvolt =3D <4200000>;
 =09=09=09=09regulator-always-on;
 =09=09=09};
=20
--=20
2.25.1


