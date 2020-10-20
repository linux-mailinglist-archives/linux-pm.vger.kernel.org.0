Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD529334C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 04:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbgJTCuw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 22:50:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:58545 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390839AbgJTCuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 22:50:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201020025049epoutp013c0fafbc1a80e7718e5d0d013668ed73~-k5J5UgNI0473104731epoutp01n
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201020025049epoutp013c0fafbc1a80e7718e5d0d013668ed73~-k5J5UgNI0473104731epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603162249;
        bh=j1OxPu5Ga73Da30LXduKjAqKnj37k6UjA/67PWnnVIY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=o+VDbZjzgyilu+5M63ru1RA0nT5joF+ydWkodCtx/LLoYnQkT+98HjX8QhRFjdv7W
         FTp6GWRJSEvK/GzlIsXw910OEsTmitmMiyVoBXGXp1NJkm3tQj6i1Gl5mT9ztiyM9K
         fyDcrxzKFFZjira6B9vcjcw6HL97aqYEeKV9eqA8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201020025048epcas1p49af11d0c80869bd015fdad4e8f4d16cb~-k5JEc-683014930149epcas1p4J;
        Tue, 20 Oct 2020 02:50:48 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CFdRB3QqNzMqYkh; Tue, 20 Oct
        2020 02:50:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.5E.09577.6805E8F5; Tue, 20 Oct 2020 11:50:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201020025045epcas1p2aaf684cb1bec4a390cdede45cd1eae85~-k5Fxjd_b2906929069epcas1p2Y;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201020025045epsmtrp26e7e07b6d40b582adf9c138a76d8d556~-k5FwlPRs3243932439epsmtrp2c;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-5c-5f8e5086b0b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.D4.08604.5805E8F5; Tue, 20 Oct 2020 11:50:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201020025044epsmtip195e999d326e97b907613a12d6c41f689~-k5FdR7D60260602606epsmtip1a;
        Tue, 20 Oct 2020 02:50:44 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 0/2] PM / devfreq: Add governor feature and attribute
 flag
