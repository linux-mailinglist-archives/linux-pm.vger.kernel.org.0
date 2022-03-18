Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2084DE15F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 19:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiCRSwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Mar 2022 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRSwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2022 14:52:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A462DE7AC
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 11:50:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso11141278pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xusxtEg1yH90v3f9qs041AGR7cRo7f3jYv5F/vp0QUA=;
        b=eoFQ4W8gB/+ItfXJ0GV1BoiIt646iV4zN+oJZHgjQ56cGL4Hi76DC3q4gOsm960nmF
         Jm6Ysyo6IzPtEUB1U5AafpRr9LV/7lZvTjojrt/s0aIjxK93d0GbFXF+4K734axjFzBv
         dllCSbVJCrG6xPLhOsdybEJPqi4nQ7ych5xCCPrzQ3r9wrKn5TEY2ZQhbh/yox/OMuCC
         MeYCZBSQo+JVpF4wcFG09HqdP43VilUM6tv6gdsDss90woTxQacicaMYB2emLNjcUO32
         oG7loLDdHWpucZP8pl/OTk9ZdkEcCEebjm3TfndirRmlJw4F80dQ0Vg7OzaffLBghVc/
         DpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xusxtEg1yH90v3f9qs041AGR7cRo7f3jYv5F/vp0QUA=;
        b=sIOHY10/4BJsNfTX7OCVscfZqbJh+BEVAZKpJIr1I4TrVKvMRWM3nsL6AMlbdoGLer
         7vciuo3qq9Uv0JAq1lNsm0zggm8sLiHc2Jyz/ANzj3pIKN0Lh1z9uiG20lxCujfmhlA4
         EsSbuaD0vfUxeJf6jOppuQOAAd9U2Rharl3v8ni7yLOzN9KtrM0mknU6lnZ8UsvEMMXz
         PPfDvE0SyY22OSvxHySau37Fdds5rey9cys5zIEGhUF/AP5brglEmlRPRH53XDNCDpfz
         2IGuSe/azOzC4LYnWwnzYzEEynNFNMD+swwFj7Q3DMiOxVrofl9/s2Rlp0/rDrdlhjfQ
         u9/w==
X-Gm-Message-State: AOAM532YT453CzjpCUAQWRuYyckmOTi0hTSamC62AWPovgU8cevdXo+h
        o5O7xewnoN47o7hm0ehA0i65mg==
X-Google-Smtp-Source: ABdhPJzYEDRdBPcQdP0hVTpXeYKbXjmT/dKxXT0phjvBYhGG7PLYd0IeEv/P0qF5S4raol7UNsuADQ==
X-Received: by 2002:a17:902:c412:b0:154:2177:26b8 with SMTP id k18-20020a170902c41200b00154217726b8mr869503plk.36.1647629443044;
        Fri, 18 Mar 2022 11:50:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00084a00b004f7ebae5be6sm10737071pfk.155.2022.03.18.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:50:42 -0700 (PDT)
Message-ID: <6234d482.1c69fb81.fe766.ce3a@mx.google.com>
Date:   Fri, 18 Mar 2022 11:50:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.17-rc9-173-g4560f59dc554
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 43 runs,
 4 regressions (acpi-5.17-rc9-173-g4560f59dc554)
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

pm/testing baseline: 43 runs, 4 regressions (acpi-5.17-rc9-173-g4560f59dc55=
4)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =

kontron-pitx-imx8m  | arm64 | lab-kontron  | gcc-10   | defconfig          =
| 1          =

r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
7-rc9-173-g4560f59dc554/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.17-rc9-173-g4560f59dc554
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4560f59dc55401a9b00f450ae7d97f9dfa916d74 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/6234cbe9c99bec8349f800f3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6234cbe9c99bec8=
349f800f7
        failing since 31 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        16 lines

    2022-03-18T18:13:51.691139  <8>[   37.538652] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrit RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2022-03-18T18:13:51.723228  kern  :alert : 8<--- cut here ---
    2022-03-18T18:13:51.731272  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-03-18T18:13:51.735809  kern  :alert : [000001a0] *pgd=3Dbc0dd835
    2022-03-18T18:13:51.746434  kern  :alert : Register<8>[   37.590174] <L=
AVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUR=
EMENT=3D16>   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6234cbe9c99bec8=
349f800f8
        failing since 31 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        58 lines

    2022-03-18T18:13:51.748397   r0 information: NULL pointer
    2022-03-18T18:13:51.753942  kern  :alert : Register r1 information: non=
-slab/vmalloc memory
    2022-03-18T18:13:51.761271  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-03-18T18:13:51.764577  kern  :alert : Register r3 information: non=
-paged memory
    2022-03-18T18:13:51.773261  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c4f32000 pointer offset 64 size 1024
    2022-03-18T18:13:51.782036  kern  :alert : Register r5 information: sla=
b task_struct start c25ff700 pointer offset 0
    2022-03-18T18:13:51.790668  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21d2000 pointer offset 16 size 1024
    2022-03-18T18:13:51.798835  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c4f32000 pointer offset 128 size 1024
    2022-03-18T18:13:51.804620  kern  :alert : Register r8 information: non=
-slab/vmalloc memory
    2022-03-18T18:13:51.813089  kern  :alert : Register r9 information: sla=
b kmalloc-1k start c21d2000 pointer offset 0 size 1024 =

    ... (43 line(s) more)  =

 =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
kontron-pitx-imx8m  | arm64 | lab-kontron  | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6234ca3a95c2f0cc3cf8009f

  Results:     51 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/623=
4ca3a95c2f0cc3cf800b6
        new failure (last pass: acpi-5.17-rc9-163-g2a20faf0630e)

    2022-03-18T18:06:32.827407  /lava-100856/1/../bin/lava-test-case
    2022-03-18T18:06:32.827739  <8>[   11.380618] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2022-03-18T18:06:32.827941  /lava-100856/1/../bin/lava-test-case
    2022-03-18T18:06:32.828132  <8>[   11.400431] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy-driver-present RESULT=3Dpass>
    2022-03-18T18:06:32.828349  /lava-100856/1/../bin/lava-test-case
    2022-03-18T18:06:32.828518  <8>[   11.421674] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy0-probed RESULT=3Dpass>
    2022-03-18T18:06:32.828686  /lava-100856/1/../bin/lava-test-case   =

 =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6234cb39f0fe10c602f80080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator=
-x.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.17-rc9-173-g=
4560f59dc554/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator=
-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6234cb39f0fe10c602f80=
081
        new failure (last pass: acpi-5.17-rc9-163-g2a20faf0630e) =

 =20
