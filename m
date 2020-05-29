Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C501E7D97
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgE2Mtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 08:49:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54567 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgE2Mtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 08:49:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529124949euoutp02808e59ea2562ef20869eca665de2208a~TgLCnLrqg0831508315euoutp02i
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 12:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529124949euoutp02808e59ea2562ef20869eca665de2208a~TgLCnLrqg0831508315euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590756589;
        bh=aN1siSuQ/DP89e17gPstpLyzXOPICD7+xxdW1lji8ko=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aAUlBLHnL89XEB9CBivH9EBGAbefO0xQpUFQYHE4wf2B4IENjAyTOK4Fo8rQH3dvQ
         pb4Oxx7qWf/O+1TdAV/D4UDcC50ZerGyd9Zrl/aM0YjCN5v8I42e8X0/WE0Oql4+aZ
         gKtmru/Q3oxBDNxy3NlL+Xb8rH2ayokPmCujJcMc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529124948eucas1p110a658290579b7b93d501369234fbe5b~TgLCCgaCI2813228132eucas1p1s;
        Fri, 29 May 2020 12:49:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.74.60698.CE401DE5; Fri, 29
        May 2020 13:49:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632~TgLBsJgNe2814928149eucas1p1r;
        Fri, 29 May 2020 12:49:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529124948eusmtrp1d71829d89a644f99baf443bcd184fac2~TgLBrZw_q1703417034eusmtrp18;
        Fri, 29 May 2020 12:49:48 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-eb-5ed104ec38bf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 49.CA.07950.CE401DE5; Fri, 29
        May 2020 13:49:48 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529124947eusmtip137f13c0207064f2862fb3e582c786bce~TgLAwmtSB1272112721eusmtip1t;
        Fri, 29 May 2020 12:49:47 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] Fix regulators coupling for Exynos5800
Date:   Fri, 29 May 2020 14:49:38 +0200
Message-Id: <20200529124940.10675-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURjn3Ht3dxWn12l4srIaFBTkAwUPWmJlcSFJo78MNFfe1NJpu2oZ
        JL7IOUxNyUw0LURtTufMV+YrkSSWzlc+8EFqYYpCtWkPp9R2s/77vb7z+/g4FC6uFzhT0bIE
        Vi6TxkhIa6LlzU/9sVViOMxd3eyNtMUaAXo4/5FEE8YlAar9ugiQXt8gRB/KpjC0MabA0Gh7
        KYkM9/sAKtZ3Yaiub1aIVn8MYGj6ySiB3ulGBGh7XEsgRd8GjrTrjL8987JkVsg0qrJJZma8
        g2TyttyZpvdZBJPbpAJM/2QrxhgaXYKpS9bHI9iY6CRW7uYXbh21MJqBxQ+Jb88XTYJUUGSn
        BFYUpL3gUlcaoQTWlJiuATDXmCbkiRHAzyYdxhMDgOqZOWJn5HvrW8Ab1QCWlZoshmXkwYqN
        GZO0B1SuKUlzyJFOA7C5YggzGzi9icPO4YNKQFEOtC9s0RwwywR9CK41f7JERPQJmJdaSPJl
        +2FtQw9ufgfS7UKYU1iA8UYA1IxvCXnsAFf6m/7ivVBXmEPwAxkAzg/WCXmSA+BoejHgU75w
        ZvAXad4Cp49ATbsbL5+EPUa1RYa0LZxcs+d3toUFLY9wXhZBxT0xnz4MS/rr/9W+HhrBeczA
        scUewN8kFLa0d5P5wKXkf1cFACrgxCZysZEs5yljb7ly0lguURbpejUuthH8+UW67f71NtBl
        utILaApIbEQNj/VhYoE0iUuO7QWQwiWOolMDujCxKEKafIeVx12WJ8awXC/YQxESJ5Hns+VQ
        MR0pTWBvsGw8K99xMcrKORUQ1yqb/ZD2RVuW7d2n5YOSzfymKu9X+0JYf6rjecF1yc1xUWaA
        33zj+QllkKoqpdpVgXtFOJ8JqfTy+XZhzuRrUH1Zbu2QaU0p0we7O4nOi+pzeh/X+KndDYZy
        cfjpswlunB2VmikNrjEZbQIDAoPSsWSfsYHs5dUNKxC6a0FCcFFSj6O4nJP+Bg5NcatBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Xd03LBfjDGY8kLPYOGM9q8XUh0/Y
        LK5/ec5qsfrjY0aL8+c3sFs8mHuTyeLblQ4mi8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ
        4va8yywWZ05fYrX4d20ji0XHkW/MFhu/ejgIeuycdZfdY9OqTjaPO9f2sHn0/zXw2HK1ncWj
        b8sqRo/jN7YzeXzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CX8ehyM1PBBaGKh9NuMDYwTuPvYuTkkBAwkfi+/SRjFyMXh5DAUkaJOTv/
        MEMkZCROTmtghbCFJf5c62IDsYUEPjFKdH+OALHZBAwlut6CxLk4RARaGSXOv17FBOIwC7Sy
        SCy4swpoEgeHsIC1xLb1CiANLAKqEm+3PmUCsXkFbCX6GyazQSyQl1i94QDzBEaeBYwMqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQJjYNuxn1t2MHa9Cz7EKMDBqMTDu2Hm+Tgh1sSy4src
        Q4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BVo+kVlKNDkfGJ95JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYGypuJMaozW1eveZsiKHzgRzLyd3rn/+R
        eMCn3VIrEi8kslq78KPAO2O+TUqRfDWrfeb1cXRJrugSqIle7rG8/HD0kcf9x0yK2h7+tbnX
        k7158TOdkujQPXlrYyXX58Qcj76w8o9rx8kGi6KZWazPNy632DLlzIb/obeOcJWIP5eXOPrc
        19lRiaU4I9FQi7moOBEAJ+qStZcCAAA=
