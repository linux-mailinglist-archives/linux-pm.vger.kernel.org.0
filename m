Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C27116F69
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfLIOow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:44:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59587 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfLIOoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 09:44:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191209144443euoutp01bfc4b6e0513eb20f9813acfc497b7dee~euyQF-0oC0633006330euoutp01S
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 14:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191209144443euoutp01bfc4b6e0513eb20f9813acfc497b7dee~euyQF-0oC0633006330euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575902683;
        bh=vmsYHmTYNYlLDIB9n5HoDoLj6M0SpxR24w7UmG0Af50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyF8ALsNHfopDXgNzhPIgwVaxLjJEh/V7hJg4RMPQh9iqbvRX5K6geozqVL2MjEyk
         mUxERSVDWBCD9b6ack1OKIX6zTIKV+K3iiId4WjQcSNqCxfU9vHsr0sjvqc3FbuJUl
         79kqH7GoVfwxil4WDSVOFYiZDL1AAXPK0KvD0kR4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209144442eucas1p2feb35da92f2ba3b14a47d9d1f6546734~euyP3HPvr1762917629eucas1p2A;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.28.60698.ADD5EED5; Mon,  9
        Dec 2019 14:44:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91~euyPbvn8y2849928499eucas1p1h;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209144442eusmtrp27c68c303bdc9a039888bf6d5a33ec8f0~euyPbLpEc2831928319eusmtrp2y;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-17-5dee5dda4d41
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.09.08375.ADD5EED5; Mon,  9
        Dec 2019 14:44:42 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144441eusmtip2e24a7d14775db59d3a38f850b9345d6a~euyO7yv3f1405314053eusmtip2M;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 3/4] PM / devfreq: Kconfig: add DEVFREQ_DELAYED_TIMER option
Date:   Mon,  9 Dec 2019 15:44:24 +0100
Message-Id: <20191209144425.13321-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209144425.13321-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7q3Yt/FGhy8qW2xccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGVsmb+AvaCJs6Jj4kzGBsY17F2MnBwSAiYSM/4eYu5i5OIQEljB
        KPFk01d2COcLo8SZc+tZQaqEBD4zShxtVobpWHZxIRNE0XJGiZN325ggioA6dr4vALHZBPQl
        Dp49yQJiiwhIS3QumgjWwCxwjEli16G/YFOFBXwkfnRMYgaxWQRUJc7cOs8IYvMK2Ej8eLcH
        KM4BtE1eYs5bDZAwp4CtxOuPU5ghSgQlTs58AjafGaikeetssBckBPrZJb6ef80EcamLxJnO
        v2wQtrDEq+NboH6Wkfi/cz5UTbnE04V97BDNLYwSD9o/skAkrCUOH7/ICnIEs4CmxPpd+hBh
        R4mDO1azQdzGJ3HjrSDEDXwSk7ZNhzqZV6KjTQiiWlXi+akeqE3SEl3/17FC2B4SmzpbWCcw
        Ks5C8s0sJN/MQti7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCiOf3v+NcdjPv+
        JB1iFOBgVOLhXeDwLlaINbGsuDL3EKMEB7OSCO+Sia9ihXhTEiurUovy44tKc1KLDzFKc7Ao
        ifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamDcdKhdOsRU74/Apzqfl7suLz3Kuez5V+5TyvsE
        bm31f7R5R1aa08aLNaYe0Wt/Oqys5xcVyle3qtjNH/jTViphY9Ue1trWe3+Xhh4I6ZkmpdOe
        Gf3ztoAlt4/Ot5RzGblPD/nVmatr2Dqopijn/V3wrPbcPPtjHPqBkZMvrV/OMmFJwSeLi3OV
        WIozEg21mIuKEwEgIbF1MAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1bse9iDWZc4rXYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK2
        zF/AXtDEWdExcSZjA+Ma9i5GTg4JAROJZRcXMnUxcnEICSxllDj67SMbREJaovH0aiYIW1ji
        z7UuNoiiT4wSj//NAStiE9CXOHj2JAuILQLU0LloIlgDs8AZJolfLRUgtrCAj8SPjknMIDaL
        gKrEmVvnGUFsXgEbiR/v9gDFOYAWyEvMeasBEuYUsJV4/XEKWLkQUEn7//8sEOWCEidnPmGB
        GC8v0bx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyJbcd+bt7B
        eGlj8CFGAQ5GJR7eBQ7vYoVYE8uKK3MPMUpwMCuJ8C6Z+CpWiDclsbIqtSg/vqg0J7X4EKMp
        0A8TmaVEk/OB8ZpXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHR
        82Lu99w+451Lt5iu0bZeZFMn/+t/LW8M55ds5ocm4S+VLfp0XnwO+nCJtdnW9PquOTYcrM0t
        q7lnLWY/d1b06uWP1pEBJV2B/DJBYibrL3L9cb7Y0TSL0+7hnMrN5yav63w2Z/qTHw96d1ud
        T4xMZNpRzqh++qqSpZzVkXuLTUIL7i+qYtBWYinOSDTUYi4qTgQA5QC6qZ8CAAA=
X-CMS-MailID: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Kconfig option DEVFREQ_DELAYED_TIMER. If set, devfreq workqueue
will use delayed timer from its start.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 38a94df749a2..c799917c34c9 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -74,6 +74,18 @@ config DEVFREQ_GOV_PASSIVE
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
 
+comment "DEVFREQ Options"
+
+config DEVFREQ_DELAYED_TIMER
+	bool "Use delayed timer in Simple Ondemand Governor"
+	default false
+	help
+	  Simple Ondemand Governor uses polling for reading buses counters.
+	  A default timer used is deferred, which saves power, but can
+	  miss increased demand for higher bus frequency if timer was
+	  assigned to idle cpu. If you want to change this to delayed
+	  timer at the cost of more power used, say Yes here.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
-- 
2.24.0

