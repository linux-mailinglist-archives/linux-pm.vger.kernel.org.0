Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D3116F6C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfLIOon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:44:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53791 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLIOon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 09:44:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209144442euoutp020d59962f912bbd8b2c2703fc7926f624~euyPNQl1W2561025610euoutp02G
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209144442euoutp020d59962f912bbd8b2c2703fc7926f624~euyPNQl1W2561025610euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575902682;
        bh=HSFFoFiOo0swpbY+DWz76dNsC/W3cBBhFIOvJXJuUMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWTtgsSwIn9JRxeDbschkYpwUvFZz3F/mrTn2stiMnxglJa/Jqfaut9ca1HEewJac
         wjH1NzxYXWXEZEpL3HzDZO/9TWNdfeBNT6ga5/5YjyUh0jVAwla2wznpnQGCoUI32L
         ntXZhy8scnkzXbWWy8LpahTe9LhiBdj0fjR7bvYg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209144441eucas1p1e2fd2160c44410e8462c0ef9eeda7844~euyO7alLw2849128491eucas1p1E;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.28.60698.9DD5EED5; Mon,  9
        Dec 2019 14:44:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2~euyOkRiqq1586515865eucas1p1U;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209144441eusmtrp2796e72b048fb8833b0fe8d0a31d5a5da~euyOjpYGv2834828348eusmtrp2i;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-14-5dee5dd9e231
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3A.C9.07950.9DD5EED5; Mon,  9
        Dec 2019 14:44:41 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144440eusmtip2d0aedf96da3be9749a458fb850d20de4~euyODqXWa1447214472eusmtip2r;
        Mon,  9 Dec 2019 14:44:40 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 1/4] PM / devfreq: reuse system workqueue machanism
Date:   Mon,  9 Dec 2019 15:44:22 +0100
Message-Id: <20191209144425.13321-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209144425.13321-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7o3Y9/FGjzbq2mxccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGU8vraapeAYe8WWL49YGxg3s3UxcnJICJhI/Lk5mb2LkYtDSGAF
        o8S93h1sEM4XRonJc24xQzifGSU+nt0I13L8UzMTRGI5o0T/0SPMcC1fzj1nBaliE9CXOHj2
        JAuILSIgLdG5aCJYB7PAMSaJXYf+ghUJCzhLrHn3GcxmEVCVOLDjB5jNK2AjcenceqAGDqB1
        8hJz3mqAhDkFbCVef5zCDFEiKHFy5hOw+cxAJc1bZzNDXNfPLjHxQB5Eq4vEvg9MEGFhiVfH
        t7BD2DIS/3fOh4qXSzxd2Af2v4RAC6PEg/aPLBAJa4nDxy+ygsxhFtCUWL9LHyLsKDH3/zNm
        iPF8EjfeCkJcwCcxadt0qDCvREebEES1qsTzUz1Qm6Qluv6vY4WwPSQWNsxlm8CoOAvJL7OQ
        /DILYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgYnm9L/jX3cw7vuTdIhRgINR
        iYd3gcO7WCHWxLLiytxDjBIczEoivEsmvooV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWs
        kEB6YklqdmpqQWoRTJaJg1OqgVGk6sap1eo18RFvntyQLL6au7yQ6YKL12LWNU6vG/MmqzIW
        eayc2ynqH3Lc8DF/5PZDx/oDfn+f15tu96XoT8N8drdlG35cWZAg5Zo+f8/mXXO65Bx3bpvN
        sMziwg7zVT+WWso94/oSWyYn5hu3JSpe89zjX2e5mCXko/42tASHxUr01N7pb1FiKc5INNRi
        LipOBAB+2nwjMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd2bse9iDXauEbLYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIe
        X1vNUnCMvWLLl0esDYyb2boYOTkkBEwkjn9qZupi5OIQEljKKLHh1iVmiIS0ROPp1UwQtrDE
        n2tdbBBFnxgl+qd0sIMk2AT0JQ6ePckCYosANXQumgjWwCxwhkniV0sFiC0s4Cyx5t1nVhCb
        RUBV4sCOH2A2r4CNxKVz64HqOYAWyEvMeasBEuYUsJV4/XEK2A1CQCXt//+zQJQLSpyc+YQF
        Yry8RPPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAmth37uWUH
        Y9e74EOMAhyMSjy8CxzexQqxJpYVV+YeYpTgYFYS4V0y8VWsEG9KYmVValF+fFFpTmrxIUZT
        oB8mMkuJJucD4zWvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj
        prFtVpi8lPvnps+y/935QxtW7702P1h3a9Y/hnShT0VmG6//yqztDXnzp9zjWr+O/7P4mTfc
        yjYvLA78qr50q/CW2LNJsSasdexScosO5il7id7le6jhXXVr5Qb7tlnHc/wcdjy0m3Ds/DcZ
        tn8+Hgf3HpJpTAkq2XXQ+E3gvawdfgeCCxcpsRRnJBpqMRcVJwIA+IJM/58CAAA=
X-CMS-MailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p16945780c1a1ff3302a233414ae6aace2@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need for creating another workqueue, it is enough
to reuse system_freezable_power_efficient one.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 46a7ff7c2994..955949c6fc1f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1532,11 +1532,11 @@ static int __init devfreq_init(void)
 		return PTR_ERR(devfreq_class);
 	}
 
-	devfreq_wq = create_freezable_workqueue("devfreq_wq");
+	devfreq_wq = system_freezable_power_efficient_wq;
 	if (!devfreq_wq) {
 		class_destroy(devfreq_class);
-		pr_err("%s: couldn't create workqueue\n", __FILE__);
-		return -ENOMEM;
+		pr_err("%s: system_freezable_power_efficient_wq isn't initialized\n", __FILE__);
+		return -EINVAL;
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
-- 
2.24.0

