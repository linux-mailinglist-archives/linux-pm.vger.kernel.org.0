Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE414032A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 05:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgAQEwo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 23:52:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34142 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAQEwn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 23:52:43 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200117045241epoutp016f83d983b648068b3988801c4318cf9c~qk3e92cS-1497114971epoutp01-
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 04:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200117045241epoutp016f83d983b648068b3988801c4318cf9c~qk3e92cS-1497114971epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579236761;
        bh=VALNIWQroewRPbnoUT/6LXcwDjWm+lp+l2wg6JToJFw=;
        h=To:Cc:From:Subject:Date:References:From;
        b=pkmwDxUHsRuy11Azv3sPnbefL1+qRiWXBVGh4ofFBZClQRENwPcMBJQ7slokYi71Q
         fgbThKhpMqhT1+djCqY6WuBAJGyNlWwE1Mh8rR16k+XjdoHC+OhCRzwXC+BlWkScop
         ekZviR8TtuEHuVz7WdTTkif198IirDUmxIa9WNR8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200117045241epcas1p3a70a301cbf8eacbbc86d328d7ff72367~qk3eanL841694616946epcas1p3-;
        Fri, 17 Jan 2020 04:52:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47zTFd4W9KzMqYkn; Fri, 17 Jan
        2020 04:52:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.42.57028.29D312E5; Fri, 17 Jan 2020 13:52:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200117045233epcas1p4ec7b610173ad1536e340fd83aea3e4ed~qk3XgHScK1939819398epcas1p4h;
        Fri, 17 Jan 2020 04:52:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117045233epsmtrp21933c428c777cb3e670b878f0e8629cd~qk3XeUrUN0944409444epsmtrp2V;
        Fri, 17 Jan 2020 04:52:33 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-ba-5e213d9231e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.26.10238.19D312E5; Fri, 17 Jan 2020 13:52:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117045233epsmtip23ac94f1403d0a23695a3155911d8ed7c~qk3XTgv0v0966009660epsmtip2c;
        Fri, 17 Jan 2020 04:52:33 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.6
Organization: Samsung Electronics
Message-ID: <ddb60cb0-5e54-3ed9-4d61-3098cc2d71d9@samsung.com>
Date:   Fri, 17 Jan 2020 13:59:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmvu4kW8U4g1+7BC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdcbfz
        JUvBJrWK00fOMzYwLpLtYuTgkBAwkZjbEtHFyMUhJLCDUeLTyUNMEM4nRokdfbPYIZxvjBJT
        Nm1k7WLkBOtYefc3I0RiL6NEz+02NgjnPaPE6r+HGEHmigjYS3R8yASJMwtcYJLYv+U+O0g3
        m4CWxP4XN9hAbGEBTYmDCx8xg9j8AooSV388ZgSxeQXsJB4s2AAWZxFQlXi7dwULiC0qECZx
        clsLVI2gxMmZT8DizALiEreezGeCsOUlmrfOZgZZLCFwmU3ixYt3UGe7SGyfPpUFwhaWeHV8
        CzuELSXx+d1eNgi7WmLlySNsEM0djBJb9l+AajaW2L90MhPIZ8xAV6/fpQ8RVpTY+XsuI8Ri
        Pol3X3tYIYHKK9HRJgRRoixx+cFdJghbUmJxeyfUKg+J5Wcfs0xgVJyF5J1ZSN6ZheSdWQiL
        FzCyrGIUSy0ozk1PLTYsMESO7U2M4NSpZbqDcco5n0OMAhyMSjy8M4IU4oRYE8uKK3MPMUpw
        MCuJ8J6cIRsnxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBaT2vJN7Q1MjY2NjCxNDM1NBQ
        SZx3ugvQHIH0xJLU7NTUgtQimD4mDk6pBsbj9Te3+mrOCq8L7Lwm/Piv+aObfs3C0gYMSx5P
        jzQrZ1t3WvJn4e1LJyWEpU/FeGl/1UzdvXKD6J81QisOzY0r5LJ7dOJX0Nl68cPi83jrdlc0
        f9md9W+nQErSrqkPfrec3tIq+OepqUp63i8r9SeCPs1vV+l/b/2akrS8+/MtF46Im3ePqvIp
        sRRnJBpqMRcVJwIAwZlCqrMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO5EW8U4g/XdOhYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eJ24wo2izOnL7E6sHtsWtXJ5rHlajuLR9+WVYwenzfJBbBEcdmk
        pOZklqUW6dslcGXc7XzJUrBJreL0kfOMDYyLZLsYOTkkBEwkVt79zdjFyMUhJLCbUWJj2xk2
        iISkxLSLR5m7GDmAbGGJw4eLIWreMkpMbZnMBBIXEbCX6PiQCRJnFrjEJDHr1ycWkF42AS2J
        /S9ugM0RFtCUOLjwETOIzS+gKHH1x2NGEJtXwE7iwYINYHEWAVWJt3tXgPWKCoRJ7FzymAmi
        RlDi5MwnYHFmAXWJP/MuMUPY4hK3nsxngrDlJZq3zmaewCg4C0nLLCQts5C0zELSsoCRZRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBMaGnuYLy8JP4QowAHoxIP74wghTgh1sSy
        4srcQ4wSHMxKIrwnZ8jGCfGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1
        CCbLxMEp1cAYLzKlM3LebnZHS/aV5UeO2onl66q8zZ7jMtv0yktt9XyuaIHwtTmBOz8vN3fz
        LHW+5OGZP8258T9by+WDdxSiXCz8JU9W8Dyc9kXB2zInofGjqNIEY8Psf8/m+ymcvuS36LYk
        S3Ktv9csaW6BuTPMDlgvNw/6VBWdMqGP47rZg4CAJ4eeFCuxFGckGmoxFxUnAgAzQi1AhQIA
        AA==
