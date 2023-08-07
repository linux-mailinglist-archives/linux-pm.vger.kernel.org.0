Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC777303C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHGUVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjHGUVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 16:21:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E911717
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 13:21:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686e29b058cso3464994b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691439672; x=1692044472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HslrqtCVSRUzHJnRyZOwajp12vxAm0J2EKQTblzYkSE=;
        b=eTm8ixww3V4X3jZ5lX/xXNfCbKdyPYIaD8lWv2b6sMYWUot2rXzqD6hKxuQKswuzTA
         zD8eqWuYPRdY40n02YreV2FwKcyNWjj5XHVJMxhi1l4VL8qWsdUozpjX8CXLy7kkUHEm
         OB98L5QmmBNtc5fAy1iXM8foOQOX4V6Eu990w2Oryk6SOulMPBdTk5oLiiQ4lt700VXR
         913IVT32LsEHl595Jr05RvLr6/ztkynb/laZp1zcEb+ER7+WmifzVONp4X/J5eYBjU8+
         929A1/RXvo9NsBZNrS5iEsfukgO3/a5pzgi8rmB3EO0DWKtBxrX+HWhDZlpt25yc5jKo
         fFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691439672; x=1692044472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HslrqtCVSRUzHJnRyZOwajp12vxAm0J2EKQTblzYkSE=;
        b=CC0p+ZaVF/s+kWMKoiMXFOKW8v/lPS8OkGq+Or3gqyiF2nr25vvTw4QVIngOdWp7IR
         cGwicZv5ZnpaztSamYK4eBah9z5eESB4JHCW1k+AgJd+t3Zb2cv0IEdLWEjOMlgIGCQf
         qkxtkxBbljoEfg30pIA3x+vQg/IK/9gwQxyI/SSGleB412umG04A4CcyKbTWN2ChE0eV
         FOtLyoly7iSFo1OeVDU+e9L+CDEBiTVjdkWPUKuVvJ4EoBPHfiAzfUNlxe7kCiMLCNIX
         cehNWR1/RxpKQleQ2aJDN+UWGiLU+2xq3OrwvC1L7kU+4AtiHMytJaA1/wyrWyluNn+u
         Avww==
X-Gm-Message-State: AOJu0YwTduYFZXC6bTJc+KEHkfTLFn1i3ipznB/ZWdBfNPm442ldsC+P
        xBcsm6+/C9zb5n9/hasoJ3QuMg==
X-Google-Smtp-Source: AGHT+IG5Wjqm4BLKn2j086AV5Bl1I6SRKri+B9YOK8A4N0wIx3Www9atjfPz0t1MCofUkGzQa39TsA==
X-Received: by 2002:a05:6a20:6a22:b0:138:2fb8:6c48 with SMTP id p34-20020a056a206a2200b001382fb86c48mr10521283pzk.8.1691439671913;
        Mon, 07 Aug 2023 13:21:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w18-20020a637b12000000b00564d939c887sm3788757pgc.10.2023.08.07.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:21:11 -0700 (PDT)
Message-ID: <64d15237.630a0220.1e810.623e@mx.google.com>
Date:   Mon, 07 Aug 2023 13:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc5-70-g1ce1d2ec8fc3
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 50 runs,
 4 regressions (v6.5-rc5-70-g1ce1d2ec8fc3)
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

pm/testing baseline: 50 runs, 4 regressions (v6.5-rc5-70-g1ce1d2ec8fc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc5=
-70-g1ce1d2ec8fc3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc5-70-g1ce1d2ec8fc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1ce1d2ec8fc34809aa5b55619bbb6dc9577165e9 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d14874a917569c6035b241

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d14874a917569c6035b244
        failing since 24 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-07T19:39:23.729524  [   12.333553] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241419_1.5.2.4.1>
    2023-08-07T19:39:23.834687  =

    2023-08-07T19:39:23.935858  / # #export SHELL=3D/bin/sh
    2023-08-07T19:39:23.936250  =

    2023-08-07T19:39:24.037199  / # export SHELL=3D/bin/sh. /lava-1241419/e=
nvironment
    2023-08-07T19:39:24.037595  =

    2023-08-07T19:39:24.138556  / # . /lava-1241419/environment/lava-124141=
9/bin/lava-test-runner /lava-1241419/1
    2023-08-07T19:39:24.139246  =

    2023-08-07T19:39:24.143572  / # /lava-1241419/bin/lava-test-runner /lav=
a-1241419/1
    2023-08-07T19:39:24.167874  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d14889a917569c6035b27c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d14889a917569c6035b27f
        failing since 144 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-07T19:39:28.130084  [   12.569071] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241422_1.5.2.4.1>
    2023-08-07T19:39:28.235435  =

    2023-08-07T19:39:28.336731  / # #export SHELL=3D/bin/sh
    2023-08-07T19:39:28.337140  =

    2023-08-07T19:39:28.438130  / # export SHELL=3D/bin/sh. /lava-1241422/e=
nvironment
    2023-08-07T19:39:28.438534  =

    2023-08-07T19:39:28.539565  / # . /lava-1241422/environment/lava-124142=
2/bin/lava-test-runner /lava-1241422/1
    2023-08-07T19:39:28.540345  =

    2023-08-07T19:39:28.544274  / # /lava-1241422/bin/lava-test-runner /lav=
a-1241422/1
    2023-08-07T19:39:28.567008  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d14823fb8a09b6fc35b207

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d14823fb8a09b6fc35b20c
        failing since 18 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-07T19:39:43.313901  / # #

    2023-08-07T19:39:43.416083  export SHELL=3D/bin/sh

    2023-08-07T19:39:43.416824  #

    2023-08-07T19:39:43.518266  / # export SHELL=3D/bin/sh. /lava-11226581/=
environment

    2023-08-07T19:39:43.518894  =


    2023-08-07T19:39:43.620247  / # . /lava-11226581/environment/lava-11226=
581/bin/lava-test-runner /lava-11226581/1

    2023-08-07T19:39:43.621529  =


    2023-08-07T19:39:43.638114  / # /lava-11226581/bin/lava-test-runner /la=
va-11226581/1

    2023-08-07T19:39:43.688164  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T19:39:43.688697  + cd /lav<8>[   19.279586] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11226581_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d1484c17b731971335b1e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-70-g1ce1d2=
ec8fc3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d1484c17b731971335b1e9
        failing since 18 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-07T19:38:41.402733  / # #

    2023-08-07T19:38:42.482252  export SHELL=3D/bin/sh

    2023-08-07T19:38:42.484213  #

    2023-08-07T19:38:43.974011  / # export SHELL=3D/bin/sh. /lava-11226588/=
environment

    2023-08-07T19:38:43.975805  =


    2023-08-07T19:38:46.693931  / # . /lava-11226588/environment/lava-11226=
588/bin/lava-test-runner /lava-11226588/1

    2023-08-07T19:38:46.696388  =


    2023-08-07T19:38:46.709745  / # /lava-11226588/bin/lava-test-runner /la=
va-11226588/1

    2023-08-07T19:38:46.768683  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T19:38:46.769183  + cd /lava-112265<8>[   28.477236] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11226588_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
