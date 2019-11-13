Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB62FACA8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKMJNy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32936 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMJNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091351euoutp02999a529fd57ac3cec4a74bf6c20bffad~Wrf894n_22229622296euoutp02h
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191113091351euoutp02999a529fd57ac3cec4a74bf6c20bffad~Wrf894n_22229622296euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636431;
        bh=6kTIaVH2hMyJlHyAYmy99jGCeC1LIi6Ohv9O3YM4Dvc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rj95D70lxVbV4YVeTzttbxgdPWJruQPh9R/izAgq1ApkoPlQ9lZxtyODzLAk6oJHb
         POzk570MHcEwzFZFO9Cgyl+WkZMsNBDpMAXw4wVEppU3TAb9Azxm55f3pLGsC5SGdN
         zI2HRbxHCD/xjjP+pQr6zqVdW125SCx064ILDlCc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091351eucas1p1210e2308350b47d60d85c2acc80ac4a3~Wrf8sDk4O1871618716eucas1p1k;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 05.82.04469.F49CBCD5; Wed, 13
        Nov 2019 09:13:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091350eucas1p2545166dfa1dc3b85aee375e353d7a604~Wrf8YNfPx1330013300eucas1p2C;
        Wed, 13 Nov 2019 09:13:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113091350eusmtrp1d9c37e38c230652370bbc1e1c037574c~Wrf8XJE4a0965609656eusmtrp1h;
        Wed, 13 Nov 2019 09:13:50 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-a5-5dcbc94fa996
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.DA.04117.E49CBCD5; Wed, 13
        Nov 2019 09:13:50 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091350eusmtip1d741020f48953919fddc6530d8f7a470~Wrf7zwrm00369203692eusmtip1N;
        Wed, 13 Nov 2019 09:13:50 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 0/7] devfreq: improve devfreq statistics counting
Date:   Wed, 13 Nov 2019 10:13:29 +0100
Message-Id: <20191113091336.5218-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7r+J0/HGrx/w2uxccZ6VovrX56z
        WvTt+89oseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZsDr8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy9vb9YS3Y
        w12xcuc/lgbGKZxdjJwcEgImEjsnTGDuYuTiEBJYwSjR9Ww9lPOFUeJ132V2COczo8SV7j2M
        MC1zmy9BJZYzSqzado0JruVz7y8WkCo2AX2Jg2dPgtkiAtISnYsmghUxCzxnlrg8/z8zSEJY
        wFHi8vHDYEUsAqoSq9evB1vBK2At0d/WCmRzAK2Tl5jzVgMiLChxcuYTsHJmoHDz1tlgt0oI
        LGOX2HyuhwXiPBeJlfeeMUHYwhKvjm9hh7BlJE5Phqkpl3i6sI8dormFUeJB+0eohLXE4eMX
        WUEWMwtoSqzfpQ8RdpTob37JDHEPn8SNt4IQN/BJTNo2HSrMK9HRJgRRrSrx/FQP1AXSEl3/
        17FC2B4S+6/+AVskJBArsel5D9sERoVZSD6bheSzWQg3LGBkXsUonlpanJueWmyYl1quV5yY
        W1yal66XnJ+7iRGYpk7/O/5pB+PXS0mHGAU4GJV4eCUWnooVYk0sK67MPcQowcGsJMK7o+JE
        rBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQbGcoPWClEW
        KfZAs0pBHr71h+ccX2PXaKogtnNxma39BlPTGNWNMU6Xm/vDo55dfi/Qy/vQ9OGDJ+efnWz8
        xZ8iNTW0tDIwhF0+3XIG44me7OPrBWYJZrKxXeoIyvLx2/91r//dqe/DRTnesNrPtt6rmx1k
        9WB+/db2s06PJnw7K3rsb/DLimlKLMUZiYZazEXFiQC5eWZ0TwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7p+J0/HGnzeb2axccZ6VovrX56z
        WvTt+89oseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZsDr8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy9vb9YS3Yw12xcuc/lgbGKZxdjJwcEgIm
        EnObL7F3MXJxCAksZZSYt7aZESIhLdF4ejUThC0s8edaFxtE0SdGia89W5hBEmwC+hIHz55k
        AbFFgBo6F01kAiliFnjPLDFpzxZWkISwgKPE5eOHwYpYBFQlVq9fD7aBV8Baor+tFcjmANog
        LzHnrQZEWFDi5MwnYOXMQOHmrbOZJzDyzUKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZgfGw79nPLDsaud8GHGAU4GJV4eA/MOxUrxJpYVlyZe4hRgoNZSYR3R8WJWCHelMTK
        qtSi/Pii0pzU4kOMpkC3TmSWEk3OB8ZuXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs
        1NSC1CKYPiYOTqkGxi65yYfXSsmdNf7zfPc8p4VHynmWbWthl3G7uOn2lTSDK+8vsD+X0Kna
        0bX43BejdWUzLvD9nLVO95vNNJ+t/gmFK+2ndP5Lf116y8FpannsvOM5E7nWiJ1UbtW7dOpf
        3rnKs2zCB6eb2xW07fgk+Olk7cOMRYumcF6fY999ZtsH4fwHkgu9L69QYinOSDTUYi4qTgQA
        xVDFz6UCAAA=
X-CMS-MailID: 20191113091350eucas1p2545166dfa1dc3b85aee375e353d7a604
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091350eucas1p2545166dfa1dc3b85aee375e353d7a604
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091350eucas1p2545166dfa1dc3b85aee375e353d7a604
References: <CGME20191113091350eucas1p2545166dfa1dc3b85aee375e353d7a604@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this patch series improves devfreq statistics:

- do conversion to use 64-bit jiffies for storing elapsed time and prevent counters
  overflow,

- add ability to reset statistics using sysfs,

- move statistics data to separate structure for improved code
  readability and maintenance,

- make devfreq statistics code more similar to cpufreq statistics
  code for improved long-term maintainability

The first four patches fix time stats to use 64-bits, add spinlock for protecting data
access, add new function in sysfs for clearing statistics counters and change var name
used in time counters. Remaining patches make steps to moving stats into separate
structure devfreq_stats.

Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

Kamil Konieczny (7):
  devfreq: change time stats to 64-bit
  devfreq: protect devfreq stats data with spinlock
  devfreq: add clearing transitions stats in sysfs
  devfreq: change var name used in time statistics
  devfreq: move transition statistics to devfreq profile structure
  devfreq: move transition statistics allocations to set_freq_stats()
  devfreq: move statistics to separate struct

 drivers/devfreq/devfreq.c          | 199 ++++++++++++++++++-----------
 drivers/devfreq/exynos-bus.c       |   6 +-
 drivers/devfreq/governor_passive.c |  26 ++--
 include/linux/devfreq.h            |  41 +++---
 4 files changed, 167 insertions(+), 105 deletions(-)

-- 
2.24.0

