Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDF1EB1AD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 00:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgFAWZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFAWZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 18:25:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87365C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 15:25:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so2074251pfa.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E9JUa1yumyY9fgcnWG3AJgUqfdeNBuOEvTmvrp1AaVo=;
        b=S/CddwRoFWjo9U3ELdnmx9r+NsKSoj9di3EWHwzeQU8MRuQgiKx+IkLUhE19gZx5RK
         Iz+yVLmDrZrDX3KmF9GbeWnOIHXknrJeCOLL6bSzpna1zwHYw2hUqIjH02hqaZZhssFe
         SL0Gs65G2wH5V9/ojGxnaldQIm6jfrSiMpLz73uN4mC/0TWvQPj1f2AjNoVwQJUbZQEY
         JB60GQjvlW01wZZhZI7OtUbtWiKdXxqCrcYzxV1Y8I07D1doDAAozRSKinZSfJsAcrPw
         9gRrQOig7eKN7hOvhMQHTjcBCZq1K0bzhbxHeka43QO3CYePRcDTdSA7XwFuNpbF8ssZ
         ZHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E9JUa1yumyY9fgcnWG3AJgUqfdeNBuOEvTmvrp1AaVo=;
        b=dD2Hi2XQ1CZlYwV8R2jPFS3zPrQO/giaAuedzUhJpRlgTi1FK5e7RZ+CeTzv5haY1P
         1qQNEWUk01eD9MCzz0LTPgWDMT0FosaiEWJlHvgNArVcdNqaIFjLqN/HX2P2zHZ4qiEv
         cP95OWLkhXjhN30omNJaBaTS8UQXFaNh9LgnettO2QRH/bsGWY8DxQ7H8ruWAhPCgD6C
         qNhwaBkCOrqE7XHSwluUpEIwgH7tS+0CAWlekVU5Q8uMuoLuX2kino9OxlvenPg/9DEv
         ULHraWRtl+1TLzwvQfXVjuKG5c0PLt6r3FZo4MwAzvJPJ9xIlNVoCkxM+k0QHFh85ZgI
         Oj2Q==
X-Gm-Message-State: AOAM532oOUkFBCn4j4wDDkz9mWJSSxtH8NQqTIZgFJt9X7cM9xJHKa+z
        gMdnyJwNW8JPXO2vSiFBPse4qw==
X-Google-Smtp-Source: ABdhPJwt75ZzqI0xolBomEBbCKmcXJS1tX8ol/vZSbPg5XKhow80vttmtmXodlvekc+1QVLKRRtzFA==
X-Received: by 2002:a63:da0e:: with SMTP id c14mr20734575pgh.377.1591050343114;
        Mon, 01 Jun 2020 15:25:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h35sm421607pje.29.2020.06.01.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:25:41 -0700 (PDT)
Message-ID: <5ed58065.1c69fb81.9134f.19d4@mx.google.com>
Date:   Mon, 01 Jun 2020 15:25:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.7-rc7-129-gc291ca907606
Subject: pm/testing baseline: 43 runs,
 2 regressions (v5.7-rc7-129-gc291ca907606)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 43 runs, 2 regressions (v5.7-rc7-129-gc291ca907606)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
bcm2837-rpi-3-b              | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =

meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7=
-129-gc291ca907606/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc7-129-gc291ca907606
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c291ca907606f834e19abfb788b11dfbc888b7e4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
bcm2837-rpi-3-b              | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ed575e0ef8ebb724a1dba7f

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-129-gc291c=
a907606/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-129-gc291c=
a907606/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ed575e0ef8ebb72=
4a1dba84
      failing since 3 days (last pass: v5.7-rc7-92-g065693d08662, first fai=
l: v5.7-rc7-109-g1a09809dda81)
      2 lines =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ed577539a61b3aa9c1dba92

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-129-gc291c=
a907606/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-librete=
ch-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-129-gc291c=
a907606/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-librete=
ch-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ed577539a61b3a=
a9c1dba99
      new failure (last pass: v5.7-rc7-109-g1a09809dda81)
      2 lines =20
