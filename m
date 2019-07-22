Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6F6FCA0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfGVJrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42281 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfGVJrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094735euoutp02f352cdea24714da5aa172a4ca597ad71~zsa212Shl2893128931euoutp02b
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094735euoutp02f352cdea24714da5aa172a4ca597ad71~zsa212Shl2893128931euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788855;
        bh=WNEl3Tg78F0IeuBzIomZpFxDfnKkZ4Oivfi2xCmRXSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vASJA9fWTnF/J3+Nm9+UrkdoAY4Klk8mtRDVag8YvHSt38E712QDh4jw9fykbPf+H
         RNPUz8xykrWNGV2CZ45FQfhryXWYxrkT5WNpj8ZJ87mIAi8mRjgKnDRuLqYGSRrMVe
         JX0c3CC7gm9kYKP0wy3yBRF/bJaupWvHL3jSq6es=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722094734eucas1p2c5558704bd0eb076b2dcae60e2a26b31~zsa2Anq_-2046920469eucas1p2W;
        Mon, 22 Jul 2019 09:47:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.26.04377.536853D5; Mon, 22
        Jul 2019 10:47:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722094733eucas1p1a0294a332b11aed42124308c5d204e62~zsa1Gwlo_1117211172eucas1p1h;
        Mon, 22 Jul 2019 09:47:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722094733eusmtrp11788dbdbdd4af3ae1b30c543af5067fd~zsa04e_L73266032660eusmtrp17;
        Mon, 22 Jul 2019 09:47:33 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-11-5d35863578cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.2A.04140.536853D5; Mon, 22
        Jul 2019 10:47:33 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094732eusmtip2ce3d5db50cf4fef014f8718630e8a754~zsaz2Ukqt0863408634eusmtip2p;
        Mon, 22 Jul 2019 09:47:32 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 9/9] ARM: exynos_defconfig: enable DMC driver
Date:   Mon, 22 Jul 2019 11:46:46 +0200
Message-Id: <20190722094646.13342-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa1BMYRjHvefeTtscq9GbWzM7GWKqRcw7w7gMZo6GmRo+ocmW02W0G3uE
        8GFpCl1EqXbaQnZSttJ1miRS7cgItZFSIq2mUJt0cUnRdja+/Z/f8/z/zzPvvAwus5KLmHD1
        cV6jVkbIKQlR+fhns+eGuPUBilwVKtUVk6h9rJ9EN0wvSFQwYgEoxlBModSn2Rh6lqBCyZYv
        OGpuLqHR8/ODNOrULkEjie9I9LI6i0KjSSaAdM0PMVRk6qZRbrsZQ+anO1HXuXwKxT4w0ahh
        8AKJpl+XEqj2lS/qmnRCE096wVZXrvB6IeAmxlMIbrgjlub0WjPB3cvsprky4yWKq80upLmk
        GCvF1VlrMO5yhRFw5U1nuNGyZX6O+yWbDvMR4Sd4jffmQ5Kw8ok2cHSYPPWt9hapBWlkPHBg
        IOsDn/dYqHggYWRsPoAt2kukWIwB+P5NBy4WowBOZGaDOUvO91ZMbOQB2G1opf5Zsq61z3QY
        hmK9YJXxmM3gzOoA1A/stc3g7AccXi7Kmk1awG6DdQbT7CEEuxzWWeNnuZTdCs26IkLc5gYL
        Sh7htkyHGf6pUSXiXAbGfgU2DNkdUHsBF/EC+Lmxghb1EtiUmmhPEaA2Kcd+/1loSc62z2yE
        DY1m0haDsx6wuNpbxNvgj2EDIaY7wY6h+TaMz8iUygxcxFJ4MU4mTq+EFYktmKgXwrzCdHs4
        B/tjpu0vmApgTl8MfgW4Zf5fdhMAI3DhowRVKC+sVfMnvQSlSohSh3oFR6rKwMwvbJpuHKsC
        1b+D6gHLALmjVFHpEyAjlSeEaFU9gAwud5aqFesDZNLDyujTvCYyUBMVwQv1YDFDyF2kZ+b1
        HJCxocrj/BGeP8pr5roY47BICw4KRNueO+4GvzSNZbdLBu2/KyRyXYZ7ywujdco3dDvhHSR1
        /bPjZs3HCMe3+ruyq6D4V7CvzisoszNB7ZN8MmT84GpL73a/an3bvvvOGNAX+S+dlCQY3g/8
        msyfIpM8bw8JeQFl7S+dV+iDFaNmPRYo8yjZMq7pq0pJ72mdKpUTQphyzSpcIyj/AuKojZmB
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7qmbaaxBlMvslhsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GVs/naVseA9a8Wn/YtYGxinsnYxcnJICJhILPx+iamLkYtDSGAp
        o8SsmbOYIRJiEpP2bWeHsIUl/lzrYoMo+sQo8W/PFaAEBwebgJ7EjlWFIHERgTmMEj+7tjGC
        OMwCv5klDt7tB+sWFnCUOLj4CNg6FgFViYPvuhhBbF4BB4mLM9ayQGyQl1i94QAzyFBOoPjL
        47kgYSEBe4n9L7YzTmDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwRrcd+7llB2PX
        u+BDjAIcjEo8vDc2m8QKsSaWFVfmHmKU4GBWEuHNMzCNFeJNSaysSi3Kjy8qzUktPsRoCnTT
        RGYp0eR8YPrIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAaLDc
        u3jlodkLbA/vmHFFhvnChYdzp2nvdY1L1do+0cPt/mFjT6431w+1X3Lb83b2yb5Ax9X8jbtM
        9it5y7qoTAivEy0+9bFh+/zJf/ikv+4+vs24gafdpeH9tv4rKu+eZvyylfpyhWe9aZb7b66X
        Vz9ocpVXvY4ufr00cJnsooT9Jjw1mWn7zyuxFGckGmoxFxUnAgAX9MER5wIAAA==
X-CMS-MailID: 20190722094733eucas1p1a0294a332b11aed42124308c5d204e62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094733eucas1p1a0294a332b11aed42124308c5d204e62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094733eucas1p1a0294a332b11aed42124308c5d204e62
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094733eucas1p1a0294a332b11aed42124308c5d204e62@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 2e6a863d25aa..ebed93236a47 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
-- 
2.17.1

