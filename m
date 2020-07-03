Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF292213844
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGCJ5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:57:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16007 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCJ5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 05:57:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200703095701epoutp03cd8c99de76a6449f0008c0cf06aa4296~eNZJw3pev2540225402epoutp03q
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 09:57:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200703095701epoutp03cd8c99de76a6449f0008c0cf06aa4296~eNZJw3pev2540225402epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593770221;
        bh=XPVFGQQ0V5rIApWlccYE1gKpTH76cMyrzVu+/htoC4Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=axZ2gdeOlNgfdb0/OsEj/gsgPCGkkxFEkvCvVHz+Mwe4Uxz+12ogymu1wTEzoMKsO
         GETecDIkkOAlL4hRLuDv3HK3HnQ3x9IwxFhn2phMJvSnA3cEIWwy4mzzRYOTNKMTrw
         /ekgKMoyW17IUa56xettjEG4VYr0x8bGQfreTBiU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200703095700epcas1p3d6fcdb0dadac94488f86733c991eb78a~eNZI9VFAV0807208072epcas1p3_;
        Fri,  3 Jul 2020 09:57:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49yr3G18bCzMqYkZ; Fri,  3 Jul
        2020 09:56:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.26.28578.AE00FFE5; Fri,  3 Jul 2020 18:56:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epcas1p4347374f533f0cd84430d548a3af12b79~eNZGXy1s32581025810epcas1p4a;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703095657epsmtrp135a8beb715c763a0e0cef6546732de3e~eNZGWzYIf1126511265epsmtrp1p;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-52-5eff00ea506c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.15.08382.9E00FFE5; Fri,  3 Jul 2020 18:56:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epsmtip1221f184935bf1f55415c22d0ab74d2c3~eNZGFwEjF0487104871epsmtip1C;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 0/2] PM / devfreq: Add governor flags
Date:   Fri,  3 Jul 2020 19:08:08 +0900
Message-Id: <20200703100810.12304-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV/cVw/84gz9bWC2WXTrKaDHxxhUW
        i+tfnrNarP74mNFize1DjBY/NpxitmiZtYjF4mzTG3aLFXc/slpc3jWHzeJz7xFGi4VNLewW
        txtXsFn83DWPxYHPY828NYweO+4uYfTYOesuu8emVZ1sHr3N79g8Nr7bweTxd9Z+Fo++LasY
        PT5vkgvgjMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhg
        YGQKVJiQnXHmv2DBdcGKg235DYzb+boYOTkkBEwkpp/4zdLFyMUhJLCDUeLOgQVQzidGiakX
        lrJBON8YJT4s/ccG07L8wBlmiMReRokp1/+wQjhfGCUuN09jBKliE9CS2P/iBliHiICVxOn/
        HWAdzALzmCQWn74KtISDQ1jAVOLJ/ziQGhYBVYljxw4ygoR5geofb+eHWCYvsXrDAbBWCYFG
        Dol5q74zQyRcJGbcbICyhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHcwSixZf8FVoiEscT+pZOZ
        QJYxC2hKrN+lDxFWlNj5ey7Y/cwCfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeCQ0U
        D4nfV+6DrRUSiJV4f+sq0wRG2VkICxYwMq5iFEstKM5NTy02LDBFjqNNjOD0qGW5g3H62w96
        hxiZOBgPMUpwMCuJ8Cao/osT4k1JrKxKLcqPLyrNSS0+xGgKDK+JzFKiyfnABJ1XEm9oamRs
        bGxhYmhmamioJM7rZH0hTkggPbEkNTs1tSC1CKaPiYNTqoFJOiOS4TJPT+m0F04nWE7POvHg
        Y3jT5HulT8+E3SyuOt1ksGu2lPjBg/WaE+Z++nI6bLZfuem3oye2KLLsEfHaeWeFT8rV2B38
        e089k+x9sFzw1uP3ktr5Zl1r2J4arFq61PfSkeYzU1b7Leh49TtC5MV/zSvcf9UOa7ttEU1X
        0xbLfs++tmLuhITw6eVvO7WCbTxXtSwPFrwXeIpjgcSz11/YhaMeBJvvCL0e7GaxtNC5zIpj
        Smp2isB6l8+qHs2pDna+R1eGe7za2jutSYbr/+8diTcve1u2rH19J/TlUinDL7cbNf81Bz1f
        v4eh/MHb15Vr3BpuxWe/8nRhbapf19TVHuc3Y6nKk7cnGBa+VWIpzkg01GIuKk4EAObdRBwY
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnO5Lhv9xBp+WyVosu3SU0WLijSss
        Fte/PGe1WP3xMaPFmtuHGC1+bDjFbNEyaxGLxdmmN+wWK+5+ZLW4vGsOm8Xn3iOMFgubWtgt
        bjeuYLP4uWseiwOfx5p5axg9dtxdwuixc9Zddo9NqzrZPHqb37F5bHy3g8nj76z9LB59W1Yx
        enzeJBfAGcVlk5Kak1mWWqRvl8CVcea/YMF1wYqDbfkNjNv5uhg5OSQETCSWHzjDDGILCexm
        lPhw1wwiLikx7eJRoDgHkC0scfhwcRcjF1DJJ0aJ5TNOMYHUsAloSex/cYMNxBYRsJG4u/ga
        C0gRs8AaJol32w8xgTQLC5hKPPkfB1LDIqAqcezYQUaQMK+AlcTj7fwQq+QlVm84wDyBkWcB
        I8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgUNXS3MG4fdUHvUOMTByMhxglOJiV
        RHgTVP/FCfGmJFZWpRblxxeV5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cA0
        O0Dz1MYNFn+VVhyfIrA7VmXKsnulwSv0ryw4PMX92PGJmwv2bLi+9+zsA52Zzk97U0sMpjCo
        nX+sPO2b6CLx1Z28RU9UP8dFdKd8mn3hOrdRdWfhjSM8U7wd8owm/WX8zrxGYlvTqiNJ3jkP
        H7BoWp1ZESYglWnv9rXMX3//ZIHgzknptvKONaqlvacc2b/9/5rQu/rR5wvBvHcPzkw7o9x3
        JVnJeKpjeWObv9jUE4pyy2JDi5ZGPPnrV73og/FrmxPzymdF1Tlv43859d/++ubDkk91Kn4E
        pnRMKr69dkt82B7pZOcP2YdvTfndPYU1eoGS68XKZjO/fM6eSRMzha+57y+6X2VgcSNPMUtX
        iaU4I9FQi7moOBEATZZbEcQCAAA=
