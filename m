Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C022B760F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 06:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKRF4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 00:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRF4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 00:56:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18468C0613D4
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 21:56:50 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id r6so479868pjd.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 21:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Gnv5I3A0aEV/+hmDCN2jfBl2OYiH9NfMr62pOlSqQvc=;
        b=GjApV/mrIN70lf4SVyOJDyNg7DsJjJ4SabAxTqjugjtcggx/exYV7zqcX0t6ZaQLZy
         Zw1+/H+6qVUW2TdVFJCvIxfqwqxqJ9JIi94YV4M7dFZDhNFfA0yTxOr+DFCZ4m4ZQN7L
         611i/u8l4oj0zFFiFFeZnkDaYp0khBlVVZqTJ5O9CVyGhhiIwOt56V/Ukw2vgPqjGrHx
         SqQ5sorwpn1+ooeGISCZUv7psRgtzND8ug4dL8W4KnR5Vh+YfFGqubnH6MBzXJ8kyNs3
         Wjanc73TScSn7azohn60vnRDc3XRuRASzAdDFdUXFJRRrWuJYpam5b/B/wRGsWh7IwiF
         ws4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Gnv5I3A0aEV/+hmDCN2jfBl2OYiH9NfMr62pOlSqQvc=;
        b=tFqcWZDw8EOasmVcCFpxm+nFgvs/BhWba83HYkHAGsx3nbFM1CZvIkRKMPs8YzqX8x
         une3VRj57GFkUNFEctd89TvZSkrL1UuDPZoG526/pyRPGisqpVNSHYT45HcXfGEzluoo
         t+imVXhL9HpQHvze2cL+AswPRS9OtOwHlVu175wexbliUf7gvulJgjYJUYVUWhWI3fX1
         GKfhewPcI+bYLaK9RN+omroBWoi59MvlsIHGZ7oFTHCUvzROR6iF+ZyHwe0y5iOh9Jis
         HuCxCNguUjG79ndr+vu0ElOSG3lCJuDDxYUuqo1BpGChq387GFPcWlaXJC7X9ctuwDOa
         djng==
X-Gm-Message-State: AOAM531ilu73lCGEymZiXBH6uQOGdbZq930DNQRcrqLP2blGjFrddJ7K
        tjxyawImQNkntxZrR69KSyZ3JTZHpExoPQ==
X-Google-Smtp-Source: ABdhPJyB3jpplqHDkdJh/2TKkXVKDnh5yYGVLu8x8ICpMZNJQ7WrImLKZY4qsLd6t7Ky3s0FW2PY4A==
X-Received: by 2002:a17:90a:2c09:: with SMTP id m9mr2374803pjd.205.1605679009642;
        Tue, 17 Nov 2020 21:56:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e17sm25331918pfl.216.2020.11.17.21.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 21:56:48 -0800 (PST)
Message-ID: <5fb4b7a0.1c69fb81.6f275.7b92@mx.google.com>
Date:   Tue, 17 Nov 2020 21:56:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10-rc4-32-g91565ced8699
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 119 runs,
 2 regressions (v5.10-rc4-32-g91565ced8699)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 119 runs, 2 regressions (v5.10-rc4-32-g91565ced8699)

Regressions Summary
-------------------

platform         | arch   | lab          | compiler | defconfig        | re=
gressions
-----------------+--------+--------------+----------+------------------+---=
---------
meson-gxm-q200   | arm64  | lab-baylibre | gcc-8    | defconfig        | 1 =
         =

qemu_x86_64-uefi | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
4-32-g91565ced8699/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc4-32-g91565ced8699
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      91565ced86999f0d538b19d4d8cff8050aff8a8f =



Test Regressions
---------------- =



platform         | arch   | lab          | compiler | defconfig        | re=
gressions
-----------------+--------+--------------+----------+------------------+---=
---------
meson-gxm-q200   | arm64  | lab-baylibre | gcc-8    | defconfig        | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/5fb4ae6836b92a6eefd8d910

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fb4ae6836b92a6eefd8d=
911
        new failure (last pass: pm-5.10-rc4-33-g52d108cd060d) =

 =



platform         | arch   | lab          | compiler | defconfig        | re=
gressions
-----------------+--------+--------------+----------+------------------+---=
---------
qemu_x86_64-uefi | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/5fb4aad509bb323eead8d917

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64-uef=
i.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64-uef=
i.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fb4aad509bb323eead8d=
918
        new failure (last pass: pm-5.10-rc4-33-g52d108cd060d) =

 =20
