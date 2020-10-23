Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2F296C86
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461952AbgJWKMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:12:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51484 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461902AbgJWKMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:12:54 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201023101250epoutp019bd1f16e01c558c9ce95942e8a153099~Al28CF0-m3202432024epoutp01c
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 10:12:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201023101250epoutp019bd1f16e01c558c9ce95942e8a153099~Al28CF0-m3202432024epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603447970;
        bh=jX41VGP/VWJGCpMgSRB6Vy5h2OQbvXYT6fvLe8xXPrA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fTa/Lm4f+2mgzsziUTMd8Z1PwJDCixd88rshI8Q8o78rWPNTy14DtF6aojoPAj6GS
         WlU/bk8Tzf2EJRSINZIwN3ksM6T5N5JPN6sNbovbXVNBavk75ncfcw9JwK3/Jz8M5W
         dLwIVrRBrq5DfVH9TkhHHMZqfmdQVwktxkobbEcA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201023101249epcas1p4c63a3ba3415f6ed0c1b14492dcd77504~Al27Ukof02134021340epcas1p41;
        Fri, 23 Oct 2020 10:12:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CHg5q1fqWzMqYkZ; Fri, 23 Oct
        2020 10:12:47 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.B1.09577.F9CA29F5; Fri, 23 Oct 2020 19:12:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201023101246epcas1p126bb1157eb75f972786758ef1e2f6e0c~Al24llWmc2589625896epcas1p1M;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201023101246epsmtrp11886ab4476c2da84e9778c64179fda21~Al24knLu-0544405444epsmtrp1t;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-85-5f92ac9f7a66
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.E9.08745.E9CA29F5; Fri, 23 Oct 2020 19:12:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201023101246epsmtip2aefab9230fce6deb5e744410ba06159d~Al24VVNeu3177131771epsmtip2l;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 0/2] PM / devfreq: Add governor feature and attribute
 flag
Date:   Fri, 23 Oct 2020 19:26:30 +0900
Message-Id: <20201023102632.740-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTT3f+mknxBle7OS2WXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QH8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OL
        S/PS9ZLzc60MDQyMTIEKE7IzOtYJFOyXqzj54hJLA+N20S5GTg4JAROJP0uXMHYxcnEICexg
        lDj5bisTSEJI4BOjxKWWYojEZ0aJZROnMcJ0HL+xmRkisYtR4tXER0AdHEDOF0aJjzIgNWwC
        WhL7X9xgAwmLCERKNJ8UBClnFtjBJLG7+SLYHGEBf4lzd1ayg9gsAqoSBx7cYwWxeQUsJM5e
        uc8OsUteYvWGA2C7JASmckj8vv2eCSLhItH0aiuULSzx6vgWqAYpiZf9bVB2tcTKk0fYIJo7
        GCW27L/ACpEwlti/dDLY0cwCmhLrd+lDhBUldv6eC3YcswCfxLuvPawgJRICvBIdbUIQJcoS
        lx/chVorKbG4vZMNwvaQ+Hx0Ijsk4GIlfjW+ZZnAKDsLYcECRsZVjGKpBcW56anFhgWmyFG0
        iRGcMLUsdzBOf/tB7xAjEwfjIUYJDmYlEd7d6hPjhXhTEiurUovy44tKc1KLDzGaAgNsIrOU
        aHI+MGXnlcQbmhoZGxtbmBiamRoaKonz/tHuiBcSSE8sSc1OTS1ILYLpY+LglGpg8t93PlVD
        6+PxpUH9rBfU7VlCG0vyFl9aH9MRu03rnuzHyLz19fVrb+zbd5DbfM8W1TTtiY9r398yCrBV
        jnzbe37V6ajHztZLQ7Tldzp7sRpUnmVp1LdKPPujeKGacNEGpWoWg7bdK++Xzm15Vfbu4sRb
        asZ8MxymZk3bV6b+aYqf7n+ZTw9W2QsKOW6V3dJovb2kWKKx5V/2xXr3w2fj2pSqxApuzZl7
        9PXsw8l3dCaIv+WMPXzjSWrm0afrqqaHCO983jIjacmqDRayyvezdi86Nntzb7nSsu83AyXu
        3684LrMy837dygi3zDx2+a3nmldk7/J98Pyty99tc+ZMKuoO6Gtx+n78XZnA/6ZVU5RYijMS
        DbWYi4oTAWr3LiIhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvO68NZPiDbr/KVssu3SU0WLjjPWs
        FhNvXGGxuP7lOavF6o+PGS3W3D7EaPFjwylmi5ZZi1gsFnyawWpxtukNu8XlXXPYLD73HmG0
        6Pwyi81iYVMLu8XtxhVsFj93zWNxEPBYM28No8eOu0sYPXbOusvusWlVJ5tHb/M7No+N73Yw
        efydtZ/Fo2/LKkaPz5vkAjijuGxSUnMyy1KL9O0SuDI61gkU7JerOPniEksD43bRLkZODgkB
        E4njNzYzdzFycQgJ7GCUeHdmFiNEQlJi2sWjQAkOIFtY4vDhYoiaT4wSC37eYgWpYRPQktj/
        4gYbiC0iEC2x+ONHsEHMAieYJFZ/2cUEkhAW8JV4fPsTC4jNIqAqceDBPbBmXgELibNX7rND
        LJOXWL3hAPMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCw1hLawfjnlUf
        9A4xMnEwHmKU4GBWEuHdrT4xXog3JbGyKrUoP76oNCe1+BCjNAeLkjjv11kL44QE0hNLUrNT
        UwtSi2CyTBycUg1MBRtO2r09seZoxv7t0+Piv64Qaas4svJ//76oj1O4FwRUXXD6YzPr/aW9
        Ke5ey7uY71yzZbzdJXk/4FHjmmwOn4Ny2w4GHs42fzirN+rQn33v0/5uN5T6ryov6HUoyeRQ
        65bADfe1r2283PaG/1dcofCT0533FwWuOtd36HGXwQ6zoJiyA5N/Gc54ySKn9zLlot6PdT8+
        r4q3uHzPtsT/KP/mZ+aKO47P8ZPfIiixTCVmlviHrdwMaWuD1L+q8J6bavFT+kqZncai/JP/
        C+NyZ05NXv6R17uxoTJDZFbNzkzXiTtT1HdZvXXfztOyzO2R1Jkbu/g/izrlv6p1DZyx7EP9
        hru3za0LwxjzPgmL8iixFGckGmoxFxUnAgBWj9lN0gIAAA==
