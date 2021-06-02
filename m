Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3439945C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFBUP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBUP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 16:15:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E73C06174A
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 13:13:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g6so3097174pfq.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gkWeZEvoXhqOTFkne9RKe9sxCSQjRL4PdPKB3+5rAFI=;
        b=0vUPOs87AJsEQy/mUR3nmE2xGIsjxITWHNPanDgnUUwm6THzYk/C8b6LOqznUd/2zn
         RY3M9TtnUkJRp24GRJudGvtXu6GPsD/DbLHz/tS4i1v7NQzJ1McISblQVmQs8Nr4kPyE
         1Tt2TV3U2mRfbDQDiMe2p3upEXjJAbhbgPIEmNJEDAxwCEAjAusJd3YN+Sd+lHu90VG1
         xceVZPOysBs8JRuM6DLX86Dqp/FV7CSbIPqOFuIoEW66xaP0d1C+2KoL7M7/5xH6kbZu
         /nUjm0WZnLRNwNDTZhLYZI3Au1cz4BqY7NyrXnbbnGNjTqCKBAgI+X0zwV67XIXcgXKh
         CXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gkWeZEvoXhqOTFkne9RKe9sxCSQjRL4PdPKB3+5rAFI=;
        b=SwN2TIX+ZXPv+6TEDAg0gmKMLiFF/U4HouFhFsAPXR6J6FjN4hOuwMmpH4n5CgfvTm
         m6A5MNhy7ELIjErT15VzUuvAOO2PbB92tFgybX5eavXQqmeH+y52oj3yTN0OtllfR+pZ
         iRjVkbAWTT/DlWaPIIzPTlTwcwGpzJqJ5wRrF5p+z3s5o+foI+mrjx7j8fbN2qAj67He
         Vs0zr+P9r8IcYxC7qY3UQ/bxf9Kr0Etp1MyY4s1fRWSWqteD7yVYflMWXMje6rWHSSf4
         zUop5ZslO4T8VagF3iSwmFoXPNLgGkx2kot5fvrrhySVHRI8FA9Yz6ofMvOY2L1oVmNT
         4r+w==
X-Gm-Message-State: AOAM5335j/urE/oohJ7V594xI2xC4+X4dBzfPv+v4pz2KrogYL5Xi9TW
        RrrYdBZ4D6LjYJXXN/bmhHIjUJPMXXVarw==
X-Google-Smtp-Source: ABdhPJyOur7MQ25DRSpxnzImmKxFcuofHSerQaTfgnHUmTylokfVUSMv4UxDB7X7+BLm+A/sXiNyJQ==
X-Received: by 2002:a62:aa01:0:b029:2ea:743:6693 with SMTP id e1-20020a62aa010000b02902ea07436693mr8939880pff.68.1622664822800;
        Wed, 02 Jun 2021 13:13:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g63sm389344pfb.55.2021.06.02.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:13:42 -0700 (PDT)
Message-ID: <60b7e676.1c69fb81.a40b5.1b0a@mx.google.com>
Date:   Wed, 02 Jun 2021 13:13:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.13-rc5-42-ga25ea0c642c2
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs,
 3 regressions (acpi-5.13-rc5-42-ga25ea0c642c2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 3 regressions (acpi-5.13-rc5-42-ga25ea0c642c2)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
3-rc5-42-ga25ea0c642c2/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.13-rc5-42-ga25ea0c642c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a25ea0c642c2fa68ced9d7e9cfc85ed4ea470deb =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/60b7d748349aa0f79cb3af98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60b7d748349aa0f79cb3af99
        failing since 287 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/60b7de3df3d47ab9c8b3afa1

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-=
jaq.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-=
jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60b7de3df3d47ab9=
c8b3afa6
        failing since 22 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-06-02 19:34:48.985000+00:00  rtcwake: assuming RTC uses UTC ...<6>=
[   82.120302] smsc95xx 2-1.1:1.0 eth0: Link is Down
    2021-06-02 19:34:48.985000+00:00  =

    2021-06-02 19:34:48.995000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Wed Jun  2 19:34:55 2<6>[   82.129083] smsc95xx 2-1.1:1.0 eth0: hardw=
are isn't capable of remote wakeup
    2021-06-02 19:34:48.996000+00:00  021
    2021-06-02 19:34:48.996000+00:00  <6>[   82.141378] PM: suspend entry (=
deep)
    2021-06-02 19:34:49.001000+00:00  <6>[   82.149907] Filesystems sync: 0=
.000 seconds
    2021-06-02 19:34:49.013000+00:00  <6>[   82.157277] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-06-02 19:34:49.019000+00:00  <6>[   82.168789] OOM killer disabled.
    2021-06-02 19:34:49.276000+00:00  <6>[   82.174924] Freezing remaining =
freezable tasks ... =

    2021-06-02 19:34:49.295000+00:00  <6>[   82.423360] usb 2-1: new high-s=
peed USB device number 4 using dwc2 =

    ... (26 line(s) more)  =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60b7de3df3d47ab9=
c8b3afa7
        failing since 22 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-06-02 19:35:09.547000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Wed Jun  2 19:35:15 2021
    2021-06-02 19:35:09.558000+00:00  <6>[  102.708430] PM: suspend entry (=
deep)
    2021-06-02 19:35:09.569000+00:00  <6>[  102.718117] Filesystems sync: 0=
.000 seconds
    2021-06-02 19:35:09.584000+00:00  <6>[  102.728829] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-06-02 19:35:09.590000+00:00  <6>[  102.740438] OOM killer disabled.
    2021-06-02 19:35:10.095000+00:00  <6>[  102.746493] Freezing remaining =
freezable tasks ... =

    2021-06-02 19:35:10.118000+00:00  <3>[  103.243421] usb 2-1: device des=
criptor read/64, error -110
    2021-06-02 19:35:10.466000+00:00  <6>[  103.613363] usb 2-1: new high-s=
peed USB device number 5 using dwc2
    2021-06-02 19:35:15.776000+00:00  <3>[  108.923374] usb 2-1: device des=
criptor read/64, error -110
    2021-06-02 19:35:29.606000+00:00  <4>[  122.759116]  =

    ... (21 line(s) more)  =

 =20
