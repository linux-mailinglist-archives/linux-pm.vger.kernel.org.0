Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70813DDB5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgAPOmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 09:42:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34829 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAPOmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 09:42:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116144242euoutp0172fae3fb7d2adcdef97c54e18ac027be~qZRV7pbd83202932029euoutp01Y
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116144242euoutp0172fae3fb7d2adcdef97c54e18ac027be~qZRV7pbd83202932029euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579185762;
        bh=CXr3GrbWvOph9Y8HeGsYAdfWBQr4CaRWt2qdsDKZRyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kykSK39wDCXtzSpJpUgzg1i+mkumA4/eDfKje60DOH6eWVAg0A0qSpbnLF3RRoXWd
         s/Qu8AeNzD5AgHSUwg9db2hnjy5kCCvB9EG4NPVlthdtGxfkfAdolgJcYQmm+NmqGA
         jYErHK2ljdb+6hWMMj2qMnFg7Cb0QNgplzwIoAJ8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116144242eucas1p1d3567a2def247298ca22477d7914468a~qZRVtb-Q41363913639eucas1p1T;
        Thu, 16 Jan 2020 14:42:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.F2.60679.166702E5; Thu, 16
        Jan 2020 14:42:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0~qZRVZ6AHk0497304973eucas1p1G;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116144241eusmtrp137959cff65a2af54c977c33027387ca1~qZRVZIe-m0584505845eusmtrp1U;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-40-5e207661c6d3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.E4.07950.166702E5; Thu, 16
        Jan 2020 14:42:41 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144241eusmtip2b3eb3262f81e594c643ca8124a5ed374~qZRU1_EwE2382523825eusmtip2Y;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        georgi.djakov@linaro.org, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, krzk@kernel.org
Subject: [PATCH v4 1/3] interconnect: Export of_icc_get_from_provider()
Date:   Thu, 16 Jan 2020 15:42:00 +0100
Message-Id: <20200116144202.12116-2-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116144202.12116-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7qJZQpxBmd3WFvcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBLFZZOSmpNZllqkb5fAlXFr0Rf2gq0CFauWHGZvYGzi62Lk5JAQMJHon9vO3MXI
        xSEksIJRovfmARYI5wujxPYNF6Ccz4wSL3vvssO0PNr4DiqxnFHiw/51jHAtd09NZAapYhNw
        lJg09QFYh4hAvMTHbf/AOpgFdjJKHPn7hwkkISzgLvHsDMRYFgFVif0fJrOA2LwClhI/T11k
        glgnL7F6wwGgoRwcnAJWEp8fq0KUCEqcnPkErJwZqKR562ywJyQE1rFLnNvTwwbR6yLx8uVV
        KFtY4tXxLVAvyEicntzDAmEXSzzdeZ8VormBUWLTsiPMEAlriTvnfrGBLGYW0JRYv0sfIuwo
        8fTETbCwhACfxI23ghA38ElM2jadGSLMK9HRJgRhKknsmgkNagmJptXXoGZ7SMz/vZd9AqPi
        LCTPzELyzCyEtQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJp3T/45/2cG460/S
        IUYBDkYlHt4ZQQpxQqyJZcWVuYcYJTiYlUR4T86QjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        a7zoZayQQHpiSWp2ampBahFMlomDU6qBcfpKMcaT93ql0kTPt/+54F3QY5LpfOexg9HhREYL
        6w6HM99d1gpfMeP/tpxj9+sjlwu6cr7X5C3pFQwuyHjawv5x0+Rvoou//g5xMcjWFp1lb9DC
        kmewd9O+B9LslyZMjru/6OSU1NiZfPcDpB9cEsoNvvy+6bBw4/ud0/qYI+eequD/VHYlQYml
        OCPRUIu5qDgRANcwnb02AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7qJZQpxBmduqlrcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl3Fr0Rf2gq0CFauWHGZvYGzi62Lk5JAQMJF4tPEdSxcjF4eQwFJGiYVHzrFDJCQkPq6/
        wQphC0v8udbFBlH0iVHix6/HTCAJNgFHiUlTH4A1iAgkStx69JgZpIhZYD+jxMs7bWwgCWEB
        d4lnZ+6CFbEIqErs/zCZBcTmFbCU+HnqIhPEBnmJ1RsOADVzcHAKWEl8fqwKEhYCKrm9sZsV
        olxQ4uTMJywgJcwC6hLr5wmBhJmBOpu3zmaewCg4C0nVLISqWUiqFjAyr2IUSS0tzk3PLTbS
        K07MLS7NS9dLzs/dxAiMpW3Hfm7Zwdj1LvgQowAHoxIP74wghTgh1sSy4srcQ4wSHMxKIrwn
        Z8jGCfGmJFZWpRblxxeV5qQWH2I0BfpsIrOUaHI+MM7zSuINTQ3NLSwNzY3Njc0slMR5OwQO
        xggJpCeWpGanphakFsH0MXFwSjUwutcavy241yqYpr/2WaTcpQYd9rwLwjd/ZW5337bDcd77
        4yd3b0u/dXKqwQL9OXPOLha7ImvBwixsmnrANVV+ab2J6+v6gIbcgyqRCzsPzO54ZVv++mRM
        CMvHOn6X8LqC/tRZD1ek90k+eNxhtEMg5MqxwyyS649YJCWsvuLIUn74U7SupZqyEktxRqKh
        FnNRcSIAv2xK1bsCAAA=
X-CMS-MailID: 20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0
References: <20200116144202.12116-1-a.swigon@samsung.com>
        <CGME20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch makes the above function public (for use in exynos-bus devfreq
driver).

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f277e467156f..0be1764d3528 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
-static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
@@ -349,6 +349,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	return node;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
 /**
  * of_icc_get() - get a path handle from a DT node based on name
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 0c494534b4d3..cc965b8fab53 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -103,6 +103,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -154,6 +155,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
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

