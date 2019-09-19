Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8481B7640
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbfISJ1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:27:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48007 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387881AbfISJ04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:26:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919092653euoutp016980334c3dd177778e35f7573bd4b297~FzMol5lDq2470924709euoutp01I
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 09:26:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919092653euoutp016980334c3dd177778e35f7573bd4b297~FzMol5lDq2470924709euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568885213;
        bh=xMgegydTj1VyjtJMSlQNdpjkJ9FHauOHBGUiS06xb+k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=j5tkUKL0oGjaT4Sa8M0HT/WjLgXDzhLevHIEgMMekKKlnGbbkKvt2L4jlSviBYkMk
         VfhUuKYZAbstC8K6M4NI+OKHannlUg/vIZjzKy1Zj503zndjqW1lXZLrQSeXskU+Tx
         5MSG0v72fsvIK7hU1fWQOZ+A8d8lqf73x6XaB0ew=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919092652eucas1p146a6438833f2b7837de81c491ff25e8c~FzMn00FD03057630576eucas1p14;
        Thu, 19 Sep 2019 09:26:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 26.BE.04309.CD9438D5; Thu, 19
        Sep 2019 10:26:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919092652eucas1p2715611db7a0b0c4cc79956311e01c35a~FzMm7_JNw0197101971eucas1p2C;
        Thu, 19 Sep 2019 09:26:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919092651eusmtrp1388058d2816f3078f44dbc3d529337fc~FzMmtcVCN1357513575eusmtrp1O;
        Thu, 19 Sep 2019 09:26:51 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-f3-5d8349dcba50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.25.04166.BD9438D5; Thu, 19
        Sep 2019 10:26:51 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919092650eusmtip11435e05346dd810ba269b0402294f2b7~FzMl8JRRi1630716307eusmtip1V;
        Thu, 19 Sep 2019 09:26:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com, dan.carpenter@oracle.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/2] Exynos5 DMC minor fixes
Date:   Thu, 19 Sep 2019 11:26:39 +0200
Message-Id: <20190919092641.4407-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7p3PJtjDeZd0bTYOGM9q8X1L89Z
        LV7/m85iMf/IOVaL/sevmS3On9/AbnG26Q27xa0GGYtNj6+xWlzeNYfN4nPvEUaLGef3MVms
        PXKX3WLp9YtMFrcbV7BZtO49wm5x+E07q8W3E48YHYQ81sxbw+ixc9Zddo9NqzrZPDYvqff4
        +PQWi8fBd3uYPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStj8+6L7AVT2CvezWhnb2D8ydrF
        yMEhIWAisWRtQhcjF4eQwApGia4zj9kgnC+MEk9+b2WBcD4zSrR2gWQgOpa2m0LElzNK3LnS
        zQrX0dB5gBmkiE1AT2LHqsIuRk4OEYHFjBLfDkeB2MwCF5gkTq+UBbGFBfQlJj3qYQEpZxFQ
        lTjwPBIkzCtgJ9F1cDEbiC0hIC+xegPIRC4gex+7RFvPJyaIhIvEzYcPWSFsYYlXx7ewQ9gy
        Eqcng8wEsYslGnoXMkLYNRKP++dC1VhLHD5+Eex7ZgFNifW79CHCjhL9S7qYIV7kk7jxVhDi
        Yj6JSdumQ4V5JTrahCCqNSS29FyAOkZMYvmaaVDDPSQez98NZgsJxEp8bt3OPIFRbhbCrgWM
        jKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECU9Hpf8e/7GDc9SfpEKMAB6MSD+8P9aZY
        IdbEsuLK3EOMEhzMSiK8c0yBQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqem
        FqQWwWSZODilGhhNAvd0HJO/n1G/aaqZrc2qxbtuc4ulyjJaPA9leCT09E2uEfOuvV43j5mU
        zvgZs8GFP7VIr/WVxISZzoeKtjV6eDCdqc1fsKztjutzc69mli1PEz/s2dT+Xmiuy4fNTQYm
        PXvuTtw2Y0Fp0/n/CWsvyyuJrtT9yjFbgYt39tOXZU784Z1CPW1KLMUZiYZazEXFiQBUMrMR
        QQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd3bns2xBud+6lhsnLGe1eL6l+es
        Fq//TWexmH/kHKtF/+PXzBbnz29gtzjb9Ibd4laDjMWmx9dYLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbrH0+kUmi9uNK9gsWvceYbc4/Kad1eLbiUeMDkIea+atYfTYOesuu8emVZ1sHpuX1Ht8
        fHqLxePguz1MHn1bVjF6fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJexefdF9oIp7BXvZrSzNzD+ZO1i5OCQEDCRWNpu2sXIxSEksJRR
        om/JfeYuRk6guJjEpH3b2SFsYYk/17rYIIo+MUp8XbsLrJlNQE9ix6pCkLiIwHJGiWOr3jKD
        OMwCD5gkLs49xgjSLSygLzHpUQ8LSAOLgKrEgeeRIGFeATuJroOL2SAWyEus3nCAeQIjzwJG
        hlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbDt2M/NOxgvbQw+xCjAwajEw/tDvSlWiDWx
        rLgy9xCjBAezkgjvHFOgEG9KYmVValF+fFFpTmrxIUZToN0TmaVEk/OBcZpXEm9oamhuYWlo
        bmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHRfe5U+YJTj6OkWzuTTEwdNhxImZJ3
        bMXnpRt3RLE+3daTUxmV+3T7vovnWVvXcfGYhhaev1HXsVpoUpdVuopMbkBPfAbvxrCrLkuf
        /N/xNJFr893FagYmVuf6Hh+cd1JR9+fCbMWPERvuH/Zxray6uD+AaYK0LrN5jInmTT+jwjae
        rsTAvZ1KLMUZiYZazEXFiQAHHfzXmwIAAA==
X-CMS-MailID: 20190919092652eucas1p2715611db7a0b0c4cc79956311e01c35a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919092652eucas1p2715611db7a0b0c4cc79956311e01c35a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919092652eucas1p2715611db7a0b0c4cc79956311e01c35a
References: <CGME20190919092652eucas1p2715611db7a0b0c4cc79956311e01c35a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is a follow up patch set for the Exynos5 Dynamic Memory Controller
driver v13 [1]. The patches are for Krzysztof's branch [2]
for-v5.4-5.5/memory-samsung-dmc
and/or linux-next where Dan Carpenter reported the issue (patch 1/2).
There are a few fixes captured during static analysis and a new
binding for 'samsung,K3QF2F20DB' LPDDR3 memory.

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/8/21/283
[2] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-v5.4-5.5/memory-samsung-dmc

Lukasz Luba (2):
  memory: samsung: exynos5422-dmc: Fix kfree() of devm-allocated memory
    and missing static
  dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories

 Documentation/devicetree/bindings/ddr/lpddr3.txt | 10 +++++++---
 drivers/memory/samsung/exynos5422-dmc.c          |  6 ++----
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.17.1

