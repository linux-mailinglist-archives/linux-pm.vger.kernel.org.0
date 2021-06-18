Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3413AC9CE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhFRL26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 07:28:58 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:57501 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230211AbhFRL25 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Jun 2021 07:28:57 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 07:28:56 EDT
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx02-sz.bfs.de (Postfix) with ESMTPS id D38592036A;
        Fri, 18 Jun 2021 13:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1624015162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Sf1jJFf55RokYxOxUqnGEPETR4mtSWMzKaN1vm6iLI=;
        b=pnGlJKQrhwYq3IO1NBLZOUL96dnYgmMOZggQ+xj/+w7/OriXowbtoOAkcoJAtmeczjSgu+
        E2eDcSDNsXhGmAEgBIOlNH6eeOeEjDIwu1tY6BUKyvtVTAJC6/Ju9bKdoRpgBxedzdmEyC
        nUCh/fuGVCQT+O71puJxSXXLii7/oo4XW/8hOVx2/qe0reiU9NYgEetE6ylZO93jhGGYr4
        yly/xmgdkhOxLcGt1o5Dm04EQoBGvmvxoxi4sQAXGv9Fy2UPzgi+2pUgUC+Gvj4RAFG0N+
        q3XmxP6HowTgMIx9D+AbcoF69n7gD9Ov0+buJaxygpBbnpxu5vD1EbV1XUfDJw==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.4; Fri, 18 Jun
 2021 13:19:22 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2242.008; Fri, 18 Jun 2021 13:19:22 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Colin King <colin.king@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] power: supply: axp288_fuel_gauge: remove redundant
 continue statement
Thread-Topic: [PATCH] power: supply: axp288_fuel_gauge: remove redundant
 continue statement
Thread-Index: AQHXZCRywpoHegcj9UOOPqNPgVoldKsZnTXV
Date:   Fri, 18 Jun 2021 11:19:22 +0000
Message-ID: <5d5dad5246f442e5aa96bdc50ac4b1f1@bfs.de>
References: <20210618092924.99722-1-colin.king@canonical.com>
In-Reply-To: <20210618092924.99722-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-26226.007
x-tm-as-result: No-10-1.409600-5.000000
x-tmase-matchedrid: /Km4Ih+9Qr3RubRCcrbc5grcxrzwsv5u3dCmvEa6IiGoLZarzrrPmZ1b
        YL8THayDD2+lbncX+drDQarzgp+9/iLSA2Bw59G2/Ca4Pt73t1vpkhHAf9djV4TsLX8FtFkZJoK
        OQUqn/5630GP8pin5GSKkzMT7+4oopksMyXDdOswSEYfcJF0pRdbmwqk6BanYgl2XJFQkkUzbVX
        rtTxQ4GIQYFtaFqqBpca9nyMIMgSX1s8eCOeeiYMd3b2o5YTuS1Mc6SC5sKVZjLp8Cm8vwF0Ac6
        DyoS2rIj6kCfX0Edc7YHvNzW+2PibzJWOoHHj0fdXu122+iJtor9gVlOIN/6lgddECnPRgBngIg
        pj8eDcByZ8zcONpAscRB0bsfrpPI0PU0TdJoUtdoKNKOurla0u2hb42X2dnm2zNE80aHT3PbT/7
        fT/J5Kwi6gPHfOj9eM4TT+mdxOrYdMNjrgX++DAt7yDiJzSPk5VUPePG8fKjf0ic5zgpSMaAgCg
        KCG9lmDP7ys8dRrrEdy+NYmKKLmfF5QO2l9GkN
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10-1.409600-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-26226.007
x-tm-snts-smtp: 2B1ACD1591E103B3F857EFA8872585A80CCBB00CCFD89C3A60296AAD8DE812BB2000:9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spamd-Result: default: False [-15.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
         RCPT_COUNT_SEVEN(0.00)[7];
         WHITELIST_LOCAL_IP(-15.00)[10.129.90.31];
         NEURAL_HAM(-0.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[25.71%]
X-Spam-Status: No, score=-15.00
Authentication-Results: mx02-sz.bfs.de;
        none
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just a remark:
the function fuel_gauge_reg_readb() is reporting via dev_err().
But some callers are reporting also. Maybe someone should take
a look.
The valid return seems >=3D0 so removing the dev_err seems an option.

jm2c,
 re,
 wh
________________________________________
Von: Colin King <colin.king@canonical.com>
Gesendet: Freitag, 18. Juni 2021 11:29:24
An: Sebastian Reichel; Hans de Goede; Chen-Yu Tsai; linux-pm@vger.kernel.or=
g
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: [PATCH] power: supply: axp288_fuel_gauge: remove redundant continu=
e statement

WARNUNG: Diese E-Mail kam von au=DFerhalb der Organisation. Klicken Sie nic=
ht auf Links oder =F6ffnen Sie keine Anh=E4nge, es sei denn, Sie kennen den=
/die Absender*in und wissen, dass der Inhalt sicher ist.


From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
invert the if expression and remove the continue.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/suppl=
y/axp288_fuel_gauge.c
index 39e16ecb7638..20e63609ab47 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -142,9 +142,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *=
info, int reg)

        for (i =3D 0; i < NR_RETRY_CNT; i++) {
                ret =3D regmap_read(info->regmap, reg, &val);
-               if (ret =3D=3D -EBUSY)
-                       continue;
-               else
+               if (ret !=3D -EBUSY)
                        break;
        }

--
2.31.1

