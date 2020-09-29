Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210DF27C02C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgI2I4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 04:56:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33921 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgI2I4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 04:56:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200929085616epoutp0173ea11a12917b799b3c39829bb160245~5NVO_lL7f0419104191epoutp01J
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 08:56:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200929085616epoutp0173ea11a12917b799b3c39829bb160245~5NVO_lL7f0419104191epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601369776;
        bh=107FJKn3uMv27QUa2VyeeFJZ89mUpDJ75ixuz7wWBCw=;
        h=From:Subject:To:Cc:Date:References:From;
        b=nsZt7ugIj1iQ+cFs61xB/dLLZu1xuWiS7nB+YpkqcP9kR5TKDXL1r+kzTRyUX+qXh
         vlB8c7H3ZxhIONRU/rPsLcneLjFuOsyeVP3zFH4T2LjS/hc1h2euqMfJFD2UG+gEvA
         Dz0KBL5RSD9xY9vEyYX1bB28FdC422bVsvqJo7q8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200929085615epcas1p4fb58f0faf93b24073849d11ef135e4c2~5NVOoePoN1275712757epcas1p4W;
        Tue, 29 Sep 2020 08:56:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4C0tXY0lcFzMqYkh; Tue, 29 Sep
        2020 08:56:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.AB.09582.BA6F27F5; Tue, 29 Sep 2020 17:56:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15~5NVJ8gPoj2176521765epcas1p2f;
        Tue, 29 Sep 2020 08:56:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200929085610epsmtrp19c2df24cac065eaaab7500ade5082654~5NVJ73JRL1460514605epsmtrp1f;
        Tue, 29 Sep 2020 08:56:10 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-f0-5f72f6abd21f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.B5.08745.AA6F27F5; Tue, 29 Sep 2020 17:56:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200929085610epsmtip2534b6f583955bdb8c859f9e6e9bc5972~5NVJv__RB1039610396epsmtip2E;
        Tue, 29 Sep 2020 08:56:10 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.10
Organization: Samsung Electronics
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cw00.choi@samsung.com,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Message-ID: <b5d67c59-90c7-6a77-7420-a8783282430f@samsung.com>
Date:   Tue, 29 Sep 2020 18:09:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmvu7qb0XxBnduy1lMvHGFxeL6l+es
        Fmeb3rBbXN41h83ic+8RRovbjSvYLM6cvsTqwO6xaVUnm8eWq+0sHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE74+jO
        +6wF24Qq7n5ZxtLA+Jevi5GTQ0LAROJC43SmLkYuDiGBHYwSN5oPM0M4nxgl3ny5xArhfGaU
        2Pj9IUsXIwdYy55/sRDxXYwSq/+fhep4zyjx4XQ/G8hcNgEtif0vboDZwkD23ldXWEFsfgFF
        ias/HjOCDBIRsJfo+JAJ0ssssJFJ4sORZUwgNbwCdhLTjr5nBLFZBFQlZk3cARYXFQiTOLmt
        hRGiRlDi5MwnLCA2s4C4xK0n85kgbHmJ7W/nMEP89pNd4mqzCoTtInFo1ydGCFtY4tXxLewQ
        tpTEy/42KLtaYuXJI2wgB0kIdDBKbNl/gRUiYSyxf+lkJpCjmQU0Jdbv0ocIK0rs/D2XEWIv
        n8S7rz2skADilehoE4IoUZa4/OAuE4QtKbG4vZMNwvaQePP9PMsERsVZSL6ZheSbWUi+mYWw
        eAEjyypGsdSC4tz01GLDAmPkyN7ECE6cWuY7GKe9/aB3iJGJg/EQowQHs5IIr29OQbwQb0pi
        ZVVqUX58UWlOavEhRlNg+E5klhJNzgem7rySeENTI2NjYwsTQzNTQ0Mlcd6HtxTihQTSE0tS
        s1NTC1KLYPqYODilGpjylN4VVxxyn+PGbWL164zn4gn+xdOnrKlpe7LxXYtl5xQn7kiem5ui
        vPri8u5IlxU9KE5/dZOvx2aJmMz19fPbK6dE5L99eMgyT9d9i7iXmPJp+wsf+bXTQwXn+NTY
        lv47Eb3+6dLNW5Mm283qfek2RXVSymaDFca+xyadX77c5mWxROTn27LB1XICx8svX19x/v+2
        78zVHQKNB80U3i/Qn2KncaS4c4X7Ln1ZcX2tqbz6b3dFb9vfnPFq78qkDqPDYoap21nLp59I
        jpkh3/HllfTEn2WRB1m1uzbs6+E+qu59eFf5tWWrZKoW6sxsmHjYWPWmaeDiNpaZj7XbZZ5n
        bip6zH5bs9Dg34UDla+UWIozEg21mIuKEwG2JFhxJQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvO6qb0XxBsdeGFpMvHGFxeL6l+es
        Fmeb3rBbXN41h83ic+8RRovbjSvYLM6cvsTqwO6xaVUnm8eWq+0sHn1bVjF6fN4kF8ASxWWT
        kpqTWZZapG+XwJVxdOd91oJtQhV3vyxjaWD8y9fFyMEhIWAisedfbBcjF4eQwA5GiX3397F1
        MXICxSUlpl08ygxRIyxx+HAxRM1bRonXp6ayg9SwCWhJ7H9xA6xeGMje++oKK4jNL6AocfXH
        Y0aQXhEBe4mOD5kgvcwCG5kkztw5wgRSwytgJzHt6HtGEJtFQFVi1sQdYHFRgTCJnUseQ9UI
        Spyc+YQFxGYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGAVnIWmZhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4ILa0djHtWfdA7xMjEwXiIUYKDWUmE1zen
        IF6INyWxsiq1KD++qDQntfgQozQHi5I479dZC+OEBNITS1KzU1MLUotgskwcnFINTN3h6nLN
        OR283ff39j8pZAw/zj35ZGDOPONPKlbnmibtNJPdxTkzmnvqrSNWLhy5YS//GN2v1I+7pKUy
        wfCi0tE373MUX81xPHrg2OyJc1p/T4nYeN5pWbmyge2NzhlCOW/Y+E/pn7a7m7b4yGynL61x
        c94YTuth1v23UeCs0Qe/hisM71pUlj9RzjXlezPD5uf9j/O3CYeVCaac355dfb5Z4OevD5du
        Hv0449ObyuXfmj9dzjw1zSLBU/XJrpenxGeG3GM3sy1SdV397adyDSfrf/0o5ijZpUefWXxj
        4d/vw7Ezy83oquGzMoE1xYeY/BJsDoZkRompJXM8WDJF0ytuW5/C1BLz9dZ9lk8CG5RYijMS
        DbWYi4oTAR3NwAn3AgAA