X-CMS-MailID: 20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632
References: <CGME20200529124948eucas1p175379ead8afd1932f7b7ae61e35cf632@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

This patchset is another attempt to fix the regulator coupling on
Exynos5800/5422 SoCs. Here are links to the previous attempts:

https://lore.kernel.org/linux-samsung-soc/20191008101709.qVNy8eijBi0LynOteWFMnTg4GUwKG599n6OyYoX1Abs@z/
https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
https://lore.kernel.org/linux-pm/cover.1589528491.git.viresh.kumar@linaro.org/
https://lore.kernel.org/linux-pm/20200528131130.17984-1-m.szyprowski@samsung.com/

The problem is with "vdd_int" regulator coupled with "vdd_arm" on Odroid
XU3/XU4 boards family. "vdd_arm" is handled by CPUfreq. "vdd_int" is
handled by devfreq. CPUfreq initialized quite early during boot and it
starts changing OPPs and "vdd_arm" value. Sometimes CPU activity during
boot goes down and some low-frequency OPPs are selected, what in turn
causes lowering "vdd_arm". This happens before devfreq applies its
requirements on "vdd_int". Regulator balancing code reduces "vdd_arm"
voltage value, what in turn causes lowering "vdd_int" value to the lowest
possible value. This is much below the operation point of the wcore bus,
which still runs at the highest frequency.

The issue was hard to notice because in the most cases the board managed
to boot properly, even when the regulator was set to lowest value allowed
by the regulator constraints. However, it caused some random issues,
which can be observed as "Unhandled prefetch abort" or low USB stability.

Adding more and more special cases to the generic code has been rejected,
so the only way to ensure the desired behavior on Exynos5800-based SoCs 
is to make a custom regulator coupler driver.

Best regards,
Marek Szyprowski


Patch summary:

Marek Szyprowski (2):
  regulator: extract voltage balancing code to separate function
  soc: samsung: Add simple voltage coupler for Exynos5800

 arch/arm/mach-exynos/Kconfig                  |  1 +
 drivers/regulator/core.c                      | 49 ++++++++-------
 drivers/soc/samsung/Kconfig                   |  3 +
 drivers/soc/samsung/Makefile                  |  1 +
 .../soc/samsung/exynos-regulator-coupler.c    | 59 +++++++++++++++++++
 include/linux/regulator/coupler.h             |  8 +++
 6 files changed, 101 insertions(+), 20 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c

-- 
2.17.1

