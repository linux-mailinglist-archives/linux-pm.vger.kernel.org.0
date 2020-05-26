Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A41E1B49
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgEZGbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEZGbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 02:31:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45252C03E97E
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 23:31:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so9546057pgm.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 23:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vFdsK0w80lrb1Q7vBDOLNNP/pZZogv6uA98ZUvu1Kj8=;
        b=1oMuS4/iW4LvbuN+ocg1n/6F/wRZvkQzXy92UQsLEFmTacl9qV5qxWFQHMyEBzqu84
         zW93Pj2qY2UUHbzD/yh6S/J9J/eFMVi6oW3sWF9SucMqiDPy8qbTDT3SQayi2oNqbaz0
         muvAf8muP71SHTYROMz78lGaX4n4+dc3xryAQH+BYtms2P9VNT44ANGfxLVYbbpQ44g9
         QJDvogFK68LbFVwC7U2+AovaQkE6yrwUYXhXaM02ljmeYok5nAKqoxn7l/tBAWNQtpte
         Ks/C1wP1f9zmZflxtapwBO2VmEXtFb8kh60nIzRXQykspD7FDw1aI+qVgbb7CuWJD2SI
         xjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vFdsK0w80lrb1Q7vBDOLNNP/pZZogv6uA98ZUvu1Kj8=;
        b=JyPbAhR0FxCSLXjSu9Px1EtxXOd/gECTqQYg1SVUEKCV4BnB1EXKWQqIrDT0cMcgYN
         kMFhRxm89ytQlvi4BpTmrNb0p9ShTzNO640T1oUhYb0ong1HvRIAgg6Nq5smJJCBhXMC
         GtFHLTCXBtg3wmkkLK3BdY3sHgHl5UIx3XFDj7xOQtwfz5Dm5+hJyUzXt1dAnPchBYek
         FydLy8hDJeGjlqINWG3e8EyZDM4MRniJnyMzQZqX6IimlUspGQEa8daycljsidugU+2f
         kQE8g/AyB+5s19piuFRI60cJvfB0jhjSxhRAXVqv6LGO2uRDH8GobvFn5cc+1IH/IBFS
         xsDQ==
X-Gm-Message-State: AOAM530lEgJ0XraPXaHT2RMDRR6nK6KLb20ndqDumHX3srgoX9ASj3fo
        ipNjQQfe/twzW/b3QqLXdE0KHhV1A5Y=
X-Google-Smtp-Source: ABdhPJwo6Dnyin0ATNkOmeIgcsf0lgv/OmrAU5iYTnWhPRIlJhe6vLc2Gka/LmW2JR2vSgIeXMTUJA==
X-Received: by 2002:a63:e702:: with SMTP id b2mr29738898pgi.158.1590474681791;
        Mon, 25 May 2020 23:31:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e18sm14549135pfh.75.2020.05.25.23.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 23:31:20 -0700 (PDT)
Message-ID: <5eccb7b8.1c69fb81.2c1c0.82de@mx.google.com>
Date:   Mon, 25 May 2020 23:31:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc7-74-g6b0724667355
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 55 runs,
 3 regressions (v5.7-rc7-74-g6b0724667355)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 55 runs, 3 regressions (v5.7-rc7-74-g6b0724667355)

Regressions Summary
-------------------

platform        | arch   | lab           | compiler | defconfig        | re=
sults
----------------+--------+---------------+----------+------------------+---=
-----
bcm2837-rpi-3-b | arm64  | lab-baylibre  | gcc-8    | defconfig        | 4/=
5    =

qemu_x86_64     | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig | 0/=
1    =

qemu_x86_64     | x86_64 | lab-collabora | gcc-8    | x86_64_defconfig | 0/=
1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7=
-74-g6b0724667355/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc7-74-g6b0724667355
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6b0724667355b76a0813de36e987f6b881131a69 =



Test Regressions
---------------- =



platform        | arch   | lab           | compiler | defconfig        | re=
sults
----------------+--------+---------------+----------+------------------+---=
-----
bcm2837-rpi-3-b | arm64  | lab-baylibre  | gcc-8    | defconfig        | 4/=
5    =


  Details:     https://kernelci.org/test/plan/id/5eccad87e7499db9274397c8

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5eccad87e7499db9=
274397cb
      failing since 10 days (last pass: v5.7-rc5-53-gfbe093dd16f4, first fa=
il: v5.7-rc5-57-g8ef6544598d6)
      1 lines =



platform        | arch   | lab           | compiler | defconfig        | re=
sults
----------------+--------+---------------+----------+------------------+---=
-----
qemu_x86_64     | x86_64 | lab-baylibre  | gcc-8    | x86_64_defconfig | 0/=
1    =


  Details:     https://kernelci.org/test/plan/id/5eccaa56b1425fc2a64397bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/x86/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5eccaa56b1425fc2a6439=
7be
      new failure (last pass: v5.7-rc6-64-gbb7ba30bf960) =



platform        | arch   | lab           | compiler | defconfig        | re=
sults
----------------+--------+---------------+----------+------------------+---=
-----
qemu_x86_64     | x86_64 | lab-collabora | gcc-8    | x86_64_defconfig | 0/=
1    =


  Details:     https://kernelci.org/test/plan/id/5eccaa6efdc0b9a8884397c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/x86_64/x86_64_defconfig/gcc-8/lab-collabora/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-74-g6b0724=
667355/x86_64/x86_64_defconfig/gcc-8/lab-collabora/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/x86/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5eccaa6efdc0b9a888439=
7c3
      new failure (last pass: v5.7-rc6-64-gbb7ba30bf960) =20
