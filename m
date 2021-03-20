Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE23A342A49
	for <lists+linux-pm@lfdr.de>; Sat, 20 Mar 2021 05:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTD7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTD7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 23:59:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF41C061761
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 20:59:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k4so3835837plk.5
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oCK+SqOZMtDruQPNPWi6BfSqAw5hVNjTZQ/q519RWlM=;
        b=gIjtPEuy8jSWJfpRRA9tV0JuxnLhPKiy2PEA5hPbgFzK+sUwl+zyo72TD130mwNZFs
         LUijMNAjYLPw5Ee5ElnMJE9xS2gniq05RBZFl1ntYL4tdICK+VUIpWvC1yQSEhxrrPl2
         Ijk9BMD5+SgnKZ10Ndow0lUaPeruEArfkI/lR3V6zkZQ8FZNciCHsRc8GwQS7C/RAJlp
         M4WSGBl+BDTefh4K1fft3DOgFPvK/cadCMwDMtCKaj/cD90Rm6bGyXHWk6kqWVvjkbm+
         8pqOjLOtiDSYfIkMTR7ArMGT0JBBDemXh++p+ViiufTJaJBglmBLg3CASGe+F8VAN49t
         24DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oCK+SqOZMtDruQPNPWi6BfSqAw5hVNjTZQ/q519RWlM=;
        b=o3ZibzSM3qG4PqbotVOB7ETLCY7JGxlUtvqcjbKPFoIXoK5tRoPVik1fckON9pMF7O
         Q5lec2uOCX5JC+x5UZRQVmkJlSU5yIWSqVBTxbuD9Msne0bEQOlXJwljau1q27hqETgI
         srtDKggbK39JCOwpF3PA6HjIG/CuUUt4ja9wyF9J7kdPFW6jzWoMwgy30KXD95vqbZhv
         RRDtWrH8rhm0v6gEf1k4+pZce2h+giY0O0zVfd+vVGLUxLPZDu3qdc2xEuGoBR/qHLWl
         0inuWgyInLtYO2brhIagRX4eMIP9XgPEmWdPyFP4VLegvt4OozAlepl/sh80hzbS5SNo
         pt9g==
X-Gm-Message-State: AOAM531pGer/YXI9w+tU7fEUVdwqy3H+38jkf3eybTfkoirhNmdVbAb0
        uwbtT+ws89YdtCEjuTfzaz6GVw==
X-Google-Smtp-Source: ABdhPJxBBP7IRAk5hTD4nJ5TCKHYadx1tfyyZK0Rzpb3h2Rsz3Dy6QLJmGf0/WwkPv+k73+Fi+GX1A==
X-Received: by 2002:a17:902:fe96:b029:e4:2f39:9083 with SMTP id x22-20020a170902fe96b02900e42f399083mr16929444plm.47.1616212747577;
        Fri, 19 Mar 2021 20:59:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z3sm6931311pff.40.2021.03.19.20.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 20:59:07 -0700 (PDT)
Message-ID: <6055730b.1c69fb81.797b0.1ba4@mx.google.com>
Date:   Fri, 19 Mar 2021 20:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-29-g4bcad1ff6cfa
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 107 runs,
 3 regressions (v5.12-rc3-29-g4bcad1ff6cfa)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 3 regressions (v5.12-rc3-29-g4bcad1ff6cfa)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
3-29-g4bcad1ff6cfa/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc3-29-g4bcad1ff6cfa
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4bcad1ff6cfaa94d624c70322135621042c25124 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6055697fa073b47d42addcbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6055697fa073b47d42add=
cbe
        new failure (last pass: v5.11-168-gd10b8fa0d6dfd) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6055697ea073b47d42addcba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6055697ea073b47d42add=
cbb
        new failure (last pass: v5.11-168-gd10b8fa0d6dfd) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605569920c13c601e9addcb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605569920c13c601e9add=
cb7
        new failure (last pass: v5.11-168-gd10b8fa0d6dfd) =

 =20
