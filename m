Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722BD27D227
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgI2PIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgI2PIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 11:08:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C190C061755
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 08:08:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o25so4125179pgm.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+PL5xT0yPnhnwFnMIMj3aQIAB6fgMd2bCqaNn7O0l+A=;
        b=TJ8KMVrCtOOa6IY1YPVEs+nKqjKdgT29ZdybW7aMtM6Pydee8C0P2UF+65qHulVGH2
         UE2rtNUTWS7ekGOp/KoY0eQCRdqUj/v3KEGEM3R9M2CjW0eHGqBjuLCI358FV0H2zlx6
         CVsM7Wk1LNREuyJ3/3ThdtQLa/GME/qCyaeW1Po8KCNMqW4is327+DXltB0/yfuZlDSn
         2O/7e+z00S1iDRK1ycdbmEU3kDKaYDJ5L4vTU9xPW+aysWLltHYC713Tv42h+ntrwDu9
         6kSoSCIIVzzO98PBqL8IfXNQHpwvEky4tZRc3EL+0nzie0+zL6lJsvjjEp4hYr6xHYdd
         jCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+PL5xT0yPnhnwFnMIMj3aQIAB6fgMd2bCqaNn7O0l+A=;
        b=ZxQc9swJr4YvLwec0or5x0d/BhENSRTiV4GLk378OH4uUW1ecC7P73CmNPi4dwAI5E
         uzWsYLYqQv7ByXFwOYVgvx32xUsosRv1SkxTiYpHxugbeGMu5GLaqe+kh3T9KnMBNM5G
         SdrL2tR8bWlQPG8/VPNm52zFz3/zwey2a1BGyx5M9GSryFLZdZWATylDUfmhmJMzUbbU
         nOq4UCsVhMoIQDvDueSjDJ0hEeclWXPfDzEO2+Ek8o1mz4zRJYVy/2NwfIX5HeHXSWU4
         38PK+ajgnO4o4wrZwegG4xe79YvuMuQTa7u9kOro1QqCaB5q5zYmoixUbeGEwf13+iF6
         kt/Q==
X-Gm-Message-State: AOAM530QIqqX46QxEjgYmmSrbMBwaR84XXv/Il0wH5XV5R9/rPavTx7Z
        sA3PWIDxkRgjkVqKEUGDIvrv4w==
X-Google-Smtp-Source: ABdhPJxlgaMKU27OTVR2YmuezMK+jcA7ovTZVAShkfK5MchQ1m4D6uxTzxww4/Z/mHwIn0JIbcgrzg==
X-Received: by 2002:a63:c00d:: with SMTP id h13mr3652929pgg.358.1601392096118;
        Tue, 29 Sep 2020 08:08:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id hg16sm4845159pjb.37.2020.09.29.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 08:08:15 -0700 (PDT)
Message-ID: <5f734ddf.1c69fb81.2c850.97f4@mx.google.com>
Date:   Tue, 29 Sep 2020 08:08:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc7-68-geb6335b68ce3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 2 regressions (v5.9-rc7-68-geb6335b68ce3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 2 regressions (v5.9-rc7-68-geb6335b68ce3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc7=
-68-geb6335b68ce3/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc7-68-geb6335b68ce3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f733eba2619e6ef71bf9e1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0925.2/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f733eba2619e6ef71bf9e1e
      failing since 40 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f733f713d23d45fe8bf9db7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0925.2/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f733f713d23d45fe8bf9db8
      new failure (last pass: v5.9-rc6-48-g537658447367)  =20
