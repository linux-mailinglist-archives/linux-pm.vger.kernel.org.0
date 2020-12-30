Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B912E7C73
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 21:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgL3UyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 15:54:00 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:53241 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL3Ux7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 15:53:59 -0500
Date:   Wed, 30 Dec 2020 20:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609361597;
        bh=uYDyTYEISn/6Dn56ySZ1G8C+g1webIBwDMuMSIUTjPM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AsELXTqyVYE4EDeDlC04hCVT4g0IYLBL71lOWBBL8nVi94pY+dqqmQ7mF2JpSiy7n
         8o9xedGqF9lLl5rDEYfggsQXwRFJT8B9iJkD6+tblc+kK9wp22apF2XmqkaaWnEXB7
         6oZuXNkdmbz3AWB/dvDhuAhtQbcq/xfp0W0FF+EU=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: [PATCH v6 8/8] ARM: dts: exynos: Add top-off charging regulator node for I9100
Message-ID: <20201230205139.1812366-8-timon.baetz@protonmail.com>
In-Reply-To: <20201230205139.1812366-1-timon.baetz@protonmail.com>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
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

Value taken from Galaxy S2 Epic 4G Touch SPH-D710 Android vendor
kernel [0] which always sets 200mA.

Also rearrange regulators based on definition in max8997.h.

[0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/power/sec_battery_u1.c#L1525

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
v6: No change.
v5: No change.
v4: No change.
v3: Remove label.=20
    Fix commit message.
v2: Add patch.

 arch/arm/boot/dts/exynos4210-i9100.dts | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exy=
nos4210-i9100.dts
index 586d801af0b5..e702adb69670 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -560,6 +560,16 @@ safe2_sreg: ESAFEOUT2 {
 =09=09=09=09regulator-boot-on;
 =09=09=09};
=20
+=09=09=09EN32KHZ_AP {
+=09=09=09=09regulator-name =3D "EN32KHZ_AP";
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
+=09=09=09EN32KHZ_CP {
+=09=09=09=09regulator-name =3D "EN32KHZ_CP";
+=09=09=09=09regulator-always-on;
+=09=09=09};
+
 =09=09=09charger_reg: CHARGER {
 =09=09=09=09regulator-name =3D "CHARGER";
 =09=09=09=09regulator-min-microamp =3D <200000>;
@@ -573,13 +583,10 @@ chargercv_reg: CHARGER_CV {
 =09=09=09=09regulator-always-on;
 =09=09=09};
=20
-=09=09=09EN32KHZ_AP {
-=09=09=09=09regulator-name =3D "EN32KHZ_AP";
-=09=09=09=09regulator-always-on;
-=09=09=09};
-
-=09=09=09EN32KHZ_CP {
-=09=09=09=09regulator-name =3D "EN32KHZ_CP";
+=09=09=09CHARGER_TOPOFF {
+=09=09=09=09regulator-name =3D "CHARGER_TOPOFF";
+=09=09=09=09regulator-min-microamp =3D <200000>;
+=09=09=09=09regulator-max-microamp =3D <200000>;
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
--=20
2.25.1


