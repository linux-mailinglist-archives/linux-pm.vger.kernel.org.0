Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3C357C2D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 08:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhDHGMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 02:12:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20605 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDHGMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 02:12:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210408061204epoutp02a5050ddd05486a6c43f8d030dbd34464~zzTZmiKuf2433124331epoutp02-
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 06:12:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210408061204epoutp02a5050ddd05486a6c43f8d030dbd34464~zzTZmiKuf2433124331epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617862324;
        bh=fekVOjDvvz+FINWicYu+XcKH+bARMLDdV5/NPFDoKIo=;
        h=From:Subject:To:Cc:Date:References:From;
        b=jReDeOiqZn1xlyStfsbJi76/a39yPrvSgbZTgfXPpDzakJLZn7VBezjlO/BKgtFZK
         V7rOf4TED8JK0AY3uVLP73hHyH8GRaLnUCkb7aZgoUkOdX/4cNcn1whWB5gHVRkJ65
         4ATrnRexxRjcKXLFTucs0LCGyKomkREk5sRx0w94=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210408061203epcas1p3c56b46c45a47233f8a4fff2d91818f31~zzTYh3iPJ2547725477epcas1p3b;
        Thu,  8 Apr 2021 06:12:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FG9rs1DGXz4x9Q6; Thu,  8 Apr
        2021 06:11:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.11.23820.9AE9E606; Thu,  8 Apr 2021 15:11:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210408061152epcas1p195531dcfe84ab8d4a8f15f7d550993cf~zzTN4T5YK0312803128epcas1p1o;
        Thu,  8 Apr 2021 06:11:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210408061152epsmtrp1ae0463c68d46cb580616727271965fd8~zzTN3G2pn3268332683epsmtrp1w;
        Thu,  8 Apr 2021 06:11:52 +0000 (GMT)
X-AuditID: b6c32a37-0031da8000015d0c-6f-606e9ea9ed6c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.93.08745.7AE9E606; Thu,  8 Apr 2021 15:11:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210408061151epsmtip2d3d5832d0994d5b43c2f96bd4a194cc3~zzTNmGE6N0146601466epsmtip2P;
        Thu,  8 Apr 2021 06:11:51 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.13
Organization: Samsung Electronics
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        chanwoo@kernel.org, cwchoi00@gmail.com,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Message-ID: <3d4f6d28-5d8e-df33-882e-0e5dafe575b9@samsung.com>
Date:   Thu, 8 Apr 2021 15:29:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmnu7KeXkJBt8m8FlMvHGFxeL6l+es
        Fs+OalucbXrDbnF51xw2i8+9RxgtbjeuYLM4c/oSqwOHx85Zd9k9Nq3qZPPYcrWdxaNvyypG
        j8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoY
        GJkCFSZkZ3zfOp+t4IpcRduWlAbGiRJdjJwcEgImEj3v57F2MXJxCAnsYJTY8WwilPOJUeLU
        59csEM5nRonPS/+ww7R8/v4bqmoXo8T+Y2uYIJz3jBLzdu9nBKliE9CS2P/iBhuILQxkH+78
        zwpi8wsoSlz98RiohoNDRMBeouNDJkgvs8A+JomtX1czg9TwCthJLPy5DWgoOweLgIrEvDqQ
        qKhAmMTJbS2MEBWCEidnPmEBsZkFxCVuPZnPBGHLSzRvnc0McWcnh8SyLYkQtovEvba7UPcL
        S7w6vgXKlpJ42d8GZVdLrDx5hA3kHAmBDkaJLfsvsEIkjCX2L53MBHIys4CmxPpd+hBhRYmd
        v+cyQuzlk3j3tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZONgjbQ+Lapc2sExgVZyH5ZhaS
        b2Yh+WYWwuIFjCyrGMVSC4pz01OLDQuMkaN6EyM4jWqZ72Cc9vaD3iFGJg7GQ4wSHMxKIrw7
        erMThHhTEiurUovy44tKc1KLDzGaAkN3IrOUaHI+MJHnlcQbmhoZGxtbmBiamRoaKonzJhk8
        iBcSSE8sSc1OTS1ILYLpY+LglGpgSj/8x7NCqleUZ6foRuVu+X15gSVLpQ6UukwwFSv2Vbs0
        v89D7XqnT+dTrRlaJm21+ju1DtxdGLu1RjuTac0XseZIwZnzuFfsXjcr+1JQ5OZri/v3OE3N
        qGRKmX9qsVXXtnWbfGpF1YKfHjzldud3hM593q27Xk0T3vNacFqR0p2gvthNv3tOKdnmsP2P
        0aor6P06q4eZL3bVCb4Vjk83z7mT2BR86M9G5anXnpTt3Sm1/55quYN+WuSGlg/ng8ydK9xt
        OWPaE58Upr9wnn4mxS/T7MjOPblvH9n/crFOqSkO8f12/uGi9oXXLi7c+Obx97BHTYtn6dz1
        7Vk3X73qk5PLYqW0q/dlBLXdi49OVGIpzkg01GIuKk4EALEpv+MsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO7yeXkJBkeuWVhMvHGFxeL6l+es
        Fs+OalucbXrDbnF51xw2i8+9RxgtbjeuYLM4c/oSqwOHx85Zd9k9Nq3qZPPYcrWdxaNvyypG
        j8+b5AJYo7hsUlJzMstSi/TtErgyvm+dz1ZwRa6ibUtKA+NEiS5GTg4JAROJz99/s3YxcnEI
        CexglDh+eAI7REJSYtrFo8xdjBxAtrDE4cPFEDVvGSW2Ni9lA6lhE9CS2P/iBpgtDGQf7vzP
        CmLzCyhKXP3xmBGkV0TAXqLjQyZIL7PAPiaJTYePM4PU8ArYSSz8uY2pi5Gdg0VARWJeHUhU
        VCBMYueSx0wQFYISJ2c+YQGxmQXUJf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj4CwkLbOQtMxC
        0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB8aGltYNxz6oPeocYmTgY
        DzFKcDArifDu6M1OEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyW
        iYNTqoEpVGmeseSBkpLJlXyGVztjTxcG5LMtiO31/cecX3bcXGJXktGfHWXiPEnlrrV/TN+4
        +m1b8D1MuPDKIsci0SarvLYMyzXzrbms/1zZmxVup2GSxfphru3NOQ+b8xb279c75tBw5vDz
        uQzbBU4ECnbc8japK1/Vxfk3JXPLypce8v8mLf4Rqb7RofLQFyndazwGJxy4az4d1b/u2fim
        UaynvOfQwrbOozdjrJynheu8Fz/W5HV+R1RmzwLt0sBy9vNrdk1OO/nBsvqFWlfyvhXpS3R4
        ZIROXi+Y8apV39zCdcJln9wjn/fs1N/36Zu8xrN9NxU+LeuWsElrK185M1+7MXK24vrAYH/H
        3VuP/FdiKc5INNRiLipOBAC+HgD9/gIAAA==
