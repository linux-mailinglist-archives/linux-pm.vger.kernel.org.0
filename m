Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300CA191DA0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 00:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCXXpf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 19:45:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51672 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXpe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 19:45:34 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200324234531epoutp02ca4da0406592f91630e858fc8a18d0d8~-YitIbUUx2106321063epoutp02J
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 23:45:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200324234531epoutp02ca4da0406592f91630e858fc8a18d0d8~-YitIbUUx2106321063epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585093531;
        bh=cPEoOT/55PEypTYCIUSKLWGTHMtlhHI38aByhNhavak=;
        h=To:Cc:From:Subject:Date:References:From;
        b=LCg3k/VaobUVwGxAtSlpG91rfqc3lB+IKcEvzv+UUsg5rixUi3cXwE/JOxmtukue6
         KADmGxqJBox3faue4JxEV4cswl6iJ1+J1BRszsZw9MHB2U7k9jej7C81gidfOAfrKG
         5k+8PaesVv5koXzB6BDL/WcZpObS5DQaCKxMjef0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200324234531epcas1p371d8fb08a69a80adcc4477882f184339~-Yispv3zk0669306693epcas1p3z;
        Tue, 24 Mar 2020 23:45:31 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48n7Cq6P9dzMqYkb; Tue, 24 Mar
        2020 23:45:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.BE.04160.79B9A7E5; Wed, 25 Mar 2020 08:45:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324234525epcas1p28f4150423112c61645bc19e3742b22bf~-YinjJiAD2642926429epcas1p2K;
        Tue, 24 Mar 2020 23:45:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324234525epsmtrp2e8f852ef0442b6026956bc62258e8caf~-YiniXXCc0725607256epsmtrp2q;
        Tue, 24 Mar 2020 23:45:25 +0000 (GMT)
X-AuditID: b6c32a38-2afff70000001040-a1-5e7a9b9761c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.D0.04024.59B9A7E5; Wed, 25 Mar 2020 08:45:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324234525epsmtip2f2d68676863e37f5bca41ed04ee36409~-YinXQP581161211612epsmtip2D;
        Tue, 24 Mar 2020 23:45:25 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.7
