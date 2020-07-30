Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F832232ECF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgG3ImI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:42:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45572 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgG3ImH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 04:42:07 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200730084202epoutp04e89820aa25444153412d08c1daca758c~meyZVSnRX0624706247epoutp04B
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 08:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200730084202epoutp04e89820aa25444153412d08c1daca758c~meyZVSnRX0624706247epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596098522;
        bh=EXg3xl1A+ZJhPcxi9vTn8kiMuMK7HtwFSMB4Ih/vRm8=;
        h=To:Cc:From:Subject:Date:References:From;
        b=ln8RMCPavV5kK5ufHUMkSfT+5vxHaDw4orVG439ZeQIZktylswhiSPpWCY0YZcZWS
         85agxEJfdoKNJIducKEmJdoawmnvO1FEAQwTiEfkGMqF/v6Yjm7qs/Oq6Ak//AGBKN
         PmYcmITVOSGxgQnTqkSeMXWLh7x1KRWxO4JNOGCI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200730084201epcas1p2e004212e92166f74a1fc8927d08b3aac~meyYlAgcM0047600476epcas1p2o;
        Thu, 30 Jul 2020 08:42:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BHP6G4YpzzMqYkq; Thu, 30 Jul
        2020 08:41:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.1E.28581.3D7822F5; Thu, 30 Jul 2020 17:41:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200730084154epcas1p478b744a64f99618541818c1977c88fc9~meyRw_CPq2244622446epcas1p4a;
        Thu, 30 Jul 2020 08:41:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200730084154epsmtrp29db792bedec64e6a62b4e2aa85cd9c4a~meyRwTF5V1696416964epsmtrp2r;
        Thu, 30 Jul 2020 08:41:54 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-85-5f2287d3d064
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.B4.08382.2D7822F5; Thu, 30 Jul 2020 17:41:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200730084154epsmtip2bf1d9a5325df0f3c2a39649d21e2caa9~meyRfUlfz3040830408epsmtip2c;
        Thu, 30 Jul 2020 08:41:54 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?64KY7ISx6rWt?= <sungguk.na@samsung.com>,
        =?UTF-8?B?6rmA7Iq57Jqw?= <sw0312.kim@samsung.com>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.9
Organization: Samsung Electronics
Message-ID: <6bf6b502-44ef-ea50-27f6-235a8ce96c1d@samsung.com>
Date:   Thu, 30 Jul 2020 17:53:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmge7ldqV4g6fL9Cyuf3nOanG26Q27
        xeVdc9gsPvceYbS43biCzeLM6UusFjvmHWS0mDH5JZsDh8eWq+0sHn1bVjF6fN4kF8AclW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y9HJ
        bSwFZ+Qr2vbdZGxgPCPRxcjJISFgItF0dB0riC0ksINRYkY3I4T9iVFi9m25LkYuIPsbo0T3
        gpVMMA27f69igUjsZZT4uOA8K4TznlFi5v4VQBkODhEBe4mOD5kgcWaBbcwSRzc2sYN0swlo
        Sex/cYMNxBYW0JRom7wRbB2/gKLE1R+PwWxeATuJ5hvnwWwWAVWJO1vXgdWLCoRJnNzWAlUj
        KHFy5hMWEJtZQFzi1pP5TBC2vMT2t3OYIS79yy5x5mw1hO0i8Xr+RxYIW1ji1fEt7BC2lMTn
        d3vZIOxqiZUnj7CBHC0h0MEosWX/BVaIhLHE/qWTmUAeYwY6ev0ufYiwosTO33MZIfbySbz7
        2sMKUiIhwCvR0SYEUaIscfnBXWjASUosbu9kgyjxkJjcZjWBUXEWkmdmIXlmFpJnZiHsXcDI
        sopRLLWgODc9tdiwwAQ5qjcxgpOmlsUOxrlvP+gdYmTiYDzEKMHBrCTC286lEC/Em5JYWZVa
        lB9fVJqTWnyI0RQYvBOZpUST84FpO68k3tDUyNjY2MLE0MzU0FBJnPfhLaAmgfTEktTs1NSC
        1CKYPiYOTqkGpraNVxbIlzLUrXi//vodnUa1x2LqGW86Lq04fkNNsFTtqPbHDZtOTtU/KK6b
        v+lCVND2HvZQEdP5vXqVTf8vnzR6maE+a2mFqk/L270eUVypTwwZbhs+iapd+m561q05i3nj
        NZNmfY3+GXOigq3rg9D0XrY/HrFtpV5OoRMsJvyUcmmt1Yjt5Pr6u7OjueFzEPNN3aOC7tE7
        w25/kC49ce7Vhg0Pe084xWmwt7/Z2tp47dinp6LtH9gYi+S49K28bMKT60K2V7IU9KWxeNy5
        sr7xyorfn9c+K1jyrsL5zqt1CwN1/baK8XOXR8amxJ6PecalO2X2M/9N57cI+Unnn9gWaGlf
        W38i1vX01y/flViKMxINtZiLihMB6RmjyyMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO6ldqV4g+XrBS2uf3nOanG26Q27
        xeVdc9gsPvceYbS43biCzeLM6UusFjvmHWS0mDH5JZsDh8eWq+0sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJWx6OQ2loIz8hVt+24yNjCekehi5OSQEDCR2P17FUsXIxeHkMBuRolpDavZ
        IBKSEtMuHmXuYuQAsoUlDh8uhqh5yyixestZRpC4iIC9RMeHTJA4s8A2ZomJDyczg/SyCWhJ
        7H9xA2yOsICmRNvkjYwgNr+AosTVH4/BbF4BO4nmG+fBbBYBVYk7W9eB1YsKhEnsXPKYCaJG
        UOLkzCcsIDazgLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg4C0nLLCQts5C0zELSsoCRZRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBMaGnuYNy+6oPeIUYmDsZDjBIczEoivO1c
        CvFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1MLGfnhgs
        +LjtgSAnM/fTv19l9h/l1+uI4vn6vz+1XlbpCMfuLj/JNwe3/Eq33yIcdnwS77kuBrGS47e/
        3Lq9LJwxVGrhHIOotKuK9bxdDJWXf0lOnfvwkv60tGlz9m74k2t6+sUH+Y3XK122zI3NPO3w
        4cyN9ij258+b9go+nRKpw1Kr9fF/0cyw1K5NM/9tVpgba8Pd/ES8fnHSmmXGV5L2We41EJ64
        hb+D85wrX/WtPRfqToftPHFjR+kVnpXbRdQlJ673KLH5YLPNYMtB/3Vs9uuf6P5hy56+k3nT
        u8hfMjHzAh8ubldSkOd6uk7Oi2vmGve+a9ez1KNCFXg2Rh3yfNLFKyDh4XNc5trL0+5KLMUZ
        iYZazEXFiQBJ9hB1+AIAAA==
