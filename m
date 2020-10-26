Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C77298597
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 03:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421452AbgJZChK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 22:37:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54521 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421450AbgJZChD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 22:37:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026023658epoutp02f565d46d2de021a06b68c51519485bd0~Bakxp3moK0650306503epoutp02d
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 02:36:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026023658epoutp02f565d46d2de021a06b68c51519485bd0~Bakxp3moK0650306503epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603679818;
        bh=3+2zkR2VTXzfHK6pn5tH41cIwEFd98A5+NfshE9tWhE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=d5Yowh1vXW/lh25jc+PNsJew+rw2lXg24PIhn8uu3fWQ2+cySfl0Lz+wY1BiEalOo
         xpDE9bYKGBLWmBJHTtHbNo0Gv0bEmQRt9aiPf+RJHJA1kzm1SpD0keckf/eDYr1s1i
         8Z67jk+ckMLXySwVuN+YlFl/KKqRlXd8Iwv86q0k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201026023657epcas1p2a326860b376ad0459ff7d61dba6511b2~Bakwt6Wpm3236632366epcas1p2j;
        Mon, 26 Oct 2020 02:36:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CKJrR2czJzMqYlh; Mon, 26 Oct
        2020 02:36:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.DF.10463.746369F5; Mon, 26 Oct 2020 11:36:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0~Bakt3xj7-3226732267epcas1p4W;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201026023654epsmtrp1f222fad92fe0dea427e4a45bf27ccc11~Bakt29xo52089020890epsmtrp1j;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-22-5f9636470dc4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.D0.08604.646369F5; Mon, 26 Oct 2020 11:36:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026023654epsmtip26e574e7e94f8334f78663066a7d0e32f~BaktkM5nT0788107881epsmtip2P;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v6 0/2] PM / devfreq: Add governor feature and attribute
 flag
Date:   Mon, 26 Oct 2020 11:50:36 +0900
Message-Id: <20201026025038.1480-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmvq672bR4g9YtghbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoD+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZD+fVFkxSqPj86hVbA+NrsS5GTg4JAROJ/7dPsnQxcnEICexg
        lOg+Pp0JwvnEKLGmeyWU841R4uOZG0xwLZtXMkIk9jJKbNu3lA3C+cIo8b/vDCtIFZuAlsT+
        FzeAEhwcIgKREs0nBUFqmAV2MEnsbr7ICFIjLOAv8WRnC1g9i4CqxPK5f5lBbF4BS4nOC1NY
        IbbJS6zecIAZpFlCYCKHxM3DXVAJF4k/V0+wQ9jCEq+Ob4GypSRe9rdB2dUSK08eYYNo7mCU
        2LL/AlSzscT+pZOZQK5jFtCUWL9LHyKsKLHz91yw45gF+CTefe1hBSmREOCV6GgTgihRlrj8
        4C40JCQlFrd3skHYHhKfj+4Fu19IIFbi6asvzBMYZWchLFjAyLiKUSy1oDg3PbXYsMAEOZY2
        MYLTppbFDsa5bz/oHWJk4mA8xCjBwawkwjtHZmq8EG9KYmVValF+fFFpTmrxIUZTYIBNZJYS
        Tc4HJu68knhDUyNjY2MLE0MzU0NDJXHeP9od8UIC6YklqdmpqQWpRTB9TBycUg1M2lktMUxs
        iiEuE0sY7GMErd1aFIx/3Txw2DA16EmX+Bz7ZImH0kbz9Bfk3asr2iUyP+7GrNhZT85M3C3K
        Wt34qeLtyWeLXkslqf1fKnF60/xre+T/WfhaRDVPbbz0y2he1QbNTTM7vmrkpW3/3XMk/Yw8
        0/tZC3L/HmjKVjiRsT3z9YXWkHduSxdxF93OTnYI/G0eya8UedJ+le3msMAb16QO2Nu+Ln57
        dwnP/CufjnKbyZYyvvZR6qlgrb24Y69RONsb4cQZE/TCn5vOqtvffUS+y27Blq4P3nHqv5WS
        u+U9y+SDG4Sc1rJrW5nsys05+zNk+1b7tO8njFq/595skjnMwFnJ+JTBS0HjS74SS3FGoqEW
        c1FxIgBkUGTZJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvK6b2bR4g9d7FC2WXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBkP59UWTFKo+PzqFVsD42uxLkZODgkB
        E4n/m1cydjFycQgJ7GaUeH/vESNEQlJi2sWjzF2MHEC2sMThw8UQNZ8YJf796mYCqWET0JLY
        /+IGG4gtIhAtsfjjR2aQImaBE0wSq7/sYgJpFhbwlZh2rRKkhkVAVWL53L/MIDavgKVE54Up
        rBC75CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAg1tLcwbh9
        1Qe9Q4xMHIyHGCU4mJVEeOfITI0X4k1JrKxKLcqPLyrNSS0+xCjNwaIkznujcGGckEB6Yklq
        dmpqQWoRTJaJg1OqgWn9XosLVnvXZeTayQbsmHfo1BlbJaHZbbXzC852VTY1rEsJrjuzcePM
        BtVEvZSQJnHZ9Ufk1cL/Wdw7Hs002byI66Tutxu5MkdWy34IfyAbaL35a+DzPfKPfaUf/D6p
        PMMoYrNMVNcx5fYGO5kO6dzHk01+fuIIbueu/nvwUL2sIl+2ZLrRRPbD7+Rmhhpf3acQ+vDT
        K2YvIf1o+fj6qq3Hgq0N9tq2btWbwfFna9SVOmdbbofvTbW6+duZVc8xCGSGfZ/38MgtG4Zb
        ymfuam15pr/P13H65qU3Nh+P6A2rSzp/t9axwHBS58yVwaGVN9J+zjUousNwc9lCi7uV+z5o
        OjzSfyF2s7VNMsf8qxJLcUaioRZzUXEiAH7INtjRAgAA
X-CMS-MailID: 20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0
References: <CGME20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0@epcas1p4.samsung.com>
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

Changes from v5:
- Remove redundant code for creating syfs files.
- Move create_sysfs_files() position after completed governor start on
devfreq_add_device()
- Add reviewd-by/tested-by tag of Dmitry Osipenko

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
 drivers/devfreq/devfreq.c                     | 187 ++++++++++++------
 drivers/devfreq/governor.h                    |  30 ++-
 drivers/devfreq/governor_passive.c            |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   5 +-
 6 files changed, 188 insertions(+), 92 deletions(-)

-- 
2.17.1

