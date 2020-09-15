Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B126AA75
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgIORXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgIORXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:23:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6088C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:12:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j34so2313427pgi.7
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wArfFOE4fJBW1WANi2z6Wj4ItPVWsHijgHy95KGxxmw=;
        b=rDqPVRgnt/U87dBHeAkXDI25fzRow5vRrmOjzfaJYOa45fa53HyBHptsWW3aDjMkw5
         7F+DA2DalhqviJcxTBjEQKO6QZ8mvBMwgToHCmTz69lMvGaKHVXMbJWGTZbMxj4G0bmC
         iU/Fe0J1qhPOAIZJo6aBgBZgzTflYc+jlwQha3CYBbmEQ9k2TjIuJnZMq/UXo8nc2xEP
         AyEnm74BdEEzkQGvsT1mjeS0PHmzIoVMGLfNitlSRmbXpm/oQ9EDbzC/Q1EuTflm8DfO
         9+HUfxIagO4dNkRuUvYLmeZaV7OcAPavyyUM2V0ISaw8yyhnOLJKZSf16zMs+EOP2N80
         mdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wArfFOE4fJBW1WANi2z6Wj4ItPVWsHijgHy95KGxxmw=;
        b=P6B8T64w5I1GD0Hzl3vzLWB6cvBC6vA6VpRajpSRStlNSP7fY6S+H/Ts/5QOot8cEV
         +1dWLq/vB1J9QjHfDjtKnwYSifqWFUexhtpT4v6je83vGowdmP1juBYBLOeCCccxePa8
         5EAJ9kt+6YiyG3tmSObov5+xCq/gId4Tnu1hDzyhUz9riAhAQUIW515t53GqNugW+Hs1
         cgLqX4Uq+nIzPjyfRFF6LVxxUd9ylipLf9DpHHB8cKxC++tmJApELk2ahxWi93J90ZWi
         QL98BrMXwDxTK9mE5pqCkZD/Nn1gD/RQ2yEHJb2HzqBK+v0QENT7xA5pWm+g7FWGVS/b
         2SXw==
X-Gm-Message-State: AOAM5330SN9efGYhhgYBSjOSqPA1Xw12N3Vi6eMd5GUvUO45aF+h0Epu
        prGagcrK4aE9wAvdm867Nvo1Ww==
X-Google-Smtp-Source: ABdhPJxuLpYqpS6s+/wHfYi7sstpZRRmyZdieGp0oLpBqcricobdjQy/IdmjAvLz5SUMAU96Q9uyiQ==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr14418799pgc.297.1600189958494;
        Tue, 15 Sep 2020 10:12:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ih12sm118615pjb.24.2020.09.15.10.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:12:37 -0700 (PDT)
Message-ID: <5f60f605.1c69fb81.3e626.04dd@mx.google.com>
Date:   Tue, 15 Sep 2020 10:12:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc5
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 7 runs, 3 regressions (v5.9-rc5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 3 regressions (v5.9-rc5)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 1/2    =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc5=
/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      856deb866d16e29bd65952e0289066f6078af773 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f60e97ac522e8c179bed964

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f60e97ac522e8c179bed965
      failing since 26 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 1/2    =


  Details:     https://kernelci.org/test/plan/id/5f60eac3512e03365abed971

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc5/arm/multi_=
v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc5/arm/multi_=
v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/armhf/rootfs.cpio.gz =


  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/5f60eac3512e0336=
5abed973
      new failure (last pass: v5.9-rc4-6-g23818c154bae)

    2020-09-15 16:18:16.965000  [Enter `^Ec?' for help]
    2020-09-15 16:18:28.761000  =EF=BF=BD
    2020-09-15 16:18:28.761000  =

    2020-09-15 16:18:28.761000  coreboot-7d042db9 Mon Oct 22 20:40:09 UTC 2=
018 bootblock starting...
    2020-09-15 16:18:28.761000  Exception handlers installed.
    2020-09-15 16:18:28.772000  Configuring PLL at ff760030 with NF =3D 99,=
 NR =3D 2 and NO =3D 2 (VCO =3D 1188000KHz, output =3D 594000KHz)
    2020-09-15 16:18:28.784000  Configuring PLL at ff760020 with NF =3D 32,=
 NR =3D 1 and NO =3D 2 (VCO =3D 768000KHz, output =3D 384000KHz)
    2020-09-15 16:18:28.784000  Translation table is @ ff700000
    2020-09-15 16:18:28.797000  Mapping address range [0x00000000:0x0000000=
0) as uncached
    2020-09-15 16:18:28.797000  Creating new subtable @ff720800 for [0xff70=
0000:0xff800000)
    ... (1154 line(s) more)
      =



platform          | arch  | lab           | compiler | defconfig          |=
 results
------------------+-------+---------------+----------+--------------------+=
--------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-8    | defconfig          |=
 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f60e9a6d0472e779ebed955

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f60e9a6d0472e779ebed956
      new failure (last pass: v5.9-rc4-6-g23818c154bae)  =20
