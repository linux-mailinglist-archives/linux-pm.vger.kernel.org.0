Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5752A116B74
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLIKuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:51 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52483 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLIKue (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191209105031euoutp01620541e03b2c14e71c70b7c0b9df2e6d~erlxyGmYi0079900799euoutp01H
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 10:50:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191209105031euoutp01620541e03b2c14e71c70b7c0b9df2e6d~erlxyGmYi0079900799euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575888631;
        bh=tu/3vAqg2eZBipuQKDMS6XZM950MbyTsGIPOEwI9Cxc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WsXwm7n9TRXZfiiPfqvIqBLdcvV4E+LkkamsKUL15QNtL1ABO1zpXukwd46n8ZQ71
         CqxZu0sLRBKnAPn2ys58BN6H4tPOz0J64Gi/bGeOI/jPMy0W5/BPUid13+8mi+1DhE
         N1bqjEMSOw7lkOlWWblxIrfqCRwWodcxtExHKuoE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209105031eucas1p27d021a0c350d9539165b612d26c6bce6~erlxazhQi1399213992eucas1p2J;
        Mon,  9 Dec 2019 10:50:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.46.61286.7F62EED5; Mon,  9
        Dec 2019 10:50:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105030eucas1p11e28297118da5a1d9f3a8c955584a4bf~erlxDvwK00759507595eucas1p15;
        Mon,  9 Dec 2019 10:50:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209105030eusmtrp1a61aad405c47222845290cfa811b9435~erlxC9M7D2125621256eusmtrp1P;
        Mon,  9 Dec 2019 10:50:30 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-2a-5dee26f7d5a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.C7.07950.6F62EED5; Mon,  9
        Dec 2019 10:50:30 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105030eusmtip19583cc7dad07d17a1c8d1aa87ffc5a04~erlwRNiPp2957929579eusmtip1l;
        Mon,  9 Dec 2019 10:50:30 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        k.konieczny@samsung.com, leonard.crestez@nxp.com
Subject: [PATCH v3 0/4] devfreq: Clean up exynos-bus driver
Date:   Mon,  9 Dec 2019 11:48:58 +0100
Message-Id: <20191209104902.11904-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229nZjqvJ5xR8UbOYZBdIk4q+SCK70H4G3dZl1cyDSU5lp+kM
        ymVpJt5aRLYiKi2XXVzLRAeZLm2p2VDJslgK2sVb5VTsXm7HLv+e73mf53kvfAwle0wHM4nJ
        B1ltsjpJLpIIqx99cS6ajPigWvykHpOei9mI3CmppMnz8Xc0MfYUC8kldwlNivqGKOJ0WsSk
        LWtYTMyuUZpY+7po0mm7ICJjBY2IlDjrBORWo0tMXh01i0jJ6QHRaqywVpwUKe6WZSrufKgR
        KAqrKpBizBq2kd4hiYlnkxLTWG3Uqr2S/S9HZ6UOztB3WX4gA3L75iGGAbwUPg8G5yFfRobN
        CPrGSR6STOFxBN2vDRT/GEPgGO4Ue1Qew/t6B80XyhG420rFfy32ZzdFHpUIx4LxTK+3EIiz
        EbQ7u71ZFG4RwPucLNqjCsArweQ2CT1YiOfCyKtJr1uKV0B9dhXi+82GG5Z6iuf9oflcv1dP
        TfHH7p33hgJuEUNBwzcBb1gHFb0nKR4HwKCjanrwUGg9nS/kMQdvanto3mxAYL3WOG1YCQ8d
        7bTnNBReAJW2KJ6OhVFTLcVfzA9ejPjzM/iBsfrsNC2F3BwZD+VgO+fHGwGybnRNZyvgU/VP
        b7YMq6C5SVmM5pj+28v0316mfxNcQlQFCmJ1nCaB5aKT2fRITq3hdMkJkftSNFY09b9afzrc
        NWiiI86OMIPkM6X6mBGVjFancRkaOwKGkgdKy04NqmTSeHXGIVabskerS2I5OwphhPIg6ZIr
        AyoZTlAfZA+wbCqr/VMVML7BBqQ84V+YGal5e7zp6+21L22ynVtU5stHIjY1apThFtdTUXXc
        +fuha2LzR+Zfab5qOPz9rM+KlN0q/UR6uMJnlzDs9YLSUOM8XBZSdOZIqq5ucxQbXWTXbxij
        K28NlePrDyY6+hXDDVlblcvvJbiWNa3PfdS3rWG0cFUrDlm/vfhX5ke5kNuvjl5IaTn1bzLn
        xVxbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rf1N7FGqx5bGJxf14ro8XGGetZ
        La5/ec5qMen+BBaLBZ9msFr0P37NbHH+/AZ2i7NNb9gtVtz9yGqx6fE1VovLu+awWXzuPcJo
        MeP8PiaLtUfuslvcblzBZjFj8ks2BwGPTas62Tw2L6n32PhuB5NH35ZVjB6fN8kFsEbp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdz6KFvwirvi
        2oa/jA2Mnzi7GDk5JARMJF4cOM7axcjFISSwlFFi+pIXzBAJCYmP62+wQtjCEn+udbFBFH1i
        lGictBWsiE3AUWLS1AfsIAkRgU5GifXLpjOBOMwCN5gkmra8YwGpEhawlpj1aRaYzSKgKvH2
        9nc2EJtXwFLiQOsWRogV8hKrNxxghogLSpyc+QSongNokLrE+nlCIGFmoJLmrbOZJzDyz0JS
        NQuhahaSqgWMzKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY23bsZ9bdjB2vQs+xCjAwajE
        w6tg9TZWiDWxrLgy9xCjBAezkgjvkomvYoV4UxIrq1KL8uOLSnNSiw8xmgK9MJFZSjQ5H5gG
        8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MGoufVIe1Mc44+/s
        xwq6U2P5efQ/r/r9Pur8kTJdHqmOjJJ9cRaP1n39xfzS4UXEczcXvt0394syLO5K76o9x7n/
        zHlnXdnPicb+fYn32yQs1HN4Tz0zUng/U0RKdrqA1/eEryuq6vM2+u9I0RNPYDv/Y0p18nXF
        rTMWGutF67CW/3soGhhvrMRSnJFoqMVcVJwIAFyRxV7LAgAA
X-CMS-MailID: 20191209105030eucas1p11e28297118da5a1d9f3a8c955584a4bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105030eucas1p11e28297118da5a1d9f3a8c955584a4bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105030eucas1p11e28297118da5a1d9f3a8c955584a4bf
References: <CGME20191209105030eucas1p11e28297118da5a1d9f3a8c955584a4bf@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following patchset incorporates the first four patches from a bigger
RFC[1]. The purpose of these patches is to improve readability of the code,
with the main focus on the exynos_bus_probe() function.

The original exynos_bus_probe() function has 13 local variables, over 140
lines of code, and multiple goto statements. Patches 01 and 02 from this
series extract two mutually exclusive code paths into separate functions,
exynos_bus_profile_init[_passive](). Furthermore, patch 03 reduces the
number of goto statements by introducing an if-else construct.

The last patch adds other minor improvements, including cleaning up header
includes, variables, and return paths. This also applies to functions
introduced by patches 01 & 02 -- to avoid moving and changing code in the
same patch.

---
Changes since RFCv2[1] (patches 01..04):
* Rebase on next-20191209.
* Drop some unnecessary changes, cf. [2].

---
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

---
References:
[1] https://patchwork.kernel.org/cover/11152595/
[2] https://patchwork.kernel.org/patch/11152637/

Artur Świgoń (4):
  devfreq: exynos-bus: Extract exynos_bus_profile_init()
  devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
  devfreq: exynos-bus: Change goto-based logic to if-else logic
  devfreq: exynos-bus: Clean up code

 drivers/devfreq/exynos-bus.c | 156 +++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 72 deletions(-)

--
2.17.1

