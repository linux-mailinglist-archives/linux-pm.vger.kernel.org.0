Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA24B7910
	for <lists+linux-pm@lfdr.de>; Tue, 15 Feb 2022 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiBOUvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Feb 2022 15:51:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiBOUvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Feb 2022 15:51:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A513CF7
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 12:51:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b8so275929pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ivFzH4Kgxg/KhLY7KhVJt2GSvEBvVXBd0UUyr7eg07U=;
        b=wQk/CHgHeh/6uyL07mRB/mBNE0UW+Tf9cnTDvpY96RKFdC1HogK8qTjN/F9XZZHs9W
         YhZWvEb8XKrKeDZHOp2EGps1A+WMeJ6aVCMa1brNRorOzg1BtQ3mDBi0+iworz6NMzdA
         Dsd0t87FhwCqSfS+/yp+2+POIHf8ugpo17ms0pj/jzQDMQK29/b2tnaPtqy7aIWQJSHV
         HJ64V8+mLjoJDnNDRVrR44Uig1OpOAJzJd8BMqs3Nl3mywz9n6DH2EPlGwO0XQ6XKsH/
         2ftQWvOzFO/S2aslcLSg1YMU4hVFDjawycru1ck+oBfXCqhMBhM61+q+ATjuHxHJKcYS
         Hdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ivFzH4Kgxg/KhLY7KhVJt2GSvEBvVXBd0UUyr7eg07U=;
        b=6qLs+2a8tA9HY+oQC5d7KIFA/zyS9h/FKw+QuOP1hsMQwb99F1oNS+aX2jX3fNhO4v
         RvTdNddmhghyyqJTNxdMXlZPrj3TJ65HXxUNXGQby3P69uBF3i+VQW1E++9LxS6GdS1q
         F1rpym0ng5VP2NRHdX6a2TNIZ0xu6rGjF+0kl9cF8X6vDcgngeu86JACPEIe5ShZCHEc
         GOMH6ju3FmWWnmJqYzRCseU8wFbafKu02vb5Y4mc95ZEaxRwl8eywWK1K8VVoDTkCK/k
         zYpyvIsgZ9YfwSOBGXRAm6tIJH69TEWgoI0dieakKQvjRh3Zkm9GYxnmXR9N9pBYXEtA
         2ZVA==
X-Gm-Message-State: AOAM531b5VhIUNEv/KsObWAT+9bKw28TGz4PMRZagErLa/FUVzJiXYaI
        9FyeZFV6APoT3WlgSfX4ByHGhQ==
X-Google-Smtp-Source: ABdhPJxFYUs6by5d1h7dWew7hUp0EHLKHSi7uFQKxLCSH3URmsg4NvG62lztzS0W4XUBeD6wibSJmw==
X-Received: by 2002:a17:90a:ce81:b0:1b9:dbef:8c1c with SMTP id g1-20020a17090ace8100b001b9dbef8c1cmr6562076pju.34.1644958302936;
        Tue, 15 Feb 2022 12:51:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3sm42414490pfe.67.2022.02.15.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:51:42 -0800 (PST)
Message-ID: <620c125e.1c69fb81.a93e4.930e@mx.google.com>
Date:   Tue, 15 Feb 2022 12:51:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-49-gbe8b582111d6
Subject: pm/testing baseline: 55 runs,
 8 regressions (v5.17-rc4-49-gbe8b582111d6)
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

pm/testing baseline: 55 runs, 8 regressions (v5.17-rc4-49-gbe8b582111d6)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
4-49-gbe8b582111d6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc4-49-gbe8b582111d6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      be8b582111d67263006ded4f1b88f9ff28bea49e =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c0720a0d9eb1afdc6298b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c0720a0d9eb1afdc62=
98c
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c070508af6bbeeec62998

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c070508af6bbeeec62=
999
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c0723a0d9eb1afdc62991

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c0723a0d9eb1afdc62=
992
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c0706a0d9eb1afdc6296c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c0706a0d9eb1afdc62=
96d
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c071fa0d9eb1afdc62988

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c071fa0d9eb1afdc62=
989
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c070408af6bbeeec62995

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c070408af6bbeeec62=
996
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c0722a0d9eb1afdc6298e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c0722a0d9eb1afdc62=
98f
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620c0717a0d9eb1afdc6297f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-49-gbe8b5=
82111d6/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620c0717a0d9eb1afdc62=
980
        failing since 6 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =20
