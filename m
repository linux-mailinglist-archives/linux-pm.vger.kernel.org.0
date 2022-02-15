Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5D4B60CF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Feb 2022 03:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiBOCJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 21:09:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiBOCJY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 21:09:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ABEC5EC
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 18:09:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v4so16201998pjh.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VUBQ5aIWlv6L2crg6EoQug7OUDTccug6I1VtiUkhZNg=;
        b=rdn4bZUPL84hlWR7o8nSOqPDxyL1ObryDPMQ+7hlnOh6ok+k9sEcpI8guPncznJcnU
         tlJ/LNsvAe/n1lzskVxHeLhFA3XTJ9HZ2pkQDqYOLabAyaTTbGRmPJgs9lT9V85N75A/
         m4NpuFRfEVWkMr6HKcsWZMbmiUpJpeq7rHekfb2HC97OY/t/J5M/8jirxbuDnlGAJuoL
         eVfBNeG0w6zTXnNCUyGD+05vALelbeBXSAL7DAuwUKJu1NBgIoMwt/PJ2OIGPWi85Y8W
         kZUT3KKWiG4JcgFpO2Dj4hMCYfVJWSqljsuwATuKWO+WRf93pSltHCcTT3ldCGbrsvR6
         B4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VUBQ5aIWlv6L2crg6EoQug7OUDTccug6I1VtiUkhZNg=;
        b=vdfZ7pWImLTwVJGg2LrGnbrsRlDXTirBTGTcgOC5GD5LZM0Kw8b0VyCf5arHRSZM5W
         i6kJt/XwUrfbLwj1P5hcxk2QBPZpTveWgWiHk0u9kvrzxg8xBiZRs8ySWaL3Z7CxzyqI
         xjYsTIHEVYdBpSQGO6axkDzW3gnORhFjdzhgvbG1UW4tNaJ7dWjvj7ZyUXVZkWkUK/GP
         xwefx3uS7UPoBSuUmmKrM3uc6ur2WO1mUpJd7V2X//ESS+SitZue4MP0CtY/xwZYpVi9
         iUHsuT2oZKFrCslk24THrpDA0rRRVEh9Y5usaONwXFS3AK4hANwvWqgu/MBSH924C2TS
         01uA==
X-Gm-Message-State: AOAM533Y+VQ6+atzZdrYG3lnwN/p+BHLREp/kYFL+1WJKRwCVEFgRHtT
        dUFsB7HqoFA94VFYYREtU8XV1Q==
X-Google-Smtp-Source: ABdhPJxiWQs//+hhFNqdJSxj5QJj3lpcqvVohZog674M5QY/3ltMCXF7mj/JxGu8yL/B4SCx7nsM6A==
X-Received: by 2002:a17:90b:1b51:: with SMTP id nv17mr1836376pjb.226.1644890954699;
        Mon, 14 Feb 2022 18:09:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bm3sm677266pgb.88.2022.02.14.18.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:09:14 -0800 (PST)
Message-ID: <620b0b4a.1c69fb81.a5365.2b21@mx.google.com>
Date:   Mon, 14 Feb 2022 18:09:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-37-gd4e043a4af96
Subject: pm/testing baseline: 60 runs,
 12 regressions (v5.17-rc4-37-gd4e043a4af96)
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

pm/testing baseline: 60 runs, 12 regressions (v5.17-rc4-37-gd4e043a4af96)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
cubietruck                 | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =

sun7i-a20-cubieboard2      | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
4-37-gd4e043a4af96/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc4-37-gd4e043a4af96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d4e043a4af969c8d992f8abb3aca811380201cfb =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
cubietruck                 | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =


  Details:     https://kernelci.org/test/plan/id/620b0025390c9cc52ec6296c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/620b0025390c9cc=
