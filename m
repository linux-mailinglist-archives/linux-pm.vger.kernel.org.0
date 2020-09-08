Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22AC260F65
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgIHKNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:13:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10584 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgIHKMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:12:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200908101234epoutp042b75180f9e8c910b2c96f54615b3aa17~yx02utNqU2440024400epoutp04V
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 10:12:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200908101234epoutp042b75180f9e8c910b2c96f54615b3aa17~yx02utNqU2440024400epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599559954;
        bh=CmgUl2xaYyV+9cq6Fw4uq9IsbKjByyxJGsTM86w+7yo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fDiYV0ZAiHP93dt944xsJQDrpvUjbVvBhqSADdptNE1bHIu40izDyn9ImX85xc/5I
         neXOJWSw0qp28Dh4c7dtjoYLiWx1AujfGaRObxd0i0WOzIcK4dXb1iRjgajz9VNAO4
         Ovtutr6v07h6BY/1+cewRkTKSXQZ03KJHk9NCp2M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200908101233epcas1p48dbb6ac569c11a55c56e9659a58768ea~yx02J93En1796017960epcas1p4U;
        Tue,  8 Sep 2020 10:12:33 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bm1DH240xzMqYkg; Tue,  8 Sep
        2020 10:12:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.1F.19033.F09575F5; Tue,  8 Sep 2020 19:12:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epcas1p321249119f81d90755efdfafd95f9d180~yx0zoC3g83135431354epcas1p3f;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908101230epsmtrp2a3b11f448fe27ee9e54fd7fd2acc9d02~yx0znRG3w2650426504epsmtrp2C;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-6d-5f57590f3237
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.99.08382.E09575F5; Tue,  8 Sep 2020 19:12:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epsmtip21fe1d796ac6b486f74639bab3462d5d7~yx0zbt_dj1358513585epsmtip2p;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] PM / devfreq: Deprecate fixed property name by using
 phandle get
Date:   Tue,  8 Sep 2020 19:24:44 +0900
Message-Id: <20200908102447.15097-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmgS5/ZHi8waSpPBbXvzxntTh/fgO7
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWNjUwm5xu3EFmwOnx5p5axg9Nq3qZPPYvKTe
        o2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgO5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn
        51oZGhgYmQIVJmRndF+cxlSwiLdi2uXnbA2MF7i6GDk4JARMJLac4e9i5OIQEtjBKDFtfTsT
        hPOJUeLdlXY2COcbo8Ty1uWsXYycYB2ti55BVe1llLjVs4UdwvnCKDHj40JGkCo2AS2J/S9u
        sIHYIgJlEre/XGUGKWIWaGWUuPf8GhNIQlggSuL83L0sIDaLgKrE56sH2UFsXgEriauf/jBD
        rJOXWL3hAFizhMAhdonfjVug7nCRaG2ZA1UkLPHq+BZ2CFtK4vO7vWwQdrXEypNH2CCaOxgl
        tuy/ANVsLLF/6WQmUBAwC2hKrN+lDxFWlNj5ey7YB8wCfBLvvvawQkKJV6KjTQiiRFni8oO7
        TBC2pMTi9k6oVR4Svx4dBYsLCcRKXHr6j2UCo+wshAULGBlXMYqlFhTnpqcWGxYYIUfTJkZw
        ItMy28E46e0HvUOMTByMhxglOJiVRHi7DoXGC/GmJFZWpRblxxeV5qQWH2I0BQbYRGYp0eR8
        YCrNK4k3NDUyNja2MDE0MzU0VBLnfXhLIV5IID2xJDU7NbUgtQimj4mDU6qBqd1h8g3WQxEp
        DolL/i7427TgcfSPV78nCf/b8Sr6wZzSuenvnKOrdC5a2y0wnvHU1frOjF3N04X36YVJxLmc
        5645fup/09/6zff2n5/49EtP8uVvM6rK519unPrSxcgt9sVhH6beybOXLGqU+pldvPHAnKct
        zcx+U0LkTjl8V7Hr7spz9v4huZ2jO1GAd+f9713FnisnmPvp2um2nWw7ebXEhXGr7J5J0l7r
        45O8Km59jbdknbT0vPr8eWsW/3i+5N6Lz31zV1fyMAa8XHc9dL31BmHBCvWJs6xSXUy0pa1a
        Sps2zDhg0GQfGBQrnf3iQFPXsZRZ6jMyeVo/3O6Y135c8tYiP/akD9xuAabTc5RYijMSDbWY
        i4oTAXwxT5LtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJXpcvMjzeoO+7tsX1L89ZLc6f38Bu
        cbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsFja1sFvcblzB5sDpsWbeGkaPTas62Tw2L6n3
        6NuyitHj8ya5ANYoLpuU1JzMstQifbsErozui9OYChbxVky7/JytgfECVxcjJ4eEgIlE66Jn
        TF2MXBxCArsZJTasPsYEkZCUmHbxKHMXIweQLSxx+HAxRM0nRonmfasZQWrYBLQk9r+4wQZi
        iwjUSCybu4cNpIhZoJNR4uS0l2AJYYEIiZ1TW8BsFgFVic9XD7KD2LwCVhJXP/1hhlgmL7F6
        wwHmCYw8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAeWluYOxu2rPugdYmTi
        YDzEKMHBrCTC23UoNF6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUw
        WSYOTqkGprAo1fSl35JLsq+brRR68bVrypfeVcoRafulbBS3ponW5mbk3U53V3fc0vw3m2tZ
        1b5vehs67t005/geOXHZ11Mv5gTkLbkmeDTz9eGkhJe/fs8xe9fXF//pxzbV0JqzNvvC/XKe
        5DL6530qLw5d8exfe9blpcZmIoVzTh5/8zubefebZRLyEWyJFx8ZvvnEJWZ4rVJv75plfaxH
        LX+xq5vbv/BNip950mzeu8M7LQI7uw4c/uzuu39HbHHKS5flm668vqTpl3hWIzb0V1x60P1t
        trM1qyyWyx6N31957fT7KX/Xvn1gXrV7/XLeg70RizltkyvYFhRI/JzG+cZq7a/u49HeV/Yo
        l7FPef3iQ4cSS3FGoqEWc1FxIgD5DSMqmwIAAA==
