Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF06380E5B
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhENQpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhENQpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 12:45:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F5C061574
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 09:44:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x188so132326pfd.7
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AsKJK3OW/xZ29+khF6u1+FlFsygksOqmH2Fw9Mm6hhE=;
        b=y0ibYJ+7xf09qr4v9aO6wqP3AVjgZlBHkpa34yQqiro9WRG1/IKiXPwdWxwGOeVcXG
         CQjDqWlFVC24LpVQtVOZpmwaT+8nCF8Luue6Uv2uc+BjhlrnIsi2dfO7Jq2kLvSQWf7i
         q109lxCdjn1V65ckGm/C7uTeIwSBpQ+vdjJI0ETGzxb/Xhj5fQTgo8sf9SdPA3e//ng2
         v7AWlVXKQA8+LhWqjmMRiDICCgEx6FooPVqmXsuTXhe2DvLnps0imcDQSST9HyIEa0mJ
         4iAtqmJIbLOMPDyMpiEQigxVasVj4dRkcB8PPj7EI/B6zi7t+yoaiQH6/Shsq+i/UTIb
         rd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AsKJK3OW/xZ29+khF6u1+FlFsygksOqmH2Fw9Mm6hhE=;
        b=T2vfdg/9dB4IAxbwJ4a+/C4NpfhWouh7Raj5GGNhsvX96zcm6ADhjmPDK4khGOdpda
         aQFAbzcwV7VWdr8Z0/KGyht0ZhoDelVixF/Jazfx4HZUxFQt65p8rre5LEDG2ojcfdoQ
         pk3p89zw+7mm5v+M1rLQvChoGkT18R8pkJnXa+6H//ocM4V574dMcEQSFbsEOWOMhklA
         +vOshX3o1Xzx0JZNIKWU1nHhWzH5v5h+4uIKlx99j7cab+8Fc3/g6rnem+zGlh0xpUIZ
         bNJ5iagnTvhDzLGEuXXWZubRR7RUqje5eWbObfQNIUUrMiUGe+yrBFaXP7Ni5IUJKvZK
         vyQA==
X-Gm-Message-State: AOAM533uK2CQ1hISxulPCJICSf5XjzHLLHSLDPyTZRH9KRbvdNYQXE5V
        KwJxJgOXEQV+RBy2XYuSd+dT4w==
X-Google-Smtp-Source: ABdhPJy+95BshNAHmh3GRWE8l/Inl4Bzq1r69rNQmNA9OVmN4oy7XF4uzB/8e1pNZH32PJhEO7Kn2w==
X-Received: by 2002:a63:b10:: with SMTP id 16mr48958655pgl.90.1621010642212;
        Fri, 14 May 2021 09:44:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w23sm4670673pfn.63.2021.05.14.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:44:01 -0700 (PDT)
Message-ID: <609ea8d1.1c69fb81.d6573.011b@mx.google.com>
Date:   Fri, 14 May 2021 09:44:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc1-13-g05bb2ae3f2bf
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 74 runs,
 4 regressions (v5.13-rc1-13-g05bb2ae3f2bf)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 74 runs, 4 regressions (v5.13-rc1-13-g05bb2ae3f2bf)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =

imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
1-13-g05bb2ae3f2bf/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc1-13-g05bb2ae3f2bf
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      05bb2ae3f2bf0f86fe8740b90d357cccb7aa3764 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/609e9eaad38f64bcfbb3afed

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/609e9eabd38f64b=
cfbb3aff3
        failing since 3 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, firs=
t fail: v5.13-rc1-4-gdc9d574fa82fc)
        11 lines

    2021-05-14 16:00:19.114000+00:00  kern  :alert : Mem abort in[   21.685=
210] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines=
 MEASUREMENT=3D11>
    2021-05-14 16:00:19.115000+00:00  fo:
    2021-05-14 16:00:19.116000+00:00  kern  :alert :   ESR =3D 0x96000006   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/609e9eabd38f64b=
cfbb3aff4
        failing since 3 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, firs=
t fail: v5.13-rc1-4-gdc9d574fa82fc)
        2 lines

    2021-05-14 16:00:19.120000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0
    2021-05-14 16:00:19.121000+00:00  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2021-05-14 16:00:19.122000+00:00  kern  :alert : Data abort info:
    2021-05-14 16:00:19.122000+00:00  kern  :alert :   ISV =3D 0, ISS =3D 0=
x00000006
    2021-05-14 16:00:19.156000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2021-05-14 16:00:19.158000+00:00  kern  :alert : user pgtable: 4k pages=
, 48-bit VAs, pgdp=3D000000003a8cf000
    2021-05-14 16:00:19.159000+00:00  kern  :aler[   21.726122] <LAVA_SIGNA=
L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2021-05-14 16:00:19.160000+00:00  t : [0000000000000050] p[   21.737207=
] <LAVA_SIGNAL_ENDRUN 0_dmesg 328702_1.5.2.4.1>
    2021-05-14 16:00:19.160000+00:00  gd=3D080000003a8d0003, p4d=3D08000000=
3a8d0003, pud=3D080000003a8d1003, pmd=3D0000000000000000   =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/609ea23e0d6fc99569b3afa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609ea23e0d6fc99569b3a=
fa2
        failing since 2 days (last pass: v5.13-rc1-4-gdc9d574fa82fc, first =
fail: v5.13-rc1-9-gcb7accda3e01f) =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/609e9f70597ce45451b3afa9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-13-g05bb2=
ae3f2bf/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609e9f70597ce45451b3a=
faa
        new failure (last pass: v5.13-rc1-9-gcb7accda3e01f) =

 =20
