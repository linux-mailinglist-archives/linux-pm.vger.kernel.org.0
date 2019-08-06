Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52427836C8
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfHFQ3D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:42383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387893AbfHFQ3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108892;
        bh=3PISsFhP2p4tj5ULA7y6xFGMEsiPJROECIygBRA4/zw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T0iVRuoT39ebTrgaB4OPmg8iKCMVi7occ3T/FDP4lznR919TIUhhex3qNkfFO/XJD
         JB6x5QXGcc2Z6dMM/2LvbOOXTTMb4Cf/Dt0uU3pTZBAWBzxa2c+kwIn/aHF02ERY+i
         RXrbehwbzB2PTGqqOMRELCEwuNmrVkUTeHdIiz1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M1nOg-1iAuD01Mxm-00tlSl; Tue, 06 Aug 2019 18:28:12 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v4 06/10] rtc: mt6397: add compatible for mt6323
Date:   Tue,  6 Aug 2019 18:27:41 +0200
Message-Id: <20190806162745.8414-7-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806162745.8414-1-frank-w@public-files.de>
References: <20190806162745.8414-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:DIhRHK2hht0aS3gGjUBdMit/fe5lr9+ny2VtU0f6VLpF4RgJt8C
 Ny5zDjYzK3kf7a1hq2zGlC6rBLjIORmId4UnzIKKaj3aDh+S033M7zD5wxBBv7c9usz0me8
 lAPNLVND/HByjaQNmrq7dlxPC/nk3seTF7rC6T4zZWTZoX3Myf0SkR6QS/2uCrRC8FqNBIj
 RpFLUf40mm8Ixb9lHkRaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E2LKdkfghHA=:FNem/ARHXV0uE2yKyiYHq5
 gY2PBWiTOl70HXT2nYwno+ily3sUA4zF6RH2X6jPdcezoNtDW0fpVgTll1zlwPeq6Tw2ub8Rh
 2DLriMUfIv4XlI/ncDzyEsiBAjtRLwzGfzPsHMwUj/Wl9ZfBUgZHNcwMGRrKMWpEBZDMQe3MA
 40RANSqPGoLq8gRDOILBjzXQ/2BuDR9gCOEuupkUc2lXuDRHXHbD4ThS6RYnu5Z0cn+Gi1KFD
 LYMHR+GzdSqPtFAy+XhcGSA/I5KpbH6J8GLn/LOJNfWQz9SyQDrY5PmNbYwWthglBYrE9hiBM
 2dyibsQZIos8kXbtwoYjpC6xQ6zuaoOc+LNJtSELPkyn0a6YoHAvapE+enMJ13xzXqFry9Sm+
 jaIWjOOJwJX5oBn9vmD8xD16S9Vdpo5TF1uWeDcgLFnF5nqrqPKksW/Br+h6/AC/8T3k7LwnV
 DPspmn7LgPYxWTYu5gm7BGQcz2xh0/CIi0I9rRMC/QwJUBsPv1NOpINrzBQ5cscHM1/JeX4yg
 UddkmfaCEOZK5J64UCYbahuJVmvyr0GJL9eYhVMaYgH6U8sBnr2ffYzBRLTTafV5mBqhO3dy+
 Bx2Rs8b3QG44khaV9pZ7wcGjl7cGKUHzsS/3tF6MD54cRvPBGrlzTPMOG/L7QsoVqhJwJjxyK
 1bcmddHtIQEVPdd0UbPJz7Rb9dQqwd509SQEE9EHOob1v4Lc75sXYIF5Dy+s+7PTvEg9ExrTU
 oUknbl01i9Ro0FT+8HcYIWXwFBfOPRxq+TPqkl7RE+dKTAkYt9J2dqt4Ti3jTxyspfevS2dVi
 wAVKFf+bEijKxm4qvqTNLNz6iZUYVETBgVCFh1pry7t7Xl4t+muKh+YdDmFBEKUJB5QzVN9nL
 2KXBIRoKtZONJ5pFopJyRjfPjLnrqICzU5ZD2Th8JDqeVjJOWddlHsNtYyT2jbr6sGshe/Ak/
 fnRiizWw3kUvQ6xUX/Mit6facC85cft/l/ziBX6Ozlhz9dND526CTsRN4Ym56T5SAjC7O9/LM
 zqpKrMeRZNwABkCelzWUxfKrTOI/7YumvfaTL55UMibw9pwOMmkMo7HI24Mxb5UJZHgVCCFn4
 JukOcDmXXHQvKfHc4/TxuTbdyIKcKMo8Xcg/uHjyZE9VlfLbTbE66IFDw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

use mt6397 rtc driver also for mt6323 but with different
base/size see "mfd: mt6323: add mt6323 rtc+pwrc"

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
changes since v3: moved (was part 5)
changes since v2: splitted this from v2.3 suggested-by Alexandre Belloni

 drivers/rtc/rtc-mt6397.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 9370b7fc9f81..21cd9cc8b4c7 100644
=2D-- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -325,6 +325,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_sus=
pend,
 			mt6397_rtc_resume);

 static const struct of_device_id mt6397_rtc_of_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-rtc", },
 	{ .compatible =3D "mediatek,mt6397-rtc", },
 	{ }
 };
=2D-
2.17.1