X-CMS-MailID: 20200703095657epcas1p4347374f533f0cd84430d548a3af12b79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703095657epcas1p4347374f533f0cd84430d548a3af12b79
References: <CGME20200703095657epcas1p4347374f533f0cd84430d548a3af12b79@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devfreq provides the multiple governors and sysfs interface for user.
But, some sysfs attributes are useful or not useful. Prior to that
the user can access all sysfs attributes regardless of availability.

So, clarify the access permission of sysfs attributes according to governor.
Provide the governor flag to specify what is necessary or not.
When adding the devfreq governor, governor can specify the available
attributes with DEVFREQ_GOV_ATTR_ATTR_* defintion as following.

[Definition for sysfs attributes]
- DEVFREQ_GOV_ATTR_GOVERNOR
- DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS
- DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES
- DEVFREQ_GOV_ATTR_CUR_FREQ
- DEVFREQ_GOV_ATTR_TARGET_FREQ
- DEVFREQ_GOV_ATTR_MIN_FREQ
- DEVFREQ_GOV_ATTR_MAX_FREQ
- DEVFREQ_GOV_ATTR_TRANS_STAT
- DEVFREQ_GOV_ATTR_POLLING_INTERVAL
- DEVFREQ_GOV_ATTR_TIMER

Also, the devfreq governor is able to have the specific flag as follows
in order to implement the specific feature with DEVFREQ_GOV_FLA_*.
For exmaple, the devfreq deivce using passive governor cannot change
their own governor because passive governor requires the 'immutable'
feature with DEVFREQ_GOV_FLAG_IMMUTABLE.

[Definition for governor flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
: If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
: Devfreq core won't schedule polling work for this governor if value is set.


Based on:
- This series is based on v5.8-rc3 and patchset[1].
- [1] https://patchwork.kernel.org/cover/11640919/
  ("[RFC,0/2] PM / devfreq: Add delayed timer for polling")

Chanwoo Choi (2):
  PM / devfreq: Clean up the devfreq instance name in sysfs attr
  PM / devfreq: Add governor flags to clarify the features

 drivers/devfreq/devfreq.c                 | 188 +++++++++++++++++-----
 drivers/devfreq/governor.h                |  45 +++++-
 drivers/devfreq/governor_passive.c        |   3 +-
 drivers/devfreq/governor_performance.c    |   1 +
 drivers/devfreq/governor_powersave.c      |   1 +
 drivers/devfreq/governor_simpleondemand.c |   3 +
 drivers/devfreq/governor_userspace.c      |   1 +
 drivers/devfreq/tegra30-devfreq.c         |   6 +-
 8 files changed, 195 insertions(+), 53 deletions(-)

-- 
2.17.1

