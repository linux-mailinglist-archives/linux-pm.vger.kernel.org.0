Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C138222BD2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgGPTWr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPTWr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 15:22:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C7C061755
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 12:22:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x9so4299067plr.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=g3jVk0mLRfUKBNzTKCAxsgBjEhs9hLY6B0osdHV10p4=;
        b=Zdplj19sa5j0bOZK8gVKH/4SqNgmICFW3vWK3qjHeTA19PP9agTRjHf+k27RFxqZz5
         SGXPvubRWguVs1nPaoMHCOCdCgoSTAcKzoWVvXkYr9tvvhpfwsEfHWyXO64vdH7ETJ6/
         t2qqQaiioryow+uH+3r5C9O59e04x8oyb1stOQzqygQtvfg+c9ENeC8/yVc0cSi3mASt
         fWTT37Ls+xhaVQOrQo5vdI3tHPXOGe6ZrXkvwGfKgqCRHWPm2uhdnn9Wc7HSzpI/0qp/
         2mL555dl7VRoIvqWe/JBv81nrWhWxl323Bp1kWG2AcEOkKNQcIMgIztDyHELWLtEvbKp
         a4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=g3jVk0mLRfUKBNzTKCAxsgBjEhs9hLY6B0osdHV10p4=;
        b=E0fcKawdtI6po+oNPCafvJYRW2neESkPSBty4ukeywZ95Mn1GNnpPxgfEZKQomUC7j
         HjC1z/bdAjkv4X5kdSKcDl3zdNieahDnAJda6Dl75HUd1IjTXhhhQMLLmXtkdTtRnalJ
         W83dJHzqiAKYP1TmhOX4HLfwJ/pQNfMfltyzDD3JxYIkjrOTVtTiwk3a4nD2bgKj5RJu
         clJiWZzyNs2sYFrVbm3t1g34yk0TIJdMhykVtlSxing7YB86MmfqA6qQ4yPrZCm6ajof
         gEUmF+5/2UIe4Gqe4reEx8sqSuwrVuzxqIhMawU4q0er14P3PXXHVc1M8xTB4Zc4RU4T
         r1fQ==
X-Gm-Message-State: AOAM533c/oNPdeT7o5dJutCzfhEsKVvlyw8EeNlGighs23nXgz/XuRzO
        Ejxx7OjL8wJ4rrKwIEzVrpObiQ==
X-Google-Smtp-Source: ABdhPJz9HARTA4ErQ9tcoRxQM3YrNshCRW8CV/2LAPJNaSCw8KiVweaIJow5skU4yxYIDe2A8PaMEA==
X-Received: by 2002:a17:902:d34a:: with SMTP id l10mr4799719plk.190.1594927366474;
        Thu, 16 Jul 2020 12:22:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e16sm5636705pff.180.2020.07.16.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:22:45 -0700 (PDT)
Message-ID: <5f10a905.1c69fb81.bcb17.0ccc@mx.google.com>
Date:   Thu, 16 Jul 2020 12:22:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-62-ge1f8d84fc3fe
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 88 runs,
 2 regressions (v5.8-rc5-62-ge1f8d84fc3fe)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 88 runs, 2 regressions (v5.8-rc5-62-ge1f8d84fc3fe)

Regressions Summary
-------------------

platform                     | arch   | lab          | compiler | defconfig=
        | results
-----------------------------+--------+--------------+----------+----------=
--------+--------
meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre | gcc-8    | defconfig=
        | 4/5    =

qemu_x86_64                  | x86_64 | lab-baylibre | gcc-8    | x86_64_de=
fconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc5=
-62-ge1f8d84fc3fe/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc5-62-ge1f8d84fc3fe
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e1f8d84fc3fe27530af068400101f20b67c33664 =



Test Regressions
---------------- =



platform                     | arch   | lab          | compiler | defconfig=
        | results
-----------------------------+--------+--------------+----------+----------=
--------+--------
meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre | gcc-8    | defconfig=
        | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f109dc95e2096e4a985bb1c

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-62-ge1f8d8=
4fc3fe/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-62-ge1f8d8=
4fc3fe/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5f109dc95e2096e=
4a985bb21
      new failure (last pass: v5.8-rc5-46-g8d0151344351)
      2 lines =



platform                     | arch   | lab          | compiler | defconfig=
        | results
-----------------------------+--------+--------------+----------+----------=
--------+--------
qemu_x86_64                  | x86_64 | lab-baylibre | gcc-8    | x86_64_de=
fconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f109aa1862a8cb1b485bb20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-62-ge1f8d8=
4fc3fe/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-62-ge1f8d8=
4fc3fe/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/x86/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f109aa1862a8cb1b485b=
b21
      new failure (last pass: v5.8-rc5-44-g71865a3b9f0a) =20
