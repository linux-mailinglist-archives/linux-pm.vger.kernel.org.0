Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2797E35958
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFEJNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:13:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59895 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfFEJNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 05:13:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190605091306euoutp0232b85c6f614e89715debfbc3d4e81523~lQoVechnt2351623516euoutp02B
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 09:13:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190605091306euoutp0232b85c6f614e89715debfbc3d4e81523~lQoVechnt2351623516euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559725986;
        bh=p1ciuR2zati+bXIjUeTHD6GvYRFmX4EBTdt0xqfp0gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WACTbgVyAHB0l6iD9Tvr3LEMXFwUuXW3GqebF9wgCbxFJitROVJtOhqu0rTqMwqol
         XKU2Xpirak8UFEfMxfmR4CjFjoJ5ckcpM1LSFZHnYdhfbkqDHjMFYVAFg5vaiCGxp2
         BIhG/TJp+XwMFsDaEf3K/HHAdRJVH6Sgkjqf8pqU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605091305eucas1p18906cc1ffa3e78e404eac4680ea16d04~lQoU9aOOi1094610946eucas1p1K;
        Wed,  5 Jun 2019 09:13:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 62.06.04298.1A787FC5; Wed,  5
        Jun 2019 10:13:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0~lQoUEVhb31225212252eucas1p1Q;
        Wed,  5 Jun 2019 09:13:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190605091304eusmtrp1668f764d5880035023b14fd9e0034d58~lQoT0ouvC0947509475eusmtrp1f;
        Wed,  5 Jun 2019 09:13:04 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-53-5cf787a1075e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.8A.04140.0A787FC5; Wed,  5
        Jun 2019 10:13:04 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605091304eusmtip1ecc8c4f8c8d4a4be73f8d5f8f90d3da7~lQoTHWPOr2955629556eusmtip1j;
        Wed,  5 Jun 2019 09:13:03 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v4 5/5] DT: arm: exynos4412: add event data type which is
 monitored
Date:   Wed,  5 Jun 2019 11:12:36 +0200
Message-Id: <20190605091236.24263-6-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605091236.24263-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTcRTvf+/u7nW1uE3Lk0nWosgemlD0hyLT/DApyIw+ZJLd9DIjH7mr
        phm5inz1UJRqSE98lc60+Whqa6VrM7SWFhqJIQ6MzCIfWUFZXa/Wtx+/1zkcDkOqaigv5khC
        Mq9L4OLUcoWs0f7Duf529rfIDf25a/F9Qw2FeyfeU/im7QWF810fSex01tL4+ZkRGr/Ve2OT
        q4fCr5qvyfH4RRvCBucjAlfb+mlc1ttF4L7Td+T4nMVG47aRbApPtg+i7Qs0xhtGpGkq7qc1
        pspcuaauNFPz5PNDQnOpvhJpxk1Lw+gIxdYYPu5IKq/z33ZIEWt9Okoc+6BM6/wRpEd6RR5y
        Y4DdCIUF5bI8pGBU7B0E5qttlCio2AkE7177SsI4AkvuaWo2MXqpi5SECgSu0hL0L9GSsycP
        MYyc9QNzZZJIe7AlCCbbIkQ/yZYT8OjsGCEK7uw+6G8YnM7K2JXQ92tiGivZQPjZZCakYT5Q
        VfuYFDvd2O1QZwgUe4C10zBVlyMTeWBDYLg7WbK7w7CjnpawN3QUXZBJWAD9xdtIwifBlX99
        xrMF2hxdlFhDsr5Q0+wv0UFgsVoJqX0+vPm0QKTJv7Cw8Sop0UrIyVJJ7tVQf+HlzL6LoMJ4
        ZaZcA/qBalK6TRECZ1ZsAfIp/j/rFkKVyJNPEeK1vBCQwB/3E7h4ISVB6xedGG9Cf9+oY8ox
        ZkZfuw+3IpZB6nnKL9xkpIriUoX0+FYEDKn2UHJ9E5EqZQyXfoLXJUbpUuJ4oRUtYWRqT2XG
        nIEDKlbLJfNHef4Yr5tVCcbNS4926o1hv6Pm5HQVdx/0PB821/p977rohhCf/BWbX9vJnkyv
        Uw3Lh/xDuw0OR/Lm2oYHVe1rFvaM0PJ7A6su24NdzXG3JjvVoaONGWlod1mg+VmL8/owsfRL
        SJkjE65V28vu5i5u1Q7tqrAYfYKjnhZZDMtOhYcnYcN+X1PR1KYdVrVMiOUC1pA6gfsDtLgw
        n0IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7oL2r/HGKzcrG2xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GfuPfmQqeMlbceanYwNjA1cXIyeHhICJxMe+i8xdjFwcQgJLGSWONW5jgkiISUza
        t50dwhaW+HOtiw2i6BOjxLSTJ1i6GDk42AT0JHasKgSJiwgsB2pe9RZsErPANiaJPVd2M4J0
        CwsESyy7uh9sKouAqsTtv1/A4rwC9hJ/du6A2iYvsXrDAWaQoZwCDhKbZ9iDhIWASo6f3co8
        gZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42Xbs55YdjF3vgg8xCnAwKvHwfkj8
        FiPEmlhWXJl7iFGCg1lJhDfx9pcYId6UxMqq1KL8+KLSnNTiQ4ymQDdNZJYSTc4HxnBeSbyh
        qaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGvZ2+69fdveez02LT4voN
        U67NMrVrc3kummx+y4Onw3nV/RM/Jwv1zFcPLUmYfeN1z/UCF7XuLY7JH9y7QgS8bv16433t
        9VX2muXxSY7X2T8fXHFg7tOw13v8PNvvdbnd7lV9wv42evXTbEuD2u9HDz2L/NHXf4OFnUNi
        d93uHwJ35q51MnYUVGIpzkg01GIuKk4EAMWQWpqpAgAA
X-CMS-MailID: 20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds new field in the PPMU event which shows explicitly
what kind of data the event is monitoring. It is possible to change it
using defined values in exynos_ppmu.h file.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 3a3b2fafefdd..549faba85a7a 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -6,12 +6,16 @@
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
  */
 
+#include <dt-bindings/pmu/exynos_ppmu.h>
+
 &ppmu_dmc0 {
        status = "okay";
 
        events {
 	       ppmu_dmc0_3: ppmu-event3-dmc0 {
 		       event-name = "ppmu-event3-dmc0";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -22,6 +26,8 @@
        events {
 	       ppmu_dmc1_3: ppmu-event3-dmc1 {
 		       event-name = "ppmu-event3-dmc1";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -32,6 +38,8 @@
        events {
 	       ppmu_leftbus_3: ppmu-event3-leftbus {
 		       event-name = "ppmu-event3-leftbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
@@ -42,6 +50,8 @@
        events {
 	       ppmu_rightbus_3: ppmu-event3-rightbus {
 		       event-name = "ppmu-event3-rightbus";
+		       event-data-type = <(PPMU_RO_DATA_CNT |
+					   PPMU_WO_DATA_CNT)>;
 	       };
        };
 };
-- 
2.17.1

