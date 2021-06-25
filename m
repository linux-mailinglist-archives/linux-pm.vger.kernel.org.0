Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776D33B4210
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFYLGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 07:06:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:57532 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYLGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 07:06:08 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210625110346epoutp04bbe3b8376a2dec681dc390400c366521~LzmW01gsX1224612246epoutp04I
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 11:03:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210625110346epoutp04bbe3b8376a2dec681dc390400c366521~LzmW01gsX1224612246epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624619026;
        bh=qSA7CE5B0fTuLAuGBrmFV7sheZb8ie8/MT7rYYQ+iaw=;
        h=To:Cc:From:Subject:Date:References:From;
        b=qXCOkHLfl9yHtaWAvD5ZLU+ZHvucmql+Z5zPOiz1Kaii8K/fTj2zsaELoGS1SUhHu
         hDcISZeXq8fUfJw5eUHhqwT5AAY/545ktpXT/hISxl8LbfnkffyfqHxWvHoTM32gH/
         Z8lQEzPP1zHWRVC1hKr+Gf5SAnlzBGP2+urtZ7V4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210625110345epcas1p369f65824c86ddb45f66bbed839915a17~LzmWB6mpw0251802518epcas1p3v;
        Fri, 25 Jun 2021 11:03:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GBDdV4zXvz4x9Pw; Fri, 25 Jun
        2021 11:03:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.DE.09551.E08B5D06; Fri, 25 Jun 2021 20:03:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210625110341epcas1p32171bda25f6020b090537e15e763d5eb~LzmSQDL8t1935219352epcas1p3X;
        Fri, 25 Jun 2021 11:03:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210625110341epsmtrp1142e527f455e5893a032e681b99cb043~LzmSPTCdG2779327793epsmtrp1s;
        Fri, 25 Jun 2021 11:03:41 +0000 (GMT)
X-AuditID: b6c32a36-2b3ff7000000254f-73-60d5b80e1dcc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.28.08289.D08B5D06; Fri, 25 Jun 2021 20:03:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210625110341epsmtip2d0b98f150c9f992c1e6376f6356b4f49~LzmSAEopC2210222102epsmtip2N;
        Fri, 25 Jun 2021 11:03:41 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.14
Organization: Samsung Electronics
Message-ID: <b020c243-3175-3e31-8b7c-e1b30572e6d9@samsung.com>
Date:   Fri, 25 Jun 2021 20:22:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmri7fjqsJBks2K1pMvHGFxeL6l+es
        Fmeb3rBbXN41h83ic+8RRovbjSvYLM6cvsTqwO6xaVUnm8eWq+0sHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE749X7
        jYwFHyQq3mx6z9bA+Fu4i5GTQ0LARKLzzxf2LkYuDiGBHYwSR768ZwZJCAl8YpSYdbQEIvGZ
        UWL717lMMB1HX82B6tjFKHHi4EQWCOc9o8Sv7l6gdg4OEQF7iY4PmSBxZoELTBIXN7WxgnSz
        CWhJ7H9xgw3EFgayr11ZCRbnF1CUuPrjMSOIzStgJ/GpG+IMFgFViZbPR9lBbFGBMImT21qg
        agQlTs58wgJiMwuIS9x6Mp8JwpaX2P52DjPIYgmBv+wSbx8chjrbRWLCmrXsELawxKvjW6Bs
        KYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyE8hnzAKaEut36UOEFSV2/p7LCLGYT+Ld
        1x5WkBIJAV6JjjYhiBJlicsP7kKdICmxuL2TDcL2kFg/6xDbBEbFWUjemYXknVlI3pmFsHgB
        I8sqRrHUguLc9NRiwwIj5NjexAhOnVpmOxgnvf2gd4iRiYPxEKMEB7OSCO+jlksJQrwpiZVV
        qUX58UWlOanFhxhNgQE8kVlKNDkfmLzzSuINTY2MjY0tTAzNTA0NlcR5d7IdShASSE8sSc1O
        TS1ILYLpY+LglGpgUnPpTg32K1hdmSA8dcbhXl/epKSaSRYGsWEP6iX0ZP55Bu7xytR38c+T
        sF9QuayQa9furINpdgtWpws1XpGblHHu2LQn7FV7vTaa/GJu6k1U7HWe5H7o68zFrfsnCbPP
        75z0/cjqwHvcwSzc6x7yCJxny8r28l70JY11wr2arT6J/A/mfo/fdMG95++fV/G30o4qNh9c
        erX9Feu/TSyfA65Y3XRlVJ2R1/jGWEh62pEprz8G8cgmsrVOv2lZuJsl9vTDAO1tCuFSGdvK
        vrTXeh2uu+NcrX3c521+tVnD7b4l7sW67jmPv7Bm3y9131lQdPLTTGa3t19WRkfZbWD0qrig
        qh2zbeY89WjGizZKLMUZiYZazEXFiQAgihJLJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvC7vjqsJBu1rjCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mp49X4jY8EHiYo3m96zNTD+Fu5i5OSQEDCROPpqDnsXIxeHkMAORokv8xYw
        QyQkJaZdPApkcwDZwhKHDxdD1LxllNi/9Qc7SFxEwF6i40MmSJxZ4BKTxMYzN9hBetkEtCT2
        v7jBBmILA9nXrqxkBbH5BRQlrv54zAhi8wrYSXzqfg+2i0VAVaLl81GwXlGBMImdSx4zQdQI
        Spyc+YQFxGYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGAVnIWmZhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4JLa0djHtWfdA7xMjEwXiIUYKDWUmE91HL
        pQQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamM5znQ2e
        82z7mcZvH2wams0+mc20yVa4oHRZ/FGW+Drpz2Fea3Nv3Lhpe1ZtqZGz2Gkfg1295740Cc3f
        pdD63pKTdVflJieXozYO7wxPFe77Z35wN+P8NQIlq2Nl2wxEykMOqU9tuqPoaOjqUf1tY/IX
        hk36gl9lNK4uE+6Qm7fwz1xn+Ron8db9nDskT6zqWB0hbFK11H/a1eIHNzaKlX/7dc/0ZrrG
        rubsiYqrmm9ZSX049+7n/2M/lyu3LX0pINNeyDY/03pFVQHL3m0vFrc37BafGfFp5oeXF10k
        DK/Z3furHZ16K+Cl36sZTpdXNAW2//9WU/hqj+j6dsFTE5NEbL9LVlf0RN7icv8/96ESS3FG
        oqEWc1FxIgBoRIND+AIAAA==
