Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A76DA3EA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjDFUoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjDFUoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 16:44:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FCE93F9
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 13:41:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q2so2475456pll.7
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2023 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680813704; x=1683405704;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0RyqBnrHf5qAq/zStO97UqQan9IBD3NEJ3wWf5GgP70=;
        b=KFAEcF296CwjwQiLW29BuFsmwnCbTN7wFJx5BRxwt+HquZBpzjmv3fzKKfnffZO1du
         TOW27crC2VZfPVBl99FyHnp+yCQI6oQJZ2fqyWvrtAHkXxp0g+IBcqKCairth5QNgrZF
         TngIW/0FQpaDML3FcI/kra9PHwek9MkxWW0YLGa+S7a41orp7ZGjFdTKcxthfnBJOpwK
         Ymv17gIQB8jf7dR4lQuI89GncbBzyhEW4+9IZShcZgS+kc10XtZYSddjKbZb2pzOZ+gJ
         V9lcHPBbdAP7SWE4iTL7lrfZ7LIHrcVPkMFHx48c2A/lYLae3VY2DclkzsoF5JNHMJ5d
         DpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813704; x=1683405704;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RyqBnrHf5qAq/zStO97UqQan9IBD3NEJ3wWf5GgP70=;
        b=qz6K7aeGTb9gghj0rpLwAkLQ4rlMWoAJwEASO421uRjfoCInGOBTkyApff1YdxC8Bn
         Bho1gOJgLsK9+4l2x1o06ID52+CtvMHx8FcCeV8h4RJXrtkMA/Ahv6XPjIvFVTbM5e6j
         GHIhrJyOlrJeYhlMDD8Px4LP6L5G4S6X17F62lwfzDHQdzB7gotiO96iRTJcZPav56GC
         5REC7eUhj5Hufk7vl5muyei+uH4mNP6giRwPXryZdJokp+Mjcm/OQZhQx9N3ungBMhh0
         GR+JYTo9wRd92TB9D/h9x0flORUsejsf8OkRBY4XNiVUpZezI+UWKzYRrWpBVkbrgZF2
         /uog==
X-Gm-Message-State: AAQBX9eKIWUcB8hVWyjLIjKHZydsTAMp3/MsqgMxRybZiyU7yLpppskX
        VZvNxxi3vPK6QyHXy1RY7JKRc67TfPheH8m9ii8/65kE
X-Google-Smtp-Source: AKy350YYg4kKEi4h9qZr82s+iwTJb9HFsrJ90NYjAF0jCq+hc/1BBIcacFIcuOzeA0COgo+Ntr4dvA==
X-Received: by 2002:a17:90a:df83:b0:240:9b09:e9ce with SMTP id p3-20020a17090adf8300b002409b09e9cemr7783855pjv.16.1680813703824;
        Thu, 06 Apr 2023 13:41:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902a50c00b0019aaab3f9d7sm1759688plq.113.2023.04.06.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:41:43 -0700 (PDT)
Message-ID: <642f2e87.170a0220.34cbc.4114@mx.google.com>
Date:   Thu, 06 Apr 2023 13:41:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc5-82-g88579d8989f1
Subject: pm/testing baseline: 56 runs,
 3 regressions (v6.3-rc5-82-g88579d8989f1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 56 runs, 3 regressions (v6.3-rc5-82-g88579d8989f1)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
fsl-lx2160a-rdb    | arm64 | lab-nxp     | gcc-10   | defconfig | 1        =
  =

kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc5=
-82-g88579d8989f1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc5-82-g88579d8989f1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      88579d8989f143a528ada7f733b72091ccd3e2a6 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
fsl-lx2160a-rdb    | arm64 | lab-nxp     | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/642f24b231ba0a368a79e922

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc5-82-g88579d=
8989f1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc5-82-g88579d=
8989f1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/642f24b231ba0a368a79e929
        failing since 21 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-04-06T19:59:34.883783  [   12.605710] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1195494_1.5.2.4.1>
    2023-04-06T19:59:34.989536  / # #
    2023-04-06T19:59:35.091503  export SHELL=3D/bin/sh
    2023-04-06T19:59:35.092117  #
    2023-04-06T19:59:35.193604  / # export SHELL=3D/bin/sh. /lava-1195494/e=
nvironment
    2023-04-06T19:59:35.194110  =

    2023-04-06T19:59:35.295651  / # . /lava-1195494/environment/lava-119549=
4/bin/lava-test-runner /lava-1195494/1
    2023-04-06T19:59:35.296428  =

    2023-04-06T19:59:35.298213  / # /lava-1195494/bin/lava-test-runner /lav=
a-1195494/1
    2023-04-06T19:59:35.323484  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/642f2463614870f8de79e947

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc5-82-g88579d=
8989f1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc5-82-g88579d=
8989f1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/642f2463614870f8de79e94e
        new failure (last pass: v6.3-rc5-82-g1a2117acfb4f)

    2023-04-06T19:58:17.577309  / # #
    2023-04-06T19:58:17.678591  export SHELL=3D/bin/sh
    2023-04-06T19:58:17.678997  #
    2023-04-06T19:58:17.780277  / # export SHELL=3D/bin/sh. /lava-313406/en=
vironment
    2023-04-06T19:58:17.780652  =

    2023-04-06T19:58:17.882217  / # . /lava-313406/environment/lava-313406/=
bin/lava-test-runner /lava-313406/1
    2023-04-06T19:58:17.883225  =

    2023-04-06T19:58:17.888149  / # /lava-313406/bin/lava-test-runner /lava=
-313406/1
    2023-04-06T19:58:17.953214  + export 'TESTRUN_ID=3D1_bootrr'
    2023-04-06T19:58:17.953759  + cd /l<8>[   15.194601] <LAVA_SIGNAL_START=
RUN 1_bootrr 313406_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/642=
f2463614870f8de79e95e
        new failure (last pass: v6.3-rc5-82-g1a2117acfb4f)

    2023-04-06T19:58:20.328848  /lava-313406/1/../bin/lava-test-case
    2023-04-06T19:58:20.329599  <8>[   17.666372] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-04-06T19:58:20.329912  /lava-313406/1/../bin/lava-test-case   =

 =20
