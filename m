Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732AB76F68B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 02:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHDAhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 20:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDAhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 20:37:31 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056E4207
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 17:37:28 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a412653352so1182421b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691109447; x=1691714247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXY78h2er0p24Rs4g44vSzoJ/mvmkxtAHCNpbMnNOf8=;
        b=A/2AnPPdvJbJOmPKGVAHTi+z7+i03UNMuB2e1BTQrZo2PqwF1BcWIJnluEKNmzzpfH
         Gtz6HcaFXJndFGgO/6Xk82AsUqBjdegBuw40K6Odjubjpi/o2puxNwMs9u5GjK+YQ6IS
         EomZ6/OtD9KD30s57oFpB37k6LcmKx2L93440jg6xbDQvU1TWsRdbw0CRY44y0TuPvzD
         oEoLwsqJ7IawnXVp8akiOwk+sPWB8o7l7GCkP21XBgOPKhYH7k04ARIYimX/hhmeQSR0
         8j8kcu+gLrYMlVz+XFbxK0mwOrjQAU8dqKklZRX58H6uwijFBR13RMoc1EU6tEHz5ySI
         CkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691109447; x=1691714247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXY78h2er0p24Rs4g44vSzoJ/mvmkxtAHCNpbMnNOf8=;
        b=fH4higbGJ/XYVKP4vJDZVWlD9YaMUDVDR+XWW/Oy+f+K9XOAyvG42imHuOChhk7mbr
         8aS3jMN/CdnUl630c9MewW7pJv7mfy5DvTzne2MEveDxlWVLqJG6LyLIZc4O4BYUk2PL
         6iUolhnRHFqSmQijDk4aCxX4Vdfr7WLbKOzgRCtxZl6TLfXkhiejEFtQDBFYmGWCjeW1
         t2iWulhZzjAio5Ruhz+Z88xbvxxnoOJySoNYWXmrTp1gMIMRLGjBWJHV0MdVA5zex94j
         kONHezq13OWUReLuRAzoMduVKCvf/CH9JxPwO0XjtqawIgyA7uk1aNerkteX/LygR7ze
         Tlgw==
X-Gm-Message-State: AOJu0YysQgQXu5OHS2m3WXSX3Lyq74ZiD9s2xpdDoFPYePLuAlLg4Trt
        QNm0dvccZq61dJHIGYmikEZDBdghV/J7j33S5nWrqA==
X-Google-Smtp-Source: AGHT+IHU1zQgmAlhhCawkKhN3XMWzW+oFyxbZdF7PF7XaO0G+weoSCNzYo52xZiBzbEtSDJtp3RxwA==
X-Received: by 2002:a05:6808:1514:b0:3a7:398d:d2f1 with SMTP id u20-20020a056808151400b003a7398dd2f1mr225742oiw.49.1691109447550;
        Thu, 03 Aug 2023 17:37:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b00262d9b4b527sm404807pjo.52.2023.08.03.17.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:37:26 -0700 (PDT)
Message-ID: <64cc4846.170a0220.fd1f3.1cc2@mx.google.com>
Date:   Thu, 03 Aug 2023 17:37:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc4-68-g8a3c19975d99
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 49 runs,
 5 regressions (v6.5-rc4-68-g8a3c19975d99)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 5 regressions (v6.5-rc4-68-g8a3c19975d99)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc4=
-68-g8a3c19975d99/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc4-68-g8a3c19975d99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8a3c19975d99406f6494a292ea1fc6ef57be9183 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64cc3adc9aba04016335b22b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cc3adc9aba04016335b22e
        failing since 20 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-03T23:39:54.128297  [   16.754637] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240767_1.5.2.4.1>
    2023-08-03T23:39:54.233400  =

    2023-08-03T23:39:54.334549  / # #export SHELL=3D/bin/sh
    2023-08-03T23:39:54.334945  =

    2023-08-03T23:39:54.435899  / # export SHELL=3D/bin/sh. /lava-1240767/e=
nvironment
    2023-08-03T23:39:54.436296  =

    2023-08-03T23:39:54.537244  / # . /lava-1240767/environment/lava-124076=