X-CMS-MailID: 20200730084154epcas1p478b744a64f99618541818c1977c88fc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200730084154epcas1p478b744a64f99618541818c1977c88fc9
References: <CGME20200730084154epcas1p478b744a64f99618541818c1977c88fc9@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.9-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.9

Best Regards,
Chanwoo Choi


The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.9

for you to fetch changes up to 27a69714450f5c9288cec2b20f1ae4f7ad34dacf:

  PM / devfreq: Fix the wrong end with semicolon (2020-07-30 17:22:58 +0900)

----------------------------------------------------------------

Update devfreq for 5.9

Detailed description for this pull request:
1. Update devfreq core
- Add support delayed timer for polling mode. Until now, the devfreq supports
  only deferrable timer for reducing the unneeded CPU wakeup.
  But, it has a problem for Non-CPU device like DMC device with DMA operation.
  These Non-CPU device need to monitor continuously regardless of CPU state.
  Add support the delayed timer for polling mode to support the continuous
  monitoring.
- Fix indentation of result of devfreq_summary debugfs node.
- Fix the wrong end of code with semicolon instead of comma
- Clean-up code to use the unified local variable name in sysfs-related
  internal funcitons.
- Fix trivial spelling for devfreq-event.c.

2. Update devfreq driver
- Add the exception handling code to control when rockchip,pmu property is absent
  for rk3399_dmc.c.
- Add missing 'rockchip,pmu' property to dt-binding document for rk3399_dmc.c.
- Change the kind of timer of exynos5422-dmc.c from deferrable to delayed
  timer in order to monitor the DMC (Dynamic Memory Controller) status
  regardless of CPU idle state. And adjust the polling interval and upthreshold
  value in order to react faster and make better decisions when benchmarking
  testing for the memory behavior.
- Add module parameter to either enable or disable the IRQ mode for DMC
  behavior monitoring. The exynos5422-dmc.c can operate in both polling
  and IRQ mode. The user can choose the monitoring mode by using module param.
  The default monitoring mode is polling mode with delayed timer.

 3. Add maintainer entry
- Add Dmitry Osipenko <digetx@gmail.com> as maintainer for memory frequency
  scaling drivers for Nvidia Tegra. He have been developed and reviewed
  the tegra*-devfreq.c.

----------------------------------------------------------------
Chanwoo Choi (5):
      PM / devfreq: Add support delayed timer for polling mode
      memory: samsung: exynos5422-dmc: Use delayed timer as default
      PM / devfreq: Clean up the devfreq instance name in sysfs attr
      PM / devfreq: Fix indentaion of devfreq_summary debugfs node
      PM / devfreq: Fix the wrong end with semicolon

Dmitry Osipenko (1):
      PM / devfreq: tegra: Add Dmitry as a maintainer

Enric Balletbo i Serra (1):
      dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle

Kieran Bingham (1):
      PM / devfreq: event: Fix trivial spelling

Lukasz Luba (2):
      memory: samsung: exynos5422-dmc: Adjust polling interval and uptreshold
      memory: samsung: exynos5422-dmc: Add module param to control IRQ mode

Marc Zyngier (1):
      PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent

 Documentation/ABI/testing/sysfs-class-devfreq      |  12 ++
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +
 MAINTAINERS                                        |   9 +
 drivers/devfreq/devfreq-event.c                    |   4 +-
 drivers/devfreq/devfreq.c                          | 195 ++++++++++++++++-----
 drivers/devfreq/rk3399_dmc.c                       |  42 +++--
 drivers/memory/samsung/exynos5422-dmc.c            |  14 +-
 include/linux/devfreq.h                            |   9 +
 8 files changed, 218 insertions(+), 69 deletions(-)
