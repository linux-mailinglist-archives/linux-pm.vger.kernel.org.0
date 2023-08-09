Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9C776C28
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHIW0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjHIW0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 18:26:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AEEC9
        for <linux-pm@vger.kernel.org>; Wed,  9 Aug 2023 15:26:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so249311a12.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Aug 2023 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691620000; x=1692224800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LIuxK2Ap3iI/cwnwLm4ABbO3u7VrVGrGbRBJD2sxMB0=;
        b=za5ql+trmRfDXCHAWJkcobV9ecujNz5DsYQ5+AVgHOsfYMfdr5pFYaxqFRzNjV6WBP
         aGX7aZcwrYdGCI3OtbH2P2s5gq4wlwtiAtccmOpE6o1JxyxyiQ868yELmzlnm/SedY0c
         4wH6YyqNsU9t5hstO8CP5VvG7hXrCqw+n2FqwkKX4cGN0R0s5FUaGkjXlhIiLGuCLx0/
         iIy83isWOIqMITBpnqTMZ5vx/6YnjAEoUP/p92JRc1nD6yHdcf6aelWpLkjSX5DWN+pv
         nmciR/YEMaNVx3PhWaUfASpKTDnZRyXrFNJZdIj2q31zv42fxZBm+3Clgf8LqvtGIGBl
         nqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691620000; x=1692224800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIuxK2Ap3iI/cwnwLm4ABbO3u7VrVGrGbRBJD2sxMB0=;
        b=D7x++LnHqCXKBQv1z49H1wzO1Hyh6oaK3zKk2L/HLAWkvRoZHeRt10+rI03MzUpmXI
         nLegfs+7KXmUq+mpJvVKZ0vduZnXyCsUbB9Axdr58yZ4jHoJJL/rCvpXe9mislJauJIn
         J7AeCkzmf44xQKU0qfmlbw/OX7exhHrlvLb8CX3USoVllCiryi9zRCbxuAaj+yDx5c9u
         rubFdyHbd76+oMhcNPe3JisvKUzGWxEzG/663nk4wD/FeuPQBaZDpRd0kOPKvsVqsVzK
         rQ3tJvbq2z7IBRZmL2z5UApJjPqxQv08G/ihLT+4F7eHD0eYjs/1fk1WgRlK5/zCcnzA
         U+jg==
X-Gm-Message-State: AOJu0Yz+ATkd5VDZ3GMijV1VECvCikrRdQ9aRH3Glo3pl8eW2JlyoNU/
        xINfbA+3pGSJyXCs/rj4bL8fWXuO++05zD8trKy5Yg==
X-Google-Smtp-Source: AGHT+IHN+Qi+ocb8ao4d+QRKV9YRgKi6IeYur2uus2fV1vOamgxIaDB5pqMBBZ14tGXsIBqGzC17zA==
X-Received: by 2002:a17:903:2441:b0:1bc:224a:45c1 with SMTP id l1-20020a170903244100b001bc224a45c1mr554377pls.55.1691619999726;
        Wed, 09 Aug 2023 15:26:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001bc9bfaba3esm37674plh.126.2023.08.09.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:26:39 -0700 (PDT)
Message-ID: <64d4129f.170a0220.765da.0177@mx.google.com>
Date:   Wed, 09 Aug 2023 15:26:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc5-74-ga20df7d5b715
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 51 runs,
 5 regressions (v6.5-rc5-74-ga20df7d5b715)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 5 regressions (v6.5-rc5-74-ga20df7d5b715)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
fsl-ls2088a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig |=
 1          =

fsl-lx2160a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig |=
 1          =

imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =

r8a779m1-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc5=
-74-ga20df7d5b715/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc5-74-ga20df7d5b715
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a20df7d5b715d8e98e9c26642039b200e00edad2 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
fsl-ls2088a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64d408f4a8426f976d35b1e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d408f4a8426f976d35b1ec
        failing since 26 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-09T21:44:58.183971  [   11.879718] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242282_1.5.2.4.1>
    2023-08-09T21:44:58.289393  =

    2023-08-09T21:44:58.390623  / # #export SHELL=3D/bin/sh
    2023-08-09T21:44:58.391058  =

    2023-08-09T21:44:58.492044  / # export SHELL=3D/bin/sh. /lava-1242282/e=
nvironment
    2023-08-09T21:44:58.492466  =

    2023-08-09T21:44:58.593446  / # . /lava-1242282/environment/lava-124228=
2/bin/lava-test-runner /lava-1242282/1
    2023-08-09T21:44:58.594140  =

    2023-08-09T21:44:58.598481  / # /lava-1242282/bin/lava-test-runner /lav=
a-1242282/1
    2023-08-09T21:44:58.622396  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
fsl-lx2160a-rdb          | arm64 | lab-nxp         | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64d408e1a492666f2c35b1dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d408e1a492666f2c35b1e0
        failing since 147 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-09T21:44:43.162815  [   17.035677] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242281_1.5.2.4.1>
    2023-08-09T21:44:43.268024  =

    2023-08-09T21:44:43.369235  / # #export SHELL=3D/bin/sh
    2023-08-09T21:44:43.369654  =

    2023-08-09T21:44:43.470639  / # export SHELL=3D/bin/sh. /lava-1242281/e=
nvironment
    2023-08-09T21:44:43.471115  =

    2023-08-09T21:44:43.572140  / # . /lava-1242281/environment/lava-124228=
1/bin/lava-test-runner /lava-1242281/1
    2023-08-09T21:44:43.572871  =

    2023-08-09T21:44:43.576911  / # /lava-1242281/bin/lava-test-runner /lav=
a-1242281/1
    2023-08-09T21:44:43.599012  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64d4088060a3a1b26135b268

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d4088060a3a1b26135b=
269
        new failure (last pass: v6.5-rc5-70-g1ce1d2ec8fc3) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64d4087c60a3a1b26135b251

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d4087c60a3a1b26135b256
        failing since 21 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-09T21:44:43.952102  / # #

    2023-08-09T21:44:44.054283  export SHELL=3D/bin/sh

    2023-08-09T21:44:44.055010  #

    2023-08-09T21:44:44.156433  / # export SHELL=3D/bin/sh. /lava-11248313/=
environment

    2023-08-09T21:44:44.157188  =


    2023-08-09T21:44:44.258635  / # . /lava-11248313/environment/lava-11248=
313/bin/lava-test-runner /lava-11248313/1

    2023-08-09T21:44:44.259730  =


    2023-08-09T21:44:44.276349  / # /lava-11248313/bin/lava-test-runner /la=
va-11248313/1

    2023-08-09T21:44:44.325832  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T21:44:44.326340  + cd /lava-112483<8>[   19.110732] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11248313_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
r8a779m1-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64d4089b3b9498179835b1e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-74-ga20df7=
d5b715/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d4089b3b9498179835b1ee
        failing since 21 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-09T21:43:55.900343  / # #

    2023-08-09T21:43:56.980172  export SHELL=3D/bin/sh

    2023-08-09T21:43:56.982039  #

    2023-08-09T21:43:58.471990  / # export SHELL=3D/bin/sh. /lava-11248307/=
environment

    2023-08-09T21:43:58.473765  =


    2023-08-09T21:44:01.194798  / # . /lava-11248307/environment/lava-11248=
307/bin/lava-test-runner /lava-11248307/1

    2023-08-09T21:44:01.197217  =


    2023-08-09T21:44:01.210187  / # /lava-11248307/bin/lava-test-runner /la=
va-11248307/1

    2023-08-09T21:44:01.269264  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T21:44:01.269769  + cd /lava-112483<8>[   28.537705] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11248307_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
