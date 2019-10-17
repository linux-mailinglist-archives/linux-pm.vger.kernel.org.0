Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F2DA9F3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408817AbfJQK2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 06:28:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42988 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405805AbfJQK2r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 06:28:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191017102844euoutp01de421b9e5ca201eac9741c20b90808db~OaGoTvEUz2792227922euoutp01l
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 10:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191017102844euoutp01de421b9e5ca201eac9741c20b90808db~OaGoTvEUz2792227922euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571308124;
        bh=iRCzuB8y77uwfElmExl0r6Se4rQgS/Q62RZNDHvwRto=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DOVB/Q4AWQpZ7d3dCv9C3snrSob/qJBoRidXkL5Zsx27c5bSs3bgcbQK7SwZaWoZt
         slc0pPlfW1siD0pS/HELYwrwhoj+U6oe7X1Pp4fAoCoOytHstVl1DoV7AzOfmDPzLR
         HF0RrVmaeeoJ23xK1KjNGuvPFi3vwLaq5ylQhX8E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191017102844eucas1p2bee1c8122997d8a01a80d763b0bef90e~OaGn19DRh1118711187eucas1p2b;
        Thu, 17 Oct 2019 10:28:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.00.04374.C5248AD5; Thu, 17
        Oct 2019 11:28:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191017102843eucas1p164993b3644d006481fb041e36175eebe~OaGnYvAvr2840828408eucas1p1b;
        Thu, 17 Oct 2019 10:28:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191017102843eusmtrp2d58a7d10f4a48b53240821211d2f0e9c~OaGnXm8t71361913619eusmtrp2K;
        Thu, 17 Oct 2019 10:28:43 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-1a-5da8425c3687
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.49.04117.B5248AD5; Thu, 17
        Oct 2019 11:28:43 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191017102843eusmtip2154fff2e728f839a3ab68c2c7c7c59b3~OaGm3D8PH0361203612eusmtip2R;
        Thu, 17 Oct 2019 10:28:43 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] opp: core: Revert "add regulators enable and disable"
