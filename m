Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0D116B72
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLIKur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46108 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfLIKug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209105034euoutp025c4a71aaa1758b14e30f33fdeaadaab0~erl0V0_q63098930989euoutp02X
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 10:50:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209105034euoutp025c4a71aaa1758b14e30f33fdeaadaab0~erl0V0_q63098930989euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575888634;
        bh=XF8b5+RnbnhvUODeVp5HfzGOMbNt2Uj0dVL4oFNxQD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWuHDXSkim8+164MbWhbz+opMZdTxOfFu62PmTn06xVW3RQ9Km//65hFf9Co1Navd
         dpvJWW2E0LfBD/pMTChFTmyTpzfm6OJBaYEoHpgRs/uuuWNp9I4tMbfHdNnXhSaBpg
         Usx5qE4Ic6fd3gOibvLho/KDC1WHv/SvI8PcSdTQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209105034eucas1p182d3b8056147576e49af062c3919dc42~erlz9utCS1563615636eucas1p1G;
        Mon,  9 Dec 2019 10:50:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 74.2E.60679.9F62EED5; Mon,  9
        Dec 2019 10:50:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209105033eucas1p21ee8064e1d6917b403c06ee59a97421d~erlzZV7pJ1406714067eucas1p2_;
        Mon,  9 Dec 2019 10:50:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209105033eusmtrp1b10bcfaaad3446502feccb2d4131fc53~erlzYiNOv2135321353eusmtrp1f;
        Mon,  9 Dec 2019 10:50:33 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-53-5dee26f9056f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.D6.08375.9F62EED5; Mon,  9
        Dec 2019 10:50:33 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105032eusmtip1b54a778cfa047ee0e5a7c514ea187ef6~erlyoGs7e3003930039eusmtip1i;
        Mon,  9 Dec 2019 10:50:32 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        k.konieczny@samsung.com, leonard.crestez@nxp.com
Subject: [PATCH v3 3/4] devfreq: exynos-bus: Change goto-based logic to
 if-else logic
Date:   Mon,  9 Dec 2019 11:49:01 +0100
Message-Id: <20191209104902.11904-4-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209104902.11904-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGO7u7291odp2Wr1pWCwXFND+om0kkFIwoqb8KwWrpTSWntutH
        VpAaikqZKaWuUqupQ8mPZX6SqalDxebMtLIxSSW/ZU2INCq3a+V/zznv8/zO+8AhMHEP7kRE
        xcTTihhZtIQn5Db0/Hi7d8VtMXRfSQBlLE5HVF1hDU6NLn/FqTxjLpcq/VaIU3cn5jBKp6vl
        UwNp83xKbTDhlGZiBKfetTziUeY7XYgq1LVxqOddBj41lqrmUYX5M7wjpFRTmcWTvlDdlNYt
        NnGkOfWVSGrWuJzCQ4SB4XR0VCKt8D58QRg5MHsjbkZwdXq1gZOCjPxsJCCA9AdDzSCWjYSE
        mFQjaMg1rx+WEbSXjeIWl5g0Ixgu8clGhDXR/TmW9VQgyJyv5/4LLGXMWbE8Mgjy7o/zLQN7
        Mh2BXvfRisXIPg5MZ6RZsXbkGSj7YuJZsFzSFZZWkOVaRB4ElekBh91vJ1TVtmMWLSADwFQ+
        wGc9ttBbNMm1aGzNc+vlQysfyBk+dCirERs+Cip9Ac5qO5jV1q+X3g79+be5rGZgqtmIs+EU
        BJryLowdHII3Wj1uWQ4j3aGmxZutHwStJndW2sCHBVt2BRvIayjA2GsRZGaIWSmBliIbFgeQ
        VjWyjpaC9tUkykW7lRu6KDd0Uf5/tRRhlciBTmDkETTjG0MneTEyOZMQE+EVFivXoLXf1f9L
        u9yEWn5e7EQkgSSbRbsCFkLFuCyRSZZ3IiAwib1IdW82VCwKlyVfoxWx5xUJ0TTTiZwJrsRB
        5Pd0JlRMRsji6cs0HUcr/k45hMApBQmj1cE5j+2Lf59z7H/dO6Y8bq9TrVZecTVuC9qqV2e4
        7ndxbvQ/eyLyUvhwUlvW0MCz4KW4vj3dvXKzs54WnIwoIn2QIKzvxNSQvqd78vv1uE0Hqp8Y
        Aj+lat+HtPb6jy6nmXSezX7ZVWZPF8eK4o7GgNO+41hqzTG/3C1uHoM7JFwmUubjgSkY2R/1
        FE8vWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7o/1d7FGiz9J25xf14ro8XGGetZ
        La5/ec5qMen+BBaLBZ9msFr0P37NbHH+/AZ2i7NNb9gtVtz9yGqx6fE1VovLu+awWXzuPcJo
        MeP8PiaLtUfuslvcblzBZjFj8ks2BwGPTas62Tw2L6n32PhuB5NH35ZVjB6fN8kFsEbp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZx9VVPwkrPi
        xe9tTA2M99m7GDk4JARMJI7eye9i5OIQEljKKPFv5SPmLkZOoLiExMf1N1ghbGGJP9e62CCK
        PjFKTJryCqyITcBRYtLUB+wgCRGBTkaJ9cumM4E4zAI3mCSatrxjAakSFgiV6GleyQayjkVA
        VeL9L0aQMK+ApcSSj9OYIDbIS6zecABsKKeAlcTHZWfZQWwhoJq5C1ezQNQLSpyc+YQFZAyz
        gLrE+nlCIGFmoNbmrbOZJzAKzkJSNQuhahaSqgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
        NzEC43LbsZ+bdzBe2hh8iFGAg1GJh7fC5m2sEGtiWXFl7iFGCQ5mJRHeJRNfxQrxpiRWVqUW
        5ccXleakFh9iNAX6bCKzlGhyPjBl5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYBQ+XHVDQtbJ1/GQRlGntNbH7/X7pH/Uh2qun3XtonACm0v9kZRZhU4Hp5ZU
        cTmKqVVnfzA7wfylwJddsGja26fl1Qm7N0pdub3NajNbNFPBLUH5I/oFk+WWy+od8NjHLzJf
        ZaLS7H2l+strVNdzBC5W/ZE15WS3zjqdfYfDVKqiDtqcvdaoosRSnJFoqMVcVJwIAExjXRTh
        AgAA
X-CMS-MailID: 20191209105033eucas1p21ee8064e1d6917b403c06ee59a97421d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105033eucas1p21ee8064e1d6917b403c06ee59a97421d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105033eucas1p21ee8064e1d6917b403c06ee59a97421d
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105033eucas1p21ee8064e1d6917b403c06ee59a97421d@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch improves code readability by changing the following construct:

>    if (cond)
>        goto passive;
>    foo();
>    goto out;
> passive:
>    bar();
> out:

into this:

>    if (cond)
>        bar();
>    else
>        foo();

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 19d9f9f8ced2..0b557df63666 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -427,19 +427,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err_reg;
 
 	if (passive)
-		goto passive;
+		ret = exynos_bus_profile_init_passive(bus, profile);
+	else
+		ret = exynos_bus_profile_init(bus, profile);
 
-	ret = exynos_bus_profile_init(bus, profile);
 	if (ret < 0)
 		goto err;
 
-	goto out;
-passive:
-	ret = exynos_bus_profile_init_passive(bus, profile);
-	if (ret < 0)
-		goto err;
-
-out:
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