X-CMS-MailID: 20200908101230epcas1p321249119f81d90755efdfafd95f9d180
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908101230epcas1p321249119f81d90755efdfafd95f9d180
References: <CGME20200908101230epcas1p321249119f81d90755efdfafd95f9d180@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pirot to that devfreq and devfreq-event framework defines the fixed 'devfreq'
and 'devfreq-event' property to get the devfreq/devfreq-event phandle. But,
these property name are not expressing the h/w. So, deprecate the fixed
property name of both 'devfreq' and 'devfreq-event'. But, in order to keep
the backward compatibility of devicetree, doesn't change the property name
on devfreq device drivers and devicetree.

This patchset picks only three patches from patchset[1].

[1] https://patchwork.kernel.org/cover/11304545/
- [v2,00/11] PM / devfreq: Remove deprecated 'devfreq' and 'devfreq-events' properties


Changes from v2:
- Send the patches related to both devfreq_get_devfreq_by_phandle
  and devfreq_event_get_edev_by_phandle function to change the function
  prototype.

Changes from v1:
- Edit function name by removing '_by_node' postfix.
- Split out dt-binding patch to make it the separte patch.
- Add Lukasz's tag for exynos5422-dmc

Chanwoo Choi (2):
  PM / devfreq: Change prototype of devfreq_get_devfreq_by_phandle function
  PM / devfreq: event: Change prototype of devfreq_event_get_edev_by_phandle function

Leonard Crestez (1):
  PM / devfreq: Add devfreq_get_devfreq_by_node function

 drivers/devfreq/devfreq-event.c         | 14 +++---
 drivers/devfreq/devfreq.c               | 57 ++++++++++++++++++-------
 drivers/devfreq/exynos-bus.c            |  7 +--
 drivers/devfreq/rk3399_dmc.c            |  2 +-
 drivers/memory/samsung/exynos5422-dmc.c |  6 ++-
 include/linux/devfreq-event.h           | 14 ++++--
 include/linux/devfreq.h                 | 11 ++++-
 7 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.17.1

