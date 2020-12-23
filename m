Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137182E1CBF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgLWNn2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 08:43:28 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:42925 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgLWNn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:43:27 -0500
Date:   Wed, 23 Dec 2020 13:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608730965;
        bh=uD0o1RGxUdohZwqEit8GaCkXhH2zAclkKXfTpSwZqmA=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=WIkDn5kFXqS8/edjTH+tgQkmaw5smZ3INaZ6dBX0cmabKxd+dF3tuIFiZ6T64KWUQ
         KWVVcU2V3anrFhWZNqFb2ByOCPraiXHuuWXz6hOLY3yuSDS7tFNf2dfZConLPtoovG
         UzqIZZPmGMDLku6ydDpe74JR6+vCQH/s1NaFTsN0=
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
Subject: [PATCH v4 1/7] extcon: max8997: Add CHGINS and CHGRM interrupt handling
Message-ID: <20201223134221.804943-1-timon.baetz@protonmail.com>
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

This allows the MAX8997 charger to set the current limit depending on
the detected extcon charger type.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/extcon/extcon-max8997.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max899=
7.c
index 337b0eea4e62..e1408075ef7d 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -44,6 +44,8 @@ static struct max8997_muic_irq muic_irqs[] =3D {
 =09{ MAX8997_MUICIRQ_ChgDetRun,=09"muic-CHGDETRUN" },
 =09{ MAX8997_MUICIRQ_ChgTyp,=09"muic-CHGTYP" },
 =09{ MAX8997_MUICIRQ_OVP,=09=09"muic-OVP" },
+=09{ MAX8997_PMICIRQ_CHGINS,=09"pmic-CHGINS" },
+=09{ MAX8997_PMICIRQ_CHGRM,=09"pmic-CHGRM" },
 };
=20
 /* Define supported cable type */
@@ -538,6 +540,8 @@ static void max8997_muic_irq_work(struct work_struct *w=
ork)
 =09case MAX8997_MUICIRQ_DCDTmr:
 =09case MAX8997_MUICIRQ_ChgDetRun:
 =09case MAX8997_MUICIRQ_ChgTyp:
+=09case MAX8997_PMICIRQ_CHGINS:
+=09case MAX8997_PMICIRQ_CHGRM:
 =09=09/* Handle charger cable */
 =09=09ret =3D max8997_muic_chg_handler(info);
 =09=09break;
--=20
2.25.1


