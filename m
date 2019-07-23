Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9871816
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbfGWMVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:21:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57719 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbfGWMU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122027euoutp02dd902a587f7abfaf8dc3775b13ead784~0CJnRlHnC3163531635euoutp02x
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723122027euoutp02dd902a587f7abfaf8dc3775b13ead784~0CJnRlHnC3163531635euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884427;
        bh=69sx8Ho8WYsPHRFweup85Ar55fYbxmZw5YIq9XlVhhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUMiMS8rcDKWYgE9JDpSXyrW2C/qVYaHwu/wbPvKqmsUEuGa5VRBnPlZromlcP7Mx
         fbSINPeJEhHU44dcWyOuSwl6rwTYuEFk1Rbpzs3eQtF1vubr0RJILay34ncj+SXh94
         0G4Ye/ncfa+oc0XnGp7cTPnUGSHP6E2RPqn6qmhQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122026eucas1p1f335ee2bd2411aaba4b3ccdda8ae2cfe~0CJme7mvZ0728407284eucas1p17;
        Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.0C.04377.A8BF63D5; Tue, 23
        Jul 2019 13:20:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64~0CJlrL8tN2751727517eucas1p2d;
        Tue, 23 Jul 2019 12:20:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122025eusmtrp1f6762be756a6f02ff6df821cd5e17030~0CJlgYUKY2491824918eusmtrp1b;
        Tue, 23 Jul 2019 12:20:25 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ad-5d36fb8ae00a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.41.04146.98BF63D5; Tue, 23
        Jul 2019 13:20:25 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122024eusmtip27564000c231ee8652f0e0023861fb0d6~0CJk5pYbi1612616126eusmtip2K;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 05/11] icc: Export of_icc_get_from_provider()
Date:   Tue, 23 Jul 2019 14:20:10 +0200
Message-Id: <20190723122016.30279-6-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87pdv81iDT7N4bU4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        exSXTUpqTmZZapG+XQJXxt3jl5kLXvBXPOy8xdjAuIe3i5GDQ0LAROJqs3sXIxeHkMAKRomX
        n+8xQThfGCV+dX5jgXA+M0pcv3wIKMMJ1rHy0n2oxHJGieZZz1nhWr7OvccKUsUm4CnRM3EH
        WEJE4AijxOQF78FamAVWATnftzGCbBcWcJTYtbEKpIFFQFXixJYOFhCbFyi8pKGHEWKdvMTq
        DQeYQWxOASeJrqPtbBA1ghInZz4Bq2cGqmneOpsZZL6EwEd2iV97NkE1u0j8at/HDGELS7w6
        voUdwpaROD25hwXCLpZ4uvM+K0RzA6PEpmVHoBqsJQ4fv8gKciizgKbE+l36EGFHifdHdzJB
        Qo9P4sZbQYgb+CQmbZvODBHmlehoE4IwtSQW/I6GaJSQaFp9DWq2h8TsJy3MExgVZyF5ZhaS
        Z2YhrF3AyLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMJmd/nf8yw7GXX+SDjEKcDAq
        8fBu2GMaK8SaWFZcmXuIUYKDWUmEN7DBLFaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2gh
        gfTEktTs1NSC1CKYLBMHp1QDo0X9j6Az33m+ztN9uHpqxo6tPPfz+eKvab1VqHyZxShR9qGT
        2144dL2w02uf8xsrTfaUqnPOEagUOXC+Y7dEfHx6UedrUYYXXW2KN/jn5e6cY3eqfsmRP5Mk
        Nu4Sq33R4n/nwsMK9VeJrgZeDyR/hyRNi3xx/ZlztmDUm9llfa0T02I5pj56p8RSnJFoqMVc
        VJwIAJpbezdiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7qdv81iDfZNlbI4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJext3j
        l5kLXvBXPOy8xdjAuIe3i5GTQ0LARGLlpfssXYxcHEICSxklvuz/zAqRkJD4uP4GlC0s8eda
        FxtE0SdGibZ9C8ASbAKeEj0Td7CCJEQETjFKbF1+DqyKWWATo8Td4xPZuxg5OIQFHCV2bawC
        aWARUJU4saWDBcTmBQovaehhhNggL7F6wwFmEJtTwEmi62g7G4gtBFSzbftrRoh6QYmTM5+w
        gIxkFlCXWD9PCCTMDNTavHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFuem6xoV5xYm5xaV66
        XnJ+7iZGYJRuO/Zz8w7GSxuDDzEKcDAq8fBu2GMaK8SaWFZcmXuIUYKDWUmEN7DBLFaINyWx
        siq1KD++qDQntfgQoynQaxOZpUST84EJJK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklq
        dmpqQWoRTB8TB6dUA6N/5Vm3R2LR8xyf9c01epf+1Fbg1qOvLO7TrBvnRlmcOPc4Sr0m70ae
        cdDW16nb9r6MVLNcJvyKzYzzWfOs8kvyqexCTFem/EtuET7tdE/8aUl15pupj99Nff0ibdbE
        fS/OnIvOaf/n8lqpbcqvHsN/0+NYbCx3JEz80ma8IcZeZZIW28VC6zglluKMREMt5qLiRABm
        fgMp6AIAAA==
X-CMS-MailID: 20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch makes the above function public (for use in exynos-bus devfreq
driver).

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 871eb4bc4efc..d566ae0b66c0 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -274,7 +274,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
-static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
@@ -293,6 +293,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	return node;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
 /**
  * of_icc_get() - get a path handle from a DT node based on name
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 63caccadc2db..9ecfc518b952 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -97,6 +97,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -137,6 +138,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
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

