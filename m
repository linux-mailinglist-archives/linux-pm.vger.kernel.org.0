Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D802857F3
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 06:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGExt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 00:53:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54162 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgJGExt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 00:53:49 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201007045347epoutp02d6df74ba1368b3cd114f2952ec6d6599~7nLzObeeT2824028240epoutp02Q
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 04:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201007045347epoutp02d6df74ba1368b3cd114f2952ec6d6599~7nLzObeeT2824028240epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602046427;
        bh=wkRAS5+UPLdtUDs4UJT4JQOyIRjxqkddK6E3soMuPAs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Qw28XsToECwwaTNnu4o4jULnPAS5gOLc45PoO+h/9/sIKb0N/DhOeCRoIgx7Dr1XB
         ylnrRuZYmt8sfifZIOoEJQccH3C8FifGNRBz3BrebWCVPaIzsTxH8qCesnEnmaf3xV
         POzUGlD6f4pw+Awmsjp9PBd7Otgvls+8nxohRgjg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201007045346epcas1p35f4fd1e681730f5729ebf44df106ee18~7nLykxG682102521025epcas1p3v;
        Wed,  7 Oct 2020 04:53:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4C5hn242xnzMqYkV; Wed,  7 Oct
        2020 04:53:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.66.10463.5D94D7F5; Wed,  7 Oct 2020 13:53:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epcas1p32326a90323a3313f39041e3699e477f0~7nLs3IVob1699316993epcas1p3b;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201007045340epsmtrp13533e2cd01091dc63ca05067595ea932~7nLs2MsFS1492114921epsmtrp10;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-09-5f7d49d50cce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.99.08745.4D94D7F5; Wed,  7 Oct 2020 13:53:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epsmtip292615296ae22a1d7e8debe7878389649~7nLsipw_g2037420374epsmtip2y;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 0/2] PM / devfreq: Add governor feature and attribute
 flag
