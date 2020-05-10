Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F701CCB43
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgEJNGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 09:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728743AbgEJNGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 09:06:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8432C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 06:06:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so3414915pfn.3
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vfGef1Szw54qMt4C3vH6yp5y6l1t/GAXNeY2v8+8UOY=;
        b=levZOkn+3RY8ytHoXmukZ8gWoV0NByuDCWrLTrG12pWeLByznFrPXMUmsPMK0Na4Vs
         Qj3pqXyHbqGQ2b2B8ACdH4/ks2IKLDPP+zHB9hmBgdj8CaeA+jq6EnlKZbhJMRgS42Gk
         ymHDoZzTl5q1XYxBM+Ui2edF5dl+xZ2EUP5O8/cfmLnE2MwTz9JL77WElOhj2/Bq4epd
         VkSx6yMMUIY8zGkaR1MS7gJbeJJhIb/JYQmFXc9pLCi+D+aaocdunsxrmU5udCcxjQtD
         BUzKwWxYWqtL2Lmc2NDrVHYyJB7hmZPV8uDtCjGKKBtgAVZVSPPZzuQana/zoe8Fuz5h
         qlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vfGef1Szw54qMt4C3vH6yp5y6l1t/GAXNeY2v8+8UOY=;
        b=jadn6GH03h7CdiQtYIJczK4F5ykCBpHUhmg5vDWBefubSRFV8OzDwDp4ROwhcLnyct
         0zfGG9xVkjg8VFsLyoA/SfCQmn3QtCii6QhMv9B0YOXSbMk0R4E3ty76pYV1YpHxc5Yn
         GnVJRU5ep9vG/02c/F4j09tE43qK3vZxNDWOaradEPPBRRv8u2g7EyTcujpWMg3U0QFD
         cOjnVWE8IUDeesEmCRjkoBh2cj2YHgPG2z+bvapim4zP/zu7VsazhRS6Eusg5kvMn7Pc
         YNHCkF+mC4VIrlRmoIYSNeT1M3kq+EDT/ZqcENAf5CZp8YNUrMm59zxpn3YvLnSRGvyG
         nvmg==
X-Gm-Message-State: AOAM5330mIJg/iF8ivivlY4RhwbRUS2oczLfiPKOcuWMtrIqbItlUzqT
        wvIdZodxcfO1BxPfsvgVUEDu/y26QQc=
X-Google-Smtp-Source: ABdhPJxsXqk76ZvaX8lJ6sHgymxT5nZCyMQS7R5tVfxDXIP985/ap5D5wgRQ2xWqAaZLS+wS/WyG8A==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr862004pga.358.1589115962896;
        Sun, 10 May 2020 06:06:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n30sm1622219pgc.87.2020.05.10.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 06:06:02 -0700 (PDT)
Message-ID: <5eb7fc3a.1c69fb81.c6446.5525@mx.google.com>
Date:   Sun, 10 May 2020 06:06:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc4-41-g277a1722e66d
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 3 runs, 0 regressions (v5.7-rc4-41-g277a1722e66d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 0 regressions (v5.7-rc4-41-g277a1722e66d)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

2   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

3   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc4-41-g277a1722e66d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      277a1722e66d47e6fc8b63834273f83631e33562 =



Test Failures
-------------
     =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
2   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc4-41-g277a17=
22e66d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

        =20
