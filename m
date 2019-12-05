Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1000114313
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEOzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:55:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47452 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLEOzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:55:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205145543euoutp02658f0198a15d897344c29d29c885f974~dgWuBg5kx0613706137euoutp02N
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205145543euoutp02658f0198a15d897344c29d29c885f974~dgWuBg5kx0613706137euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575557743;
        bh=dGqNJXVYXrQwmKJmbCA1sFU9NdFZmpFhildJ3M91MNU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=D6b7ECEArzKHMzqUl5DhWpVqYyCs9PgzCFoiF9C5x4p6K0PosGXtbhP2d6Jdi4d+o
         xS66snDd7ABy+V0ydP2JhWhmmJTgcy2HLTU2QDShYq+BFRK6OO2H5m7mogm2RmM8ts
         MKY9sqxyuqgESr7oRGfv069vDuJ9Ud3ZG0iNC7+Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205145543eucas1p1204779d0eee53f4f674e663068f2bf3e~dgWtyUaFF2197721977eucas1p1b;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.EB.60679.F6A19ED5; Thu,  5
        Dec 2019 14:55:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191205145542eucas1p2b39536c9c186d5656f39d214baa32670~dgWtfXxfF0125801258eucas1p2M;
        Thu,  5 Dec 2019 14:55:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205145542eusmtrp1b48b427395ad93003fe9ea752444e933~dgWtetGmi2543125431eusmtrp1h;
        Thu,  5 Dec 2019 14:55:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-05-5de91a6f6a3f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.01.07950.E6A19ED5; Thu,  5
        Dec 2019 14:55:42 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205145542eusmtip2ae010565245e7cb7602aaf217d3d039d~dgWtAoZ7J2087920879eusmtip2c;
        Thu,  5 Dec 2019 14:55:42 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 0/3] devfreq: improve devfreq statistics counting
Date:   Thu,  5 Dec 2019 15:55:24 +0100
Message-Id: <20191205145527.26117-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87r5Ui9jDZ4uZbPYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        ApijuGxSUnMyy1KL9O0SuDImzfjKWLCTv2LhZOcGxgU8XYycHBICJhIzNsxi62Lk4hASWMEo
        cevBXXYI5wujxOmNh1ggnM+MElNv/mKHaTl6uZsRIrGcUeLYyvkILSv//GUDqWIT0Jc4ePYk
        C4gtIiAt0bloIhNIEbPAMSaJXYf+soIkhAVcJNovfGUCsVkEVCV+XjjKCGLzCthIrNk8F2gq
        B9A6eYk5bzUgwoISJ2c+AZvJDBRu3jqbGWSmhMBnNolFrX1MEPUuEu+3pUJcKizx6vgWqKtl
        JE5P7mGBsMslni7sY4fobWGUeND+ESphLXH4+EVWkDnMApoS63fpQ4QdJZbtncMMMZ5P4sZb
        QYgT+CQmbZsOFeaV6GgTgqhWlXh+qocJwpaW6Pq/jhXC9pA42H4EbJGQQKzEiQ8HmCcwKsxC
        8tgsJI/NQrhhASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBEc/rf8S87GHf9STrE
        KMDBqMTDO+Pzi1gh1sSy4srcQ4wSHMxKIrzpfC9jhXhTEiurUovy44tKc1KLDzFKc7AoifNW
        MzyIFhJITyxJzU5NLUgtgskycXBKNTAaxeYXP88IVbdh3p3YOXP119qTcusZIm9mpM7/uez0
        VQWjg195hOwll7D8euLmPPN/za8pB8RPSTxckvJ51/Lpxyd/nvbIPfa2tvatXeK6PziuX/x9
        wMbM5m1EwMUkwXiuO4zpM8yTTBet+Xrs9h0d8+3Rj482iF/jXr+juzpz5+pD1+ylipuslViK
        MxINtZiLihMB64qx/zADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7p5Ui9jDc7O0rbYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIm
        zfjKWLCTv2LhZOcGxgU8XYycHBICJhJHL3czdjFycQgJLGWUmH9kBjNEQlqi8fRqJghbWOLP
        tS42iKJPjBLbdxwAK2IT0Jc4ePYkC4gtAtTQuWgiWAOzwBkmiV8tFSC2sICLRPuFr2BxFgFV
        iZ8XjjKC2LwCNhJrNs9l72LkAFogLzHnrQZEWFDi5MwnLBBj5CWat85mnsDINwtJahaS1AJG
        plWMIqmlxbnpucVGesWJucWleel6yfm5mxiBAb7t2M8tOxi73gUfYhTgYFTi4Z3x+UWsEGti
        WXFl7iFGCQ5mJRHedL6XsUK8KYmVValF+fFFpTmpxYcYTYFuncgsJZqcD4y+vJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjFuuP7WTdu57VjCrb2Fj57XTJcGr
        FzE73y7PdjUKzb13fWbtvJ/9aSfWrX0bxiD0rW7ZstaCqa/5N/Me65+Vt8r2ef2TcyGO+o0l
        1q6f7ZmZTq1do2uTZSlpfrz3d/S8T27az4O4DWfGJndLvpNcf/iZdtOFvZurtvR9S09Q2bVI
        guf/YWmdd0osxRmJhlrMRcWJAHUE4NSGAgAA
X-CMS-MailID: 20191205145542eucas1p2b39536c9c186d5656f39d214baa32670
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205145542eucas1p2b39536c9c186d5656f39d214baa32670
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205145542eucas1p2b39536c9c186d5656f39d214baa32670
References: <CGME20191205145542eucas1p2b39536c9c186d5656f39d214baa32670@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this patch series tries to improve devfreq statistics:

- do conversion to use 64-bit jiffies for storing elapsed time and prevent
  counters overflow,

- add ability to reset statistics using sysfs,

- move statistics data to separate structure for improved code
  readability and maintenance.

Changes in v3:
- changed types of cur_time and last_stats_updated to u64 as this is
  returned by get_jiffies_64() in 1/3
- add checks for zero in input and clear stats only when zero is written
  to trans_stats
- change documentation of trans_stat in sysfs
- removed freq_table and max_state from struct devfreq_stats as they are
  already present in struct devfreq_dev_profile
- renamed last_stat_updated to last_update, as 'stat' is already present
  in struct devfreq_stats
- define struct devfreq_stats stats; in devfreq as there is only one
  stats per devfreq
- improve descriptions of devfreq_stats and stats
- use profile instead of devfreq->profile in devfreq_add_device, as this
  var is already parameter
- added Reviewed-by: Matthias Kaehlcke <mka@chromium.org> to 3/3

Changes in v2:
- added Acked-by to first patch
- dropped spinlock patch, there is mutex used for protecting stats data
- rewrite clearing statistics, suggested by Chanwoo Choi: reuse
  trans_stats sysfs file, any write to it will clear devfreq stats
- dropped change var name last_stat_updated
- squashed three last patches into one, as it turned out that freq_table
  from devfreq_profile is used by other drivers
- rebased on linux-next

Kamil Konieczny (3):
  devfreq: change time stats to 64-bit
  devfreq: add clearing transitions stats
  devfreq: move statistics to separate struct

 Documentation/ABI/testing/sysfs-class-devfreq | 11 ++-
 drivers/devfreq/devfreq.c                     | 92 ++++++++++++-------
 include/linux/devfreq.h                       | 26 ++++--
 3 files changed, 83 insertions(+), 46 deletions(-)

-- 
2.24.0

