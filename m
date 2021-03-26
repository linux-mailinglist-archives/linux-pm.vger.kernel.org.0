Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B034AEE3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZTBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCZTAi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 15:00:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8994C0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 12:00:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m7so5229692pgj.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dE3OaX68i8+d5yc3H7G8crZfwFPIKYXj4WQHu7U6DcU=;
        b=cRrZ3Oj2a30GkIjaiOolaMNhetZSVURRUHhE5VStC9vFuEHveRQnYex6Q8SRr5yG71
         1nnml6vYgIayxQSqP5dCje4SHNJeCvE9na52/SAD9fR9GkcgzGonMaBbB+8u1F+EZuSu
         bZRJYSUuFxo7rNNkGPddhvIz4n7hVWNUl6Vq3FVVZ2/Ex9nEG4/Avatlpaft6TgU3sAB
         Id8lUxESxCTb6WWVBpARhZij5ffEUP7WJk8/1wXqGAhbjUdKW+3MxiWHH8neIqs5gxpO
         Xi2KWRpgHhkpuekkBJ/iG6ZeDIo+JL7K6n5pXaLg6k32qD9z7ly7AwNEmhGkqSJwnsR+
         kMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dE3OaX68i8+d5yc3H7G8crZfwFPIKYXj4WQHu7U6DcU=;
        b=Mx+KemVqAaglYw+XbyvJrYfWc49wYDxjkXz84yEkYLvR6d8Nn6I/++tQPgARyAl1Oc
         0JwzR2HkyTMb/4PpU8sg3wRlDOWk3NVpu/Oji5O/fqnMUFOCCGwrsgdl26sP/UfiaIQz
         3mOg3RRRxFDIY/d0x9v0ZLrn3YhUlqRUL96gFKgGJUctIIOox8aIAKuQXj4QMgkNn0qc
         OZmSl3ZpHAFZG2J0YYsJaQbeFCFWbmtl1KF9COIFV+YylyuTh62S8gKp0QfUZd2NNjn0
         CEgfLN7bon/Wd4ZpPmldOkueMM1KAHkkPn7TUatSmFerbKIMFGHS2D6tVbVeiY5RvP3o
         Qdjw==
X-Gm-Message-State: AOAM5308Ogekj1BpC89WkZya8+gTk1bqspuMJwwM/ewCDy7kCQ05rQtH
        4GdKnsYWZbjo5lqxRmyYRtkYmA==
X-Google-Smtp-Source: ABdhPJyeN5BKApCbV0SQQOhoDnLlZsxj+QXPyRFdLCExEPNB9I/VlWjrvir11OJrRVPgcDhcQfsUtg==
X-Received: by 2002:a65:6a43:: with SMTP id o3mr13377132pgu.297.1616785237261;
        Fri, 26 Mar 2021 12:00:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4sm9420953pfn.67.2021.03.26.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:00:36 -0700 (PDT)
Message-ID: <605e2f54.1c69fb81.65165.73f3@mx.google.com>
Date:   Fri, 26 Mar 2021 12:00:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-49-ga78dc08f39195
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 111 runs,
 5 regressions (v5.12-rc4-49-ga78dc08f39195)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 111 runs, 5 regressions (v5.12-rc4-49-ga78dc08f39195)

Regressions Summary
-------------------

platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
imx8mp-evk               | arm64 | lab-nxp      | gcc-8    | defconfig | 1 =
         =

meson-gxm-q200           | arm64 | lab-baylibre | gcc-8    | defconfig | 1 =
         =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =

r8a774c0-ek874           | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-49-ga78dc08f39195/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-49-ga78dc08f39195
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a78dc08f391956cc281a98bc08f41b904ff6c831 =



Test Regressions
---------------- =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
imx8mp-evk               | arm64 | lab-nxp      | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/605e2698db69056ba6af0309

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605e2698db69056ba6af0=
30a
        new failure (last pass: v5.12-rc4-45-g972d86381b186) =

 =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
meson-gxm-q200           | arm64 | lab-baylibre | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/605e262acec902ee17af02b6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605e262acec902ee17af0=
2b7
        new failure (last pass: v5.12-rc4-45-g972d86381b186) =

 =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/605e25e8c8b81caa26af02d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605e25e8c8b81caa26af0=
2d2
        failing since 6 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/605e25fcc8b81caa26af031b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605e25fcc8b81caa26af0=
31c
        failing since 6 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a774c0-ek874           | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/605e25fbc8b81caa26af030f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605e25fbc8b81caa26af0=
310
        failing since 6 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =20