X-CMS-MailID: 20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15
References: <CGME20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.10-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.10

Best Regards,
Chanwoo Choi


The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.10

for you to fetch changes up to d353d1202b89ab039acd079cd97f7646058ebe11:

  PM / devfreq: tegra30: Improve initial hardware resetting (2020-09-29 17:50:10 +0900)

----------------------------------------------------------------

Detailed description for this pull request:
1. Update devfreq core
-  Until now, devfreq and devfreq-event framework defines the fixed 'devfreq'
and 'devfreq-event' property to get the devfreq/devfreq-event phandle. But,
these property name are not expressing the h/w. So, deprecate the fixed
property name of both 'devfreq' and 'devfreq-event'. But, in order to keep
the backward compatibility of devicetree, doesn't change the property name
on devfreq device drivers and devicetree.

2. Update devfreq driver
- Replace reset_control_(assert|dessert) fucntions with reset_control_reset()
for reseting the h/w during probe on tegra30-devfreq.c.

----------------------------------------------------------------

Chanwoo Choi (2):
      PM / devfreq: Change prototype of devfreq_get_devfreq_by_phandle function
      PM / devfreq: event: Change prototype of devfreq_event_get_edev_by_phandle function

Dmitry Osipenko (1):
      PM / devfreq: tegra30: Improve initial hardware resetting

Leonard Crestez (1):
      PM / devfreq: Add devfreq_get_devfreq_by_node function

 drivers/devfreq/devfreq-event.c         | 14 ++++----
 drivers/devfreq/devfreq.c               | 57 ++++++++++++++++++++++++---------
 drivers/devfreq/exynos-bus.c            |  7 ++--
 drivers/devfreq/rk3399_dmc.c            |  2 +-
 drivers/devfreq/tegra30-devfreq.c       |  8 +++--
 drivers/memory/samsung/exynos5422-dmc.c |  6 ++--
 include/linux/devfreq-event.h           | 14 +++++---
 include/linux/devfreq.h                 | 11 +++++--
 8 files changed, 83 insertions(+), 36 deletions(-)

