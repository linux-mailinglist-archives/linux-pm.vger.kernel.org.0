Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6626746F2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 00:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjASXNZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 18:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjASXM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 18:12:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BF8E
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 15:06:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so6518812pjq.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 15:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OL5KWbHtN9N424EGf5VxFy0aw3wyAXOdJRr5Uzneh88=;
        b=y1dHACgyFkMnd5Y1NzhqLEtaEOP0/E5vwubdnn5iQJ7l3UUA8245cD7/sCIeAWY/8E
         7Yi5e099e62biGnLQZPYOz9ybelOdjaIDJKZWq6XZOMVpGeWmJwkwkkIF/E/br1XfjzB
         V666E9QSeFF6hfAHDjWm1JPlzzrUbF91TSQGl0GNtz8T26CUZ5c0LRh8e0M7gpXoGLKK
         BdG2b33nvmRNsSLn1aVm2NGQtOK/zp9O/4Z8c/gF1wU6r5KQYqPDE5VW6O0h3mnIooGA
         dVV/uqvew1tI4FRYpAfbMfieAX1w1VZTU3usyXqD3xB0nqSmFStZ9IZarJ9hK6KiymPH
         5Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OL5KWbHtN9N424EGf5VxFy0aw3wyAXOdJRr5Uzneh88=;
        b=vKHnfhr5VmWO3bEGfavLeC6r55/5d9sKv7vHWHNpValUB0nMWzN9Fasi5/oicGgBHf
         YuLIBV1LebOkXf7enlG0t78PNjUfrwAY1GC+Rqmabm3qZvN7b4VQZ0jkzjHBHwNYXK08
         5s/13cTAAIo+DwPxzrTodxh+Lq00H0sUHmjhOEBvgNBo75OBKFeqMkbAVqpr5A6w1q3I
         kS/DNghVJIPKL6FLSuLclQcEFGP2+ii+K5SKUqfPSSlhS8p/O9XI/VyRsV+NF9aMHctv
         Vvd/0b7tA1ARcCSxyZqbnxBqg3MmvsviFFbI+VusqeFsK4+m+KUwrG5PUf9grd9MpWZI
         n8jQ==
X-Gm-Message-State: AFqh2kq3JEWTH20MrDrcwFc/FAY7vorVdHdthpNFEKLRqX3JvMtPc9sY
        D44iNjN9984wmVg0Vez32JpWRw==
X-Google-Smtp-Source: AMrXdXvsNa3DuKwidckBUHjUP+wWwYWhSi3A2vUqsbL9VtTbiBG66eAffK6lxkHm4GGJbC6xUI+rLQ==
X-Received: by 2002:a05:6a20:6048:b0:b9:40b7:76af with SMTP id s8-20020a056a20604800b000b940b776afmr2870990pza.14.1674169594235;
        Thu, 19 Jan 2023 15:06:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b005882b189a44sm21179070pfr.104.2023.01.19.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:06:33 -0800 (PST)
Message-ID: <63c9ccf9.a70a0220.6efe7.3114@mx.google.com>
Date:   Thu, 19 Jan 2023 15:06:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc4-80-gafd822f01cda
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 78 runs,
 2 regressions (v6.2-rc4-80-gafd822f01cda)
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

pm/testing baseline: 78 runs, 2 regressions (v6.2-rc4-80-gafd822f01cda)

Regressions Summary
-------------------

platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc4=
-80-gafd822f01cda/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc4-80-gafd822f01cda
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      afd822f01cda9833bb5a4525a0dd36c689c5941a =



Test Regressions
---------------- =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9c2c511230669f3915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc4-80-gafd822=
f01cda/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc4-80-gafd822=
f01cda/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c9c2c511230669f3915ebf
        failing since 1 day (last pass: v6.1-rc8-224-g02f29b079520, first f=
ail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-19T22:22:45.793765  / # #
    2023-01-19T22:22:45.895488  export SHELL=3D/bin/sh
    2023-01-19T22:22:45.895870  #
    2023-01-19T22:22:45.997265  / # export SHELL=3D/bin/sh. /lava-3173379/e=
nvironment
    2023-01-19T22:22:45.997818  =

    2023-01-19T22:22:46.099184  / # . /lava-3173379/environment/lava-317337=
9/bin/lava-test-runner /lava-3173379/1
    2023-01-19T22:22:46.099849  =

    2023-01-19T22:22:46.105019  / # /lava-3173379/bin/lava-test-runner /lav=
a-3173379/1
    2023-01-19T22:22:46.208950  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T22:22:46.209451  + cd /lava-3173379/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63c9c2c4f2182d612d915ecb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc4-80-gafd822=
f01cda/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc4-80-gafd822=
f01cda/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c9c2c4f2182d612d915ed0
        failing since 1 day (last pass: v6.1-rc8-224-g02f29b079520, first f=
ail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-19T22:22:40.239496  / # #
    2023-01-19T22:22:40.341476  export SHELL=3D/bin/sh
    2023-01-19T22:22:40.342020  #
    2023-01-19T22:22:40.443377  / # export SHELL=3D/bin/sh. /lava-3173378/e=
nvironment
    2023-01-19T22:22:40.443911  =

    2023-01-19T22:22:40.545309  / # . /lava-3173378/environment/lava-317337=
8/bin/lava-test-runner /lava-3173378/1
    2023-01-19T22:22:40.546139  =

    2023-01-19T22:22:40.550726  / # /lava-3173378/bin/lava-test-runner /lav=
a-3173378/1
    2023-01-19T22:22:40.658688  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T22:22:40.659112  + cd /lava-3173378/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