52ec62970
        new failure (last pass: v5.17-rc3-39-g9b044ca4ac33)
        16 lines

    2022-02-15T01:21:16.751910  <8>[   37.433529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrit RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2022-02-15T01:21:16.780540  kern  :alert : 8<--- cut here ---
    2022-02-15T01:21:16.788427  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-02-15T01:21:16.792067  kern  :alert : [000001a0] *pgd=3Dbc108835
    2022-02-15T01:21:16.796708  kern  :alert : Register r0 information: NUL=
L pointer   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/620b0025390c9cc=
52ec62971
        new failure (last pass: v5.17-rc3-39-g9b044ca4ac33)
        58 lines

    2022-02-15T01:21:16.806190  ke<8>[   37.483179] <LAVA_SIGNAL_TESTCASE T=
EST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D16>
    2022-02-15T01:21:16.811215  rn  :alert : Register r1 information: non-s=
lab/vmalloc memory
    2022-02-15T01:21:16.816610  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-02-15T01:21:16.821745  kern  :alert : Register r3 information: non=
-paged memory
    2022-02-15T01:21:16.830618  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c4d23000 pointer offset 64 size 1024
    2022-02-15T01:21:16.838359  kern  :alert : Register r5 information: sla=
b task_struct start c4d8a200 pointer offset 0
    2022-02-15T01:21:16.847024  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21d2000 pointer offset 16 size 1024
    2022-02-15T01:21:16.855527  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c4d23000 pointer offset 128 size 1024
    2022-02-15T01:21:16.861444  kern  :alert : Register r8 information: non=
-slab/vmalloc memory
    2022-02-15T01:21:16.869890  kern  :alert : Register r9 information: sla=
b kmalloc-1k start c21d2000 pointer offset 0 size 1024 =

    ... (44 line(s) more)  =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b012766f82b42aac62992

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b012766f82b42aac62=
993
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b012666f82b42aac6298f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b012666f82b42aac62=
990
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b0118df4d4f743ac62999

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b0118df4d4f743ac62=
99a
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b0125e999ae3e99c629ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b0125e999ae3e99c62=
9cf
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b0116503d2035ecc6298d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b0116503d2035ecc62=
98e
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b00fedf4d4f743ac62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b00fedf4d4f743ac62=
969
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b0115c37381ffe1c62994

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b0115c37381ffe1c62=
995
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig   =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/620b00fdc37381ffe1c6296a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620b00fdc37381ffe1c62=
96b
        failing since 5 days (last pass: v5.17-rc3-33-g4e3e936b36f6, first =
fail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
       | regressions
---------------------------+-------+--------------+----------+-------------=
-------+------------
sun7i-a20-cubieboard2      | arm   | lab-baylibre | gcc-10   | multi_v7_def=
config | 2          =


  Details:     https://kernelci.org/test/plan/id/620b003a9584a1c8e6c6299f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc4-37-gd4e04=
3a4af96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220211.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/620b003a9584a1c=
8e6c629a3
        new failure (last pass: v5.17-rc3-39-g9b044ca4ac33)
        16 lines

    2022-02-15T01:21:44.233621  kern  :alert : 8<--- cut here ---
    2022-02-15T01:21:44.233914  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-02-15T01:21:44.234084  kern  :alert : [000001a0] *pgd=3D7c<8>[   3=
6.930696] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D16>
    2022-02-15T01:21:44.234243  8f2835
    2022-02-15T01:21:44.234396  kern  :alert : Register r0 information: NUL=
L pointer
    2022-02-15T01:21:44.234544  kern  :alert : Register r1 information: non=
-slab/vmalloc memory
    2022-02-15T01:21:44.234690  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-02-15T01:21:44.234834  kern  :alert : Register r3 information: non=
-paged memory   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/620b003a9584a1c=
8e6c629a4
        new failure (last pass: v5.17-rc3-39-g9b044ca4ac33)
        58 lines

    2022-02-15T01:21:44.276519  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c4df2c00 pointer offset 64 size 1024
    2022-02-15T01:21:44.276709  kern  :alert : Register r5 information: sla=
b task_struct start c4d5bb80 pointer offset 0
    2022-02-15T01:21:44.276868  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21cdc00 pointer offset 16 size 1024
    2022-02-15T01:21:44.277023  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c4df2c00 pointer offset 128 size 1024
    2022-02-15T01:21:44.277172  kern  :alert : Register r8 information: non=
-slab/vmalloc memory
    2022-02-15T01:21:44.319415  kern  :alert : Register r9 information: sla=
b kmalloc-1k start c21cdc00 pointer offset 0 size 1024
    2022-02-15T01:21:44.319665  kern  :alert : Register r10 information: sl=
ab kmalloc-1k start c4e2e800 pointer offset 0 size 1024
    2022-02-15T01:21:44.319828  kern  :alert : Register r11 information: NU=
LL pointer
    2022-02-15T01:21:44.319980  kern  :alert : Register r12 information: sl=
ab task_struct start c4d5bb80 pointer offset 0
    2022-02-15T01:21:44.320134  kern  :emerg : Internal error: Oops: 17 [#1=
] SMP ARM =

    ... (39 line(s) more)  =

 =20
