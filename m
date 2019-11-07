Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7349CF2624
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 04:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfKGD5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 22:57:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32246 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKGD5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:57:13 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191107035709epoutp016cf3f7fce5c25e58f0143cb6679251b2~UxTt6-LJy2843328433epoutp010
        for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2019 03:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191107035709epoutp016cf3f7fce5c25e58f0143cb6679251b2~UxTt6-LJy2843328433epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573099029;
        bh=AWybcpMgrQSTggA9B94xiUoLber9ej/kmw/368T+q2I=;
        h=To:Cc:From:Subject:Date:References:From;
        b=XN0ZsXlc8fY6VDB27p68nPY1XbXUrFjxZNLfxJ6J7RFNS1iITzBjhe1WZMl3GEhJN
         CxUwZ1ZNR7H5sXbtU9P/1u1QLEw5iPwt4qwgyFYhPfub2yia9tCg7a+OEoN5c8hoNh
         kzOCozlRTVSmtMm4pvYODZ5y1FTv6Ge+uiGHezro=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191107035708epcas1p1bc507940ab511496df615c920cea7e5e~UxTtW2pAw1369713697epcas1p1M;
        Thu,  7 Nov 2019 03:57:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 477qNK0dVzzMqYkV; Thu,  7 Nov
        2019 03:57:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.2E.04068.E0693CD5; Thu,  7 Nov 2019 12:57:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191107035701epcas1p237d69dd23f28fde1f52bfc4def529e92~UxTm4D9Ty2381723817epcas1p2P;
        Thu,  7 Nov 2019 03:57:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191107035701epsmtrp12081deac00b4dcef7dc44de3cc5ac9d4~UxTm3OTCx0607506075epsmtrp1d;
        Thu,  7 Nov 2019 03:57:01 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-99-5dc3960ee1ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.1E.25663.D0693CD5; Thu,  7 Nov 2019 12:57:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191107035701epsmtip2af8aecdee3629609c8eb9e37bfa7ecaa~UxTmsF0uE1936119361epsmtip2q;
        Thu,  7 Nov 2019 03:57:01 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.5
Organization: Samsung Electronics
Message-ID: <dcdea33b-472f-c3e5-ed9e-3fae16591f46@samsung.com>
Date:   Thu, 7 Nov 2019 13:02:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvi7ftMOxBo0/rC0m3rjCYnH9y3NW
        i8u75rBZfO49wmhxu3EFm8WZ05dYHdg8Nq3qZPPYcrWdxaNvyypGj8+b5AJYorJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM1pfbGAtOKVV
        0T95CUsD43fFLkZODgkBE4kDv86zdjFycQgJ7GCUOHnnPAtIQkjgE6PE8SMBEIlvjBLfdi5n
        hOlYc28xM0RiL6PErZsvWCCc94wSH7tfA83i4BARsJfo+JAJEmcWmMckce/zJGaQbjYBLYn9
        L26wgdjCApoSX7Z8B4vzCyhKXP3xmBGkl1fATuLLyXSQMIuAisTWxu0sIGFRgQiJ018TQcK8
        AoISJ2c+ATuUWUBc4taT+UwQtrzE9rdzwG6TEDjDJjH17Qc2iKNdJDoeb2KHsIUlXh3fAmVL
        Sbzsb4OyqyVWnjzCBtHcwSixZf8FVoiEscT+pZOZQI5gBrp5/S59iLCixM7fcxkhFvNJvPva
        A/a6hACvREebEESJssTlB3eZIGxJicXtnVDneEi0bvvMNoFRcRaSd2YheWcWkndmISxewMiy
        ilEstaA4Nz212LDAFDmuNzGCk6WW5Q7GY+d8DjEKcDAq8fBmbD4UK8SaWFZcmXuIUYKDWUmE
        N6bvYKwQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgcm8rySeENTI2NjYwsTQzNTQ0MlcV7H
        5UtjhQTSE0tSs1NTC1KLYPqYODilGhhleb1lwpZy/NGs+VhurfOCYSpPn4qvzhH2vZ+XTY6U
        cv69/O2jVxxXNl9/VsucdErEcl+1m5CS2Nu5ugnPa87YWGecUXDb2XS63ubhx/6L4nl3tJ5d
        Lf7Suq4hf9n1RSnvRWP4tZSNzs1gaJtX52D2NvnAI+HypPvzfV82n3q82ikgMOJTg4USS3FG
        oqEWc1FxIgBUhjoLrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvC7vtMOxBuueylpMvHGFxeL6l+es
        Fpd3zWGz+Nx7hNHiduMKNoszpy+xOrB5bFrVyeax5Wo7i0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBltL7YwFpwSquif/ISlgbG74pdjJwcEgImEmvuLWbuYuTiEBLYzSjx/+8rRoiEpMS0
        i0eBEhxAtrDE4cPFEDVvGSWOzv7EBBIXEbCX6PiQCRJnFpjHJPH57VcmkF42AS2J/S9usIHY
        wgKaEl+2fGcGsfkFFCWu/njMCNLLK2An8eVkOkiYRUBFYmvjdhYQW1QgQuL59htgJ/AKCEqc
        nPkELM4soC7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArOQtIyC0nLLCQts5C0LGBkWcUomVpQ
        nJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwHWlo7GE+ciD/EKMDBqMTDm7H5UKwQa2JZcWXu
        IUYJDmYlEd6YvoOxQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZ
        ODilGhinv70n7FXVrHds69cle73rn5wOzLGwZ+rWPsdw8eyhtKyYNC/bydFcuikHxC3PNOt4
        pay49tNxqq+qVuajdSvbnvvxrK90ruFceu7F/osbzwo/vLzJ+6Znd8wEra36DKXXE6JCtMT/
        /LZ1XZsTGb34KuOM4PISU53WeYlCQv47b28Va9L/sVeJpTgj0VCLuag4EQBpSMeAfwIAAA==
