Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D87251C3
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjFGBrT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjFGBqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 21:46:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B42110
        for <linux-pm@vger.kernel.org>; Tue,  6 Jun 2023 18:45:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso6167077a12.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2023 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686102310; x=1688694310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1kBrR1WX6WinUq8F15i0r74c0059b6HoxV51QVtmnus=;
        b=WQltHNi+yK1sCsd4VRQ0pGx77pZGRL3F9JtivFISEESoHe8r5wDcBO206LSxXsgfL6
         wdCZBpIjix5vihGeG4E3boxnbqeWmzx4KFDGiYo7TEa2IU+XQIaFi++y856fUfDu67l6
         QNFquFqP4D+oyuwWHDNWGaJCbrQcKEhpnu2JtPRybbk72CUicriYTgrj4fHxsqmSEK/U
         +eulMzbOCKdSjbSIxyGvDTgOi0lzQ4H4Jk11p3CnpJqtfq5smXGoK5UlDdqkz6jWRe0u
         FIKKSfldYIogbR0/7Nrs1dptSeaPzaQVmQC4qOtn1FJ2Y7Ix7W+fJOXErwVxWpi6IUAD
         H0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102310; x=1688694310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kBrR1WX6WinUq8F15i0r74c0059b6HoxV51QVtmnus=;
        b=LimvyxDgGW2zAXYMaWZbaqlNvGTQiH67PLWStrhTxzqv6Q5Fbx9jGham00dw6KpNWo
         24OonsOUapH3tLIRoHA75JGqZamy3m4NurWIzoP5vyrxF6/b+IXp/TxkbOiZGGxIi2jx
         vmzUW28vWvHV8WwFQSpG2nQjb8QGR77nE5vdv2uJc4v/Ira0o+q0gfdAmLaDgdF0Wm1V
         qaQ8K1tG80ogUeubC1l6hr6EU/eaimjVMKmTnUWUcLvbShvOsMY+Rb7CJToDfVO0RhAK
         X48X8yXQprI/6iin6T6vU1JF4BbdbwXRU4ZVCsHgXUx2KOZ3PPhjUxY0R/GNVaxQbDPf
         Fx7g==
X-Gm-Message-State: AC+VfDy8TMuKgiwlx7TTFwfzDup27DODIX7QU/UAkQXn6hRyljKbuC/y
        j+VicKmHHvhseW1cnjeIfXT/0w==
X-Google-Smtp-Source: ACHHUZ66uABMwvXV68kC+63jusQSyh9LQq3IhCV0Pt4wIQVSRcTxZb2DO4J/vFMt9DF/OYqwAV7+6w==
X-Received: by 2002:a17:902:aa08:b0:1ab:d6f:51b0 with SMTP id be8-20020a170902aa0800b001ab0d6f51b0mr3474055plb.18.1686102309877;
        Tue, 06 Jun 2023 18:45:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902bc4900b001b0772fe3fdsm9160851plz.265.2023.06.06.18.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 18:45:09 -0700 (PDT)
Message-ID: <647fe125.170a0220.2fb03.1771@mx.google.com>
Date:   Tue, 06 Jun 2023 18:45:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc5-35-ge8195eaff86f
Subject: pm/testing baseline: 60 runs,
 3 regressions (v6.4-rc5-35-ge8195eaff86f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 60 runs, 3 regressions (v6.4-rc5-35-ge8195eaff86f)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc5=
-35-ge8195eaff86f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc5-35-ge8195eaff86f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e8195eaff86fd2ddb5f00646b5f76e40cd1164a8 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/647fd5d8f0119d4951306134

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647fd5d8f0119d4951306139
        failing since 130 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-07T00:56:33.672814  + set +x
    2023-06-07T00:56:33.673021  [   13.132910] <LAVA_SIGNAL_ENDRUN 0_dmesg =
969236_1.5.2.3.1>
    2023-06-07T00:56:33.780895  / # #
    2023-06-07T00:56:33.882636  export SHELL=3D/bin/sh
    2023-06-07T00:56:33.883194  #
    2023-06-07T00:56:33.984508  / # export SHELL=3D/bin/sh. /lava-969236/en=
vironment
    2023-06-07T00:56:33.985135  =

    2023-06-07T00:56:34.086540  / # . /lava-969236/environment/lava-969236/=
bin/lava-test-runner /lava-969236/1
    2023-06-07T00:56:34.087369  =

    2023-06-07T00:56:34.091142  / # /lava-969236/bin/lava-test-runner /lava=
-969236/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647fd7eef547193b8e306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647fd7eef547193b8e306=
135
        new failure (last pass: v6.3-rc7-189-g704d7a52a540b) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647fd7ecf547193b8e30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc5-35-ge8195e=
aff86f/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647fd7ecf547193b8e306=
12f
        failing since 49 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
