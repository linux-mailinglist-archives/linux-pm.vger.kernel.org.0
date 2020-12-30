Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01ED2E7C69
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL3Uxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 15:53:31 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:19001 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgL3Ux1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 15:53:27 -0500
Date:   Wed, 30 Dec 2020 20:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609361565;
        bh=QcfiTWtTDArQ+22+ZzQYt+73XP/h9+2hnvwT2W0jOXU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pCaZ34+Lax1GV/ryEs0iQDKv6MAq0n7l8aRUpzizCAr0Hmkm1DZXymJnM7AYsz81i
         2rzHVsAO+yf/3/VpBuBhskMXKS+BWmxWeLSSkbuNoQ8XUJo6/V4lGQL0JM6aic2Tm6
         LOb4AlfR2jslQc7Jk1uPdGFVLYrS5kyqu7rmeT3I=
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
Subject: [PATCH v6 5/8] ARM: dts: exynos: Add muic and charger nodes for Origen
Message-ID: <20201230205139.1812366-5-timon.baetz@protonmail.com>
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

Both nodes are disabled as there is no battery and pins are not
connected.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
v6: No change.
v5: Add patch.

 arch/arm/boot/dts/exynos4210-origen.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/ex=
ynos4210-origen.dts
index 7d2cfbafefb2..9792531ac3da 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -312,6 +312,16 @@ EN32KHZ_AP {
 =09=09=09=09regulator-always-on;
 =09=09=09};
 =09=09};
+
+=09=09muic {
+=09=09=09compatible =3D "maxim,max8997-muic";
+=09=09=09status =3D "disabled";
+=09=09};
+
+=09=09charger {
+=09=09=09compatible =3D "maxim,max8997-battery";
+=09=09=09status =3D "disabled";
+=09=09};
 =09};
 };
=20
--=20
2.25.1


