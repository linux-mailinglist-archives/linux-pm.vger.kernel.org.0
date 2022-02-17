Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE364BA90D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiBQTAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 14:00:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBQTAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 14:00:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5096E571
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 10:59:56 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x18so464764pfh.5
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8tdrCS/V5K1Cn/KcECrBN26rDWRuXebkIcTkPxfDWXQ=;
        b=iyRm2Hb8G93nIYeQ2PeW+MszTmiVfd0JyJALMqB//oBN/KsISsombLu8ic/WK87YWj
         qbq1ocRg11xCoivkqyGjaURVNZ9PAxj8hAcTfPIHSa7SZC2yvh/4i1XdYi6oLPBWPXTT
         hyF12B+SCzuedSaIbfe0PyPwCVKoYWy0sOScA9+OWai2JW8+eqQqRrHYW9fK7uv7PWlM
         NAxkb4MUoyfNwHn16X50o4YGohyqgmD+n3kXfoEuXnqOESgJHjzEQBDG/cjas0ZbhWOB
         iSx7B6R/1uRnVfhsH862nZdJeY1SQHwXl0LIXwWhqcKiLaYaO9kOHjrCYZ/PG/NXRW4Y
         cslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8tdrCS/V5K1Cn/KcECrBN26rDWRuXebkIcTkPxfDWXQ=;
        b=IKmu+ha95nzVjKhKea5KQR94jD/e/Mt08+cRUfWFsN1z9Qz4bOHp6u8qU9P3lZigz9
         oB0DSb8DzBLb60baNEw6QEKGfNHbXbCB8n01tyVjRcspYiw6dxSpSHbMVrvMRtgdvXu3
         6Ck7yoeW5v53kbNbwGvbfGN9IAWb575pJEbaXxXDtwLNg3N56DKREPxE+kX3S8lF7VIt
         AqknHFRV10Wx69QsqSRrJJT3+9qYsKlfz2BXjPKnaRWQ3f6keDg1zzVpGi0PM5E4++wV
         iTb0kXcbIn096OaZ7P3mDjca3xnGMyM2u+/J9+TT6sxn7P2tb/ePBHlUupaTDLDMeU3b
         3iNA==
X-Gm-Message-State: AOAM5334+7/vKHsLu0St4hWCvjyIR3VUHp7AcrKtyC24LnZoKZUw/2ky
        7VYK2E5gEYVBO0vpH3Hma+vOSA==
X-Google-Smtp-Source: ABdhPJzDOle67bBfxldgs1C6rRoD0pu1/VFOyLSLQP2x9JDtr1OWQqNhg/xsP9PVHKnU1wM2ICoK+g==
X-Received: by 2002:a05:6a00:244b:b0:4c9:319e:ecb7 with SMTP id d11-20020a056a00244b00b004c9319eecb7mr4396881pfj.58.1645124395721;
        Thu, 17 Feb 2022 10:59:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e8sm309809pfv.168.2022.02.17.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:59:55 -0800 (PST)
Message-ID: <620e9b2b.1c69fb81.b75d0.15b5@mx.google.com>
Date:   Thu, 17 Feb 2022 10:59:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-51-ga6df857665e6
Subject: pm/testing baseline: 58 runs,
 10 regressions (v5.17-rc4-51-ga6df857665e6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 58 runs, 10 regressions (v5.17-rc4-51-ga6df857665e6)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
bcm2711-rpi-4-b            | arm64 | lab-collabora | gcc-10   | defconfig |=
 1          =

kontron-pitx-imx8m         | arm64 | lab-kontron   | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
4-51-ga6df857665e6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc4-51-ga6df857665e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a6df857665e68dd113761a7f5d8935995d1be237 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
bcm2711-rpi-4-b            | arm64 | lab-collabora | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e91b275c99d366dc62991

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e91b275c99d366dc62=
992
        new failure (last pass: v5.17-rc4-49-gbe8b582111d6) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
kontron-pitx-imx8m         | arm64 | lab-kontron   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e925773e0d2d006c629f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e925773e0d2d006c62=
9f2
        new failure (last pass: v5.17-rc4-49-gbe8b582111d6) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e917273187c5417c6296c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e917273187c5417c62=
96d
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e913722bf832959c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e913722bf832959c62=
969
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e919a4f50240663c62976

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e919a4f50240663c62=
977
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e918373187c5417c62989

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e918373187c5417c62=
98a
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e91ad75c99d366dc62989

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e91ad75c99d366dc62=
98a
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e916f73c03c7816c62992

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e916f73c03c7816c62=
993
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e918673187c5417c62997

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e918673187c5417c62=
998
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab           | compiler | defconfig |=
 regressions
---------------------------+-------+---------------+----------+-----------+=
------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/620e91483c67a74e28c6296f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-51-ga6df8=
57665e6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620e91483c67a74e28c62=
970
        failing since 8 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =20
