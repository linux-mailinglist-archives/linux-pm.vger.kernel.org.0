Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970107C5A77
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjJKRpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJKRpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 13:45:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAD493
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 10:45:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c888b3a25aso763305ad.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697046343; x=1697651143; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nEnmRlMcIfB0vsp7eOd9pK8KOFCNqsfCWrewtFMzAK4=;
        b=dIcjFrQups0kzZL46UnCK0z8GDdB9EUo6WrbxOXElqqryvhTJFHSxL6PUwc0+GtuUb
         8LLP/E1aRPwsIRUt5EmrxDkHGbI2AHRXh+ecJiXLmoK0T+fV2H+IcslGnO6oIzA3sHoA
         i7DPTw9+KxLL/Zb/nzJnkc/p6gA2yOnzyctmxDuRtjqT0vbWzji+mDWt0cq4tmFXCpIq
         D/0L0S2vuzYZf9QFpcr+ecJjtEwwq5ojBjjXRhttGEoyvZoi+s8oV3QFtuQgs2auUYc+
         xJSCW9lQJpK0Tplyy1wXwhfYWfyKBpvFWxLTYtjhmj/zjQ/Dfr6j6ch/gbHFDW8ggMmy
         CrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046343; x=1697651143;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEnmRlMcIfB0vsp7eOd9pK8KOFCNqsfCWrewtFMzAK4=;
        b=hS3yBw7+e+4EGpQKZgO3AV7bT6G696mfa04c7eTmdoEq+ETnVRVHDZ6ak8H12SF3aF
         mZZZQ1hBeRqPr7XdeSN/lZMkHhmhBrH1+W0llvZ3Bw4bYECwzSxMIA5Oqn3CI9ADWtDm
         3WwY401/nhSzYgyhwomi71GBDbe747dZPUPJGL4RGN6r99B2M3AWE2BZjlv7OmqzcDy7
         wAYZO4FCkWm4ZHKSA0R0cfx7TpGXE6PrUOkOVUHwBVvHJryVk4dUiPyphCX8v1kaUehP
         VOvBDJCIvdARU9LsDlfUWOjzfit+BQR845jEZ6uZ0oWAuLLV2uRN9377zEzPFkUPT7vu
         LWuQ==
X-Gm-Message-State: AOJu0YwP9qtO0ZWijrMMox5PCHEs8s/ah601zroNqDvaRHtsa3IhOrZ/
        rVI35mVtGRAm7hds0weD8ZJJ6Q==
X-Google-Smtp-Source: AGHT+IFkNwkGT3TJq+CO/TXBR49z7F82oTHy5Quca+UgVwIvuAizb/bF7Jr+btxXFboRYpynfx1BKg==
X-Received: by 2002:a17:902:e5c7:b0:1c6:ec8:4c67 with SMTP id u7-20020a170902e5c700b001c60ec84c67mr22393317plf.18.1697046342937;
        Wed, 11 Oct 2023 10:45:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b001c72d694ea5sm98147plb.303.2023.10.11.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:45:42 -0700 (PDT)
Message-ID: <6526df46.170a0220.35e5a.074a@mx.google.com>
Date:   Wed, 11 Oct 2023 10:45:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-141-g45db6c21c12e0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.6-rc5-141-g45db6c21c12e0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 3 regressions (v6.6-rc5-141-g45db6c21c12e0)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc5=
-141-g45db6c21c12e0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc5-141-g45db6c21c12e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      45db6c21c12e0b3fc5f5909c46d34911ceb42285 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526d9d3c1162a9da1efcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526d9d3c1162a9da1efcefc
        failing since 29 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-11T17:22:04.283764  + set<8>[   27.669177] <LAVA_SIGNAL_ENDRUN =
0_dmesg 164735_1.5.2.4.1>
    2023-10-11T17:22:04.284356   +x
    2023-10-11T17:22:04.392962  / # #
    2023-10-11T17:22:05.558824  export SHELL=3D/bin/sh
    2023-10-11T17:22:05.564981  #
    2023-10-11T17:22:07.064254  / # export SHELL=3D/bin/sh. /lava-164735/en=
vironment
    2023-10-11T17:22:07.070350  =

    2023-10-11T17:22:09.793510  / # . /lava-164735/environment/lava-164735/=
bin/lava-test-runner /lava-164735/1
    2023-10-11T17:22:09.800257  =

    2023-10-11T17:22:09.802623  / # /lava-164735/bin/lava-test-runner /lava=
-164735/1 =

    ... (12 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526d505bdd7048528efcf36

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526d505bdd7048528efcf3f
        failing since 83 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-11T17:06:02.203725  / # #

    2023-10-11T17:06:02.304156  export SHELL=3D/bin/sh

    2023-10-11T17:06:02.304254  #

    2023-10-11T17:06:02.404689  / # export SHELL=3D/bin/sh. /lava-11742557/=
environment

    2023-10-11T17:06:02.404800  =


    2023-10-11T17:06:02.505222  / # . /lava-11742557/environment/lava-11742=
557/bin/lava-test-runner /lava-11742557/1

    2023-10-11T17:06:02.505402  =


    2023-10-11T17:06:02.517715  / # /lava-11742557/bin/lava-test-runner /la=
va-11742557/1

    2023-10-11T17:06:02.559822  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T17:06:02.576906  + cd /lav<8>[   20.527110] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11742557_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526d52d3c7403a51befcf09

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-141-g45db6=
c21c12e0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526d52d3c7403a51befcf12
        failing since 83 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-11T17:04:43.197365  / # #

    2023-10-11T17:04:44.277518  export SHELL=3D/bin/sh

    2023-10-11T17:04:44.279368  #

    2023-10-11T17:04:45.770819  / # export SHELL=3D/bin/sh. /lava-11742562/=
environment

    2023-10-11T17:04:45.772777  =


    2023-10-11T17:04:48.497763  / # . /lava-11742562/environment/lava-11742=
562/bin/lava-test-runner /lava-11742562/1

    2023-10-11T17:04:48.500096  =


    2023-10-11T17:04:48.506752  / # /lava-11742562/bin/lava-test-runner /la=
va-11742562/1

    2023-10-11T17:04:48.569193  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T17:04:48.569663  + cd /lava-117425<8>[   28.578900] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11742562_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