X-CMS-MailID: 20191107035701epcas1p237d69dd23f28fde1f52bfc4def529e92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191107035701epcas1p237d69dd23f28fde1f52bfc4def529e92
References: <CGME20191107035701epcas1p237d69dd23f28fde1f52bfc4def529e92@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.5-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.5


When pull the this pull request to linux-pm, auto-merging will happen.
Because of the change of the devfreq git information on patch[1] and
patch[2] add the additional information of exynos_ppmu.h.
But, when I tested it, the auto merging was completed without problem.
If the problem happen, I'll resend the pull request rebased on
the top of 'linux-next' branch instead of Linux 5.4-rc6.

[1] MAINTAINERS: Update myself as maintainer for DEVFREQ subsystem support
- https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c389ec67b7f8e028438643c4af4bbff550192187

[2] include: dt-bindings: add Performance Monitoring Unit for Exynos
- https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-next&id=fcbd8037f7df694aa7bfb7ce82c0c7f5e53e7b7b

Best Regards,
Chanwoo Choi


The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.5

for you to fetch changes up to fee22854c0273569836de2039d9c432ea4df2cfc:

  PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient (2019-11-06 12:04:01 +0900)

----------------------------------------------------------------
Update devfreq for 5.5

Detailed description for this pull request:
1. Update devfreq core
- Check NULL governor in available_governors_show sysfs in order to prevent
  showing the wrong governor information.
- Fix the race condition between devfreq_update_status() and trans_stat_show()
- Add new 'interrupt-driven' flag for devfreq goveror. Each devfreq driver can
  add the their own governor (NIVIDIA Tegra30 ACTMON governor) which is interrupt-driven
  governor. It needs to use the following sysfs interface to get the new polling
  interval in order to change the NVIDIA Tegra30 hardware's polling interval.
  : /sys/class/devfreq/devfreqX/polling_interval
  So, if 'interrupt-driven' flag of devfreq governor is 1, the devfreq governor
  is able to use the 'polling_interval' sysfs interface to get the new polling
  interval value. But, the devfreq core doesn't schedule out the polling work
  for this governor like NVIDIA Tegra30 ACTMON governor.

2. Update devfreq driver
- For exynos-bus.c, remove unused property from dt-binding documentation
- For tegra30-devfreq.c, update the internal behavior like fixing the overflow
  integer issue and clean-up code.

3. Update devfreq-event driver
- For exynos-ppmu.c, add exynos_ppmu.h dt-binding file for 'event-data-type' filed.
  and update dt-binging documentation. Also,  Fix minor coding style.

----------------------------------------------------------------
Dmitry Osipenko (18):
      PM / devfreq: tegra30: Change irq type to unsigned int
      PM / devfreq: tegra30: Keep interrupt disabled while governor is stopped
      PM / devfreq: tegra30: Handle possible round-rate error
      PM / devfreq: tegra30: Drop write-barrier
      PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
      PM / devfreq: tegra30: Use kHz units uniformly in the code
      PM / devfreq: tegra30: Use CPUFreq notifier
      PM / devfreq: tegra30: Move clk-notifier's registration to governor's start
      PM / devfreq: tegra30: Reset boosting on startup
      PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
      PM / devfreq: tegra30: Constify structs
      PM / devfreq: tegra30: Include appropriate header
      PM / devfreq: tegra30: Don't enable already enabled consecutive interrupts
      PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
      PM / devfreq: tegra30: Use kHz units for dependency threshold
      PM / devfreq: Add new interrupt_driven flag for governors
      PM / devfreq: tegra30: Support variable polling interval
      PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient

Kamil Konieczny (1):
      dt-bindings: devfreq: exynos-bus: Remove unused property

Leonard Crestez (2):
      PM / devfreq: Check NULL governor in available_governors_show
      PM / devfreq: Lock devfreq in trans_stat_show

Lukasz Luba (2):
      include: dt-bindings: add Performance Monitoring Unit for Exynos
      Documentation: devicetree: add PPMU events description

Marek Szyprowski (1):
      PM / devfreq: exynos-ppmu: remove useless assignment

Matthias Kaehlcke (1):
      PM / devfreq: Make log message more explicit when devfreq device already exists

 .../bindings/devfreq/event/exynos-ppmu.txt         |  26 +-
 .../devicetree/bindings/devfreq/exynos-bus.txt     |   2 -
 MAINTAINERS                                        |   1 +
 drivers/devfreq/devfreq.c                          |  33 +-
 drivers/devfreq/event/exynos-ppmu.c                |   1 -
 drivers/devfreq/governor.h                         |   3 +
 drivers/devfreq/tegra30-devfreq.c                  | 417 +++++++++++++++------
 include/dt-bindings/pmu/exynos_ppmu.h              |  25 ++
 8 files changed, 386 insertions(+), 122 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
