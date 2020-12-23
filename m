Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8139D2E1CD6
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 14:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgLWNoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 08:44:22 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:16582 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgLWNoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:44:20 -0500
Date:   Wed, 23 Dec 2020 13:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608731017;
        bh=CZAYsRHV593ZQXe0ik2Cb4E+1qQpPIw5P6nDjWNCENA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=t+2ntKFI97kioYC0Q+Rf4hYCMYler6OEO+Vap4VG39PoRhLzQDFr+5JoVN9DiqTpR
         dVk4H4VRVppCnvZI80Frog8VtT69QHOGIL6XqA4F8ZI25LKr7GVmh4ZnTopxTuV/m4
         Yvx7pYMgCvCmnt8JX2znfpOoWWluVjndDB6wd3U8=
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
Subject: [PATCH v4 7/7] ARM: dts: exynos: Add top-off charging regulator node for i9100
Message-ID: <20201223134221.804943-7-timon.baetz@protonmail.com>
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

Value taken from Galaxy S2 Epic 4G Touch SPH-D710 Android vendor
kernel [0] which always sets 200mA.

Also rearrange regulators based on definition in max8997.h.

[0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic=
-4g-touch-sph-d710-exynos4210-dump/drivers/power/sec_battery_u1.c#L1525

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
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