X-CMS-MailID: 20210408061152epcas1p195531dcfe84ab8d4a8f15f7d550993cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210408061152epcas1p195531dcfe84ab8d4a8f15f7d550993cf
References: <CGME20210408061152epcas1p195531dcfe84ab8d4a8f15f7d550993cf@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.13-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.12

This pull request contains the immutable branch to keep the immutable patch[1]
between devfreq and drm for gpu driver.
[1] https://patchwork.kernel.org/project/linux-pm/patch/20210308133041.10516-1-daniel.lezcano@linaro.org/

Best Regards,
Chanwoo Choi


The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.13

for you to fetch changes up to 0a7dc8318c2817fb33dc50946f7ca6e0ff28f036:

  PM / devfreq: imx8m-ddrc: Remove unneeded of_match_ptr() (2021-04-08 13:14:51 +0900)

----------------------------------------------------------------
Detailed description for this pull request:
1. Update devfreq core
- Register devfreq as a cooling device when adding devfreq device
basically if the flag of devfreq device is set as cooling device.

- Add missing unlock opeation in devfreq_add_device

- Use the next frequency as resume_freq instead of previous frequency
  when using opp-suspend property

- Check whether .get_dev_status in struct devfreq_dev_profile is
implemented or not by devfreq driver before calling .get_dev_status
function.

2. Update devfreq driver
- Use dev_err_probe to simplify the error handling on rk3399_dmc.c

- Remove unused .get_dev_status function on imx8m-ddrc.c because
imx8m_ddrc_get_dev_status has not returend the any current status of
device.

- Remove unneeded of_match_ptr() from imx-bus.c and imx8m-ddrc.ca

- Add missing phandle informatioon and replace undefined variable
with integer value for rk3399_dmc.txt devicetree binding document.

3. Update minor issue
- Fix the wrong set_freq path of userspace governor in drivers/devfreq/Kconfig
- Remove the invalid description from .get_target_freq in struct
devfreq_dev_profile
----------------------------------------------------------------
Chanwoo Choi (1):
      Merge branch 'immutable-devfreq-v5.13-rc1' into devfreq-next

Daniel Lezcano (1):
      PM / devfreq: Register devfreq as a cooling device on demand

Dong Aisheng (5):
      PM / devfreq: Use more accurate returned new_freq as resume_freq
      PM / devfreq: Fix the wrong set_freq path for userspace governor in Kconfig
      PM / devfreq: Check get_dev_status in devfreq_update_stats
      PM / devfreq: Remove the invalid description for get_target_freq
      PM / devfreq: imx8m-ddrc: Remove imx8m_ddrc_get_dev_status

Enric Balletbo i Serra (1):
      dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.

Fabio Estevam (2):
      PM / devfreq: imx-bus: Remove unneeded of_match_ptr()
      PM / devfreq: imx8m-ddrc: Remove unneeded of_match_ptr()

Gaël PORTAY (1):
      dt-bindings: devfreq: rk3399_dmc: Remove references of unexistant defines

Krzysztof Kozlowski (1):
      PM / devfreq: rk3399_dmc: Simplify with dev_err_probe()

Lukasz Luba (1):
      PM / devfreq: Unlock mutex and free devfreq struct in error path

 Documentation/ABI/testing/sysfs-class-devfreq      |  5 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 75 +++++++++++-----------
 drivers/devfreq/Kconfig                            |  2 +-
 drivers/devfreq/devfreq.c                          | 14 +++-
 drivers/devfreq/governor.h                         |  5 +-
 drivers/devfreq/imx-bus.c                          |  2 +-
 drivers/devfreq/imx8m-ddrc.c                       | 16 +----
 drivers/devfreq/rk3399_dmc.c                       | 20 ++----
 include/linux/devfreq.h                            |  9 +++
 9 files changed, 70 insertions(+), 78 deletions(-)
