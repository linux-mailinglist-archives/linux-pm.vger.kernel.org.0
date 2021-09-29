Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63C641BBA4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbhI2AOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 20:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhI2AOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 20:14:47 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713BDC06161C
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 17:13:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s11so782783pgr.11
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2+pefwxNyyAlW782iO5ElW43s2yDhbluopyYBnEoHj8=;
        b=iR7B/fEOGbopLoqkiO8e2i1p07WMP4LpCXHuvNPr7LNt278gfoaMLLSoTO9I/PiQ7i
         MzwgHw2cfslyxhGJC47x4+dIQa1FXsSJ6JYQme5iR70sFTNJEwPuoTvrMdvXE5pX00P4
         vBXNoYHffbp50MmZ1aBpA0DaiRTHN+rjRyeL8flv5n7hZqeyBUTewD0h5Wn+nCzeGhy0
         frjA/flve9nlVniP0w/EqcJ6L4Bp41XnpGdP04gEBsWcJaTP7YwgnI47tDbOv6eGnSM0
         hNW4VjJ1Yavr/HZ7QfdFLKI4BwDbNjRWLTibnrOGkYersxh/dySqUKYIDGI85vSDcctW
         RlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2+pefwxNyyAlW782iO5ElW43s2yDhbluopyYBnEoHj8=;
        b=S2gegk0Bm1EOZPHIYDCWqNMm9MBAkBymtrTKvspvxyhm97RyCCxmFRFJXd/mpanu/g
         MlKCvI6q3HLkSorLpsJ8r6fze75cgobtGMeS5CzZQCD8S1fKxar7k4FFi1eMZ/c4czEJ
         ozHax0pxtxKBsf1SGexa9NEpOfl6rkYzG4nV9x/1BV1pnCrfCrN5zbODjbQX/Glfx3Wt
         CjSw2PbgpJ4zQGKRNKLLW9+d3b7Eq5v76qa+SVDpCHh9mz9ZsjUr98p9CHPCNSCxaKb+
         BTJgoofgJ7s8UfrNDMTOwdqYjlSOsrANQgXbQDNXl+Jipgsy03s2fVTyK78p1zoP5iI9
         KVzQ==
X-Gm-Message-State: AOAM530NsJO6zSjSoK6uG8mpv/AE4k1euiUDEZwTd4741AWuOf18kWy8
        y4k/cSkVQ/LUOTPROOP8+7Peiw==
X-Google-Smtp-Source: ABdhPJy7SxHWNKOfEAuey32XQkc4zUq9la/JWr4PGJyxzRqskx+XUgPywH8ybeMLp84HQWQhiq+lfQ==
X-Received: by 2002:aa7:9485:0:b0:44b:b7ff:85bd with SMTP id z5-20020aa79485000000b0044bb7ff85bdmr3997303pfk.20.1632874386907;
        Tue, 28 Sep 2021 17:13:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f16sm245969pfk.110.2021.09.28.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:13:06 -0700 (PDT)
Message-ID: <6153af92.1c69fb81.5e217.1d25@mx.google.com>
Date:   Tue, 28 Sep 2021 17:13:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-g5264d800ffd5
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 2 regressions (v5.15-rc3-23-g5264d800ffd5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 2 regressions (v5.15-rc3-23-g5264d800ffd5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
3-23-g5264d800ffd5/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-23-g5264d800ffd5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5264d800ffd532b515f32ad3a3439b5611438157 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6153a063e295a1bbf499a308

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6153a063e295a1bbf499a309
        failing since 405 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6153a1a8b51a5381b199a372

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6153a1a8b51a5381b199a373
        new failure (last pass: v5.15-rc3-18-g7c86bb8dfc1b) =

 =20