Organization: Samsung Electronics
Message-ID: <21bd6b76-5a3e-96c1-4184-49e96ea5f594@samsung.com>
Date:   Wed, 25 Mar 2020 08:54:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmge702VVxBrMPsVlMvHGFxeL6l+es
        Fmeb3rBbXN41h83ic+8RRovbjSvYLM6cvsTqwO6xaVUnm8eWq+0sHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7492q
        fvaCuwIVnd+XMDYwLuLtYuTkkBAwkVjy9Bh7FyMXh5DADkaJW529bBDOJ0aJVzc3QznfGCXa
        73QywrS8+rgSqmUvo8Tkr49ZIZz3jBI7erqBHA4OEQF7iY4PmSBxZoGTTBLXzn5mBulmE9CS
        2P/iBhuILSygKXF7zicmEJtfQFHi6o/HYBt4Bewk1q17zwpiswioSlx8swGsV1QgTOLkthao
        GkGJkzOfsIDYzALiEreezGeCsOUltr+dwwyyWELgMptEz9JPLCAHSQi4SNz4LgTxgbDEq+Nb
        2CFsKYnP7/ayQdjVEitPHmGD6O1glNiy/wIrRMJYYv/SyUwgc5iBjl6/Sx8irCix8/dcRoi9
        fBLvvvawQqzilehog1qlLHH5wV0mCFtSYnF7J9QqD4mj+3ezTmBUnIXkm1lIvpmF5JtZCIsX
        MLKsYhRLLSjOTU8tNiwwQY7tTYzg1KllsYNxzzmfQ4wCHIxKPLwNjyvjhFgTy4orcw8xSnAw
        K4nwbk6tiBPiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cC0nlcSb2hqZGxsbGFiaGZqaKgk
        zjv1ek6ckEB6YklqdmpqQWoRTB8TB6dUA2O982IHhf+yK3bwrzxT8al6B1e3gO/fOWYunKZM
        s4oNDn8NDAnv81lXF/Jl6aGwmrsLg0w11mhOYG6ovrzTLMRxyvLX6jfnLXP8MPcx68wPjk+X
        HONZmDLtc9W3pI1PrSvny2fUvba49/JBixmnZ0DQjtXuhy8eVjpf57TiynP1/qSgs37X1AuU
        WIozEg21mIuKEwHFcdM0swMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO7U2VVxBofXGVpMvHGFxeL6l+es
        Fmeb3rBbXN41h83ic+8RRovbjSvYLM6cvsTqwO6xaVUnm8eWq+0sHn1bVjF6fN4kF8ASxWWT
        kpqTWZZapG+XwJXxblU/e8FdgYrO70sYGxgX8XYxcnJICJhIvPq4kr2LkYtDSGA3o8SEx1dY
        IRKSEtMuHmXuYuQAsoUlDh8uhqh5yyhxquEiO0hcRMBeouNDJkg5s8BpJok1dxxBbDYBLYn9
        L26wgdjCApoSt+d8YgKx+QUUJa7+eMwIYvMK2EmsW/cebBWLgKrExTcbmEFsUYEwiZ1LHjNB
        1AhKnJz5hAVivrrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg4C0nLLCQts5C0zELSsoCRZRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBEaGnuYLy8JP4QowAHoxIPr9bDyjgh1sSy
        4srcQ4wSHMxKIrybUyvihHhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBa
        BJNl4uCUamBMTj/7kuP7pjq7JYtNuI6cjqstCPoqzSAgFL7tkNijLZ2X0hxnG50KKDZ+F8ts
        97YqTfrzz/x/snYLM6M0TqQt2KUWtLv0mhcT4687payaKb7Xnz2wP68/2em9d4VR5CWDjtzd
        2zluPSzwlK3/W6T6+NcuwXbLdJabU+wrI61v2VYf4Lx1rVmJpTgj0VCLuag4EQBmtjwmhAIA
        AA==
X-CMS-MailID: 20200324234525epcas1p28f4150423112c61645bc19e3742b22bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324234525epcas1p28f4150423112c61645bc19e3742b22bf
References: <CGME20200324234525epcas1p28f4150423112c61645bc19e3742b22bf@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.7-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.7

Best Regards,
Chanwoo Choi

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.7

for you to fetch changes up to 7a51320ecd394202d80131ad7837a72ca2213e64:

  PM / devfreq: Get rid of some doc warnings (2020-03-25 08:35:03 +0900)

----------------------------------------------------------------

Detailed description for this pull request:
1. Update devfreq code with minor issue:
- Remove unneeded extern keyword from devfreq header file.

- Change to DEVFREQ_GOV_UPDATE_INTERNAL event name because
  old DEVFREQ_GOV_INTERNAL name doesn't specify exactly what to do.

- Fix handling code of return value of dev_pm_qos_remove_request().

- Use constant name for userspace governor with DEVFREQ_GOV_USERSPACE.

- Get rid of doc warnings and  fix typo.

----------------------------------------------------------------

Chanwoo Choi (2):
      PM / devfreq: Remove unneeded extern keyword
      PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL event name

Christophe JAILLET (1):
      PM / devfreq: Fix a typo in a comment

Leonard Crestez (1):
      PM / devfreq: Fix handling dev_pm_qos_remove_request result

Mauro Carvalho Chehab (1):
      PM / devfreq: Get rid of some doc warnings

pierre Kuo (1):
      PM / devfreq: Use constant name of userspace governor

 drivers/devfreq/devfreq.c                 |  14 ++--
 drivers/devfreq/governor.h                |  21 +++---
 drivers/devfreq/governor_simpleondemand.c |   4 +-
 drivers/devfreq/governor_userspace.c      |   2 +-
 drivers/devfreq/tegra30-devfreq.c         |   4 +-
 include/linux/devfreq.h                   | 106 +++++++++++++++---------------
 6 files changed, 74 insertions(+), 77 deletions(-)