Date:   Tue, 20 Oct 2020 12:04:05 +0900
Message-Id: <20201020030407.21047-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTV7ctoC/eYMU7CYtll44yWmycsZ7V
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVs0TJrEYvFgk8zWC3ONr1ht7i8aw6bxefeI4wW
        nV9msVksbGpht7jduILN4ueueSwOAh5r5q1h9Nhxdwmjx85Zd9k9Nq3qZPPobX7H5rHx3Q4m
        j7+z9rN49G1ZxejxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0B9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi
        0rx0veT8XCtDAwMjU6DChOyMZYenMxU8ka24/bybpYHxjUgXIweHhICJxKEzZl2MXBxCAjsY
        JX4uucsE4XxilJhxYCULhPONUaL/+mvGLkZOsI6Jc16ygthCAnsZJabMKYQo+sIo8eDQeSaQ
        BJuAlsT+FzfYQFaICERKNJ8UBKlhFtjBJLG7+SIjSFxYwF+i90QuiMkioCqx6YQdSCevgJVE
        35t/zBCr5CVWbzjADNIqITCVQ+Llv1OsEFe7SCyfaQpRIyzx6vgWdghbSuLzu71sEHa1xMqT
        R9ggejsYJbbsv8AKkTCW2L90MhPIHGYBTYn1u/QhwooSO3/PBXuRWYBP4t3XHqhVvBIdbUIQ
        JcoSlx/cZYKwJSUWt3dCrfKQmDz5Oli5kECsxO4NFRMYZWchzF/AyLiKUSy1oDg3PbXYsMAU
        OYI2MYKTpZblDsbpbz/oHWJk4mA8xCjBwawkwjuBtS9eiDclsbIqtSg/vqg0J7X4EKMpMLQm
        MkuJJucD03VeSbyhqZGxsbGFiaGZqaGhkjjvH+2OeCGB9MSS1OzU1ILUIpg+Jg5OqQamxRrn
        2N4z50yXexlYeShF7YrPIenngbWTtkUdDit9Uut2csM/Hw8Zqynshls8dh5MDt+24uUasdL3
        3zSt1R+me2Y/yYzxXt7hN2eGC09ZQjv39fW1Sezb4jqWLyz2Wvfdn+PwriR7fYnbSWFNPoxM
        T5Pm/fxrX7fwR2+f6eVvb/QLeBalPNWz3tdTcFQkZfN7sS/pnQ+9vkTP2rnt/QT39XY2lziO
        852f2nitxqSunf/xYuZTxdqbYl4rBi54NW2e779ZYbriX6LXNsWVvdxTtP7W9AduTuwpGUsD
        hV93MYfxVEk0lS04vNJrs3pw4/33S/RWG2veFDhSumoa01Zvs2UbzRaHHE9Vzt6g27NaiaU4
        I9FQi7moOBEAUg0gZR8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnG5rQF+8weYGDotll44yWmycsZ7V
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVs0TJrEYvFgk8zWC3ONr1ht7i8aw6bxefeI4wW
        nV9msVksbGpht7jduILN4ueueSwOAh5r5q1h9Nhxdwmjx85Zd9k9Nq3qZPPobX7H5rHx3Q4m
        j7+z9rN49G1ZxejxeZNcAGcUl01Kak5mWWqRvl0CV8ayw9OZCp7IVtx+3s3SwPhGpIuRk0NC
        wERi4pyXrF2MXBxCArsZJb7+OssEkZCUmHbxKHMXIweQLSxx+HAxRM0nRolZK++xgtSwCWhJ
        7H9xgw3EFhGIllj88SMzSBGzwAkmidVfdoENEhbwlbi44w4byCAWAVWJTSfsQMK8AlYSfW/+
        MUPskpdYveEA8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDWEtzB+P2
        VR/0DjEycTAeYpTgYFYS4Z3A2hcvxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdG4cI4IYH0xJLU
        7NTUgtQimCwTB6dUA1P6NuftH23+XBcxcNW9/e/J0+nn+pw/bbrdcKr/xEXjPNMfd9PkP7ZH
        /JyZ/l/w5pINPXxpS2W947f1B696vmWK27cfAibfWe5tm+sdejb6eOXj/uX/nr7m3XNQ3NqB
        86Z7iC4L+7sMe7a3x8x2X+95rNzKoVmje+1i6sQi294JmvLH2aVWqb0zOcz1ePqFq6ve31y8
        V1PUuHhJVlBktEDPdTVXy5sb1KO8hJ4vF3YLdhNR3+x51oxBqfagMuMknhP8X3deYCzLkpp6
        MORgYbXdeYG3SyTel3imFQeszni04v1hnelVe81fPt3LyNj++9fyFqP/c/dcseuwi49JOVv1
        PFrmjBiXyOdjhu5P1diVWIozEg21mIuKEwFUq+Hp0gIAAA==
X-CMS-MailID: 20201020025045epcas1p2aaf684cb1bec4a390cdede45cd1eae85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020025045epcas1p2aaf684cb1bec4a390cdede45cd1eae85
References: <CGME20201020025045epcas1p2aaf684cb1bec4a390cdede45cd1eae85@epcas1p2.samsung.com>
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

Chanwoo Choi (2):
  PM / devfreq: Add governor feature flag
  PM / devfreq: Add governor attribute flag for specifc sysfs nodes

 Documentation/ABI/testing/sysfs-class-devfreq |  54 +++--
 drivers/devfreq/devfreq.c                     | 213 ++++++++++++------
 drivers/devfreq/governor.h                    |  30 ++-
 drivers/devfreq/governor_passive.c            |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   5 +-
 6 files changed, 200 insertions(+), 106 deletions(-)

-- 
2.17.1

