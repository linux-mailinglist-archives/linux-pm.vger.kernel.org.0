Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559B7B7C4E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfISOY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46487 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403767AbfISOX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142328euoutp0194ea0e2e32a0e9860f3c3fb5c9ddb242~F3Pk5ZsBL2320923209euoutp01E
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142328euoutp0194ea0e2e32a0e9860f3c3fb5c9ddb242~F3Pk5ZsBL2320923209euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903008;
        bh=AnLAppA40BqI8z9CshVPHeubC24brELzTHSPwO597YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xpv+vFwizO8MF8htiBDmDI6/+MEBOo28EozwPyXQir4HfD8XYVM67AtJD8V+zFTP+
         BBkURovEhn+GnOFs6L2BR4Ydc0T99DMIJxqTmtpVKHtWz/cPK3XH9mej5KLWEfk1Bk
         g+g4+o9MPgUOjLkZGU3xnQ91tLKLhs3+H4oDp9Ck=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142327eucas1p2ed6a1e2c127dd2789af76ab265167b07~F3PkJG0Yp3082530825eucas1p2m;
        Thu, 19 Sep 2019 14:23:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.1B.04309.F5F838D5; Thu, 19
        Sep 2019 15:23:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142326eucas1p204819014fe85716b47e2de4af9102cd5~F3PjKGocO2469524695eucas1p2L;
        Thu, 19 Sep 2019 14:23:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142326eusmtrp1095ef82681f3c06555d9fdcc527e3361~F3Pi7onA90555105551eusmtrp1a;
        Thu, 19 Sep 2019 14:23:26 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-56-5d838f5f8266
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.65.04117.D5F838D5; Thu, 19
        Sep 2019 15:23:25 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142325eusmtip10316e90c68f927ac1cd0f37950339202~F3PiEhIDb3226332263eusmtip1B;
        Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 06/11] interconnect: Relax requirement in
 of_icc_get_from_provider()
Date:   Thu, 19 Sep 2019 16:22:31 +0200
Message-Id: <20190919142236.4071-7-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuOxtNjlPypYvZNKEsu9DlK0UKQw5E0B8FooiuOmikU3a8
        dIEyzZqXtCaiuTArU1NMXfPSNDMbmUiuZZpQa9W63yS2kKgs57Hyv9/3Ps/zPd8LH0MoHdR8
        Zr8mnddq1MkqWk623/0+tDK+JDdudWejFPfdbZNiR1Uewq0VzRR+7H5L4QuWIQo/+jZO4/Kb
        RhrrHWdIbLW2SHG9/SuFjc5RCg+bz9PYddqCcIW1R4KbLHYpfnK8nsYVpe/pLd6csSGf5p6O
        dtOco7Bfwl2vOca1fumUcLe/dEu4YlMD4lxG/51MjDx8H5+8P5PXropIkCc1ua9SaVbpweY6
        E5GNzHQBkjHAroPeiTGyAMkZJVuPQNf0ghYPbgTOE0+nXUrWhWDgSvDfROudH0g01SG4NfIS
        /UsUGhooj4tmt4K+7LnUI/iyFgSl1ePTJQRbI4Fig5XwuHzYODgxPinxMMkuhapKm9TDChZD
        bXY1IfYthsaW3mmWsZvA3XOBFD3eMHDu1TQTU57cNgPhKQA2j4H75Q8oMbwNDBM5M6v6wId+
        k1TkhTBYWkSKLMDrGw5KDGcjMNZaZprD4E6/bUpgphqWQbN5lTjeCg/NdolnDKwXjH32Ft/g
        Bfr2ckIcK0B3UimiCsznvMQgQE7j6MzdHJSV28gzaEnlrGUqZy1T+b+2GhENyI/PEFISeWGt
        hs8KFdQpQoYmMXRvaooRTX27wcl+dycy/9zTh1gGqeYqArJy45SUOlM4lNKHgCFUvorz63Pi
        lIp96kOHeW1qvDYjmRf60AKGVPkpjsx5HqtkE9Xp/AGeT+O1f1UJI5ufjdJR1rGEZ2jRYOzy
        S20V8R1hQ26Z83Jn1MUgve+yNz26qBXxiuGzISFHO9ZF1oVsKGl58uG+entLZLjdPzqMKTTb
        DVVlAcS9JGKDznSwUPdxx7xPv+/t6g1b9GvjcFGwy2WeiA7cXZuZ+s7WteS607aZ1vfmB5lO
        xXRFXBMCO0ZYFSkkqdcsJ7SC+g9oiYmgcgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7qx/c2xBts2WFscOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2Ptl5WsBefZK9Yv38LcwLiLrYuRk0NCwERi4+HfjF2MXBxCAksZJXYd
        OsICkZCQ+Lj+BiuELSzx51oXG0TRJ0aJb+fOgyXYBBwlJk19wA6SEBE4xSixdfk5sCpmgQ1M
        EsufvgSrEhaIlvjzfiMTiM0ioCoxb9ZFdhCbV8BCYlnDAmaIFfISqzccALM5BSwlvuybD3aG
        EFDN3MdzGSHqBSVOznwCFOcAWqAusX6eEEiYGai1eets5gmMgrOQVM1CqJqFpGoBI/MqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwCjeduznlh2MXe+CDzEKcDAq8fAqlDfHCrEmlhVX5h5i
        lOBgVhLhnWPaFCvEm5JYWZValB9fVJqTWnyI0RTotYnMUqLJ+cAEk1cSb2hqaG5haWhubG5s
        ZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXHzizM5okftX/LsumzmY9PM/bM/qOKUhq91
        tXuCfKn5IQmmtEd/FFnu3PCc176Zc8V+1Z3PL4SE3FOt3FTRvFFe9Lz5vKfSiumX5scK7ghe
        7/Zh9dJTuow7vObyld04cyXytZJR+bbzfGkf2nY6THwQIHQwdhVD4RmXf7LBvVXfLtxgbdGp
        u6bEUpyRaKjFXFScCAA/QVJ9+AIAAA==
X-CMS-MailID: 20190919142326eucas1p204819014fe85716b47e2de4af9102cd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142326eucas1p204819014fe85716b47e2de4af9102cd5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142326eucas1p204819014fe85716b47e2de4af9102cd5
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142326eucas1p204819014fe85716b47e2de4af9102cd5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch relaxes the condition in of_icc_get_from_provider() so that it
is no longer required to set #interconnect-cells = <1> in the DT. In case
of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 95850700e367..f357c3a78858 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -284,7 +284,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-- 
2.17.1