Date:   Thu, 17 Oct 2019 12:27:58 +0200
Message-Id: <20191017102758.8104-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229k5Ow6nx03yw8RyUZDiTLI4pISG5X4E9UOEyqEzDzp0Uzav
        XcDNTDetlmQtExWTpvM+RVPcKBNnic1LlgijaV4gEtJpmIq1ebT+Pe9zeZ+PjxdHuCWoHy6R
        ZVNymTiDj7GZPcO/rSEJFxpFp3498iI7de0oWTm3gJHNq98AWbemQ0mrtYNFTvVXY6TjwRAg
        dVYzg2wdsrHIH5tjDHL3cyeT7LIPY1Eewr4qG0toNKgx4cNuAxBaZnoZQocx4Cp6nR2ZQmVI
        cil56Pkkdprukx1kqb3ze1fWkEJQ7akB7jgkwqHVNoBpABvnEo0AjlRtM10Cl1gHcHnOnxYc
        ADqGOpgHidmBSSYt6AFcrKxH6MGZUJumMJcLI8KgZkXjxDjuQyTC9o1zLg9CLDHgY1M36uJ5
        xCVo3LzisjOJ43Bh0bQX5RCRsMX2E6PLjsDmjjd7+yGxjcGlmi5ACzGwqKwcpTEPfrd0s2js
        D//01TLoQBGAcx9bWfRQDuCUSrefjoDvLBN7r0CIk7C9P5Smo2GbdgRx0ZDwhDMr3i4accKK
        nmf7NAeW3ufS7hOwytL2r/bt+CRCYyEcXdsC9C+KoNrWhGlBQNX/rjoADMCXylFIUynFaRmV
        J1CIpYocWargZqbUCJznMbpr2XgNzDvJg4DAAd+Do53Xi7ioOFdRIB0EEEf4Ppzaew0iLidF
        XHCLkmcmynMyKMUgOIwz+b6c2272G1wiVZxNpVNUFiU/UBm4u18h4NUnFZPrxWZlgl3y1WaI
        VCl3DNrn6i2UnfWl5kleCVBNBIOLZXERAgwTSA/FKk3zsbKj0dMt+mQsyEsPYu7a03VRi5dV
        XXNPz7o5QvIb3nOaX77aKh2/VtFUHl8pQYLHbOYXy3f6JwJXZ3c+KNHpitJAnk9ZY3j8mbhj
        BXymIk0cFoTIFeK/ti3q0hoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xe7rRTitiDZ4u0LfYOGM9q8XUh0/Y
        LFZ/fMxoseDTDFaL8+c3sFtc3jWHzeJz7xFGixnn9zFZrD1yl93izY+zTBb/rm1ksdj84Bib
        A4/Hzll32T02repk8+jbsorR4/iN7UwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXMuPKAsaBTsGL720/MDYxz+LoYOTkkBEwkbu25
        xNLFyMUhJLCUUWLOm+lsEAkZiZPTGlghbGGJP9e6wOJCAp8YJV72BoLYbAKGEl1vIeIiAokS
        D3qes4MMYhZ4wyRx6NEjoAQHh7CAm8SmH/4gNSwCqhJPnu4Fq+cVsJFYc/cD1C55idUbDjBP
        YORZwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBotx37uWUHY9e74EOMAhyMSjy8L5iX
        xwqxJpYVV+YeYpTgYFYS4Z3fsiRWiDclsbIqtSg/vqg0J7X4EKMp0PKJzFKiyfnAiMoriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC439in8vI6hZDl5/45P9kv
        /utM8qUFUrcaahzvGd0rfHjFweLVxDCDxu+vpLcb7Nv6vT9AYO3HN8dfn37dY3+a1TXz2GaH
        A5wTI/ZFJ87pLvxtLtkts3XdWc3IHdkb23+w/f385uL0XEc9q1W3noT8EF2YJbhi48NbBWvz
        VKN2X2GQrxWYkjClRomlOCPRUIu5qDgRAFRkTDxwAgAA
X-CMS-MailID: 20191017102843eucas1p164993b3644d006481fb041e36175eebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191017102843eucas1p164993b3644d006481fb041e36175eebe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191017102843eucas1p164993b3644d006481fb041e36175eebe
References: <CGME20191017102843eucas1p164993b3644d006481fb041e36175eebe@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the drivers, which use the OPP framework control regulators, which
are already enabled. Typically those regulators are also system critical,
due to providing power to CPU core or system buses. It turned out that
there are cases, where calling regulator_enable() on such boot-enabled
regulator has side-effects and might change its initial voltage due to
performing initial voltage balancing without all restrictions from the
consumers. Until this issue becomes finally solved in regulator core,
avoid calling regulator_enable()/disable() from the OPP framework.

This reverts commit 7f93ff73f7c8c8bfa6be33bcc16470b0b44682aa.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This is a follow-up from the following discussion:
https://lkml.org/lkml/2019/10/9/541
---
 drivers/opp/core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3b7ffd0234e9..9ff0538ee83a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1626,12 +1626,6 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 			goto free_regulators;
 		}
 
-		ret = regulator_enable(reg);
-		if (ret < 0) {
-			regulator_put(reg);
-			goto free_regulators;
-		}
-
 		opp_table->regulators[i] = reg;
 	}
 
@@ -1645,10 +1639,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	return opp_table;
 
 free_regulators:
-	while (i--) {
-		regulator_disable(opp_table->regulators[i]);
-		regulator_put(opp_table->regulators[i]);
-	}
+	while (i != 0)
+		regulator_put(opp_table->regulators[--i]);
 
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
@@ -1674,10 +1666,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	for (i = opp_table->regulator_count - 1; i >= 0; i--) {
-		regulator_disable(opp_table->regulators[i]);
+	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
-	}
 
 	_free_set_opp_data(opp_table);
 
-- 
2.17.1

