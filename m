Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC17B32C4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 14:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjI2MqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjI2MqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 08:46:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F101AB
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 05:46:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c576d35feso12427071b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695991578; x=1696596378; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PoQKrJd9kKi3K5BN3LNXduSs9pojAN7dwfjLj/NAsCo=;
        b=VjKZdi+WbDgOeCfiFx5KaHAoubGmbKsjGzlH7au7s6PvVzkBiSnW+Jzdmh3kjXgoY4
         2Bb0yhKnpQkafGXkJMgcw3Hb9PXIci3HiN9NxKldKQPFanCqdsoq2DKh8QrYw8MRxiNp
         1cI7fzIUtvHWwPmCKFr1BYokF4aaEx+uas51IrTW6yYeUftuvIweD4B4sOjulpQ30ncx
         gBBTvE3X6F7TcHbN+vO2CvXr89JOcPqC85ZdbiKVjbpo1v71XRt8Ejxg2byB6+qYDxfV
         01pBDy4b/LB0ArWIaeyztf3Ol1Dng3dl+31rS7yfktXQ3bNL6wlqLiJ3V2TVIuIypV72
         jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695991578; x=1696596378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoQKrJd9kKi3K5BN3LNXduSs9pojAN7dwfjLj/NAsCo=;
        b=uyiY2puh/NNEZDQpyRxL3PqxB9mOGjsLJrOHcFGZXWaBUMNezjaEsUTccWwsdAKYJk
         wk76JcamjhnOKOZMgdGuh838TRLrA8SmBUiJCUgSXgrpmd6C+jb4viqT7MUsr5OtQIAH
         Q8FYRDqcO8fMTSfW+aniVPyRPr/+lKdMaMLusOP5ReAoXnUJwi8xkrPTLR6Itz3B0bYL
         MMnjDG2UQVjY/AowDy/kMcYu/LfjsawrRT8VzcRvP9luLAQrpV6F+uXzMZ5hRSfvWt3/
         gcBtYtgDP0IQPUkMiHSF+g/yvWhukb63+BxXL23yuxsLeBULUM/ITmunNn5j9cIlvjDB
         uWcg==
X-Gm-Message-State: AOJu0YxusmW/nKJY7VxPYe4Tp75F4uoY070+vOQWZnneOi57dD51hT8r
        6kZRAPA7ea4oWZ+14gmgnbFmxQ==
X-Google-Smtp-Source: AGHT+IGib4k3RxgedUamTfJURN7bz2w1phioYOcOFkvkoVe3X0NHdCWvi8hF4Kv9aCMS+Hb6ssQllQ==
X-Received: by 2002:a05:6a00:3912:b0:690:2ecd:a593 with SMTP id fh18-20020a056a00391200b006902ecda593mr4708382pfb.26.1695991578534;
        Fri, 29 Sep 2023 05:46:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7801a000000b0068c10187dc3sm14888395pfi.168.2023.09.29.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:46:18 -0700 (PDT)
Message-ID: <6516c71a.a70a0220.c03e7.b57f@mx.google.com>
Date:   Fri, 29 Sep 2023 05:46:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-95-g705ffbf392dc
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 2 regressions (v6.6-rc3-95-g705ffbf392dc)
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

pm/testing baseline: 46 runs, 2 regressions (v6.6-rc3-95-g705ffbf392dc)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc3=
-95-g705ffbf392dc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc3-95-g705ffbf392dc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      705ffbf392dc64e6f54772eb08e99d94f7845ed8 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6516bcc7e93a393af68a0a42

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-95-g705ffb=
f392dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-95-g705ffb=
f392dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6516bcc8e93a393af68a0a4b
        failing since 71 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-29T12:06:23.272214  / # #

    2023-09-29T12:06:23.372681  export SHELL=3D/bin/sh

    2023-09-29T12:06:23.372850  #

    2023-09-29T12:06:23.473421  / # export SHELL=3D/bin/sh. /lava-11639476/=
environment

    2023-09-29T12:06:23.473570  =


    2023-09-29T12:06:23.574027  / # . /lava-11639476/environment/lava-11639=
476/bin/lava-test-runner /lava-11639476/1

    2023-09-29T12:06:23.574243  =


    2023-09-29T12:06:23.586081  / # /lava-11639476/bin/lava-test-runner /la=
va-11639476/1

    2023-09-29T12:06:23.627909  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-29T12:06:23.645378  + cd /lav<8>[   20.535598] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11639476_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6516bcdae93a393af68a0a5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-95-g705ffb=
f392dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-95-g705ffb=
f392dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6516bcdae93a393af68a0a64
        failing since 71 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-29T12:04:34.353780  / # #

    2023-09-29T12:04:35.434433  export SHELL=3D/bin/sh

    2023-09-29T12:04:35.436310  #

    2023-09-29T12:04:36.922133  / # export SHELL=3D/bin/sh. /lava-11639469/=
environment

    2023-09-29T12:04:36.923424  =


    2023-09-29T12:04:39.646946  / # . /lava-11639469/environment/lava-11639=
469/bin/lava-test-runner /lava-11639469/1

    2023-09-29T12:04:39.649085  =


    2023-09-29T12:04:39.662401  / # /lava-11639469/bin/lava-test-runner /la=
va-11639469/1

    2023-09-29T12:04:39.678430  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-29T12:04:39.721511  + cd /lava-116394<8>[   28.545948] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11639469_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
