Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F62189B79
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCRL6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:58:33 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37961 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRL6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 07:58:32 -0400
Received: by mail-pg1-f174.google.com with SMTP id x7so13564348pgh.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XMezUoQIlAqwFF412AUYGc5u75A3bzJ9GCQZGz/GOyQ=;
        b=yNKLFPma4HG4LNoud3yF3weV6BVOmAuk/qY/QRgU172uAWmZhCrEIh3Br31ShmLbN2
         VggCMurPjj1PvoWgwbNBJhlIGbG3px8xl5NTkfGCYPB0vzi/7TlfTeqjTqyE4y/6e30j
         nfiKf7LFQqU0zL/pBiQgq0o9PgRHH+mHzl73SzlhFUtXKzNyJapOEduthZSMyrFr7amU
         hczpkPq9LnrYWXp2Pbqjdx05i3yvpoDHGtxlIyV3H8GTNNACCnKwexhg/Gx9KP4gaJcc
         OCIdLKxbTpyR+Vw4LIYkqxZAgaULgGsK7EDpJie58KCvwry3k28IwLZhctkKLLlxwkpf
         lWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XMezUoQIlAqwFF412AUYGc5u75A3bzJ9GCQZGz/GOyQ=;
        b=ekDGdTZiZrHe72ehrabuTzVFSMNkpD37E0BljHlQKZmnpeZtBiKb+68GSIWlYMMgPp
         MyERB0d2N7zSneJZmqIttTqEwKev+byL9aCEPgyEnePvje/WreuiSXZAPwflZgUwGkZ5
         afbQOk2qQIiwOMLFg0uAVNwNBKvUK+x+Q6Xro2UYq10VUWNnzq0PZ7rAFz3dDZSStfXG
         Y6B5yNr2U118jbE9scZJMl79ciqmYu+RVzlZ2vb4K/DYACOgGNsoesA60AorRVFFxF/M
         XA0WG3yGC9/vuQr7tvm4xxSAO4szaDA1jcGPhYl7qIDPYOEcf2hvK92z3N4FIqahJvuM
         mq0A==
X-Gm-Message-State: ANhLgQ107WtFisEbWhSmOzcorE/sAUJKS3QWh7J6OjGHJ7T5eOSY2bIY
        7dFPqj5YDs4GopfQTb6s/wbzCw==
X-Google-Smtp-Source: ADFU+vvtD90zZsDYe8sToG3vN9lsXETrRP7rnmvzu3jpx9mYko/T2kbHXalHQlLiBoZPQsm6wFrORA==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr4502800pgj.274.1584532709463;
        Wed, 18 Mar 2020 04:58:29 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 189sm6652780pfw.203.2020.03.18.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:58:28 -0700 (PDT)
Message-ID: <5e720ce4.1c69fb81.79194.88e3@mx.google.com>
Date:   Wed, 18 Mar 2020 04:58:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-102-gc03d064a440c
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.6-rc6-102-gc03d064a440c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.6-rc6-102-gc03d064a440c)

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
  Describe: v5.6-rc6-102-gc03d064a440c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c03d064a440c2a5cbe3da782db05d3e18dc5ec3e =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.ht=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.ht=
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-102-gc03d0=
64a440c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
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
