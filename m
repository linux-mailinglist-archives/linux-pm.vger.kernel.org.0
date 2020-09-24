Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C97276E1D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIXKDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 06:03:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16893 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKDu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 06:03:50 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200924100346epoutp041d9c2e7576ef01f680413e669ff5c6bd~3sBwFIrT51808318083epoutp04V
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 10:03:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200924100346epoutp041d9c2e7576ef01f680413e669ff5c6bd~3sBwFIrT51808318083epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600941826;
        bh=EcZrqdvcHEr3ec5WOK95eQsbOLmFQCqsB45ZWwMXruE=;
        h=To:Cc:From:Subject:Date:References:From;
        b=UQKkpajaT6cu2KpCj54mXJejyP8YvHdAvJj6TjtsX1dCt6+raGIvjc/w5ILx6r71F
         EWrMrwGFGjGShApCx7OsL6LAwyC3D57Mncu/304aooUopolUfPJuVBZvOPZDgL4RH2
         Oo27T2CuReDPuV5t0cze8ZQrNRMSps1b2at9fzbI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200924100346epcas1p263b06f4a8641e144b469252441a28301~3sBve6qaG2423024230epcas1p2e;
        Thu, 24 Sep 2020 10:03:46 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BxrGl4nQ7zMqYkV; Thu, 24 Sep
        2020 10:03:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.D3.09582.FFE6C6F5; Thu, 24 Sep 2020 19:03:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75~3sBsWdlCP3132031320epcas1p4K;
        Thu, 24 Sep 2020 10:03:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200924100342epsmtrp2b0ea2c82296936cb7fa11d952d69eaf3~3sBsVwq883001330013epsmtrp26;
        Thu, 24 Sep 2020 10:03:42 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-e6-5f6c6eff76fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.A0.08604.EFE6C6F5; Thu, 24 Sep 2020 19:03:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200924100342epsmtip14a9d02bd8e0e112894935f53b138579c~3sBsJDTXw2669626696epsmtip1k;
        Thu, 24 Sep 2020 10:03:42 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq fixes for v5.9-rc7
Organization: Samsung Electronics
Message-ID: <2dc9eeae-159e-c886-0278-f3c85d20bab5@samsung.com>
Date:   Thu, 24 Sep 2020 19:16:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmge7/vJx4g/f7FS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdce/j
        EraCJu6KI6d+MzcwtnN2MXJwSAiYSPR2OXUxcnEICexglDjZvowZwvnEKLF99iomCOcbo8TO
        KSuAMpxgHWu/r2eFSOxllDj06TgjhPOeUeLLwR52kLkiAvYSHR8yQeLMAheYJC5uamMF6WYT
        0JLY/+IGG4gtLKAncfN1OxOIzS+gKHH1x2NGkF5eATuJuZOFQMIsAqoSe85dZQGxRQXCJE5u
        a2EEsXkFBCVOznwCFmcWEJe49WQ+E4QtL7H97RywFyQE/rJLTHg1lQXiTxeJrqm8EA8IS7w6
        voUdwpaS+PxuLxuEXS2x8uQRNojeDkaJLfsvsEIkjCX2L53MBDKHWUBTYv0ufYiwosTO33MZ
        IfbySbz72sMKsYpXoqNNCKJEWeLyg7tMELakxOL2TqhVHhKdM9ezT2BUnIXkm1lIvpmF5JtZ
        CIsXMLKsYhRLLSjOTU8tNiwwRo7rTYzgtKllvoNx2tsPeocYmTgYDzFKcDArifDeUMuOF+JN
        SaysSi3Kjy8qzUktPsRoCgzficxSosn5wMSdVxJvaGpkbGxsYWJoZmpoqCTO+/CWQryQQHpi
        SWp2ampBahFMHxMHp1QD0zRDRxMd7/53uxpXZT2qeLzDIHr2XP+iOfvvqzOKTlyxYHfQCrP0
        IIclOnszYx4yzKvIme1fecn2bvNh5SPrAn2+xwq+v1Lbu29yYPat25vfHt3S2v47op9ZpveX
        1eWMog/MTtYZHjt5I+q2lR56vv4YU/upqY6nNihbrX7F9c/aPedb5U6by1wvJXwtmHlu/FLl
        K98zIf64fYaxYvUv1bSrCpUTNSb43v4ppByt46bD9lFc3yr4fOftX58sT7hrSpW2fJjRdarx
        ep1mVMDzosbQjlWzWjINjumqe1kpTp+3RV9Q3f+d+u3TffPm31oQOmlXv3DQJY5LIs0qcncj
        jl39KvGd+53d/Y0mk6Q+KLEUZyQaajEXFScCAPwwKdMkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO6/vJx4g61TTS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mq493EJW0ETd8WRU7+ZGxjbObsYOTkkBEwk1n5fz9rFyMUhJLCbUeLglsuM
        EAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZSYuO8tWFxEwF6i40MmSJxZ4BKTxMYzN9hBetkEtCT2
        v7jBBmILC+hJ3HzdzgRi8wsoSlz98ZgRpJdXwE5i7mQhkDCLgKrEnnNXWUBsUYEwiZ1LHoOV
        8woISpyc+QQsziygLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs5C0jILScssJC2zkLQsYGRZ
        xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHBFamjsYt6/6oHeIkYmD8RCjBAezkgjv
        DbXseCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJpCeWpGanphakFsFkmTg4pRqY+CL3
        hEnKTlz3L2hmZGqgUIv6aVXWCptLnu31s0Qff5o2oT9TbF/31nnzX/BGSl5i8fjTu3eRbMT9
        At+WJwd33+dbxqmxwPP/JcHPm5M0HdbqnG/bnsWSbXXpWPEqpVMXPoR91kv4WbOoYPs0aSOX
        tX7Fv1UXep/PCjV5v7WxaMX6E02Bbhv/SGz+93bK58+9qq4tRisiKyfkPuzb+elXw7vHlu1J
        IjZa3S1JEvN/Xqz6tOzbiXTXyhd3bj3l+XVx9VrH1gzeNrfL04NOsh67ep4hr9NQ16D6mfOG
        RkUVsaLLs9y5pDRC42uNZ3G6usb/vthuN0nE6Jp65vV8IYZ2o/QQed3Exz+rtq20NE5WYinO
        SDTUYi4qTgQAsYhVafcCAAA=
X-CMS-MailID: 20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75
References: <CGME20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.9-rc7. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-fixes-for-5.9-rc7

Best Regards,
Chanwoo Choi

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.9-rc7

for you to fetch changes up to 6bf560766a8ef5afe4faa3244220cf5b3a934549:

  PM / devfreq: tegra30: Disable clock on error in probe (2020-09-23 13:35:58 +0900)

----------------------------------------------------------------

Update devfreq for 5.9-rc7

Detailed description for this pull request:
1. Update devfreq core
- Add missing timer type to devfreq_summary debugfs node.

2. Fix issue of devfreq device driver
- Fix the exception handling about clock on tegra30-devfreq.c

----------------------------------------------------------------
Chanwoo Choi (1):
      PM / devfreq: Add timer type to devfreq_summary debugfs

Dan Carpenter (1):
      PM / devfreq: tegra30: Disable clock on error in probe

 drivers/devfreq/devfreq.c         | 11 ++++++++---
 drivers/devfreq/tegra30-devfreq.c |  4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)
 
 
