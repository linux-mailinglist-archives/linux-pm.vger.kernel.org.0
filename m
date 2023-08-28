Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF878B39C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjH1OvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjH1Oux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 10:50:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224EDCC
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 07:50:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdc19b782aso19500595ad.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693234249; x=1693839049;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5YF8X6JuL3VQSC0zqEXENHsMZ1sCITybY7GMnrtgN4I=;
        b=0E+NxWz86zUiNWKZmpzO9que7GLRt1Xi8h+ACgqk3SucxFF9iDphKjzzCa/uxQ5CcF
         D6WUxycwRvnXsdK38MH8h3H/f0kEaGlEIaXh3rjMFX0QXI2WvqoA1vsw/Vx+SupS3UOO
         NGo8eVpOyZoWr1lOqRmXtUwt2lWqagr4g9T9Ak+iz+Yza0QlDKQkY/FjQ+ecrm13i+TA
         mBWk2mrsU8241/cftXJg09jaJQCqxMrCJcpqR55DshwiVqxVWV0lYKU7KF0i0NTNVc0L
         kT4YKPrrUk5TnMN/eQ1foTGOso6ko388AO3LJtBqvg5vO55ctxbON01nWdlGoyxcgbVA
         hpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234249; x=1693839049;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YF8X6JuL3VQSC0zqEXENHsMZ1sCITybY7GMnrtgN4I=;
        b=UYmg4kU3RWs+TAL6SPIMmcd+P2LoB4pt+QtcEyNvd33asKcgzuTGXRJk4/Qcrp5Psb
         jgeYrSnAmh2VxSolYPpM0JcNeWkhZwm0B3n9BRV7lOiY5znFSAjCa//Jrxltp+fE6PKs
         h1wlZ8DOJZFTPOiF8Z6fOFkhGOV3XqHO6kRr7A++w4AQKSjuXcwGpVbE7diziFFja5ka
         riDsTGwUojX3dv9KNJmBaC8Y2FCo66GdNNbM1j9NrDuPo1dZwE9KQiAX5ybrhwMPXs+z
         gj6pyfl2WUugrXvkheXZBwDPk6P5xSCxMthM1rcDTQidiIStrBadIouTNyIlH1ovaN3U
         nVVg==
X-Gm-Message-State: AOJu0YzxG8Z3G326fnQkaO5o7NtXyhT2dj86/PUQlna/FC3cjXvF0j0e
        9L5zhMl7CLLCPYp07Me9cD8aiQ==
X-Google-Smtp-Source: AGHT+IHQl5317ARJB+SmW3pLOaanhZRP5xOvlye+juWQ3XreIYGFOB6WoH6vgaUCaE6JlNK2JiV0VQ==
X-Received: by 2002:a17:902:dac9:b0:1c0:b8fd:9c7 with SMTP id q9-20020a170902dac900b001c0b8fd09c7mr13771544plx.43.1693234249575;
        Mon, 28 Aug 2023 07:50:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001bdf45eb5b6sm7479108plg.284.2023.08.28.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:50:48 -0700 (PDT)
Message-ID: <64ecb448.170a0220.750aa.ba8e@mx.google.com>
Date:   Mon, 28 Aug 2023 07:50:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-6.6-rc1-122-g07b618ec9d7a
Subject: pm/testing baseline: 51 runs,
 4 regressions (pm-6.6-rc1-122-g07b618ec9d7a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 4 regressions (pm-6.6-rc1-122-g07b618ec9d7a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.6-r=
c1-122-g07b618ec9d7a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.6-rc1-122-g07b618ec9d7a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      07b618ec9d7a09b421b8233f594632e379de0308 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ecaa7f12fa072500286df1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ecaa7f12fa072500286df4
        failing since 45 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-28T14:08:42.150875  + [   18.487424] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1247230_1.5.2.4.1>
    2023-08-28T14:08:42.151181  set +x
    2023-08-28T14:08:42.256294  =

    2023-08-28T14:08:42.357462  / # #export SHELL=3D/bin/sh
    2023-08-28T14:08:42.357866  =

    2023-08-28T14:08:42.458814  / # export SHELL=3D/bin/sh. /lava-1247230/e=
nvironment
    2023-08-28T14:08:42.459239  =

    2023-08-28T14:08:42.560250  / # . /lava-1247230/environment/lava-124723=
0/bin/lava-test-runner /lava-1247230/1
    2023-08-28T14:08:42.560949  =

    2023-08-28T14:08:42.565294  / # /lava-1247230/bin/lava-test-runner /lav=
a-1247230/1 =

    ... (12 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ecaa966ca5cf342c286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ecaa966ca5cf342c286d70
        failing since 165 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-28T14:09:04.258062  [   17.125242] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1247232_1.5.2.4.1>
    2023-08-28T14:09:04.363455  =

    2023-08-28T14:09:04.464697  / # #export SHELL=3D/bin/sh
    2023-08-28T14:09:04.465081  =

    2023-08-28T14:09:04.565857  / # export SHELL=3D/bin/sh. /lava-1247232/e=
nvironment
    2023-08-28T14:09:04.566226  =

    2023-08-28T14:09:04.666956  / # . /lava-1247232/environment/lava-124723=
2/bin/lava-test-runner /lava-1247232/1
    2023-08-28T14:09:04.667506  =

    2023-08-28T14:09:04.671424  / # /lava-1247232/bin/lava-test-runner /lav=
a-1247232/1
    2023-08-28T14:09:04.693279  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ecaa0c6f789ec5ae286d6c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ecaa0c6f789ec5ae286d75
        failing since 39 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-28T14:08:33.045108  / # #

    2023-08-28T14:08:33.147091  export SHELL=3D/bin/sh

    2023-08-28T14:08:33.147881  #

    2023-08-28T14:08:33.249166  / # export SHELL=3D/bin/sh. /lava-11372219/=
environment

    2023-08-28T14:08:33.249882  =


    2023-08-28T14:08:33.351177  / # . /lava-11372219/environment/lava-11372=
219/bin/lava-test-runner /lava-11372219/1

    2023-08-28T14:08:33.352242  =


    2023-08-28T14:08:33.369224  / # /lava-11372219/bin/lava-test-runner /la=
va-11372219/1

    2023-08-28T14:08:33.419094  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T14:08:33.419572  + cd /lava-113722<8>[   19.328518] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11372219_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ecaa226f789ec5ae286dee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.6-rc1-122-g07b=
618ec9d7a/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ecaa226f789ec5ae286df7
        failing since 39 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-28T14:07:31.626664  / # #

    2023-08-28T14:07:32.702483  export SHELL=3D/bin/sh

    2023-08-28T14:07:32.704362  #

    2023-08-28T14:07:34.191209  / # export SHELL=3D/bin/sh. /lava-11372211/=
environment

    2023-08-28T14:07:34.192495  =


    2023-08-28T14:07:36.909615  / # . /lava-11372211/environment/lava-11372=
211/bin/lava-test-runner /lava-11372211/1

    2023-08-28T14:07:36.911531  =


    2023-08-28T14:07:36.925408  / # /lava-11372211/bin/lava-test-runner /la=
va-11372211/1

    2023-08-28T14:07:36.941501  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-28T14:07:36.984597  + cd /lav<8>[   28.528482] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11372211_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
