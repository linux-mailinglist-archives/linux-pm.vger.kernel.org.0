Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7E1E72A2
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 04:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbgE2Chg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 22:37:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17729 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbgE2Chg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 22:37:36 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200529023729epoutp0401f44bd865e7ef2f5abd0fdcbaa542cf~TX0ZTRCHs1064510645epoutp04J
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 02:37:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200529023729epoutp0401f44bd865e7ef2f5abd0fdcbaa542cf~TX0ZTRCHs1064510645epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590719849;
        bh=nL+qSGcZDLB7G5y8ifPxUy+B4ORMRSkHJ8AyLTcVfVg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=rZzrMc9U8w687/dpWm699bwFdV3jOGdBoWZC6/XHQ1ycySimcDzGnWADvcl24V4id
         7feN1Ke/FDqJemm9/G+ffQOAHNB5ff49jkAIXDjj+uBICcncB1GZC0/lJ5LZBlL6Lb
         /jqGf+YA0R0Xfpx4yFoXJwtijo3ON89GtXnKu/wo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529023728epcas1p2b3ae5c6d9d5f7fabc98384c1d834d640~TX0ZBw5vm3091530915epcas1p2d;
        Fri, 29 May 2020 02:37:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49Y7yG0KSrzMqYkW; Fri, 29 May
        2020 02:37:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.60.28581.36570DE5; Fri, 29 May 2020 11:37:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200529023722epcas1p4062a6826d015c249adddd45bf28c0a29~TX0TgB14s0491404914epcas1p4F;
        Fri, 29 May 2020 02:37:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529023722epsmtrp19ea1b3060b05718aa2a664b7c1dbd70f~TX0TfdCay1012710127epsmtrp1K;
        Fri, 29 May 2020 02:37:22 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-76-5ed075638f59
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.2A.08382.26570DE5; Fri, 29 May 2020 11:37:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529023722epsmtip1e9751a12903c089d4937175624338bce~TX0TVUHzY2806128061epsmtip1v;
        Fri, 29 May 2020 02:37:22 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.8
Organization: Samsung Electronics
Message-ID: <eba2afce-78d0-50ba-8907-da2f61f0df9e@samsung.com>
Date:   Fri, 29 May 2020 11:47:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmvm5y6YU4gw1LpSwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdcWPe
        G5aC2SIVU88uY25gXCzQxcjJISFgInHs53qmLkYuDiGBHYwSvYueMkM4nxglJmyazQjhfGOU
        uHoPJAPRcuDaQajEXkaJiW272CGc94wSl29PB3I4OEQE7CU6PmSCxJkFLjBJXNzUxgrSzSag
        JbH/xQ02EFtYQFNi07QFLCA2v4CixNUfjxlBbF4BO4mtGyexg9gsAqoSu6Z/YQKxRQXCJE5u
        a4GqEZQ4OfMJWC+zgLjErSfzmSBseYntb+eA/SAh8JddYvHuA1Bnu0g8+j+LCcIWlnh1fAs7
        hC0l8bK/Dcqullh58ggbRHMHo8SW/RdYIRLGEvuXTmYC+YwZ6Or1u/QhwooSO3/PZYRYzCfx
        7msPK0iJhACvREebEESJssTlB3eh1kpKLG7vZIOwPSS6j89im8CoOAvJO7OQvDMLyTuzEBYv
        YGRZxSiWWlCcm55abFhgghzdmxjByVPLYgfj3Lcf9A4xMnEwHmKU4GBWEuFdc/Z8nBBvSmJl
        VWpRfnxRaU5q8SFGU2AAT2SWEk3OB6bvvJJ4Q1MjY2NjCxNDM1NDQyVx3pNWF+KEBNITS1Kz
        U1MLUotg+pg4OKUamOYZ1Z79bn2na5f0Sr109WiB2+/uT3pZpPdvogmTSNGcBX5vmcQKOO3m
        pq7+3KF09MfCnStT5k3cP5ndNj+Sf8rETbXFC/mur8ww4BNfNSXf6emT8EYpH15Os9Se3lO3
        nxgGNtiG5Hnq/I5M5NghxMcQyKM0tUzkb9MSqY6pIjqTP7We3nNK07gsYI9bj8mPqRZXHwgn
        59+4+G/61AzFMJEJd5f/+ijd1TFxU3xvk9eSik4+pZUeF9y0FR9xJxifEhYM3nz/UsGci9Ib
        75hP3G9tUfKm9qvKyYRVky+zRDWtLM24p+K2dVIE65q5rIrCiW5nXRR2/lzilpN16bDmwtwd
        L9j3vlug+2G+hkblaiWW4oxEQy3mouJEAMJDwpcnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG5S6YU4g6Pr9Cwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mq4Me8NS8FskYqpZ5cxNzAuFuhi5OSQEDCROHDtIGMXIxeHkMBuRonJl08y
        QSQkJaZdPMrcxcgBZAtLHD5cDFHzllFi4f5JjCBxEQF7iY4PmSBxZoFLTBIbz9xgB+llE9CS
        2P/iBhuILSygKbFp2gIWEJtfQFHi6o/HjCA2r4CdxNaNk8DqWQRUJXZN/wK2V1QgTGLnksdM
        EDWCEidnPgHrZRZQl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYBWchaZmFpGUWkpZZSFoWMLKs
        YpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgktzR2M21d90DvEyMTBeIhRgoNZSYR3
        zdnzcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwZZgb
        /v1wUyuHJ4vzVsrR/Tp+6TOvvs1u3LySiSu454GQ/WJlxbhTYV0ZCzpW+E9e3ZzTmiO6egqL
        vZae5sG5+y6tKv97MTxq76Fk/l9Je34vTzhaaPKF/Ury1ctXZ1uWNZ1VitaZprS4Xq3ibIph
        b8X3829uyDTU5tiaP2u8YGmg35RzYlt/5bLWQ6WpZ5S+v034setU5at6OZdDnOq9S5YflOys
        3MtlM+tHG5M4m062p0pu+dN61gmWLPp9TCveXeG58uLjYjcGEcZni15HMnAfSPD6sWrjhqfB
        az8prvR/rbhVN6KnnHPLY6dDu+dv/rB18/27+hY39h1Ysu5c68+HjJVyt2bm5VbOebTaQYml
        OCPRUIu5qDgRAL3ruXH4AgAA