X-CMS-MailID: 20201023101246epcas1p126bb1157eb75f972786758ef1e2f6e0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101246epcas1p126bb1157eb75f972786758ef1e2f6e0c
References: <CGME20201023101246epcas1p126bb1157eb75f972786758ef1e2f6e0c@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each devfreq governor can have the different sysfs attributes and features.
In order to provide the only available sysfs attribute to user-space,
add governor attribute flag with DEVFREQ_GOV_ATTR_[attribute name] defintion.

Also, each governor is able to have the specific flag in order to
support specific feature with DEVFREQ_GOV_FLAG_[feature name] defintion
like immutable governor.

According to each governor, can initiate the governor feature and attribute
flags.

[Common sysfs attributes for devfreq class]
And all devfreq governors have to support the following common attributes.
The common attributes are added to devfreq class by default.
- governor
- available_governors
- available_frequencies
- cur_freq
- target_freq
- min_freq
- max_freq
- trans_stat

[Definition for governor attribute flag]
- DEVFREQ_GOV_ATTR_POLLING_INTERVAL to update polling interval for timer.
  : /sys/class/devfreq/[devfreq dev name]/polling_interval
- DEVFREQ_GOV_ATTR_TIMER to change the type of timer on either deferrable
  or dealyed timer.
  : /sys/class/devfreq/[devfreq dev name]/timer

[Definition for governor feature flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
  : If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
  : Devfreq core won't schedule polling work for this governor if value is set.

[Table of governor attribute flags for evfreq governors]
-----------------------------------------------------------------------------
                      | simple    | perfor | power | user | passive | tegra30
		      | ondemand  | mance  | save  | space|         |
------------------------------------------------------------------------------
governor              | O         | O      | O     | O    | O       | O
available_governors   | O         | O      | O     | O    | O       | O
available_frequencies | O         | O      | O     | O    | O       | O
cur_freq              | O         | O      | O     | O    | O       | O
target_freq           | O         | O      | O     | O    | O       | O
min_freq              | O         | O      | O     | O    | O       | O
max_freq              | O         | O      | O     | O    | O       | O
trans_stat            | O         | O      | O     | O    | O       | O
------------------------------------------------------------------------------
polling_interval      | O         | X      | X     | X    | X       | O
timer                 | O         | X      | X     | X    | X       | X
------------------------------------------------------------------------------
immutable             | X         | X      | X     | X    | O       | O
interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
------------------------------------------------------------------------------

Changes from v4:
- Rename from 'attr' to 'attrs'
- Restore the variable name in governor_store because it is enought to explain
the previous or new governor with detailed comments instead of variable name
changes.

Changes from v3:
- Fix typo
- Rename from 'flag' to 'flags'
- Add more exception handling code and add comments on governor_store()

Changes from v2:
- Hide unsupported sysfs node to user-space instead of checking the permission
of sysfs node.



Chanwoo Choi (2):
  PM / devfreq: Add governor feature flag
  PM / devfreq: Add governor attribute flag for specifc sysfs nodes

 Documentation/ABI/testing/sysfs-class-devfreq |  54 ++---
 drivers/devfreq/devfreq.c                     | 185 ++++++++++++------
 drivers/devfreq/governor.h                    |  30 ++-
 drivers/devfreq/governor_passive.c            |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   5 +-
 6 files changed, 186 insertions(+), 92 deletions(-)

-- 
2.17.1

