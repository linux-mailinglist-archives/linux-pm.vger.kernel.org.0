Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1139DF06
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFGOqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGOqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:46:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C3AC061766
        for <linux-pm@vger.kernel.org>; Mon,  7 Jun 2021 07:44:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so12101287pjz.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Jun 2021 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QaDS257JpbPHkKULCNNA3b5SU06T5kBCV3p9aYDTqac=;
        b=fp0mc3Xpza84TC8rdsWJBTsJdsOft6lOooYzC/v/pNVTLmWr60jU9otNBlgbnktLZ4
         wWXSAa5PxWnvJezOEKmvEYjFyH3BwKHCA73MPXhAiEzFdYR7RAtTHtdkjq3X+cyH+Boa
         UXSm2F6zkbEi3d4Y3J2dScbc0UBJZmxjM1MPMg1uW3ibASGN9GGmJE66GUtFHs2f976n
         HyrDGbFDpMqziUAXYJkF7wZzxGBn/bI8pV3SUbAlF2IWipzuMKXEhW4owJBU3/jKCHor
         3FziuTMk1rn4KyVQa+AkR42abWhLAJMNwshRe8CevLRZF4y0lbMFTd7RJCZYhb2zM2SJ
         K++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QaDS257JpbPHkKULCNNA3b5SU06T5kBCV3p9aYDTqac=;
        b=hJYP4zI98U2FPrHu7+Ev8Vs/Bv6uzd5ll9FSt0VYQZDQRXA3h7OP0BKIjdcx5JQ2ot
         R6Kug7PEJYfXqYAH6z5zlE6jUjb0KOCFy7cKFjANoMj88DHu+6va8SCWpkpn2Cmb4p3B
         2wFTksJ9NM7HD3GPebLOsj4WKqWPLnEugNQ0SdtQv9u50wkthZ0gM7tvx91pz/EOHNFn
         5djMpGJuSz8lqVVv19vn7oMLBM4dxSVqbGtXAnOtlkJqe8RnmltWoNNbdfYNWC18MzxO
         wHnfIH18YSI5YvM3Ed9p9tZPtrydOCfIuC/gzfgq5D5rsVuJ0eLUXIVE5SEKYwKm4bwG
         qMbw==
X-Gm-Message-State: AOAM532HGea/sbuIs4X6WPV56PjazARzRqx4e8q4Fz9xlIH3yJc7cZzs
        1BEuh8+Ws0Es4+Kz6VEtMgir8IhfMU1VP3+i
X-Google-Smtp-Source: ABdhPJy4GP1wCihKOEsZF8R9rTlLoZNkyggVr82XpYB12IR+6U0sZYl8a6pXRBj5Az/45HyNCdLLcA==
X-Received: by 2002:a17:90b:120d:: with SMTP id gl13mr20805789pjb.72.1623077052468;
        Mon, 07 Jun 2021 07:44:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x19sm8706640pgj.66.2021.06.07.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:44:12 -0700 (PDT)
Message-ID: <60be30bc.1c69fb81.ad406.a808@mx.google.com>
Date:   Mon, 07 Jun 2021 07:44:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-37-gfcbef3bdf3a8
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs, 11 regressions (v5.13-rc5-37-gfcbef3bdf3a8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 11 regressions (v5.13-rc5-37-gfcbef3bdf3a8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig          | 1=
          =

odroid-xu3      | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
0         =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-37-gfcbef3bdf3a8/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-37-gfcbef3bdf3a8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fcbef3bdf3a80dfe325261a837f0abd0b2a1b3f0 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/60be23e7a27cbd1b320c0df5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60be23e7a27cbd1b320c0df6
        failing since 291 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
odroid-xu3      | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
0         =


  Details:     https://kernelci.org/test/plan/id/60be2f220fdcf84dee0c0e00

  Results:     3 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-9: https://kernelci.org/test/case/id/60be2f220fdcf84d=
ee0c0e0c
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.195000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-06-07 14:37:18.212000+00:00  rtcwake: assuming RTC uses UTC ...   =


  * sleep.rtcwake-freeze-2: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e0f
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.254000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =


  * sleep.rtcwake-freeze-3: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e10
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.274000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-06-07 14:37:18.292000+00:00  rtcwake: assuming RTC uses UTC ...   =


  * sleep.rtcwake-freeze-4: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e11
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2) =


  * sleep.rtcwake-freeze-5: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e12
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.317000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =


  * sleep.rtcwake-freeze-6: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e13
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.338000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-06-07 14:37:18.356000+00:00  rtcwake: assuming RTC uses UTC ...   =


  * sleep.rtcwake-freeze-7: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e14
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.382000+00:00  rtcwake: assuming RTC uses UTC ...   =


  * sleep.rtcwake-freeze-8: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e15
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.403000+00:00  rtcwake: assuming RTC uses UTC ...   =


  * sleep.rtcwake-freeze-9: https://kernelci.org/test/case/id/60be2f220fdcf=
84dee0c0e16
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2) =


  * sleep.rtcwake-freeze-10: https://kernelci.org/test/case/id/60be2f220fdc=
f84dee0c0e17
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2)

    2021-06-07 14:37:18.429000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =

 =20
