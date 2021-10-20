Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5811434AD2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJTMJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 08:09:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55610 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhJTMJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 08:09:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211020120654euoutp02d651d7210db46fb6d6b9fbdeeff2ea52~vu7312_oG2730027300euoutp025
        for <linux-pm@vger.kernel.org>; Wed, 20 Oct 2021 12:06:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211020120654euoutp02d651d7210db46fb6d6b9fbdeeff2ea52~vu7312_oG2730027300euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634731614;
        bh=8ssmdz378H2O6GPkTWYZCibFa9nC5r5ueHzA0hIFHVo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=u/5Lxkg6fJ6AP96ZQSZe0pSxJX7Ut/idMVsgo7Hc/PwikEEY36Bso6YO7dtvwiUWX
         X8JGng4vG4/oDa/zh+XHAiqvT3g4MJFwXtk6McrTmI4OtH7MKPDDCvCO5SgpprldUs
         mlSnTSrZVcaPC0nytrnzB3J2ok2k1fHl8LTeQgHM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211020120653eucas1p18d0a90d20c1e55bd931a6cbdc19baa2d~vu73Xa5rI2464724647eucas1p1n;
        Wed, 20 Oct 2021 12:06:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id ED.25.42068.D5600716; Wed, 20
        Oct 2021 13:06:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211020120653eucas1p176e7d48624cd773f2d96c06994e21856~vu72srT8A1153911539eucas1p1R;
        Wed, 20 Oct 2021 12:06:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211020120653eusmtrp2dbbcef9489ba0e7510c901ea1d8d5709~vu72r4SZ21871218712eusmtrp2B;
        Wed, 20 Oct 2021 12:06:53 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-5f-6170065d59f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.7C.20981.D5600716; Wed, 20
        Oct 2021 13:06:53 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211020120652eusmtip1f97a50283e9634607e59aeb8e70cb4f6~vu72LtMRP2013220132eusmtip1J;
        Wed, 20 Oct 2021 12:06:52 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] cpuidle: qcom_spm: make driver multi-arch friendly
