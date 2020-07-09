Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD632219801
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 07:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGIFds (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 01:33:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29010 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIFdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 01:33:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200709053343epoutp0362f34f15f1038e77b5de86bc6d8142ab~f-q_NrqCk3246432464epoutp03y
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 05:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200709053343epoutp0362f34f15f1038e77b5de86bc6d8142ab~f-q_NrqCk3246432464epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594272823;
        bh=svvG9bfEaBwsMMJ2sZbl29gt4nnz77D4sLbE0v99Y1Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nPoR3y+1lSiYFdAti3w12gk47ipF6lFFK9RYCb/APzbEtFIeTL361srugikKmB45p
         bPD5y/WRSdYNAxuQ3/YrHn126ZGOaZigoSit1MBJ8l3eLFyp2PpP+2gQUhBKKVWYME
         /DLvpendlkbKjtbVFlN7rtFbewa3FOLaa+7nXe9U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200709053342epcas1p4e82981b7d32a17c37afd53c18107f3de~f-q9x9KWZ1953219532epcas1p4e;
        Thu,  9 Jul 2020 05:33:42 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B2Pwh31YqzMqYm9; Thu,  9 Jul
        2020 05:33:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.89.28578.43CA60F5; Thu,  9 Jul 2020 14:33:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200709053339epcas1p23fb1c080b21c758940514c4672949cfa~f-q7NtslJ1480714807epcas1p2B;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200709053339epsmtrp2a3a11e617c782e343e3515a7b9d5d062~f-q7MyvIT0317203172epsmtrp2k;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-be-5f06ac34671c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.F6.08303.33CA60F5; Thu,  9 Jul 2020 14:33:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200709053339epsmtip1f3f7f400e515b20002a5a4ef51f31e4d~f-q65kJYo0804408044epsmtip19;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] PM / devfreq: Add delayed timer for polling
Date:   Thu,  9 Jul 2020 14:45:02 +0900
Message-Id: <20200709054504.656-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmrq7JGrZ4g8czxCw2zljPajHxxhUW
        i+tfnrNaLPg0g9Wi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewW
        txtXsFkcftPOavHtxCNGB36PNfPWMHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6ALSrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsakae+Y
        CuZzVJw7/4WlgXELWxcjB4eEgInE4s1FXYxcHEICOxgluo+vZIZwPjFKfNz2A8r5zCjR0bKb
        tYuRE6xj7r3nTBCJXYwSd1e/YYVwvjBKvPk2HayKTUBLYv+LG2wgtohAqMTse1PBRjEL7GKS
        +DJtJjNIQljAWeLv1RnsIIewCKhKnD7rBhLmFbCQeLajmR1im7zE6g0HwHolBD6ySyx5cQcq
        4SIx6/wqFghbWOLV8S1QcSmJz+/2skHY1RIrTx5hg2juYJTYsv8C1A/GEvuXTmYCWcwsoCmx
        fpc+RFhRYufvuYwgNrMAn8S7rz2skEDilehoE4IoUZa4/OAuE4QtKbG4vRNqlYfEjfNrwc4R
        EoiVOP7pB/MERtlZCAsWMDKuYhRLLSjOTU8tNiwwRY6lTYzgZKhluYNx+tsPeocYmTgYDzFK
        cDArifAaKLLGC/GmJFZWpRblxxeV5qQWH2I0BYbXRGYp0eR8YDrOK4k3NDUyNja2MDE0MzU0
        VBLn/bSALV5IID2xJDU7NbUgtQimj4mDU6qBqehZSEru6y9/zryflyryMJDL6VzynO99s79a
        thTNu3aArdFJ5rz8+0fv9jBFFFe/nv7VzmbzP0WHzrtPxI9Umkze8ZlTf2f5FCcXZa/t1q5f
        /80/XejPkeIkVvh6rZRnwZLdqaFmjkL2Xtq7jBmj7KwTjBUOv6+ft0731pN3d4Ti3I8vlP3S
        kShpfDUzzG3F3YKY5csrmo5uqOvZdPrwrS0vWZ90ik26F/ebccOzGDnnrxaCjxRVVvZ+2D39
        9g+TRrWzng4v+Q/v+9J3ZP7nDfO4HI/JVJ4N5/zvIag2VeDnp42zBZcYT03ZICAc2PIq8tC7
        XfKNT1audfswVdhaMNlfrUSfIYdbQMava0/uPCWW4oxEQy3mouJEAK/vhN4PBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnK7xGrZ4g8472hYbZ6xntZh44wqL
        xfUvz1ktFnyawWrR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaL
        240r2CwOv2lntfh24hGjA7/HmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfAFsVlk5Ka
        k1mWWqRvl8CVMWnaO6aC+RwV585/YWlg3MLWxcjJISFgIjH33nOmLkYuDiGBHYwSUw43s0Mk
        JCWmXTzK3MXIAWQLSxw+XAxR84lRYnXHYSaQGjYBLYn9L26ADRIRiJQ433CUDaSIWeAYk8Ty
        t+0sIAlhAWeJv1dnsIMMYhFQlTh91g0kzCtgIfFsB8wueYnVGw4wT2DkWcDIsIpRMrWgODc9
        t9iwwCgvtVyvODG3uDQvXS85P3cTIzg4tbR2MO5Z9UHvECMTB+MhRgkOZiURXgNF1ngh3pTE
        yqrUovz4otKc1OJDjNIcLErivF9nLYwTEkhPLEnNTk0tSC2CyTJxcEo1MAX+kf+w1UoyZh2b
        uKEDl5X/kZnnW4Oql/E/WniF9axhxzshvZVTH84Sko5cI+cVfq540+TlJ8w41m+b7bVsJ986
        /rTdbvXLPPYv3agxl9N+MU/Q3xXfNv7hSG79ePPOvJ4/7XufJbEv/Sp1pt7mh8z6vr75i5ht
        0t478S/6uy7B1cZOPmjFihO83ztdgn4xBE8vmGU250Rvyoyfv3jm+wQ7JVQUiwZ941iUZfd0
        k5DIbCON+MQ3EZZebDJHo2dUu/TxK7ZWtnbnqKstSP595M5M9xWHrk5cbvCqWGta4YSAfzcW
        GFvVnUq8ZOO9dQFD3eNQHwOP7enWrJtWSi75XP+pZHWln5urqYZzqUd0mRJLcUaioRZzUXEi
        AEos+we9AgAA
X-CMS-MailID: 20200709053339epcas1p23fb1c080b21c758940514c4672949cfa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709053339epcas1p23fb1c080b21c758940514c4672949cfa
References: <CGME20200709053339epcas1p23fb1c080b21c758940514c4672949cfa@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the delayed timer to devfreq framework in order to support
the periodical polling mode without stop caused by CPU idle state.
Some Non-CPU device must need to monitor the device status like
utilization regardless of CPU state.

- patch1 explains the detailed reason why the delayed timer is required.
- patch2 initializes that exynos5422-dmc device use delayed timer as default
instead of deferrable timer.

Changes from v2:
- Add reviewed-by tag
- Fix typo on patch description
- Remove 'RFC' work from patch title
- Check whether 'df->governor' is NULL or not on timer_store()

Chanwoo Choi (2):
  PM / devfreq: Add support delayed timer for polling mode
  memory: samsung: exynos5422-dmc: Use delayed timer as default

 Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
 drivers/devfreq/devfreq.c                     | 86 ++++++++++++++++++-
 drivers/memory/samsung/exynos5422-dmc.c       |  1 +
 include/linux/devfreq.h                       |  9 ++
 4 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.17.1