X-CMS-MailID: 20200529023722epcas1p4062a6826d015c249adddd45bf28c0a29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529023722epcas1p4062a6826d015c249adddd45bf28c0a29
References: <CGME20200529023722epcas1p4062a6826d015c249adddd45bf28c0a29@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.8-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.8

Best Regards,
Chanwoo Choi


The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.8

for you to fetch changes up to 8fc0e48e0faefef5064f3cb803d3d12314e16ec4:

  PM / devfreq: Use lockdep asserts instead of manual checks for locked mutex (2020-05-28 18:02:40 +0900)

----------------------------------------------------------------

Update devfreq for 5.8

Detailed description for this pull request:
1. Update devfreq core
- Use lockdep function for checking mutex state instead of manual checking.
- Replace strncpy with strscpy to fix the compile warning.

2. Update devfreq driver
- Add new imx-bus.c devfreq driver for controlling the bus frequenncy
  and it registers the imx interconnect device which indicates the imx-bus.c
  as the parent device. This relation make the connection between imx-bus.c
  and imx interconnect nodes. In result, the imx-bus.c devfreq driver handles
  the DEV_PM_QOS_MIN_FREQUENCY requirements from imx interconnect nodes
  in order to support the minimum bus bandwidth of interconnect nodes.

- Delete unneed error message and update the boosting on tegra30-devfreq.c.

----------------------------------------------------------------
Dmitry Osipenko (2):
      PM / devfreq: tegra30: Make CPUFreq notifier to take into account boosting
      PM / devfreq: Replace strncpy with strscpy

Gustavo A. R. Silva (1):
      PM / devfreq: imx-bus: Fix inconsistent IS_ERR and PTR_ERR

Krzysztof Kozlowski (1):
      PM / devfreq: Use lockdep asserts instead of manual checks for locked mutex

Leonard Crestez (2):
      PM / devfreq: Add generic imx bus scaling driver
      PM / devfreq: imx: Register interconnect device

Markus Elfring (1):
      PM / devfreq: tegra30: Delete an error message in tegra_devfreq_probe()

 drivers/devfreq/Kconfig           |   8 ++
 drivers/devfreq/Makefile          |   1 +
 drivers/devfreq/devfreq.c         |  19 ++--
 drivers/devfreq/imx-bus.c         | 179 ++++++++++++++++++++++++++++++++++++++
 drivers/devfreq/tegra30-devfreq.c |   7 +-
 5 files changed, 199 insertions(+), 15 deletions(-)
 create mode 100644 drivers/devfreq/imx-bus.c
