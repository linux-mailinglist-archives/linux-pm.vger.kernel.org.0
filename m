Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987B4DB0CB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Mar 2022 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356169AbiCPNPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Mar 2022 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356173AbiCPNPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2022 09:15:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218731932
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 06:14:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bc27so232426pgb.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bTcOi69EbkgYJIUMlVcpIvvEL8uGwxySsR4pAZ73z/E=;
        b=8BBKaMKgz4McdnTItGeSOeAIVmK62KSfIvs1VMfq5kiAhrVquBltQuGfzJoDlXKYGW
         B34wx/Noi26pj6gqzoEU2D9tF0g73+Ie/gKUdkEpYqKDeeEOwncpa40ukG+uYj9AZbW3
         olaQBtzA7P5PqQFo0t4AaaDrfOn+1TiBxngqBwjbV2e+Sp2thnq3GHyAS2VeosGTzqAR
         XaDuZ+gej7kbVQP1vZ9qYOdTGhopyYcG1xxG6ySFKwFATyWjH9SF3IQakvKu2D0wP5W6
         bvpChl8UllU1xoXWxY303gcGQqUKJ8OOKhp06f0e/fX2jBu7f7VnL5phJOLj/UEQjFET
         27Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bTcOi69EbkgYJIUMlVcpIvvEL8uGwxySsR4pAZ73z/E=;
        b=r5xPsOh+ao9hFPmV/TfMRj8Fg+KrJq0RNjGkPvLDxwvAcUr7rXZ9+vHrr8k5keT1Tl
         vamrjC7TVmkAisq7ipW+Al+U71VbPF+w5tjBYgx3xk4Lb6UCIBkEPIORclWEhwk3Yxwv
         h0BrL2rDWgR9lp3PpKryHNwboX3F5QymDFUabRWYScFTZQD/6gK7OQen5shdZT3qcJIT
         rfLmDroB1C3o4l2783oFjr1SujT4n1BSZ6kQ+IiJGWRkzrDfxvHCwy4iULKzGdgH6rDt
         6VM7MVHNgwRLwIk/GB7g1/VCEQ7HgZsukfGBha32xWjqWZW7OmFKXoM3y1xz7Ii4BToX
         RtHg==
X-Gm-Message-State: AOAM533W2feuW7gNrX0lkcsAsZUfBUW7DGlE4vbCxJ2qxUCYeWPxb8xj
        V5oCMBtTDlRXrQ7KNlb4nwGUvwhRFE3ZNv0AaqM=
X-Google-Smtp-Source: ABdhPJyxFa7x7JC/NAyZrX6259L1SaZc5UQNXaDrCNg3afUA6AeWwHZswBFqnHqPHS0i/AufmF5PIw==
X-Received: by 2002:a65:4cc9:0:b0:381:4472:bbb4 with SMTP id n9-20020a654cc9000000b003814472bbb4mr11125485pgt.10.1647436454770;
        Wed, 16 Mar 2022 06:14:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e18-20020a63d952000000b00372a1295210sm2520626pgj.51.2022.03.16.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:14:14 -0700 (PDT)
Message-ID: <6231e2a6.1c69fb81.b19bb.5aac@mx.google.com>
Date:   Wed, 16 Mar 2022 06:14:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc8-157-gad2ced059eef
Subject: pm/testing baseline: 46 runs,
 3 regressions (v5.17-rc8-157-gad2ced059eef)
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

pm/testing baseline: 46 runs, 3 regressions (v5.17-rc8-157-gad2ced059eef)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =

r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
8-157-gad2ced059eef/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc8-157-gad2ced059eef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ad2ced059eefe51ab94f02bd67ab6fbffb499d9e =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/6231d8af2ed9ce26a7c62993

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc8-157-gad2c=
ed059eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc8-157-gad2c=
ed059eef/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6231d8af2ed9ce2=
6a7c62997
        failing since 29 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        16 lines

    2022-03-16T12:31:20.062541  kern  :alert : 8<--- cut here ---
    2022-03-16T12:31:20.070621  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-03-16T12:31:20.073989  kern  :alert : [000001a0] *pgd=3Dbc0fa835
    2022-03-16T12:31:20.085086  kern  :alert : Register<8>[   37.531393] <L=
AVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUR=
EMENT=3D16>   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6231d8af2ed9ce2=
6a7c62998
        failing since 29 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        58 lines

    2022-03-16T12:31:20.087807   r0 information: NULL pointer
    2022-03-16T12:31:20.094371  kern  :alert : Register r1 information: non=
-slab/vmalloc memory
    2022-03-16T12:31:20.099023  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-03-16T12:31:20.105122  kern  :alert : Register r3 information: non=
-paged memory
    2022-03-16T12:31:20.112834  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c21d2c00 pointer offset 64 size 1024
    2022-03-16T12:31:20.120606  kern  :alert : Register r5 information: sla=
b task_struct start c2331980 pointer offset 0
    2022-03-16T12:31:20.128964  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21d2000 pointer offset 16 size 1024
    2022-03-16T12:31:20.138918  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c21d2c00 pointer offset 128 size 1024
    2022-03-16T12:31:20.143281  kern  :alert : Register r8 information: non=
-slab/vmalloc memory
    2022-03-16T12:31:20.152038  kern  :alert : Register r9 information: sla=
b kmalloc-1k start c21d2000 pointer offset 0 size 1024 =

    ... (44 line(s) more)  =

 =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6231d85aefb661d9c4c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc8-157-gad2c=
ed059eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc8-157-gad2c=
ed059eef/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6231d85aefb661d9c4c62=
969
        failing since 3 days (last pass: v5.17-rc7-144-gcdd758e337cb, first=
 fail: v5.17-rc7-161-gbda0a27564ac) =

 =20
