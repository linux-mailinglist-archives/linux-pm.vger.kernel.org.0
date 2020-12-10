Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C592D6A32
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404892AbgLJV1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbgLJV1T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 16:27:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C1C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 13:26:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v29so5424658pgk.12
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rEj+f7hDHkTufs9613P5Tbb/cDMd6lK0HlS+rE19/Hs=;
        b=P0VAZY8mxaQkLd+EG6B3nI4zO5AnRpLBJmfPmHIIB9Du4A4OFlSlrx+rNetORx5jop
         KovKTOmKlqnnvB77ezBTMO1NVuZGT6JDrKOzudukJxUWTVr1F8IiTGguPvci5sUD9rng
         g+nJRA7h/XiGr/DpvSPbY4XZ/VC9hu4sTeVRpztTVkhWe6NB3X8ESBen26F3DxdBZuIs
         E7VllwLl3qExaKAxA1forXQi4/afoRTh3OiQBECE02l1bfrYnUHGLUGkSgJ/bscna8fX
         H9UauM7xa208MqsGPpvEcZgxQCG5wRJJytogWM9p37O8fwfjCQgQbcDIvUPVeLV4X+RW
         ilkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rEj+f7hDHkTufs9613P5Tbb/cDMd6lK0HlS+rE19/Hs=;
        b=kNRXRKzRxqonfYwaKigqJm8gfFF80KPI+oJvpL6iAXaamsw8g5cUUpgJ31GV+0a/r4
         RzKiB7g5DRTIgcgfiJlXu7VSyg5MMSn/vBiNH45zdfSxj7bPq5JV+6H2vSYtT/FY3+On
         B1DBi+A6v49ENRzkr8CLoQaXROzJhyQjnRfb2R5HmWSv9jW6/VjYT9ZKCwBBnjqpAcMD
         psRWTEmBikxZtJnqBE8OTWG3uaxVWDfVIuBhzXWvm2uulCwcdGhB2vA3UkP15EunsFrb
         +T5r3IlR7lJ8kfgQIqgXKHxsftlJh72mKS+C/WqHZr64yhbH3+0/SU8SbbjNzPqBvG0j
         VTvA==
X-Gm-Message-State: AOAM530FOFWtLIpXZCTFXTUPcE/19zC/tqeBRbbNZO49CnPQ8jkMCKwg
        5WT9lWK1a31M626763/CMoZC8w==
X-Google-Smtp-Source: ABdhPJxk1dguffr0AyFs2ZiO7J4vZSfDlMkNI9d9gMrxmWd51C51xxgQF5b4HXKOv7xJ8ZOnF2SqNg==
X-Received: by 2002:a63:1707:: with SMTP id x7mr8236252pgl.71.1607635595840;
        Thu, 10 Dec 2020 13:26:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w1sm7647279pjt.23.2020.12.10.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:26:35 -0800 (PST)
Message-ID: <5fd2928b.1c69fb81.b58a5.e59d@mx.google.com>
Date:   Thu, 10 Dec 2020 13:26:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-88-g58dfa0fa290bb
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 117 runs,
 4 regressions (v5.10-rc7-88-g58dfa0fa290bb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 117 runs, 4 regressions (v5.10-rc7-88-g58dfa0fa290bb)

Regressions Summary
-------------------

platform                 | arch | lab           | compiler | defconfig     =
     | regressions
-------------------------+------+---------------+----------+---------------=
-----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre  | gcc-8    | multi_v7_defco=
nfig | 2          =

qemu_i386                | i386 | lab-baylibre  | gcc-8    | i386_defconfig=
     | 1          =

rk3288-veyron-jaq        | arm  | lab-collabora | gcc-8    | multi_v7_defco=
nfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-88-g58dfa0fa290bb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-88-g58dfa0fa290bb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      58dfa0fa290bb4c04c0dc3838b5cbce2caec7775 =



Test Regressions
---------------- =



platform                 | arch | lab           | compiler | defconfig     =
     | regressions
-------------------------+------+---------------+----------+---------------=
-----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre  | gcc-8    | multi_v7_defco=
nfig | 2          =


  Details:     https://kernelci.org/test/plan/id/5fd2889c0e7d8e9084c94cb9

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6cu=
stomboard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6cu=
stomboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5fd2889c0e7d8e9=
084c94cbd
        new failure (last pass: v5.10-rc7-96-ga834ecc967a3)
        4 lines

    2020-12-10 20:42:31.612000+00:00  kern  :alert : pgd =3D (ptrval)
    2020-12-10 20:42:31.612000+00:00  kern  :alert : [752f7389] *pgd=3D0000=
0000   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5fd2889c0e7d8e9=
084c94cbe
        new failure (last pass: v5.10-rc7-96-ga834ecc967a3)
        47 lines

    2020-12-10 20:42:31.654000+00:00  kern  :emerg : Process kworker/1:1 (p=
id: 52, stack limit =3D 0x(ptrval))
    2020-12-10 20:42:31.655000+00:00  kern  :emerg : Stack: (0xc244bd58 to =
0xc244c000)
    2020-12-10 20:42:31.656000+00:00  kern  :emerg : bd40:                 =
                                      c3a95db0 c3a95db4
    2020-12-10 20:42:31.656000+00:00  kern  :emerg : bd60: c3a95c00 c3a95c1=
4 c1448eec c09bb49c c244a000 ef86bb20 c09bc85c c3a95c00
    2020-12-10 20:42:31.657000+00:00  kern  :emerg : bd80: 752f7369 0000000=
c c19c765c c2001d80 c39da200 ef86bb40 c09c8bec c1448eec
    2020-12-10 20:42:31.696000+00:00  kern  :emerg : bda0: c19c7640 ef7fb3b=
3 c19c765c c2294740 c39dd300 c3a95c00 c3a95c14 c1448eec
    2020-12-10 20:42:31.697000+00:00  kern  :emerg : bdc0: c19c7640 0000000=
c c19c765c c09c8bbc c1446c14 00000000 c3a95c0c c3a95c00
    2020-12-10 20:42:31.698000+00:00  kern  :emerg : bde0: fffffdfb c22e0c1=
0 c2542f80 c099eafc c3a95c00 bf048000 fffffdfb bf044138
    2020-12-10 20:42:31.699000+00:00  kern  :emerg : be00: c39de6c0 c329bd0=
8 00000120 c26354c0 c2542f80 c09f8460 c39de6c0 c39de6c0
    2020-12-10 20:42:31.700000+00:00  kern  :emerg : be20: 00000040 c39de6c=
0 c2542f80 00000000 c19c7654 bf099084 bf09a014 00000017 =

    ... (36 line(s) more)  =

 =



platform                 | arch | lab           | compiler | defconfig     =
     | regressions
-------------------------+------+---------------+----------+---------------=
-----+------------
qemu_i386                | i386 | lab-baylibre  | gcc-8    | i386_defconfig=
     | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd2852d9fce3473b9c94cc5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd2852d9fce3473b9c94=
cc6
        new failure (last pass: v5.10-rc7-96-ga834ecc967a3) =

 =



platform                 | arch | lab           | compiler | defconfig     =
     | regressions
-------------------------+------+---------------+----------+---------------=
-----+------------
rk3288-veyron-jaq        | arm  | lab-collabora | gcc-8    | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd287969145aa02fbc94cbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-=
jaq.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-rk3288-veyron-=
jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd287969145aa02fbc94=
cbe
        new failure (last pass: v5.10-rc7-87-g960e625edeb5) =

 =20
