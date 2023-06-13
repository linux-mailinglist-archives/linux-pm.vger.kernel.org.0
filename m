Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7972D83D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 05:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFMDuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbjFMDt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 23:49:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7AD10EA
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 20:49:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39ca48cd4c6so2629798b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686628160; x=1689220160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhyEyaRzw8vmUlYau12G7d6TigO6ud1X5eeR8Pj+WCk=;
        b=3WOLOv3lkSMJFzJlb2aJCw/jt9FPKQAk3FiEwCnMgpUPTo5FWLXuxOg0ofdWwFqBkD
         S8HJhiuzBaKixmmQ71d+DVC2SL9Vybl7gOr+7E2gUQLLCOPxAL5a5BZIJ+rgMCkxEc4H
         +duebaHYNIZC35ikBJNeC8uGoof6no+PdIxQp0SfspU0L3NIxODjBrnXuFV7d/dSTXlR
         6I9HbEH3FEVIyLjyrI2IE3gJABLnhKsYFlftlKdl0V2IIl5Vw78hlKodAm7AZG4TaD37
         mGS4nrV5LmM+Hd22rITyN/7PLPfbaZxbw7mB6SqNHoDV5meZoNKy1FEHOiiffhEg/z61
         sbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628160; x=1689220160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhyEyaRzw8vmUlYau12G7d6TigO6ud1X5eeR8Pj+WCk=;
        b=VUj4xztxMmvL0cwSG8Xol8cKJyUJmHvhQeFLz2yY8PntM3RAtHJqBjkFUpu5NxyBbg
         dko+J06GNj94KC6JrSzXvsHh1MsIiPf7RB6onz5Adwka1RSynOfWis0FQb4639UuuOkx
         9o+esNYe/lo/ShYceq2fFbPwCjXRSQzX4ADYY9V5uUYf9JC0IUi7WErUlPsCTzRNdijq
         3ErpipESi9cMw8Oc85ry0SkvUiW8ffC2lAU6ADj40J57mkO9KUoOJAxnW0Es7wbkUV7O
         N2zjXp4lXuARASbwnWxDsKmB+AUs1exMh3MCiOumpHiZW/XpDLdt0XSl5Q0HHZzeV0Oq
         obgw==
X-Gm-Message-State: AC+VfDw137rbbfcHzVciZRGwv4Nz8QI8jLVA4MO81XdOnB50c+ijdXn4
        ql9FCHw2zUdOElfWzD5KCuSDONHA59ioS4QBf1BLcg==
X-Google-Smtp-Source: ACHHUZ6nIRrC1Q55qtjUcd0rCopmvQ1rM/J+KoaG6XnDiXYImAYlV3KLTqm5LQA3FE2CWzogfRSqHA==
X-Received: by 2002:a05:6808:aab:b0:39c:40f4:5bde with SMTP id r11-20020a0568080aab00b0039c40f45bdemr5929546oij.41.1686628160667;
        Mon, 12 Jun 2023 20:49:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b0024e37e0a67dsm8841493pjh.20.2023.06.12.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 20:49:19 -0700 (PDT)
Message-ID: <6487e73f.170a0220.1a48f.2165@mx.google.com>
Date:   Mon, 12 Jun 2023 20:49:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc6-36-g7796be1562e2
Subject: pm/testing baseline: 48 runs,
 2 regressions (v6.4-rc6-36-g7796be1562e2)
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

pm/testing baseline: 48 runs, 2 regressions (v6.4-rc6-36-g7796be1562e2)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc6=
-36-g7796be1562e2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc6-36-g7796be1562e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7796be1562e27d8b9441fe1c2c2ecfc1ebdea55d =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6487d8d819bf33007530619d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc6-36-g7796be=
1562e2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc6-36-g7796be=
1562e2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487d8d819bf3300753061a2
        failing since 136 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-13T02:47:30.885845  + set +x
    2023-06-13T02:47:30.886032  [   13.139853] <LAVA_SIGNAL_ENDRUN 0_dmesg =
975017_1.5.2.3.1>
    2023-06-13T02:47:30.993529  / # #
    2023-06-13T02:47:31.095307  export SHELL=3D/bin/sh
    2023-06-13T02:47:31.095797  #
    2023-06-13T02:47:31.197035  / # export SHELL=3D/bin/sh. /lava-975017/en=
vironment
    2023-06-13T02:47:31.197532  =

    2023-06-13T02:47:31.298940  / # . /lava-975017/environment/lava-975017/=
bin/lava-test-runner /lava-975017/1
    2023-06-13T02:47:31.299748  =

    2023-06-13T02:47:31.302950  / # /lava-975017/bin/lava-test-runner /lava=
-975017/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6487dd75edfd290a38306188

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc6-36-g7796be=
1562e2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc6-36-g7796be=
1562e2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6487dd75edfd290a38306=
189
        failing since 55 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
