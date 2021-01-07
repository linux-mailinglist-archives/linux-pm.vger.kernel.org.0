Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4502EE9B5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 00:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAGXXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 18:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbhAGXXX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 18:23:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6DC0612F4
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 15:22:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h186so5053649pfe.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 15:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Kf0HvsalZ9U/0Bl1XDTIY7XfCwkRc2BJMhu8iyfIfBA=;
        b=Ff//dhpirK15/nADsV3tCN7IjU338w4WadX6fAcxRkQ64KJjpQmASs6U8LrtXQxnL+
         4Reugngf2QRrR5hJpi2vqB+n1zZgMaiqswmsXHPsmi7hrMbfKVLk1NMZBBgkozZstAwr
         3cxRgUExYVpARJDGtvr0yYoCfgaLKHKatCDW2ieMJZRvJsLGOXAgolPSbC7I4jAHIPp6
         osBjXVAC5PTZ06R9Nq0q27i/Pr7aEa+NQzL/mlzvxI7d0wdjCvYK4HjJgnSuCeBd4t3o
         rOxZnGAY600LaV6+YRbAsGBnDtcBs07c+RK5E7ITA58XKgYudewalyW2psaL+dJTV0cA
         3xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Kf0HvsalZ9U/0Bl1XDTIY7XfCwkRc2BJMhu8iyfIfBA=;
        b=NM0hxJmR9ffhp4Z7Smrudyh+IcNFs7RX1g0972mFAAtO7OIwG8IrRuO+R5BSwgtrpK
         ZHtORPbGYw28JU6e/Bk5JW8lJF8sNAJAdNJHdtWuahEPT2CuPzPF9c/LMaiSZPl2XoNy
         OyBFtRHEdOz08+MBiaw5gHQbc48osim6ICgRy+LSpruQDeUK95OSCMHTGh4yDB6HvPK3
         +O4PCHKciBH8QM8Mhmv/pWy2gaYXs79MG+ofhQ9BCydK1LqL3Cs/44jBPFsn0YSeTnV2
         Bdb6WYKg34qZXk2XRNOCA0f5ahHQITpPwzxaOaDzltHBGkdbQqeCKLNGF2zZ0ZFNckkp
         RR5g==
X-Gm-Message-State: AOAM5334CyhzXv+0xrhRNR6nEaRUAUdbTHDj2RERwDUhhAgpvvkFXo6o
        chGBb3Xr5k+zcpOQSljmKq2RZg==
X-Google-Smtp-Source: ABdhPJz7RWNbDdJib6OvlihGW2Z9FVzQ5P9NrBWTRgm1NrL8NTXjv7wtRQcnOckc6T0QesohBCPPaQ==
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id l143-20020a6288950000b029019e92ec6886mr1028755pfd.12.1610061762635;
        Thu, 07 Jan 2021 15:22:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cu4sm3163696pjb.18.2021.01.07.15.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:22:41 -0800 (PST)
Message-ID: <5ff797c1.1c69fb81.49085.7932@mx.google.com>
Date:   Thu, 07 Jan 2021 15:22:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc2-21-g75a052c6b1ba
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 122 runs,
 3 regressions (v5.11-rc2-21-g75a052c6b1ba)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 122 runs, 3 regressions (v5.11-rc2-21-g75a052c6b1ba)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
imx8mp-evk                 | arm64 | lab-nxp      | gcc-8    | defconfig   =
   | 1          =

meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig   =
   | 1          =

qemu_i386-uefi             | i386  | lab-baylibre | gcc-8    | i386_defconf=
ig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
2-21-g75a052c6b1ba/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc2-21-g75a052c6b1ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      75a052c6b1ba2bb2cb1a09af90576af93d4f95a7 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
imx8mp-evk                 | arm64 | lab-nxp      | gcc-8    | defconfig   =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff78f5c0099a532c3c94cdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff78f5c0099a532c3c94=
cde
        new failure (last pass: v5.11-rc1-12-ga04307bd9ddd) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig   =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff78db1933429517fc94d22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff78db1933429517fc94=
d23
        failing since 3 days (last pass: v5.10-rc7-148-g08e85a810cae, first=
 fail: v5.11-rc1-12-ga04307bd9ddd) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
   | regressions
---------------------------+-------+--------------+----------+-------------=
---+------------
qemu_i386-uefi             | i386  | lab-baylibre | gcc-8    | i386_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff78b2fd2fedbfafcc94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff78b2fd2fedbfafcc94=
cc4
        new failure (last pass: v5.11-rc1-12-ga04307bd9ddd) =

 =20
