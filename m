Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE413DDB1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPOmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 09:42:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34823 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAPOmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 09:42:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116144241euoutp01e873f240cec1a92e81a692a2886be9f6~qZRVjIByl0098100981euoutp01c
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116144241euoutp01e873f240cec1a92e81a692a2886be9f6~qZRVjIByl0098100981euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579185761;
        bh=8Ahf2/0EsEBYG+/Mv5cyXwGGbXnNjNkyPPuFLBhAkYQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qGFNauyArbJxWpVSh/xTaYHLyTlldsLv0uAEsQAHlPwZmyDS9MsmfVunPRStnc61P
         TjBiTeG8jFl7zCOC8iWFJDb/iINEV8+jRDf4RyT32AQv17S2XGvdl5lk05vPsD/o0o
         +I5dZL0WMgb+mOrQiVOdrWj+AOsdmmqn0f1lKPhg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200116144241eucas1p21fbfa0f4e0e68dedad3a4bc6dcafeb64~qZRVRthGZ2314923149eucas1p2C;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.D2.60698.166702E5; Thu, 16
        Jan 2020 14:42:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff~qZRU3h-381442314423eucas1p2V;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116144241eusmtrp13ad69389c59a3c9b12dbcdca183a5a2a~qZRU20qKm0584505845eusmtrp1T;
        Thu, 16 Jan 2020 14:42:41 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e6-5e20766159d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.64.08375.166702E5; Thu, 16
        Jan 2020 14:42:41 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116144240eusmtip2b01528aecb320a8b1705f43c2d4928bd~qZRUV2MnO2614526145eusmtip2N;
        Thu, 16 Jan 2020 14:42:40 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        georgi.djakov@linaro.org, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, krzk@kernel.org
Subject: [PATCH v4 0/3] interconnect: Support Samsung Exynos use-case
Date:   Thu, 16 Jan 2020 15:41:59 +0100
Message-Id: <20200116144202.12116-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qJZQpxBg23ZCzuz2tltNg4Yz2r
        xfUvz1ktpu/dxGZx/vwGdovLu+awWXzuPcJoMeP8PiaLtUfusjtwemxa1cnmcefaHjaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgyvj68j57wQ/eihcn5jA2MG7m7mLk5JAQMJHomdfPDmIL
        CaxglOj/FQ9hf2GUuHfcu4uRC8j+zCix6/kzJpiGxzvesEAULWeU2P8+DaIIqOH95UVsIAk2
        AUeJSVMfgE0VEYiX+LjtHwtIEbPATkaJI3//gE0SFnCV2NT4jRnEZhFQlfg6qQsszitgKXHo
        7wxGiG3yEqs3HGCGiAtKnJz5BGwzM1C8eetsZpChEgKT2SUatu2DOs9FYtmaecwQtrDEq+Nb
        2CFsGYnTk3tYIOxiiac777NCNDcwSmxadgSqwVrizrlfQC9wAG3QlFi/Sx/ElAD6Zvu6IAiT
        T+LGW0GIE/gkJm2bzgwR5pXoaBOCMJUkds3kgxgnIdG0+hrUaA+JPTcWQ4MtVqLjSD/LBEaF
        WUj+moXkr1kIFyxgZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmG5O/zv+dQfjvj9J
        hxgFOBiVeHg/hCjECbEmlhVX5h5ilOBgVhLhPTlDNk6INyWxsiq1KD++qDQntfgQozQHi5I4
        r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRqGyQ3Y2P4pn1Lg0yKxjkSvd7bagsnCGq6NV1bVL
        f93Mw+adKuXPmT1z1u7U284T3s2av971voaD86+vJS+qPUWb0mMZrh22eGC1csksdtW9ba8N
        W32eLJ47aXnlV6f4ZxlaCosLJ3++YhCRvGt6sQz/qb3Hpj89o5V192uWmMf+iRqplxMuPlFi
        Kc5INNRiLipOBACAgVbSMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xe7qJZQpxBvs+sljcn9fKaLFxxnpW
        i+tfnrNaTN+7ic3i/PkN7BaXd81hs/jce4TRYsb5fUwWa4/cZXfg9Ni0qpPN4861PWwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl/H15X32gh+8FS9OzGFsYNzM3cXIySEhYCLxeMcbli5GLg4hgaWMEj1757NDJCQkPq6/
        wQphC0v8udbFBlH0iVFi+dSHbCAJNgFHiUlTH4A1iAgkStx69JgZpIhZYD+jxMs7bWBFwgKu
        EpsavzGD2CwCqhJfJ3Uxgdi8ApYSh/7OYITYIC+xesMBZoi4oMTJmU+ATuIAGqQusX6eEEiY
        Gaikeets5gmM/LOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwOjYduzn
        5h2MlzYGH2IU4GBU4uGdEaQQJ8SaWFZcmXuIUYKDWUmE9+QM2Tgh3pTEyqrUovz4otKc1OJD
        jKZAL0xklhJNzgdGbl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
        BkYPuZPXN+z/env+vG3yN9TFdmq/Vr345sxDVsNCn1f7rp1b8/yzd+jbTZwVq66KvPpQdch+
        rwSXfx3vrwaT1isP1wq7s5VwPl40p3l7SdG3PPcfD3/ViC1XtFH+zuL3ujtIMdT5zIcSzyJW
        RtUb98463LJPVn/jKH5SzuzIXKctsx68W72Eg91IiaU4I9FQi7moOBEA6vO3GKQCAAA=
X-CMS-MailID: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
References: <CGME20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously posted as a part of a larger RFC: [1].

The Exynos SoC family relies on the devfreq driver for frequency
scaling. However, a way to programmatically enforce QoS contraints
(i.e., minimum frequency) is desired. A solution which uses the
interconnect framework to ensure QoS is currently being developed[1].

The exynos-bus hierarchy is composed of multiple buses which are probed
separately. Sometimes the DMC is even handled by a different driver.
Since the exynos-bus driver is generic and supports multiple differing
bus hierarchies, IDs for nodes (i.e. buses) are assigned dynamically. Due
to the unspecified relative probing order, every bus registers its own
interconnect provider.

Rationale for each patch in this series:
* Patch 01 (exporting of_icc_get_from_provider()) makes it easy to
  retrieve the parent node from the DT (cf. patch 05 in [1]).
* Patch 02 (allowing #interconnect-cells = <0>) allows to remove dummy
  node IDs from the DT.
* Patch 03 (allowing inter-provider node pairs) is necessary to make
  such multi-provider hierarchy work. A new approach implemented in v3
  ensures not to break any existing drivers.

---
Changes since v3 (to patches in this series):
* Improve commit messages.

---
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

---
References:
[1] https://patchwork.kernel.org/patch/11305287/

Artur Świgoń (3):
  interconnect: Export of_icc_get_from_provider()
  interconnect: Relax requirement in of_icc_get_from_provider()
  interconnect: Allow inter-provider pairs to be configured

 drivers/interconnect/core.c           | 16 ++++++++--------
 include/linux/interconnect-provider.h |  8 ++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.17.1

