Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4B1EB1AC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 00:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgFAWZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgFAWZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 18:25:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC2C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 15:25:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w68so3303955pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dytY9bHVb2LhlRTCBX5TA6IqWk5ca+ANvhj11vCwF+A=;
        b=Mm9CRQXchU6ew/OsNkzPLnXQiVDLq6EWuPFA9oHbcO6fbrxV7uzlaZEORte9jpG8+m
         fQSOOTxOQyZ46QvWxTsxs6jS7BY6w/CO9atGdM9h2Wq/YwMeSO+KSqeJGhcTnyKG+6KY
         ScyXMCMDDpMkm5JyLIfbXERJdXsHQGjPvp6PUpzd1Mn2ilfgTxaDU/RX70JSgNoN7EBd
         g3zKts4HKxzBhy5MWfBMWuI3YU4qHYJb7HSvSpKhISd8QuVeKONKFA9fl5RzFYwOlBbd
         0vHoX6Jizuf0QP8g+O4kYSkpzBtcyx+YfeTwUxyWwaaStlq6YdTKRryjvmu3ZKfQYVOg
         opfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dytY9bHVb2LhlRTCBX5TA6IqWk5ca+ANvhj11vCwF+A=;
        b=ff5FEP6lU5KzowxzAW2PVZ54n2Kf8QTdpVKs50saHMtmzK9dHG3IO8BY8TvucHa6R7
         LulJCldIuuCkYbbx6MgtaV40vRTu/tsKb0vw/U817/yMf7rhaFiZyY85DNItcvbGngQs
         XsYYmdeLuVOKqqZfnJpzuYnSxiWvQlQgCTmh9UG9wou6T65jLd1QKqhO4ZTtoM52dxpD
         YIQ02bmdi+GssjG60nTW1VEydICFp/RSaBbS7quDyxcm5APRdhxkkSRZ2Fa9zwtPB/Wj
         Xm4SP/eMeYWR6ZYjyKvftQYDaKpWcfK7iXOucU2GaNn5h922SkX8v9Z9w8lRd7nm/csU
         2Pdg==
X-Gm-Message-State: AOAM531qxxXW5BXDKeAQhDkym6KgOAEF8umyrHef3O8A1Y//y1hNQ/t7
        MnoE7NiYkqybgRX5z1o+3fJbP5HoaP0=
X-Google-Smtp-Source: ABdhPJwZCnUkDAygKaJwYrWhRIaqE5N5AduMfg35JRazOBLgyX6shpISifzrcNOqmOUwsGYTBj5E5w==
X-Received: by 2002:aa7:9f11:: with SMTP id g17mr2818075pfr.278.1591050342677;
        Mon, 01 Jun 2020 15:25:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m12sm400247pjf.44.2020.06.01.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:25:41 -0700 (PDT)
Message-ID: <5ed58065.1c69fb81.43af.18fd@mx.google.com>
Date:   Mon, 01 Jun 2020 15:25:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.7-rc7-129-gc291ca907606
Subject: pm/testing boot: 44 boots: 1 failed,
 43 passed (v5.7-rc7-129-gc291ca907606)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

******************************************
* WARNING: Boot tests are now deprecated *
******************************************

As kernelci.org is expanding its functional testing capabilities, the conce=
pt
of boot testing is now deprecated.  Boot results are scheduled to be droppe=
d on
*5th June 2020*.  The full schedule for boot tests deprecation is available=
 on
this GitHub issue: https://github.com/kernelci/kernelci-backend/issues/238

The new equivalent is the *baseline* test suite which also runs sanity chec=
ks
using dmesg and bootrr: https://github.com/kernelci/bootrr

See the *baseline results for this kernel revision* on this page:
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7-129-gc291ca=
907606/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 44 boots: 1 failed, 43 passed (v5.7-rc7-129-gc291ca907606)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc7-129-gc291ca907606/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc7-129-gc291ca907606/

Tree: pm
Branch: testing
Git Describe: v5.7-rc7-129-gc291ca907606
Git Commit: c291ca907606f834e19abfb788b11dfbc888b7e4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 44 unique boards, 13 SoC families, 2 builds out of 5

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s805x-libretech-ac:
              lab-baylibre: new failure (last pass: v5.7-rc7-109-g1a09809dd=
a81)

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s805x-libretech-ac: 1 failed lab

---
For more info write to <info@kernelci.org>
