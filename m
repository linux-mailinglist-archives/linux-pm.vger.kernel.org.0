Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9E2539E1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZVlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 17:41:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41AC061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 14:41:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w186so1822920pgb.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CP9feJwcl9YD3BGcr8k7JihbK1gK0tIJ94FeFwCSgak=;
        b=t0Bsc3BtgOQAkMqZkwAg306dAEEX+yy5rZzkFE5900Kb01ybBWpCxRx23yT/1qf4+s
         I007ZE03QcRRVcHSFT2CEIOSFba0Oz2PkiXerWkpGvZHvUd2kNJZpSQIk2iszSep5T+x
         WnL8DMtrzZj+T8SEWpsgFRcRDs6v3s2yjzbfWKUp5UcNxXZznhbFSKQh3hlDISO1mmll
         csIPHFC1xcOu942xpgDG8+QqxhHkqN1fvk4k6K/M8WlG2ECtYn9a3ZwEW/Oh/FBvF3Em
         /Rwvhoq9UGg41FEPAK4vO08z6IA3hqbkrM4AJz0knJgZ0WJWR7o0aPSb0bnB96tmfcpL
         eECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CP9feJwcl9YD3BGcr8k7JihbK1gK0tIJ94FeFwCSgak=;
        b=abLLdDKGTtrVvYvM+chAoRh/6Mf8RLGoCw6x5WnkwYfqIpC80AtkL+K1Ik6y2iCCkt
         IwFl+TzwPc1jEI3nY0O63lXei0YOz11mtAbFnezeaXobXpWnhasR5DIB1KQ6fP2/RW+Q
         zV/aHmMwdoYLUo+LYmOptvKtfJxTtaNLxA1hjjKEW/QX0Rjr96e5E6rObx9ThTOu7trz
         GBJmwZpNxhim50JspUykA5qKMh6DRVeF42JMeK7xlzk8hoDqAzoiEbutp47NY3P4GhlS
         kSgqX5SH4Cxxo0yqGAh1Te6TGtOk/+uOIi+BjSSYmcBBUeghn/EP3Lwsw7D2C73nRIE2
         oSCA==
X-Gm-Message-State: AOAM5310vghFGGGQ3Bw6Neft+jcXKVWgeCc+zBsaxdCtCy7N/4DKE6YA
        PfndFDEqCt671cGp+zKWKCJmew==
X-Google-Smtp-Source: ABdhPJypHvu51EoySASKRrTgA/WL88Wk4WY8ZGLNLMQUdMWIiUmYmk89TJ7fPqBmTbeB3hjS0MT3hw==
X-Received: by 2002:a63:50c:: with SMTP id 12mr3158930pgf.173.1598478077470;
        Wed, 26 Aug 2020 14:41:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x12sm44542pjq.43.2020.08.26.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:41:16 -0700 (PDT)
Message-ID: <5f46d6fc.1c69fb81.7d7bc.039f@mx.google.com>
Date:   Wed, 26 Aug 2020 14:41:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-14-gfe784821d630
Subject: pm/testing baseline: 101 runs,
 5 regressions (v5.9-rc2-14-gfe784821d630)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 101 runs, 5 regressions (v5.9-rc2-14-gfe784821d630)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
bcm2837-rpi-3-b        | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 3/4    =

mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =

omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =

sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =

sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-14-gfe784821d630/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-14-gfe784821d630
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fe784821d630f71eee1f431f10e08518db42dc02 =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
bcm2837-rpi-3-b        | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 3/4    =


  Details:     https://kernelci.org/test/plan/id/5f46c799c419d6908a9fb43e

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f46c799c419d690=
8a9fb442
      new failure (last pass: v5.9-rc2-12-g4958dfca3d0f)
      1 lines

    2020-08-26 20:33:09.223000  Connected to bcm2837-rpi-3-b console [chann=
el connected] (~$quit to exit)
    2020-08-26 20:33:09.223000  (user:khilman) is already connected
    2020-08-26 20:33:25.132000  =00
    2020-08-26 20:33:25.133000  =

    2020-08-26 20:33:25.133000  U-Boot 2018.11 (Dec 04 2018 - 10:54:32 -080=
0)
    2020-08-26 20:33:25.133000  =

    2020-08-26 20:33:25.133000  DRAM:  948 MiB
    2020-08-26 20:33:25.148000  RPI 3 Model B (0xa02082)
    2020-08-26 20:33:25.235000  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
    2020-08-26 20:33:25.268000  Loading Environment from FAT... *** Warning=
 - bad CRC, using default environment
    ... (380 line(s) more)
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f46c85b9c91f12c609fb454

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f46c85b9c91f12c609fb=
455
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f46ccd5fb60b086199fb43d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f46ccd5fb60b08=
6199fb443
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-08-26 20:57:51.745000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-26 20:57:51.751000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-26 20:57:51.757000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-26 20:57:51.763000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-26 20:57:51.769000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-26 20:57:51.775000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-26 20:57:51.781000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-26 20:57:51.787000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-26 20:57:51.793000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-08-26 20:57:51.799000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f46cb43f8044661ed9fb437

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f46cb43f8044661ed9fb=
438
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f46ccc1bd889aa1e39fb489

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f46ccc1bd889aa1e39fb=
48a
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
