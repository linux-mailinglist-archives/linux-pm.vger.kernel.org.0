Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4802F4251
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 04:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhAMDSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 22:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhAMDSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 22:18:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1815C061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 19:17:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v19so563145pgj.12
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 19:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Gcn8MkNfb89HoI4H85gSLvl/kmTEqfB9REWnJp2V3rw=;
        b=TEXjVzjvDDdCH/+6qbSTDKc00g0RzihY1WZCCTsS7G4UFg6mZeboXcKl22ETpTwjUo
         n3QCfDfF6Rcsl89hAIMwqh+0o5Wsnmn+aSfY2btWzudhRjRKwrC7bhrxZhY5XU4aXIxz
         yc5nz9hb93b+KHq9pFYyzsiuMteSS+HrRbSStyBerTmoEXpQT6L8YMWHtGs1EsQ6WssE
         /hASMblg+rNF8xc9N4BNswmgEc5hhIN2S/xzDJa/Q76/jPQkE09SDvyHuVwcIc/HiPkP
         4vJk4eBjUYQVsTi9BJqZP7d93QqxGXzj2QyJQE7ijMUrXXNDkoStWWyUrQTLz9hnoYxL
         DZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Gcn8MkNfb89HoI4H85gSLvl/kmTEqfB9REWnJp2V3rw=;
        b=P84p03UDnL6YqD5Mp5Uy0s6jY7FJdhY/RYyRCCaPdtoYzl3XKSyDeOkejlDhkozJPm
         PLQd+ZMomaQtpWg5oXz2IybiYFpZsXNGwd7M8Vl8v+NYV6UBJubBU4qHQgrF7Ro3Ba17
         Hj0atyYL9ou9Sp12VOdMYL9ZBKK6c1B+DDB0ep8v+gXJqx1J+8vSdAJytvHadIE55AIC
         PC0pP38OdW1OcqW668dNOXvggXBNyp+vYYXyBcjtQioOX7O+k0BjhrzoPopsdWP00/PQ
         rcP9Gyv9zE1Y3buCVLtjSwHWS12Un4S7RmH5tLMd4p0QyoswpREDljV2aPitHm3Q83XJ
         eE/g==
X-Gm-Message-State: AOAM531UnhQbAhCk9QvHvGfO+LUlR9Kv64SWXbb+UX/nBhh1GlTkwI39
        vnuoWWCJPgQZfd/pRi4ihTqs3w==
X-Google-Smtp-Source: ABdhPJyiHjDYxk2pT4v7q657iM84RxmFLyj4ZZUvZRfbSy7UbeTrnJzKkkexVus9xZpXOqmCjX0TUQ==
X-Received: by 2002:a63:1047:: with SMTP id 7mr70952pgq.292.1610507872206;
        Tue, 12 Jan 2021 19:17:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o7sm571532pfp.144.2021.01.12.19.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:17:51 -0800 (PST)
Message-ID: <5ffe665f.1c69fb81.a693e.2260@mx.google.com>
Date:   Tue, 12 Jan 2021 19:17:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-12-g8cbb6cfa9b8e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 107 runs,
 3 regressions (v5.11-rc3-12-g8cbb6cfa9b8e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 3 regressions (v5.11-rc3-12-g8cbb6cfa9b8e)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
    | regressions
---------------------------+-------+---------------+----------+------------=
----+------------
imx8mp-evk                 | arm64 | lab-nxp       | gcc-8    | defconfig  =
    | 1          =

meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre  | gcc-8    | defconfig  =
    | 1          =

qemu_i386-uefi             | i386  | lab-collabora | gcc-8    | i386_defcon=
fig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
3-12-g8cbb6cfa9b8e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc3-12-g8cbb6cfa9b8e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8cbb6cfa9b8ef84f97642e04038e571673f6ffe4 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
    | regressions
---------------------------+-------+---------------+----------+------------=
----+------------
imx8mp-evk                 | arm64 | lab-nxp       | gcc-8    | defconfig  =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffe5e08704c6347d8c94cba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffe5e08704c6347d8c94=
cbb
        failing since 5 days (last pass: v5.11-rc1-12-ga04307bd9ddd, first =
fail: v5.11-rc2-21-g75a052c6b1ba) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
    | regressions
---------------------------+-------+---------------+----------+------------=
----+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre  | gcc-8    | defconfig  =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffe5c699483b5e370c94d0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffe5c699483b5e370c94=
d0d
        failing since 8 days (last pass: v5.10-rc7-148-g08e85a810cae, first=
 fail: v5.11-rc1-12-ga04307bd9ddd) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
    | regressions
---------------------------+-------+---------------+----------+------------=
----+------------
qemu_i386-uefi             | i386  | lab-collabora | gcc-8    | i386_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffe5c1e6a199fb417c94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/i386/i386_defconfig/gcc-8/lab-collabora/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/i386/i386_defconfig/gcc-8/lab-collabora/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ffe5c1e6a199fb417c94=
cc4
        new failure (last pass: v5.11-rc2-21-g75a052c6b1ba) =

 =20
