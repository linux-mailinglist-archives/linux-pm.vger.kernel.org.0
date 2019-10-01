Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704A0C34A8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfJAMqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 08:46:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56157 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfJAMqs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 08:46:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191001124646euoutp01426e9018e6ff1c8ae446d312cb2c7686~JhqlMIfl51795617956euoutp01q
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 12:46:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191001124646euoutp01426e9018e6ff1c8ae446d312cb2c7686~JhqlMIfl51795617956euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569934006;
        bh=g4kxurFt+usEuNVWHXBojGkOdXeORyctrr+zEEwPBu8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=P8/SIVsNjNe/JZMbyaBNZJ8Oqa7+xidf8ZmHQB13IOrdFZiR9eZfSiadHYRPlCc4F
         KLvOFYVZrf1KhuyOL2m2yz90ds1ccfINns/EXfDPgBv433C5SswU2SEZGe/aLdjUUd
         HKEOCGLZm9tEHStL7zdP8NQ6pcTRY3dDZ25TiG+I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191001124646eucas1p17f969e2e45fd7cf51001bfa59319fa21~Jhqk9tmbk1929719297eucas1p1H;
        Tue,  1 Oct 2019 12:46:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.B5.04469.6BA439D5; Tue,  1
        Oct 2019 13:46:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781~JhqkniZMT1512015120eucas1p2f;
        Tue,  1 Oct 2019 12:46:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001124646eusmtrp1aab8f1b17880523fae614ca86bb66c11~Jhqkm5lRA0994609946eusmtrp1V;
        Tue,  1 Oct 2019 12:46:46 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-9c-5d934ab63bdb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.2C.04166.6BA439D5; Tue,  1
        Oct 2019 13:46:46 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001124645eusmtip1af28125b5d52687f5dcd1fab59205eb7~JhqkIJMge2139721397eusmtip1B;
        Tue,  1 Oct 2019 12:46:45 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PM / devfreq: exynos-ppmu: remove useless assignment
Date:   Tue,  1 Oct 2019 14:46:41 +0200
Message-Id: <20191001124641.22896-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7rbvCbHGvz/IWOxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZ225+Yys4wlbx/f9+9gbG3axdjJwcEgImEhumTGYBsYUEVjBKrO3w7GLk
        ArK/MEo8ujKNBcL5zCjxc+sduI412y5DJZYzSjy+f54druXm6o3MIFVsAoYSXW+72LoYOThE
        BOIl1n+1AgkzCzxklOibYAJiCwu4Skz61g+2mkVAVeLeirtgrbwCthKnpt5mh1gmL7F6wwFm
        CPsMm8T9RlkI20Xi3JkzUDXCEq+Ob4GyZSROT+4BO05CoJlR4uG5tewQTg+jxOWmGYwQVdYS
        h49fZAU5jllAU2L9Ln2IsKPEsabZYGEJAT6JG28FIW7mk5i0bTozRJhXoqNNCKJaTWLW8XVw
        aw9euAR1pofEhM6PYFOEBGIlLjfmTGCUm4WwagEj4ypG8dTS4tz01GLDvNRyveLE3OLSvHS9
        5PzcTYzA6D/97/inHYxfLyUdYhTgYFTi4bV4PjFWiDWxrLgy9xCjBAezkgivzZ9JsUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYBZfxSx89dFXqvaSr
        wewbXNzHL5Rqq0xKM9+yufhmz+mbO3qezGB4dPvB5ec/7pp/CMm6WfJjwjuZGvl+M6k3c5g+
        7CmRL5Rd3sgT2dZzhkNmxoo7889LfJTV8D3eX7ZJ6sCmPRtfL9W185q9/vSm+h6RCimJ5RtX
        BXF9mHuxRlzO6cdkr73GuUosxRmJhlrMRcWJACcpSnn6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xu7rbvCbHGuzfwmGxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ225+Yys4
        wlbx/f9+9gbG3axdjJwcEgImEmu2XWbpYuTiEBJYyiix9+4lZoiEjMTJaQ1QRcISf651sUEU
        fWKUaG3sZANJsAkYSnS97QKzRQQSJR70PGcHKWIWeMwo0XjuOztIQljAVWLSt34WEJtFQFXi
        3oq7YBt4BWwlTk29zQ6xQV5i9YYDzBMYeRYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQI
        DL5tx35u3sF4aWPwIUYBDkYlHt4JLyfGCrEmlhVX5h5ilOBgVhLhtfkzKVaINyWxsiq1KD++
        qDQntfgQoynQ8onMUqLJ+cDIyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE
        08fEwSnVwKjFHeiudoBNag5TkVQNy/oNVtO4qvb7OtdbrFj94vUnRp9t85iE+RJ/ZfLdnur4
        KKjif/BCBoMre/m+5Z8MYbdPbf0uWLCE+c+7KKV/j+423X7Vpn5euVy9wbJlYeadG78Y1Pme
        CxmIOF371N94aPf+ClNBW7XEDyr8nELeR3uLfb14J5adU2Ipzkg01GIuKk4EAEmDSFRUAgAA
X-CMS-MailID: 20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781
References: <CGME20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The error code is propagated to the caller, so there is no need to keep
it additionally in the unused variable.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 87b42055e6bc..85c7a77bf3f0 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -673,7 +673,6 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 	for (i = 0; i < info->num_events; i++) {
 		edev[i] = devm_devfreq_event_add_edev(&pdev->dev, &desc[i]);
 		if (IS_ERR(edev[i])) {
-			ret = PTR_ERR(edev[i]);
 			dev_err(&pdev->dev,
 				"failed to add devfreq-event device\n");
 			return PTR_ERR(edev[i]);
-- 
2.17.1

