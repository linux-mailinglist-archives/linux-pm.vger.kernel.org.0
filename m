Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548832F6223
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhANNiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 08:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANNiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 08:38:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACAFC061574
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 05:37:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq1so3085233pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UsaTwL4k4WshB5ivVNfn6kXqaep9HdwYo6cn1MDHMto=;
        b=1g3PVFP/seNnXdwgs3TlgoctM8K8uh8xB70CEh274EK0SDUMUOF+j6OOMipcYoQfCX
         Ec1QC52P+HdggVGBGi2MqJO3UEDSALU0CpJJqRBtXNyXmKuCd3fERe+SbzHnjZxot1np
         vlEvfsMyl+bdoGwigRqea7hi+CVve6z1E2QB4/uLT7Q8Waavv5bZ7SOEzDC8YQI/qfXp
         WfKRTeaxP4XE6AteUR3/zT4HMl4f6w+O2wKLB6LkWYk7CbGpkK1ZhFRir/e1c+BiDxtz
         6EcsBVt/SJ2kDnjV8vw30dbYPgJ/XW9kfkPo4++j9PyiZLlyc9sCIMOcSAhaY6gCOVne
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UsaTwL4k4WshB5ivVNfn6kXqaep9HdwYo6cn1MDHMto=;
        b=e7PbyuQlfxRihl3wlu1ZLDL5G0i44e9skVUNvDc+Uu/wFZneQZt0dj6ba7NxUK6aL+
         T4aUf69zq8XwBTDEaaIBhSqMWFuq1kZLQBZCe+Wu8O+MCVCDyzWEkAacnldh2Sx8K3HS
         Alg8eGHIh3vidnjmx+FeWGnV/OH1TToZLBi+FH/4HohrdsCf7Nymh3SePI50ytWSugAd
         3/by3mCIhdrl4MxWedqRG6ido6Glg2tDPKB0QatpLb/itk16OMB3CIm1BGLOZQmmGV//
         3EaJZES9vwMME9ogm8a/2qlJ6SIxYkdXW7WirEsGWF/kCCeqK2sjDrax0+W7OMn1OLmL
         lFzw==
X-Gm-Message-State: AOAM531w+eMkOOUFni49v619QgfFyUYnH/0EiWr/5c2kPPkOCmcoSOVl
        sINV2fHqDoF+V85hDkPRBY0d09G4GNNWgQ==
X-Google-Smtp-Source: ABdhPJwCw7p48SChEKLdmroTvAuy/8SkBwTawDzsvKHjElcmx+yp5nf7TTEyJqluHYCCZbv6QxxFrQ==
X-Received: by 2002:a17:902:59d0:b029:da:69a8:11a8 with SMTP id d16-20020a17090259d0b02900da69a811a8mr7571484plj.63.1610631460465;
        Thu, 14 Jan 2021 05:37:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x28sm5310907pff.182.2021.01.14.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:37:39 -0800 (PST)
Message-ID: <60004923.1c69fb81.d7881.d159@mx.google.com>
Date:   Thu, 14 Jan 2021 05:37:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-19-g9f0b1e583eac
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 116 runs,
 3 regressions (v5.11-rc3-19-g9f0b1e583eac)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 116 runs, 3 regressions (v5.11-rc3-19-g9f0b1e583eac)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
imx8mp-evk                   | arm64 | lab-nxp      | gcc-8    | defconfig =
| 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-8    | defconfig =
| 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
3-19-g9f0b1e583eac/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc3-19-g9f0b1e583eac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9f0b1e583eac5573c52c2ead2e1f232adae7d044 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
imx8mp-evk                   | arm64 | lab-nxp      | gcc-8    | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/600040f97270de03d8c94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600040f97270de03d8c94=
cc4
        failing since 6 days (last pass: v5.11-rc1-12-ga04307bd9ddd, first =
fail: v5.11-rc2-21-g75a052c6b1ba) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-8    | defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/60003f7008fe8de3bbc94cb9

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-a311d-khadas=
-vim3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-a311d-khadas=
-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/60003f7008fe8de=
3bbc94cbd
        new failure (last pass: v5.11-rc3-12-g8cbb6cfa9b8e)
        8 lines =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/60003f7008fe8de=
3bbc94cbe
        new failure (last pass: v5.11-rc3-12-g8cbb6cfa9b8e)
        2 lines

    2021-01-14 12:56:08.099000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0
    2021-01-14 12:56:08.101000+00:00  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2021-01-14 12:56:08.102000+00:00  kern  :alert : swapper pgtable: 4k pa=
ge<8>[   16.441788] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfai=
l UNITS=3Dlines MEASUREMENT=3D2>
    2021-01-14 12:56:08.103000+00:00  s, 48-bit VAs, <8>[   16.451692] <LAV=
A_SIGNAL_ENDRUN 0_dmesg 587046_1.5.2.4.1>
    2021-01-14 12:56:08.104000+00:00  pgdp=3D000000000276e000   =

 =20
