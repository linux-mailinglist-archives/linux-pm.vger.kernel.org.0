Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72FF19006B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCWVe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:34:29 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38424 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVe3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 17:34:29 -0400
Received: by mail-pg1-f169.google.com with SMTP id x7so7887583pgh.5
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aGWfoImEdAk0am+80Pavz3sWDVROkWPMkfsifY3Xz3c=;
        b=CRHriKrYrlsbbnU5QaS0T8rm9O4pOHUbBNrBiPRu1R0HAzVWwG4+m0fQekM7yEvdge
         dWvLFs9S9FVj43sevIFYyVhRfEaQPyINanwnsTqY2wTGTPuqjsYJk7FSlNEDmOUeYdVJ
         Y758uBzHGbbqrGRnrddJ3PfnmrmXU6RwDIayHbhHmqJtJlf1JwD5oT50hLbax3fZukUy
         Ha+1uineuqpNN8VW5EZafWLfAMv7Z/D6rAqgxx2sAHnF9u6ksFiugPeYVx/da+sKiXXc
         M4dk66RoNhgHyd7GqMCsVkQQlBTa8cbYA7LSAyAOcid4RSczHsRpkXJmLGcwptO0T6EL
         sQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aGWfoImEdAk0am+80Pavz3sWDVROkWPMkfsifY3Xz3c=;
        b=R7sFMWy5YdcGYZDtN9qF8JKP2yAYEdVq3Xwp7vVUhpbhZZE9h/1dJRMp98oNeub1dI
         sMIsdJ7l+NdT0BRFkWGLHxhN1DBvMjRNF9XX26rKIcjtLz6Bt1PU94Ai+AdtmYmSPEP/
         9pCLiAlvEdV/CdEblhKF64mUiG/FnXoDnnH+raP1ZGli0yj8Aajbdmrlg6CPRvZULbgf
         bfW1QFGah4EYM8H7OqK15A4coyoLZ6pPZtOTVS+mqMKrM1YgmcwXNyqJyrW6tUMYQ1rw
         eWMMBF0LUcv4L0c2k2zxBkJYI64X20U7nFUCNFIgAZgPBpTtSbF/LmxF6j0oywo2GACN
         /u+A==
X-Gm-Message-State: ANhLgQ1c4jG5peJdHgWTukWSFmJQWwXuWRSpH1Jto0GmgZA6rIrWsSTj
        /jkQJhmZSpqvVCwuacusHVd4bg==
X-Google-Smtp-Source: ADFU+vubFpfmT0QEJnmishZ8hBiZxLLWATrHOt5tZnEEtA/gzLhSZK7/oobi63pr3KLEyOd3eKy3rQ==
X-Received: by 2002:aa7:999e:: with SMTP id k30mr25601324pfh.235.1584999268097;
        Mon, 23 Mar 2020 14:34:28 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f15sm12102839pfq.100.2020.03.23.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:34:26 -0700 (PDT)
Message-ID: <5e792b62.1c69fb81.1c037.bdd3@mx.google.com>
Date:   Mon, 23 Mar 2020 14:34:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc7-113-gc6e2eb7ccc3d
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.6-rc7-113-gc6e2eb7ccc3d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.6-rc7-113-gc6e2eb7ccc3d)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc7-113-gc6e2eb7ccc3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c6e2eb7ccc3d252115a7d8cba393770ec7366063 =



Test Failures
-------------
  =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

      =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc7-113-gc6e2e=
b7ccc3d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

              =20
