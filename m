Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71037179E31
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEDVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 22:21:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCEDVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 22:21:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id g12so1997814plo.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 19:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5UH0q83/v/aYiD5/WOhvNC3yGTZqYlMrmDg03hPr7tc=;
        b=SBss7atxKJdn7UqNPr4BW0yz/Udi6TAwu1bzpBvS0MC0dTOE5gUi0776lJUgWiw2j6
         8R7qiYVyojWNu6IQZryIoh8FDeg/MaKazb1Vx8SlOLWJAkU/uwyzMQ5GzaWGagSNfZkI
         9veCAjniokh8yFfYz4KrqTlnJopgq+JagQDmFVb5OLPSDRGMSpoxrB/5Nrpts300d11Y
         h9yPLBxPDmzd5S4Isf4l/TzhhtTl/u9WC2OA0q+8HZc/j+EoRcggBb3lNVkAzhDo9HvR
         UF959lnXqOj/rivwjXYSK/dapBxF9RHbab3bu2qUNysGdA7yKAw8lwa2fo363HtJPxaO
         D1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5UH0q83/v/aYiD5/WOhvNC3yGTZqYlMrmDg03hPr7tc=;
        b=puZ7RophoWzexEoxbpsZviQkW7Mm/wVvUoz7SkiGh02xzr1VaBEy9flV8yuFo4jKb1
         XnbNhDK7mDTPxYR9M3KxSWCKLYYlnXDGzH25/9zHSuGN4RnayVD3M09pcrA0wVOOwUTO
         h2aWIA2ZAy2H/MtI2vuMwgDmV2KeAGHruWvpv/+tBJ8DXwK9YlEU50bCq/IsL3Rj/CZ4
         qP5H5/X1m2rrhlyGfeehlN3DH9nEoHlov6xMB4n02KHiq2/4cCGk1hT3P2DqDe1i/ZYF
         S+7mUpXD1bLgqNm1FD5XsjCU86ppo1ubIG22yBDEMRSKJ1iKj6oC4NO+gIK8ZEA22oft
         bpUg==
X-Gm-Message-State: ANhLgQ2FwdMbQJExRwazZ4YGQL51iG2F5ivPSkgswdrhL2j95AC5nm3h
        5GMSv0cSbLOuzX6rqjEDqUUSRg==
X-Google-Smtp-Source: ADFU+vtVpqcFLkjCj4q5/rC+pWz2LzO8ptEaj/vHibhuwAg5cQ6AgPrpyPDZI8szzq7ARsC4fVKaBA==
X-Received: by 2002:a17:90a:d98e:: with SMTP id d14mr6334866pjv.70.1583378467766;
        Wed, 04 Mar 2020 19:21:07 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jx10sm4083688pjb.33.2020.03.04.19.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 19:21:07 -0800 (PST)
Message-ID: <5e607023.1c69fb81.79a59.bcf1@mx.google.com>
Date:   Wed, 04 Mar 2020 19:21:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-67-ga76a126302eb
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
Subject: pm/testing boot: 29 boots: 2 failed,
 26 passed with 1 untried/unknown (v5.6-rc4-67-ga76a126302eb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 29 boots: 2 failed, 26 passed with 1 untried/unknown (v5.6=
-rc4-67-ga76a126302eb)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc4-67-ga76a126302eb/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-67-ga76a126302eb/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-67-ga76a126302eb
Git Commit: a76a126302eb84e78d7d3fc9c7e69487fb97e8e4
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 26 unique boards, 8 SoC families, 2 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: new failure (last pass: v5.6-rc4-56-gf99f4dfcc7=
da)
          meson-gxm-q200:
              lab-baylibre: failing since 2 days (last pass: v5.6-rc3-67-g1=
46605da90d7 - first fail: v5.6-rc4-56-gf99f4dfcc7da)
          sun50i-a64-pine64-plus:
              lab-baylibre: new failure (last pass: v5.6-rc4-56-gf99f4dfcc7=
da)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-g12b-a311d-khadas-vim3: 1 failed lab
            meson-gxm-q200: 1 failed lab

---
For more info write to <info@kernelci.org>
