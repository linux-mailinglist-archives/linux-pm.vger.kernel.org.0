Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1064602BDA
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJRMgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJRMgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 08:36:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4472C2C9A
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 05:36:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q9so13165487pgq.8
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lhlz+YskMMoC/9BU2C6LzqooBInGuFa1uCMWlWjJ86o=;
        b=j9tUAbWh+iMNyRmFazUnLR8FhxSL+kmU0T4n6kiw/Je/7qQxCMhBcR2w8DlRxci85n
         L/FaW59o2kBf98eIYgm9+GRMOsOlDV4HLe70a+1iVZuFc2AOqosjBCux1Ud1oFqgFqWy
         bqUp5nEYERlAIhzCHFmZfbsV1Q4LjKebfVnUxW0Nb1W0yNkWAJYZNy6l/zfrwTMPmb+g
         C/PxiX6OG6zzMWYGzlvt+nfLNVqa9XejZbH4HLvu3NjR/4oqBjco2JQnmER5x0QYuZOs
         PrRWClvT+n/Krd1UwQqeltoaIrLADx2OXxrIp42LGBYQbgzSmKETYOitpMi7Q3nqkGuX
         rBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhlz+YskMMoC/9BU2C6LzqooBInGuFa1uCMWlWjJ86o=;
        b=BKBdyO4W8yg0XR7a3kHCaYeiqxlssG+WLKq5vJqG1rhD1HIa2H21FF4eeoxLb32aIk
         JYrDLWwAdvgFtFKiIenU2XCmRzGKe/lJmHlKigYUr7WNS/I2NcTxQ7lda8ftPYXU2Xg5
         BUTzkr7J6/nQe9yG+gXHGHSIWOVik6nXvSY+4Yz3VXkyvJmnpuG9OWYvTgTW7kiezCOL
         ueH8xfBCJ1FfXNSSS0z2zk1tYVFySlMhGOqCo+GUZuWgjn8zsP14YNJqE7sEbxD7wdaM
         m7qwYrXPiq4ZZ8b3GJkKJZ3zs4JkVMuNThOyCNamRDxLbAk2dSYlznzaym+hPC/3SQh1
         sqhA==
X-Gm-Message-State: ACrzQf13aeOr844ntCMInditxu8TUEknh19TDOuvpAxPoKU1+Gz3vnYH
        Bww+wKjOwN2r3DaMqu38NtQ9g8ooSXp0f8Rc
X-Google-Smtp-Source: AMsMyM6QC0CekslL0EtE16ckruKghC2onbGkJl0KLXmD3/OX4aVh6b2oOt9zwLQtDMAAhW/ldcTqJw==
X-Received: by 2002:a63:ce43:0:b0:45b:d6ed:6c2 with SMTP id r3-20020a63ce43000000b0045bd6ed06c2mr2450890pgi.406.1666096558834;
        Tue, 18 Oct 2022 05:35:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0017c3776634dsm8611944pln.32.2022.10.18.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:35:58 -0700 (PDT)
Message-ID: <634e9dae.170a0220.f0155.fb4d@mx.google.com>
Date:   Tue, 18 Oct 2022 05:35:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.1-rc1-8-g2deb12ae181b
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs, 1 regressions (v6.1-rc1-8-g2deb12ae181b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 47 runs, 1 regressions (v6.1-rc1-8-g2deb12ae181b)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc1=
-8-g2deb12ae181b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc1-8-g2deb12ae181b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      2deb12ae181bdfe8f5df73b20ce932ab015604b0 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/634e918950bfcd5603c2a877

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc1-8-g2deb12a=
e181b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc1-8-g2deb12a=
e181b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
4e918a50bfcd5603c2a884
        failing since 133 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-18T11:43:44.777259  /lava-185698/1/../bin/lava-test-case
    2022-10-18T11:43:44.777925  <8>[   17.452902] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-18T11:43:44.778185  /lava-185698/1/../bin/lava-test-case
    2022-10-18T11:43:44.778415  <8>[   17.469194] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-18T11:43:44.778640  /lava-185698/1/../bin/lava-test-case
    2022-10-18T11:43:44.778856  <8>[   17.487031] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-18T11:43:44.779068  /lava-185698/1/../bin/lava-test-case   =

 =20
