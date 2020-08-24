Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E224FE10
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgHXMvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHXMvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 08:51:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9732C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 05:51:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u20so4785112pfn.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eM2VykXmn931sMwNANjBH1nmfxgn9262mf4SKLZk/uY=;
        b=p9tDo9qxYInRPMVLqIl7jwlS4LdqiBclGmMR6GsBv1sam61X7mOfwkXXDUkeQULx4+
         VpdGgLgwSNa1X5tzEBOu4dn4wA5wTZ+5p2zWmhFsuIVvvj4A9qjIIom9KHK57NU+Cy+l
         EODwSiU3MGCdAWAjJrXGlx7TUYYBM9xOkgkM3n6BhAXOKkKvl7Ytrwzc7fEgSK1ULv35
         6u232kOQ7g8nY8hDt+PEIEFq1VW6qGrs3Q4WHysE5dFt7T1n17ku0trL3P0u8Vmwdhg8
         60M/GRQpwKlcwTgR8KNs1FbuQeUGL7shnkf8QnrSxr/DN4os2TLLwqKbxfT3HEFUXDKy
         dsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eM2VykXmn931sMwNANjBH1nmfxgn9262mf4SKLZk/uY=;
        b=hKKLuC+YrX7nNca9vY+Ro5DSkUYh1+mqkZZrFXoKsnX0KeE5Iqm4nXoIpSEsbsJAXX
         5Ff1XAUBEPoZyw73CkqMeqvmleGMbpJwFH8t7IxwHRZ19iPeM0pWapzfNG02gj9wElpH
         9zxc7eRcGEAG3E85llC6Vk4vdfGldYQX2xks/cY8FpFK92/QND+s3yyeTmI9kkJFvpAC
         NMTDrBD78ahqZVlzC8Unm+eJBNRKn88shWT3a+iGgey4uWt5OJNKFzSMQmB4leVhyHtw
         gbbXAzkpcDmfpPBTXdoHAmmdyfAuP6PL/jGXgQ3+hsWmRhOgljmB0QOufPduwmBkck/Y
         dYXQ==
X-Gm-Message-State: AOAM5307XrKoGMJFRVO79+5z4bzlrSeEkhV0R5y4AM0FbpH1IfsAtwJF
        d3LSJLohWxSXX5jSuiOc2qajBdngfRU+Gw==
X-Google-Smtp-Source: ABdhPJzRB8j3+QE1efplbP4gWxfqUp/AAj7NsD5wctFtxVrAYYATtul7RDfxVXaBriCPjV91m93KBw==
X-Received: by 2002:a62:7f06:: with SMTP id a6mr4108556pfd.300.1598273494011;
        Mon, 24 Aug 2020 05:51:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d15sm726430pfr.143.2020.08.24.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:51:33 -0700 (PDT)
Message-ID: <5f43b7d5.1c69fb81.9fae9.1fce@mx.google.com>
Date:   Mon, 24 Aug 2020 05:51:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-8-gf5eba0ea1052
Subject: pm/testing baseline: 77 runs, 6 regressions (v5.9-rc2-8-gf5eba0ea1052)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 77 runs, 6 regressions (v5.9-rc2-8-gf5eba0ea1052)

Regressions Summary
-------------------

platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
mt8173-elm-hana           | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 0/1    =

omap4-panda               | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 4/5    =

rk3399-gru-kevin          | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 83/88  =

sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-8-gf5eba0ea1052/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-8-gf5eba0ea1052
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f5eba0ea1052daba08e3fcf50be669b13fd7953d =



Test Regressions
---------------- =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
mt8173-elm-hana           | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f43ac04340369b1c69fb42b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f43ac04340369b1c69fb=
42c
      failing since 4 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
omap4-panda               | arm   | lab-collabora | gcc-8    | multi_v7_def=
config | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f43aee9757f6049fb9fb44a

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f43aee9757f604=
9fb9fb450
      failing since 4 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-08-24 12:13:23.537000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-24 12:13:23.543000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-24 12:13:23.548000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-24 12:13:23.554000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-24 12:13:23.560000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-24 12:13:23.566000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-24 12:13:23.572000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-24 12:13:23.578000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-24 12:13:23.584000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-08-24 12:13:23.590000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
rk3399-gru-kevin          | arm64 | lab-collabora | gcc-8    | defconfig   =
       | 83/88  =


  Details:     https://kernelci.org/test/plan/id/5f43ac87f7f4d2d92c9fb438

  Results:     83 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f43ac87f7f4d2d=
92c9fb491
      new failure (last pass: v5.9-rc1-4-gcc15fd9892e2)
      11 lines

    2020-08-24 12:03:09.112000  kern  :alert : Mem abort info:
    2020-08-24 12:03:09.116000  kern  :alert :   ESR =3D 0x96000006
    2020-08-24 12:03:09.121000  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits
    2020-08-24 12:03:09.125000  kern  :alert :   SET =3D 0, FnV =3D 0
    2020-08-24 12:03:09.128000  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2020-08-24 12:03:09.131000  kern  :alert : Data abort info:
    2020-08-24 12:03:09.136000  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006
    2020-08-24 12:03:09.139000  kern  :alert :   CM =3D 0, WnR =3D 0
    2020-08-24 12:03:09.146000  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D00000000eb042000
    2020-08-24 12:03:09.158000  kern  :alert : [0000000000000010] pgd=3D000=
00000eb048003, p4d=3D00000000eb048003, pud=3D00000000eb049003, pmd=3D000000=
0000000000
     * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5f43ac87f7f4=
d2d92c9fb492
      new failure (last pass: v5.9-rc1-4-gcc15fd9892e2)
      2 lines

    2020-08-24 12:03:09.179000  kern  :emerg : Code: 1a9f07e7 f10000df 7a40=
08e4 54000521 (f94008c8) =

      =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-cubieboard2     | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f43afc1a3546fcf3e9fb43d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboa=
rd2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f43afc1a3546fcf3e9fb=
43e
      failing since 4 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform                  | arch  | lab           | compiler | defconfig   =
       | results
--------------------------+-------+---------------+----------+-------------=
-------+--------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | multi_v7_def=
config | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f43b5fd62832f64b39fb43c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-olinuxin=
o-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f43b5fd62832f64b39fb=
43d
      failing since 4 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
