Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46DB7C4C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbfISOX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46486 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390520AbfISOX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142327euoutp01b486b4dc734cc2110f9925a3ade4b0bc~F3Pj_b5jY2191721917euoutp01J
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142327euoutp01b486b4dc734cc2110f9925a3ade4b0bc~F3Pj_b5jY2191721917euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903007;
        bh=w2UfJ6ezBPlUEZnplzVKt++ooGfyIuCYzPhz55Bgqb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cqg31bnNoolGhUGnzvbS1SsL9Zi1cxq3UBL5UlIBq+Bexfi33Gzvu0nqi7W2/h0qb
         Vni/KJo6W2l9be2pqs7RR31UhymBlZl5PQTceDyN181y94qRVBa62AeuJRZuiRHH4Q
         qJ7W47BXvDBtzwroBQJuZObfW6APG9G5lFQDei+8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142326eucas1p29743d0d0f6a4c44888d4446079565359~F3PjExPt63079930799eucas1p27;
        Thu, 19 Sep 2019 14:23:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F8.0C.04469.D5F838D5; Thu, 19
        Sep 2019 15:23:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0~F3PiUCWQt3080630806eucas1p2g;
        Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142325eusmtrp1bb5ff0307cc675ca3d309dbb76a680b1~F3PiFV8J80555105551eusmtrp1X;
        Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-0b-5d838f5d6501
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.1F.04166.D5F838D5; Thu, 19
        Sep 2019 15:23:25 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142324eusmtip1e21b74ae9efc6b6226bd53e23436627c~F3PhTa9XB3039930399eusmtip1f;
        Thu, 19 Sep 2019 14:23:24 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 05/11] interconnect: Export
 of_icc_get_from_provider()
Date:   Thu, 19 Sep 2019 16:22:30 +0200
Message-Id: <20190919142236.4071-6-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3f3YVdq8TsGTZtZAwiAtKHjVsASxawQF/soQnXmZ6aa2m2VG
        pC6tNE0cmWl+YB8uP1KXio2UmqNRVsMyDVpNKImUlPwqwSK3a+W/5znnPOd5zsvLEAoH5c8c
        zzzJ6zJVGiXtSfY+XXq1PfGqPnHHmCMCW572SLGzvgjhruoOCo/Nf6Fwg/UVhUcWZmh8vd9E
        40pnBYnt9k4pNn74TmHTp1EKvzHfpPFcmRXhavuABLdbP0jx+wIjjasNX+l93pyp5TLNOUYf
        0Zyz1CbhHtw+z3VN90m4J9OPJFx5dwvi5kybDjMJnntSec3xU7wuLCrZM62muwdlv2Vz25rL
        UT6qk5cghgF2F9xzRJUgT0bBGhG8MA4TIplHUD44vkrmECyOmFeIh1vhbH0uERvNCGxVw9J/
        koIftcg1RbPRUHlt3N3wZa0IDI0zpIsQ7G0JlNfaCZe7D3sIioZYl4Bkg+HhVCnpKstYDBOz
        saJbELR2PnY7e7DhMD/QQLqwjPWGZzc+uzGxMqPvqXVHBfYyA7OWGUoUx8DP9iZaxD4waeuW
        ingjDBmukCIWYOKhkxLF+QhMd62rd0bCoG2YcgUi2BDoMIeJDxYNvdYTIpTDu2/eYgQ5VPZe
        J8SyDC4VK0SoBPMNubgOoLB1dHU1Bw77BbICbalZc0vNmltq/rs2IqIF+fE5glbNCzsz+dOh
        gkor5GSqQ49laU1o5c8N/bbN9qGF1ykWxDJIuV62+bQ+UUGpTglntBYEDKH0ld3cXZiokKWq
        zuTxuqwkXY6GFywogCGVfrKz68aPKli16iSfwfPZvO5vV8J4+OejhPqYoKr4til1lj5w8deR
        gNoD4xFeDRqNXn7nYkfEwabevVvzvOq45NL7+7UhG5LTiwOJsbmPZulkZPCtcykFztSlGHVj
        n59huQxK+pWFfd3C6wLjvE9n0sCypv9lRrrOYI07IO2KzY2Xx315nrbYun15aqQ5PabsbpX2
        7UR4lZIU0lQ7txE6QfUHZYrZam8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7qx/c2xBuuOsFkcOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2PWlq2MBVcFKtYs72NsYJzL18XIySEhYCJxf/Uppi5GLg4hgaWMElNu
        z2GBSEhIfFx/gxXCFpb4c62LDcQWEvjEKNE2LwXEZhNwlJg09QE7SLOIwClGia3Lz7GBOMwC
        G5gklj99CdYtLOAr0fj6ENhUFgFViZ2vu4FsDg5eAQuJp5/cIBbIS6zecIAZxOYUsJT4sm8+
        C8QyC4m5j+cygti8AoISJ2c+AWtlFlCXWD9PCCTMDNTavHU28wRGwVlIqmYhVM1CUrWAkXkV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYARvO/Zz8w7GSxuDDzEKcDAq8fAqlDfHCrEmlhVX
        5h5ilOBgVhLhnWPaFCvEm5JYWZValB9fVJqTWnyI0RTos4nMUqLJ+cDkklcSb2hqaG5haWhu
        bG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVHo6zWBT5+fnuw03ml2wv9pf+fVGVcL
        tvHY8zwrEpP81CfDcTNS7NOVVO63Gn8LHlbJOMh825Sy60m8hMacwp/qhqfmzWD48tbrmPpL
        m7fJX16qu2UKCMr/U43646nY63OVS//Uq4e6HXIKB+0cFhyVfL9B7YNL02HH5y80q9iDC6c6
        fVjc8leJpTgj0VCLuag4EQBcdGda9gIAAA==
X-CMS-MailID: 20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142325eucas1p28102446c22b1e1c61aae0bad46d079b0@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch makes the above function public (for use in exynos-bus devfreq
driver).

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7b971228df38..95850700e367 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -279,7 +279,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
-static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
@@ -298,6 +298,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	return node;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
 /**
  * of_icc_get() - get a path handle from a DT node based on name
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index b16f9effa555..070e411564e1 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -100,6 +100,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -140,6 +141,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
 	return -ENOTSUPP;
 }
 
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
-- 
2.17.1