Date:   Wed,  7 Oct 2020 14:07:01 +0900
Message-Id: <20201007050703.20759-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHOW3vbTGpuRTmzpqJXeecNGtpKe2uji4mY9tdMJNNZzI3V+7g
        Whj9Sm/LppNEoDCpKGMmjlTpQFGhsPExlJagZUCBSjAiU/lIo8twwCKNtEz3xVzrxWz/PXnP
        8zvvOe85PLbgOCrkFRitlMVI6sXoGs7FgRSp9MZbxVp5xV0UP3fdD/CO2jYEr5n8kYPfWp5D
        8JalnwHeOtMP8N/br7Bxu/M0B68P1yL4WOk9Lt4UXELwiZ5TKB45OgjwymUnijeU2rn4TEkT
        iv/R4+JsSyBaXa2A8AQbAeF1BrlEp7sSJY6WhVCiI+RhEStOH4c41uUGRKQzOTt+T2FGPkXm
        URYRZcw15RUYdRpx1k7ta1qVWq6QKrbgL4tFRtJAacSZ27OlbxToo5cRi4pIvS1ayiZpWpz6
        aobFZLNSonwTbdWIKXOe3rzFLKNJA20z6mS5JsNWhVyepoqKOYX5K/9MIuaOZz8bvzLNOgTm
        Ex0gngexdDg1f58VYwHmAbD+gpThMICnSzEHWBPlCIBTnhbkSWDM70QYqQfA0O3XGWkZwJG+
        YRBbQDEJ9M1Pog7A4yVh78OyQELMYWPjLFgXbOLGnERsB1y6PM6OMQd7AQ6HJ7kxn49thUPf
        b2N6bYAt7X3sWBZidTz4TdOR1UNkwksnugHDifDX4S4uw0K4UF2xyp/D5sAgyoQPA9jlu7Ya
        VkLf2eOsWDM2lgLbelKZ8nPQ+1fd4z3Z2FoY+q0KiSkQ48PDFQJGeR5O3AmyGH4GnvmiEmWY
        gIHeIygzk73Q1fsQfAnWO/9rUA+AG6yjzLRBR9EKc/r/n6gTPP6dEtwD6hbvy/oBiwf6AeSx
        xUl8XdZBrYCfR+4/QFlMWotNT9H9QBWdVw1b+FSuKfq9jVatQpWmVCrxdIVapVCIn+b/NC3S
        CjAdaaUKKcpMWZ7kWLx44SHWwfdsmt2oBkTs58ovn1e869dnOH+Ya5510zc5XtqwMprZu/Gj
        a2rLvtsX35akhQKbRqp3ZPn3L1Ks3Y3ygZp3hoe46WeLPzz/abPfnVDFK1y/MSeZijN2viLz
        ac8I/dY97Q1rF6Yiu1La/TdLT/jcJaJHNtHJ7usvlpdg5ZFLsw1W+m+H+8+gcCDOfvXrrzZv
        GMWsfRPq8L2dgrSUR5+oLsxO3xAd8PiMyYj6lzbSe7dq6FvXot+7bp8uMCprDfWevDOz0Dym
        LmrsCtmTigcfLm2WfFfruqX/YHbO8WCMuBrMeak6VVm+En7A/VhYtuvNQG23p3okrihnL9jU
        p0fEHDqfVEjYFpr8F2Jw+3UmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvO4Vz9p4g7YJvBbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbrHi7kdWi8u75rBZ
        fO49wmjR+WUWm8XCphZ2i9uNK9gsfu6ax+Ig6LFm3hpGjx13lzB67Jx1l91j06pONo/e5nds
        Hhvf7WDy+DtrP4tH35ZVjB6fN8kFcEZx2aSk5mSWpRbp2yVwZfz9d4O1YKNMxcVTt5gaGF8I
        dzFyckgImEicPTqLtYuRi0NIYAejxNINu1khEpIS0y4eZe5i5ACyhSUOHy4GCQsJfGKU2LSD
        CcRmE9CS2P/iBhuILSIQLbH440dmkDnMAo+ZJPbfusIOkhAW8JX48egsWBGLgKrE8U832EFm
        8gpYSRzb7ACxSl5i9YYDzBMYeRYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgO
        Zy2tHYx7Vn3QO8TIxMF4iFGCg1lJhDfduyZeiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/XWQvj
        hATSE0tSs1NTC1KLYLJMHJxSDUybfgTsb3mjs26v3t8v8U4ai+WOvj0vqdZw8uaLvaUHNnHt
        Xr1tclLX51l6lXunmn5grvENjLl84axwXNf/sg8729js19XpdC/U/SuwYjZXQF//R/OKW7kO
        i1m59zioiEg0H7c+nxL3yb6Drexf79f+yF+RhxpfP95oMfGtlkDdRub48iZmdRnfZTNucrNa
        mG7Lej9l8ul3OxZU5ao51VuvOme5fIHkvaLJyy3OlHnOnBL2uVlmtatN11rHhX8F7s3fqDH9
        icrc8vN6MzUrXvZPeaW4dKoLZ2hzX1/GhDjmqdOn8DHIRZZnHS+Ov61ququ4d9/OiW8s9or+
        eldSW3szWf+jyfLoQP1TF09x2j1XYinOSDTUYi4qTgQAfaFwi9YCAAA=
X-CMS-MailID: 20201007045340epcas1p32326a90323a3313f39041e3699e477f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p32326a90323a3313f39041e3699e477f0
References: <CGME20201007045340epcas1p32326a90323a3313f39041e3699e477f0@epcas1p3.samsung.com>
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

Changes from v2:
- https://lkml.org/lkml/2020/7/13/285 ("[PATCH v2 0/2] PM / devfreq: Add governor flags")
- Hide unsupported sysfs node to user-space instead of checking the permission
of sysfs node.

Chanwoo Choi (2):
  PM / devfreq: Add governor feature flag
  PM / devfreq: Add governor attribute flag for specifc sysfs nodes

 Documentation/ABI/testing/sysfs-class-devfreq |  54 +++---
 drivers/devfreq/devfreq.c                     | 170 +++++++++++-------
 drivers/devfreq/governor.h                    |  30 +++-
 drivers/devfreq/governor_passive.c            |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   5 +-
 6 files changed, 171 insertions(+), 92 deletions(-)

-- 
2.17.1

