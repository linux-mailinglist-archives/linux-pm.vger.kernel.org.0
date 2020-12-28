Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7B2E36B2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 12:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgL1Lh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 06:37:27 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:33743 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgL1Lh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 06:37:26 -0500
Date:   Mon, 28 Dec 2020 11:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609155388;
        bh=mEKKFahaecgG/O2uWHVS+MnqiaE2ZNEu6BmGundO7+w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ie4cJL5tXhHnoDSSouuXH48/ZlkAvR6tRWr640pFiYU+68cDOkZM+kreg2fyYIj4/
         BLG5ar1ELo0gSW3bfwOcSoWVERgzoSJx3cPgZQcYpvYTeP5h4sTwSxnuKk86TstC7l
         4uugp+grNP7xn2ufUNr1Ji0/GweMllc6A8s1p6D8=
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
Subject: [PATCH v5 6/8] ARM: dts: exynos: Add muic and charger nodes for Trats
Message-ID: <20201228113507.1292506-6-timon.baetz@protonmail.com>
In-Reply-To: <20201228113507.1292506-1-timon.baetz@protonmail.com>
References: <20201228113507.1292506-1-timon.baetz@protonmail.com>
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
charger node is used to point to muic.

Note: charging control is not working as we don't have a charger-supply.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exy=
nos4210-trats.dts
index a226bec56a45..686465f0044b 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -459,6 +459,15 @@ EN32KHZ_CP {
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
+=09=09=09extcon =3D <&muic>;
+=09=09};
 =09};
 };
=20
--=20
2.25.1


