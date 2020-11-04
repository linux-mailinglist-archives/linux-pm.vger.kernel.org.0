Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28052A61E1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgKDKhg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:37:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47649 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgKDKhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103723euoutp02015c6c36afae80d17c82e52e76adc9fc~ER7zIc1eV2967329673euoutp02T
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201104103723euoutp02015c6c36afae80d17c82e52e76adc9fc~ER7zIc1eV2967329673euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486243;
        bh=JVDzwKYDWs8UfRwIGBYBtNMVEUPNKijXopbFsSAO7ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbvoaNOR1qfCiIIsDqrYgq5IRGtqNAtssqgABlAH9rD387MSsrlD51UGFAzZPspBt
         26h6SEZ5z+k3sQpVwt8kuUMfHHQ87HXls9+FhamsR0oZOdeuEXLp00YB6lCgKOQWER
         r4qmsMB4/Mr+TYTzv6BMekguxiokoup442nUop/E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103722eucas1p19f219189819cdd57aa91ceb9a3e65b85~ER7yqrybB1564115641eucas1p1v;
        Wed,  4 Nov 2020 10:37:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.8F.05997.26482AF5; Wed,  4
        Nov 2020 10:37:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5~ER7ybbYM92474024740eucas1p1Q;
        Wed,  4 Nov 2020 10:37:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103722eusmtrp157280ff025fb2b2439ad5375e1ea529c~ER7yanSCp0613806138eusmtrp1U;
        Wed,  4 Nov 2020 10:37:22 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-7d-5fa284627140
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.64.06017.26482AF5; Wed,  4
        Nov 2020 10:37:22 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103721eusmtip26ce723cdd0acee79fb5b9f40f4703844~ER7xszX011402114021eusmtip2H;
        Wed,  4 Nov 2020 10:37:21 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 3/7] MAINTAINERS: Add entry for Samsung interconnect
 drivers
Date:   Wed,  4 Nov 2020 11:36:53 +0100
Message-Id: <20201104103657.18007-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3ZfXU2uy+qkUTQyKt+yTJ7SLEPofpICIRDKZl40nFa7alZC
        mu9Th+gHTctUCm1i2rIVmiU2nSW5orAia5SGGoXaFEojc7uT/PY/5/x/nP95eFhC+YbyYk+n
        pAraFLVGRctJU99vq39cbkPszi+1e7CtNg/hu1WtFH47M0bhG+ZBCr+ZnaRxZZeRxuW2MhJb
        rW0MNo4MUfh1xzUa20vNCFdZH8twi/kjgz9kN9E4r8vM4KffCyhcVTFBH/TgjYYimh8eekTz
        tmKLjL938zKvbzcg3m7ceISOkYfFC5rT6YI2MPykPLFEx5/9SWeM28yyLPSd0iE3FrhgWOib
        JnVIziq5JgTvR17SUjGDoL83H0mFHcHw5Bi5hFhaql1II4L6zwbCMXAis81JDk1zQVDaq0cO
        7clFQv7XWidAcIUEmB6WO4HV3FEw9d1zBiE5H5gruMI4tIILBd18oyvgJmhu63b63bgweGXP
        cXk84NnVUWciYtGTc7+GcCwAbpaB56ZGRoIj4f3EXZdeDd8s7S69AQYqSkgJyEFQ0vmBkYoy
        BDZLHZJcoTA8OLf4HOziiu3Q2hEotSPgevdt0tEGzh3e/fCQQrhDuamSkNoKKMxXSu4tMG+o
        lEnaC4pHF1wkD4W1mjK0uXrZNdXLrqn+v7YOEQa0TkgTkxMEcVeKcD5AVCeLaSkJAafOJBvR
        4l8b+GuZeYg6/sT1II5FqlWKblN9rJJSp4sXknsQsITKU3HoxcAJpSJefeGioD0Tq03TCGIP
        8mZJ1TrF7oaJ40ouQZ0qJAnCWUG7NJWxbl5ZKLAtM7rmVlTI0PBhPeRuPWb/RH5dU+j/JKQg
        qtU7iNnvk9G+Yu1KhfVwEuV7KTN8mujfRsVlPNP7prp1BnuxUz1tm+908BmDk0j/diry3AO/
        S+d0ey9H7NoZXcT4rX98Po/O37pPjPkV25tFrtFkkjlJB1rHfmfHV8ing/BEwLiKFBPVQTsI
        raj+B0iTP79nAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pJLYviDb5OVbG4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl5GT5dHwSe2ihf3jzA1ML5h7WLk5JAQMJE4vnYWSxcjF4eQwFJGiVmzlzB2MXIAJaQk5rco
        QdQIS/y51sUGUfOJUWLPjYUsIAk2AUOJ3qN9jCC2iICHxKnWtWBDmQVmMEucnmUKYgsL+Esc
        ezSFDcRmEVCV+NXexA5i8wpYS3T9Xg51hLzE6g0HmEFsTgEbiYufm8FqhIBqFj8/xwRRLyhx
        cuYTFpDbmAXUJdbPE4JYJS/RvHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYKRuO/Zzyw7GrnfBhxgFOBiVeHgPbFsYL8SaWFZcmXuIUYKDWUmE1+ns6Tgh
        3pTEyqrUovz4otKc1OJDjKZAr01klhJNzgcmkbySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
        iSWp2ampBalFMH1MHJxSDYx+IS/qZ/mvYHSvSBJmXxu+7Makr82L7x7J7F95WOiKcmbm/nWx
        FyZ/2DqzUW562lV7w3WlGr8T1zzMqUxLYfuuqzzH4YvI55alvlmPNa6WFNzcssDqjeAM8UUb
        Oq5+mLB879Idz55bLuN5aPSlMWT55k+66sefH1zRuv6r6NSzE195B+86Ei9/TYmlOCPRUIu5
        qDgRACyFl5fqAgAA
X-CMS-MailID: 20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add maintainers entry for the Samsung interconnect drivers, this currently
includes Exynos SoC generic interconnect driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v7:
 - new patch.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..4bbafef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9156,6 +9156,13 @@ F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+SAMSUNG INTERCONNECT DRIVERS
+M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Artur Swigoń <a.swigon@samsung.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/interconnect/samsung
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4

