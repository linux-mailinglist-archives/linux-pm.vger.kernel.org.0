Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683467A0B1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjAXR6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjAXR6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 12:58:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D821026F
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:58:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so11772830pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qa312IQe6s7eAevg/FuIllFRk5MeLGl2PRsRn8MrkRQ=;
        b=iEieSu88AepsbWukLohZfrqQRJowo3VRiEpzUh/+iYEIV/7TmPvlrwa4x6akU0T2lB
         QhY3mMRJgTvVWlyggef+/MIMz//SZKPp/MOu18kfFg6laaUIba2bDi3Xx5ZdXpQlzET0
         zmgiuOJOiDA6MJWlZ9Ug//B4s0VlcRQwXiINF3WJRGdixghNV2qoIGDXG7WHFu3qLY2+
         734vRquA/ehnWZTP5Bvg6709drru9E7Fun7LMmwJCCDTUMXxruCMylxkWKBIzX/+kh4z
         UTCa/NUrbNk19lBpkC5wdGPxhDJQd0an3qQFMrOGbF6j/atDBqCOHnzj+FQxxZoP89Nv
         6rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qa312IQe6s7eAevg/FuIllFRk5MeLGl2PRsRn8MrkRQ=;
        b=JijZQzjn7sROns4aCl+rpfxWbN7NCtEjNOvc4Sa6GJiAJZdHCqyvUBEfEghjVrDbI+
         WsbqpvU7wb9a2PGp9MzxZsXkHeNrPshHqkR5k3V+sa2vcyp35ADiAqefEh/gexlG9yYU
         J5SQzV0oNjv4ZGU6UOEMI+LCQ3kDqR4LpLLVJi3aUenh90h7yXJInE+UTC2VpCy+uzIy
         rBHoDAeFYATX8UCjJADLIl7tx0Ol3mecKKFpI01shsjBML7izwczluORQvlRO90TdWPD
         isXAoipwkX0HtqV7a5722ycN4+47lefYikGZfUkKrjUj3mn8RrGDqw2XtEBzTPELC+6b
         HD5w==
X-Gm-Message-State: AFqh2kqXDOkuwssGqWjVV5fBUodYkSIJ7Ekjwp3Nxi+EOt94yfCFtsG5
        LwOG3zd6yTKJ3aKmQryas0GGOhAXxCCbjaJH+j0=
X-Google-Smtp-Source: AMrXdXtcR0ZNjSPVzZcn6GHYqJisf9lEziWLmPx8x/wGzSXAzeRYVFzVfhIxsbFZNHthqPGYaO90bA==
X-Received: by 2002:a62:ea13:0:b0:58d:9ad4:adaa with SMTP id t19-20020a62ea13000000b0058d9ad4adaamr28704639pfh.17.1674583130185;
        Tue, 24 Jan 2023 09:58:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ck7-20020a056a00328700b00580d877a50fsm1878976pfb.55.2023.01.24.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:58:49 -0800 (PST)
Message-ID: <63d01c59.050a0220.b94b4.372e@mx.google.com>
Date:   Tue, 24 Jan 2023 09:58:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-93-g06f503868b96
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 30 runs,
 3 regressions (v6.2-rc5-93-g06f503868b96)
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

pm/testing baseline: 30 runs, 3 regressions (v6.2-rc5-93-g06f503868b96)

Regressions Summary
-------------------

platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
cubietruck                   | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-93-g06f503868b96/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-93-g06f503868b96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      06f503868b964d4833db2465c13e0ab1efff1a5d =



Test Regressions
---------------- =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
cubietruck                   | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d00ba2998479efd8915ede

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d00ba2998479efd8915ee3
        failing since 5 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T16:47:14.074616  + set +x<8>[   15.035836] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3202287_1.5.2.4.1>
    2023-01-24T16:47:14.074911  =

    2023-01-24T16:47:14.182680  / # #
    2023-01-24T16:47:14.284163  export SHELL=3D/bin/sh
    2023-01-24T16:47:14.284514  #
    2023-01-24T16:47:14.385600  / # export SHELL=3D/bin/sh. /lava-3202287/e=
nvironment
    2023-01-24T16:47:14.386140  =

    2023-01-24T16:47:14.487504  / # . /lava-3202287/environment/lava-320228=
7/bin/lava-test-runner /lava-3202287/1
    2023-01-24T16:47:14.488258  =

    2023-01-24T16:47:14.493808  / # /lava-3202287/bin/lava-test-runner /lav=
a-3202287/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d00aeb045123a229915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d00aeb045123a229915ede
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T16:44:17.536585  / # #
    2023-01-24T16:44:17.638305  export SHELL=3D/bin/sh
    2023-01-24T16:44:17.638865  #
    2023-01-24T16:44:17.740284  / # export SHELL=3D/bin/sh. /lava-3202285/e=
nvironment
    2023-01-24T16:44:17.740842  =

    2023-01-24T16:44:17.842301  / # . /lava-3202285/environment/lava-320228=
5/bin/lava-test-runner /lava-3202285/1
    2023-01-24T16:44:17.843136  =

    2023-01-24T16:44:17.848656  / # /lava-3202285/bin/lava-test-runner /lav=
a-3202285/1
    2023-01-24T16:44:17.951643  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T16:44:17.952024  + cd /lava-3202285/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d00b06647ee05f39915ec5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-93-g06f503=
868b96/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d00b06647ee05f39915eca
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T16:44:19.389461  / # #
    2023-01-24T16:44:19.491462  export SHELL=3D/bin/sh
    2023-01-24T16:44:19.491951  #
    2023-01-24T16:44:19.593320  / # export SHELL=3D/bin/sh. /lava-3202278/e=
nvironment
    2023-01-24T16:44:19.593817  =

    2023-01-24T16:44:19.695173  / # . /lava-3202278/environment/lava-320227=
8/bin/lava-test-runner /lava-3202278/1
    2023-01-24T16:44:19.695915  =

    2023-01-24T16:44:19.700487  / # /lava-3202278/bin/lava-test-runner /lav=
a-3202278/1
    2023-01-24T16:44:19.809363  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T16:44:19.809974  + cd /lava-3202278/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