X-CMS-MailID: 20200117045233epcas1p4ec7b610173ad1536e340fd83aea3e4ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200117045233epcas1p4ec7b610173ad1536e340fd83aea3e4ed
References: <CGME20200117045233epcas1p4ec7b610173ad1536e340fd83aea3e4ed@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.6-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.6

Best Regards,
Chanwoo Choi


The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.6

for you to fetch changes up to 490a421bc575d1bf391a6ad5b582dcfbd0037724:

  PM / devfreq: Add debugfs support with devfreq_summary file (2020-01-16 19:14:49 +0900)

----------------------------------------------------------------
Detailed description for this pull request:
1. Update devfreq core
- Add new 'name' attribute of sysfs to show the device name
  : /sys/class/devfreq/devfreqX/name

- Make 'trans_stat' sysfs resetting by entering zero(0) as following
  : echo 0 > /sys/class/devfreq/devfreqX/trans_stat

- Add debugfs support with 'devfreq_summary' file to show the summary
  : /sys/kernel/debug/devfreq/devfreq_summary

- Change the type of time variable to 64bit to prevent the overflow
- Make the separate devfreq_stats including the statistics information
- Fix the minor coding-style like indentation and kernel-doc warnings

2. Update devfreq driver
- Add new imx8m-ddrc.c devfreq driver for dynamic scaling of DDR frequency.
  It changes the DDR frequency by using ARM SMCCC(SMC Calling Convention)
  interface to control TF-A firmware.

- Add COMPILE_TEST dependency for rk3399_dmc.c

- Clean-up code for exynos-bus.c and rk3399_dmc.c without behavior changes

3. Update devfreq-event driver
- Fix excessive stack usage of exynos-ppmu.c and clean-up code of
  rockchip-dfi.c without behavior changes
----------------------------------------------------------------

Arnd Bergmann (1):
      PM / devfreq: exynos-ppmu: Fix excessive stack usage

Artur Świgoń (3):
      PM / devfreq: exynos-bus: Extract exynos_bus_profile_init()
      PM / devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
      PM / devfreq: exynos-bus: Reduce goto statements and remove unused headers

Chanwoo Choi (3):
      PM / devfreq: Add new name attribute for sysfs
      PM / devfreq: rk3399_dmc: Add COMPILE_TEST and HAVE_ARM_SMCCC dependency
      PM / devfreq: Add debugfs support with devfreq_summary file

Kamil Konieczny (4):
      PM / devfreq: Change time stats to 64-bit
      PM / devfreq: Add clearing transitions stats
      PM / devfreq: Move statistics to separate struct devfreq_stats
      PM / devfreq: Move declaration of DEVICE_ATTR_RW(min_freq)

Krzysztof Kozlowski (2):
      PM / devfreq: Fix Kconfig indentation
      PM / devfreq: exynos: Rename Exynos to lowercase

Leonard Crestez (3):
      dt-bindings: memory: Add bindings for imx8m ddr controller
      PM / devfreq: Add dynamic scaling for imx8m ddr controller
      PM / devfreq: imx8m-ddrc: Remove unused defines

Randy Dunlap (1):
      PM / devfreq: Fix multiple kernel-doc warnings

Yangtao Li (6):
      PM / devfreq: rockchip-dfi: Add missing of_node_put()
      PM / devfreq: rk3399_dmc: Add missing of_node_put()
      PM / devfreq: rockchip-dfi: Convert to devm_platform_ioremap_resource
      PM / devfreq: rk3399_dmc: Disable devfreq-event device when fails
      PM / devfreq: exynos-bus: Disable devfreq-event device when fails
      PM / devfreq: exynos-bus: Add error log when fail to get devfreq-event

YueHaibing (1):
      PM / devfreq: imx8m-ddrc: Fix inconsistent IS_ERR and PTR_ERR

 Documentation/ABI/testing/sysfs-class-devfreq      |  18 +-
 .../memory-controllers/fsl/imx8m-ddrc.yaml         |  72 ++++
 drivers/devfreq/Kconfig                            |  21 +-
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq-event.c                    |   4 +-
 drivers/devfreq/devfreq.c                          | 166 +++++++-
 drivers/devfreq/event/Kconfig                      |   6 +-
 drivers/devfreq/event/exynos-nocp.c                |   2 +-
 drivers/devfreq/event/exynos-nocp.h                |   2 +-
 drivers/devfreq/event/exynos-ppmu.c                |  15 +-
 drivers/devfreq/event/exynos-ppmu.h                |   2 +-
 drivers/devfreq/event/rockchip-dfi.c               |   5 +-
 drivers/devfreq/exynos-bus.c                       | 155 ++++---
 drivers/devfreq/imx8m-ddrc.c                       | 471 +++++++++++++++++++++
 drivers/devfreq/rk3399_dmc.c                       |  19 +-
 include/linux/devfreq.h                            |  29 +-
 16 files changed, 856 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
 create mode 100644 drivers/devfreq/imx8m-ddrc.c
