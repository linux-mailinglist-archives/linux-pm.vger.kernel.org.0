Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA782CC89B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLBVIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 16:08:00 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:22617 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLBVH7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 16:07:59 -0500
Date:   Wed, 02 Dec 2020 21:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606943237;
        bh=E9RxHMzcn7X1FNm4GZyMldmxad4LWG8WG/9s9fSNl74=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=qJAHJNR9P8O1TBzC2LGmdRdxfLrppvNALomAWOXBGr3lxp8CJzVpXUyPoFYklpnkh
         N+31tqe/59saqG70dRpDrPNnN0Lv3HCV14Fr5nRjq1SjpD3JM2S1w3F0BN+s00+fc/
         w19fl7TJFnxOqcd1zWPlIxUEKcaqJ3QeOEuKw+V8=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 1/3] extcon: max8997: Add CHGINS and CHGRM interrupt handling
Message-ID: <20201202203516.43053-1-timon.baetz@protonmail.com>
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

Allows the MAX8997 charger to set the current limit depending on
the detected extcon charger type.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 drivers/extcon/extcon-max8997.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max899=
7.c
index 172e116ac1ce..70ffcef12e3e 100644
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
@@ -538,6 +540,9 @@ static void max8997_muic_irq_work(struct work_struct *w=
ork)
 =09case MAX8997_MUICIRQ_DCDTmr:
 =09case MAX8997_MUICIRQ_ChgDetRun:
 =09case MAX8997_MUICIRQ_ChgTyp:
+=09case MAX8997_PMICIRQ_CHGINS:
+=09case MAX8997_PMICIRQ_CHGRM:
+
 =09=09/* Handle charger cable */
 =09=09ret =3D max8997_muic_chg_handler(info);
 =09=09break;
--=20
2.25.1