Date:   Wed, 20 Oct 2021 14:06:43 +0200
Message-Id: <20211020120643.28231-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7qxbAWJBsf2yFuce/ybxWLmyVYm
        i7+TjrFbnN7/jsVi3mdZi4n7z7JbXN41h83ic+8RRou1R+6yW8z9MpXZ4sZcEwduj9+/JjF6
        tC2w99i0qpPN4861PWwefVtWMXp0nmX0+LxJLoA9issmJTUnsyy1SN8ugSvj4JtG9oL/3BXb
        ptk3ME7m6mLk5JAQMJE4MPEVexcjF4eQwApGiY833kM5Xxgl1q66zQLhfGaUWPn8BQtMy5kb
        35ghEssZJXqm32eCa9nxewIjSBWbgKFE19suNhBbRCBa4uvPq2BFzAKvmCQ2b3jFBJIQFnCW
        WHf+LTuIzSKgKjHn6kKwBl4BW4kjPQeYIdbJS6zecABsnYTAUg6Jn7cvs0MkXCRudPQzQtjC
        Eq+Ob4GKy0j83zmfCaKhmVHi4bm17BBOD6PE5aYZUB3WEnfO/QJaxwF0k6bE+l36EGFHiaYl
        zewgYQkBPokbbwVBwsxA5qRt05khwrwSHW1CENVqErOOr4Nbe/DCJaibPSR+rzgP9ouQQKzE
        7I3f2Ccwys1C2LWAkXEVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYAo5/e/4lx2My199
        1DvEyMTBeIhRgoNZSYR3d0V+ohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHepC1r4oUE0hNLUrNT
        UwtSi2CyTBycUg1MgQy8QXl8Pvu4trewfpPfrC4t+1iI/W/PopopniYC3X/SZcobHyZWnXB9
        K3Ck/UratVPu2qVV7bYZqk+8/1mJn/eeke4c+rL+l4XXuQM9Ny6e22HvzKR9uDIlrWi/iele
        TvF7r2/93eDEIv/J9fYqE93Hwf7qYaptuXUxZ0vfSa0R2Gs/68SNRwYXxKK9Ju3Jc9+3X2XX
        wfY9iSsYN+lziH5c617/1UWnge1c8K/Dl5Z/mbMoifVJFL856/pk1owdclJqvsuY3nkkPtJX
        CDvi1vJ196r2o0Zt69UyX7ytV5qsu8ix9Mb7B64bom6Jis+p/7OPX/WTkYvXG0PxbBH16pWF
        DtmvT0/38uV211BiKc5INNRiLipOBADakz8CkAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t/xu7qxbAWJBucfM1uce/ybxWLmyVYm
        i7+TjrFbnN7/jsVi3mdZi4n7z7JbXN41h83ic+8RRou1R+6yW8z9MpXZ4sZcEwduj9+/JjF6
        tC2w99i0qpPN4861PWwefVtWMXp0nmX0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4JtG9oL/3BXbptk3ME7m6mLk5JAQMJE4c+Mb
        cxcjF4eQwFJGiTd3H7JBJGQkTk5rYIWwhSX+XOtigyj6xChx/8gCFpAEm4ChRNfbLrAGEYFY
        ibsHD7KDFDELvGOSuL5qDVi3sICzxLrzb9lBbBYBVYk5VxeCNfAK2Eoc6TnADLFBXmL1hgPM
        Exh5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgM3G3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4
        mJVEeHdX5CcK8aYkVlalFuXHF5XmpBYfYjQF2jeRWUo0OR8YO3kl8YZmBqaGJmaWBqaWZsZK
        4rwmR9bECwmkJ5akZqemFqQWwfQxcXBKNTBJLImU+crPPPWm5HaLRy4u308F6mlEb5DYfss/
        TMmCJ45tse+Kj93HQzr/vVhkuXKC0sdEliPms+XP1p+umRGbcv+y+8EvVew7trn9jVi1unDB
        6xvLd9701nO6x9a1s2vTy+XLGDrnlwafXbNHJaVUOPXl7pcFP18pqrlzsW2V+PJv2wH2VWlK
        PPzOzPXTlYxyIzgb3y/oe6L8vb0u0ea09vQ1a55sErgWK/2Ty3qS2oovQUsklbiz/zO9aun6
        +/GpR69Y7U/zOn7GSweX7KgW3fUpbtkXp+suSz9XfZ+xo4xJgnNB6Obrx3bv+q4ud8I+Jf7A
        5TLtm2qpco5PqnyOLd8Q1LLa5s2TOp2e3p8KSizFGYmGWsxFxYkActV4lOUCAAA=
X-CMS-MailID: 20211020120653eucas1p176e7d48624cd773f2d96c06994e21856
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211020120653eucas1p176e7d48624cd773f2d96c06994e21856
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211020120653eucas1p176e7d48624cd773f2d96c06994e21856
References: <CGME20211020120653eucas1p176e7d48624cd773f2d96c06994e21856@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Avoid returning -EPROBE_DEFER from spm_cpuidle_drv_probe() on non-qcom
based systems. This makes the driver multi-arch friendly again after
commit 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main
SPM handling").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes the issue I've reported some time ago:
https://lore.kernel.org/all/86e3e09f-a8d7-3dff-3fc6-ddd7d30c5d78@samsung.com/
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 01e77913a414..1ee056fdfbb8 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -129,12 +129,26 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 	return cpuidle_register(&data->cpuidle_driver, NULL);
 }
 
+static int spm_dev_check(struct device_driver *drv, void *data)
+{
+	if (strcmp(drv->name, "qcom_spm") == 0) {
+		struct device_node *np;
+
+		np = of_find_matching_node(NULL, drv->of_match_table);
+		if (np) {
+			of_node_put(np);
+			return -EPROBE_DEFER;
+		}
+	}
+	return -ENODEV;
+}
+
 static int spm_cpuidle_drv_probe(struct platform_device *pdev)
 {
 	int cpu, ret;
 
 	if (!qcom_scm_is_available())
-		return -EPROBE_DEFER;
+		return bus_for_each_drv(pdev->dev.bus, NULL, NULL, spm_dev_check);
 
 	for_each_possible_cpu(cpu) {
 		ret = spm_cpuidle_register(&pdev->dev, cpu);
-- 
2.17.1

