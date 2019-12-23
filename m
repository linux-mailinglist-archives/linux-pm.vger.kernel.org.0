Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76901129195
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 06:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWFay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 00:30:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:50618 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfLWFay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 00:30:54 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191223053049epoutp021cebb0f4973f62362a650736c52710ac~i6Qo7Ay5t1210212102epoutp02j
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2019 05:30:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191223053049epoutp021cebb0f4973f62362a650736c52710ac~i6Qo7Ay5t1210212102epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577079049;
        bh=c3/GFKm5pcWHV0q5AiyUNnvGU6F/U8B4ahNnH34AUcs=;
        h=To:Cc:From:Subject:Date:References:From;
        b=IgEth4J49UxN4XJUWB/zlp+uJ8+LpYgV0mQMgOM3NdYpcFN6OQfyta/IDusbF1crE
         o20M9VLSmTVRKy7fFo/smTqKqyJu8aQKeBkhUaAiFeAtmOMmdG1DBykztTUuRMmDAh
         QiPY8usupYzqHgCpCVbx3kXBPFG+Wxp2AbVWgfeo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191223053049epcas1p441d014fe532ca54b3ec9cd98ce7ccc98~i6QogTXq-3151831518epcas1p4j;
        Mon, 23 Dec 2019 05:30:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47h7HB3bNyzMqYkt; Mon, 23 Dec
        2019 05:30:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.86.51241.601500E5; Mon, 23 Dec 2019 14:30:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191223053045epcas1p4bbe1dac8d04e2fbc8fa4a50d42177c2c~i6QlFBrb20720507205epcas1p4J;
        Mon, 23 Dec 2019 05:30:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191223053045epsmtrp2b2f97cf196da3fa5cbc70217c3b1e23a~i6QlEUo2u0505805058epsmtrp2L;
        Mon, 23 Dec 2019 05:30:45 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-2d-5e005106e120
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.25.06569.501500E5; Mon, 23 Dec 2019 14:30:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191223053045epsmtip2be2d39cb8ded509d592dbe242a16a372~i6Qk50Smt0933309333epsmtip2k;
        Mon, 23 Dec 2019 05:30:45 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.c>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq fixes for v5.5-rc4
Organization: Samsung Electronics
Message-ID: <3400e92c-80bd-b2ac-dba0-dfe61d26b1d0@samsung.com>
Date:   Mon, 23 Dec 2019 14:37:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmgS5bIEOcwe5PMhZ9O/+zWpxtesNu
        cXnXHDaLz71HGC1uN65gszhz+hKrA5vHlqvtLB4LF79j9ejbsorR4/MmuQCWqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjD8Tn7MWPOWp
        6Fndz9jAeI6ri5GTQ0LARGLhnF3MXYxcHEICOxglzsx7yQjhfGKUuLz4JxuE8w0os6uLDaZl
        zrmlUIm9jBJfn6yDct4zSmyddB9oGAeHiIC9RMeHTJA4s8AUJokjiw8zgnSzCWhJ7H9xA2yS
        sICexNIzK5lAbH4BRYmrPx6D1fAK2EmsufaCEWQOi4CqxJeOCJCwqECYxMltLVAlghInZz5h
        AbGZBcQlbj2ZzwRhy0tsfzsH7B8JgRNsErcP3maBuNpFoqf3BzuELSzx6vgWKFtK4vO7vVCf
        VUusPHmEDaK5g1Fiy/4LrBAJY4n9SyczgRzELKApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ
        4JXoaBOCKFGWuPzgLhOELSmxuL0TapWHxIQL55kmMCrOQvLOLCTvzELyziyExQsYWVYxiqUW
        FOempxYbFpgix/YmRnDC1LLcwXjsnM8hRgEORiUe3oQ5/2OFWBPLiitzDzFKcDArifDurv0b
        K8SbklhZlVqUH19UmpNafIjRFBjYE5mlRJPzgck8ryTe0NTI2NjYwsTQzNTQUEmcl+PHxVgh
        gfTEktTs1NSC1CKYPiYOTqkGxphmxzVdT/fvOXfCIWJfAFeQ0oH5eg6JUTFfFi1Qf39wP2Pb
        Il7DuFtGV/TuhPBd13/vH1ZQa+We+NZ+ov61N9q1CoeV3l5LXZB5IzKx93/OtdKk/7ZfFUTU
        fTZ8OPPLpMewwfH9yZ8v3GcYa6474bw7cOLm5I3cMkpZpofrNHnsDvF7fknQV2Ipzkg01GIu
        Kk4EAGYhd9+uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvC5rIEOcQcdzeYu+nf9ZLc42vWG3
        uLxrDpvF594jjBa3G1ewWZw5fYnVgc1jy9V2Fo+Fi9+xevRtWcXo8XmTXABLFJdNSmpOZllq
        kb5dAlfGn4nPWQue8lT0rO5nbGA8x9XFyMkhIWAiMefcUrYuRi4OIYHdjBLbbnYyQyQkJaZd
        PApkcwDZwhKHDxdD1LxllNj38gorSFxEwF6i40MmSJxZYAqTxOJpH1hAetkEtCT2v7jBBmIL
        C+hJLD2zkgnE5hdQlLj64zEjiM0rYCex5toLRpA5LAKqEl86IkDCogJhEjuXPGaCKBGUODnz
        CdhIZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRcBaSlllIWmYhaZmFpGUBI8sqRsnUguLc
        9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgONDS2sF44kT8IUYBDkYlHl6OWf9jhVgTy4orcw8x
        SnAwK4nw7q79GyvEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomD
        U6qBsdjEoM3Z+Ufmnu8lss2XW6Lm/fNffEZd+FD2x+4f7ouak7cunFww6/WelBrhF0+TfyXZ
        Cty9obNLWHndr5DDUVbz382sTD9u4r6/pnOvagzDI6er08+lLznrZyB36pawRMHPX6HTps71
        ObGLw3LvuaDa6ZrCYgkncjjjJ9ySM5383VL6aoV4phJLcUaioRZzUXEiAHvQ0m1/AgAA
X-CMS-MailID: 20191223053045epcas1p4bbe1dac8d04e2fbc8fa4a50d42177c2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191223053045epcas1p4bbe1dac8d04e2fbc8fa4a50d42177c2c
References: <CGME20191223053045epcas1p4bbe1dac8d04e2fbc8fa4a50d42177c2c@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-fixes pull request for v5.5-rc4. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-fixes-for-5.5-rc4

Actually, this pull request doesn't need to contain the patch[1]
because patch[1] is not critical and urgent. But, build-fix patch[2]
depends on patch[1]. So, this pull request contains two patches.
If you think that it is not reasonable, please let me know.
[1] PM / devfreq: Drop explicit selection of PM_OPP
[2] PM / devfreq: tegra: Add COMMON_CLK dependency

Regards,
Chanwoo Choi

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.5-rc4

for you to fetch changes up to 5fdb0684b5b0f41402161f068d3d84bf6ed1c3f4:

  PM / devfreq: tegra: Add COMMON_CLK dependency (2019-12-23 10:42:58 +0900)

----------------------------------------------------------------

Update devfreq for 5.5-rc4

Detailed description for this pull request:
1. Fix the build error of tegra*-devfreq.c when COMPILE_TEST is enableda
2. Drop unneeded PM_OPP dependency from each driver in Kconfig.

----------------------------------------------------------------

Arnd Bergmann (1):
      PM / devfreq: tegra: Add COMMON_CLK dependency

Leonard Crestez (1):
      PM / devfreq: Drop explicit selection of PM_OPP

 drivers/devfreq/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