X-CMS-MailID: 20210625110341epcas1p32171bda25f6020b090537e15e763d5eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210625110341epcas1p32171bda25f6020b090537e15e763d5eb
References: <CGME20210625110341epcas1p32171bda25f6020b090537e15e763d5eb@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.14-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.14

for you to fetch changes up to 8c37d01e1a86073d15ea7084390fba58d9a1665f:

  PM / devfreq: passive: Fix get_target_freq when not using required-opp (2021-06-24 10:37:35 +0900)

----------------------------------------------------------------
Detailed description for this pull request:

1. Update devfreq core
- Use DEVICE_ATTR_RW macro for devfreq userspace governor

- Add missing error code in devfreq_add_device()

- Fix get_target_freq when not using required-opp

- The 86ad9a24f21e ("PM / devfreq: Add required OPPs support to passive governor")
supported the required-opp property for using devfreq passive governor.
But, 86ad9a24f21e has caused the problem on use-case when required-opp
is not used. So that fix the passive governor for supporting the case of when
required-opp is not used.

2. Update devfreq driver
- Remove unneeded get_dev_status and polling_ms from imx-bus.c because
imx-bus.c doesn't support simple_ondemand.

- Remove unneeded DEVFREQ_GOV_SIMPLE_ONDEMAND dependecy from imx8m-ddrc.c
because it doesn't support simple_ondemand governor.

- Use tegra30-devfreq.c as thermal cooling device
- Convert dt-binding doc style to yaml and add cooling-cells property
information to dt-binding doc for tegra30-devfreq.c
----------------------------------------------------------------

Chanwoo Choi (1):
      PM / devfreq: passive: Fix get_target_freq when not using required-opp

Dmitry Osipenko (3):
      PM / devfreq: tegra30: Support thermal cooling
      dt-bindings: devfreq: tegra30-actmon: Convert to schema
      dt-bindings: devfreq: tegra30-actmon: Add cooling-cells

Dong Aisheng (2):
      PM / devfreq: imx-bus: Remove imx_bus_get_dev_status
      PM / devfreq: imx8m-ddrc: Remove DEVFREQ_GOV_SIMPLE_ONDEMAND dependency

YueHaibing (2):
      PM / devfreq: Add missing error code in devfreq_add_device()
      PM / devfreq: userspace: Use DEVICE_ATTR_RW macro

 .../bindings/arm/tegra/nvidia,tegra30-actmon.txt   |  57 ----------
 .../bindings/devfreq/nvidia,tegra30-actmon.yaml    | 126 +++++++++++++++++++++
 drivers/devfreq/Kconfig                            |   1 -
 drivers/devfreq/devfreq.c                          |   1 +
 drivers/devfreq/governor_passive.c                 |   3 +-
 drivers/devfreq/governor_userspace.c               |  10 +-
 drivers/devfreq/imx-bus.c                          |  14 ---
 drivers/devfreq/tegra30-devfreq.c                  |   1 +
 8 files changed, 135 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