7/bin/lava-test-runner /lava-1240767/1
    2023-08-03T23:39:54.537897  =

    2023-08-03T23:39:54.541962  / # /lava-1240767/bin/lava-test-runner /lav=
a-1240767/1
    2023-08-03T23:39:54.565603  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64cc3ad9f1e0ac7bd335b217

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cc3ad9f1e0ac7bd335b21a
        failing since 141 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-03T23:39:46.295242  [   17.952454] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1240765_1.5.2.4.1>
    2023-08-03T23:39:46.400716  =

    2023-08-03T23:39:46.502251  / # #export SHELL=3D/bin/sh
    2023-08-03T23:39:46.502747  =

    2023-08-03T23:39:46.603722  / # export SHELL=3D/bin/sh. /lava-1240765/e=
nvironment
    2023-08-03T23:39:46.604219  =

    2023-08-03T23:39:46.705231  / # . /lava-1240765/environment/lava-124076=
5/bin/lava-test-runner /lava-1240765/1
    2023-08-03T23:39:46.705929  =

    2023-08-03T23:39:46.709774  / # /lava-1240765/bin/lava-test-runner /lav=
a-1240765/1
    2023-08-03T23:39:46.732269  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64cc3a89f1f5e6a2b135b1ec

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cc3a89f1f5e6a2b135b1f1
        failing since 15 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-03T23:40:11.697875  / # #

    2023-08-03T23:40:11.800034  export SHELL=3D/bin/sh

    2023-08-03T23:40:11.800754  #

    2023-08-03T23:40:11.902207  / # export SHELL=3D/bin/sh. /lava-11204394/=
environment

    2023-08-03T23:40:11.902915  =


    2023-08-03T23:40:12.004373  / # . /lava-11204394/environment/lava-11204=
394/bin/lava-test-runner /lava-11204394/1

    2023-08-03T23:40:12.005527  =


    2023-08-03T23:40:12.022205  / # /lava-11204394/bin/lava-test-runner /la=
va-11204394/1

    2023-08-03T23:40:12.072390  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T23:40:12.072935  + cd /lava-112043<8>[   19.361640] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11204394_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64cc3a9cf1f5e6a2b135b269

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cc3a9cf1f5e6a2b135b26e
        failing since 15 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-03T23:39:22.944494  / # #

    2023-08-03T23:39:24.018821  export SHELL=3D/bin/sh

    2023-08-03T23:39:24.020065  #

    2023-08-03T23:39:25.504156  / # export SHELL=3D/bin/sh. /lava-11204391/=
environment

    2023-08-03T23:39:25.505490  =


    2023-08-03T23:39:28.226590  / # . /lava-11204391/environment/lava-11204=
391/bin/lava-test-runner /lava-11204391/1

    2023-08-03T23:39:28.228705  =


    2023-08-03T23:39:28.242654  / # /lava-11204391/bin/lava-test-runner /la=
va-11204391/1

    2023-08-03T23:39:28.259118  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T23:39:28.302247  + cd /lava-<8>[   28.547758] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11204391_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64cc3a9cf1f5e6a2b135b27f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc4-68-g8a3c19=
975d99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64cc3a9df1f5e6a2b135b284
        failing since 15 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-03T23:40:25.615411  / # #

    2023-08-03T23:40:25.717592  export SHELL=3D/bin/sh

    2023-08-03T23:40:25.718308  #

    2023-08-03T23:40:25.819720  / # export SHELL=3D/bin/sh. /lava-11204383/=
environment

    2023-08-03T23:40:25.820435  =


    2023-08-03T23:40:25.921897  / # . /lava-11204383/environment/lava-11204=
383/bin/lava-test-runner /lava-11204383/1

    2023-08-03T23:40:25.923218  =


    2023-08-03T23:40:25.939536  / # /lava-11204383/bin/lava-test-runner /la=
va-11204383/1

    2023-08-03T23:40:26.008367  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-03T23:40:26.008912  + cd /lava-11204383/1/tests/1_boot<8>[   18=
.392045] <LAVA_SIGNAL_STARTRUN 1_bootrr 11204383_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
