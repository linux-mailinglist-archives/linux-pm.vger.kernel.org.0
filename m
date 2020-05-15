Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B01D5988
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOS5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOS5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 14:57:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD1C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:57:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so1394906pfx.7
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fReXFsTtFjwiC+spePn5ROClhcmOvYxTrQo9qp19mKU=;
        b=AxmrEN+Hvi69PaMMbWxPL5INYsgTeExS8kK7q3Wk6mmGjaCisqgfHAALX/6CmTNyBp
         bJsqOim+rRp5hV8ycKOerxqaTMPz93XWqy7jamXM3IiebGlnhIfovRuF4jOEZ3l9i9pZ
         LfpiEsbex9uUyOCKquzu9N+YMUpGXXi7qQLBwnHXimc/woeAZufhwqLm9OFo3HpyHQzE
         vXmv+VAiW88yRoRpCfqClRnUpIRVBv+oYeaAyK8ZzkwuID+0qP6uMQFBoZfJyL8+maLn
         O0KxksYLHYkx+USe1H3NdqoNp5/NKqo11IuUWl9g93cDwAnUaJZlq2p5OFAMcSGkgYXO
         DKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fReXFsTtFjwiC+spePn5ROClhcmOvYxTrQo9qp19mKU=;
        b=RsI5GmiRVOo/07hXCVtzqlK0+XLSewOfDtng8RSFZf/SySd8vLeZSNdbgrPpryvJuE
         ++hX6woTZ4Sv/CYEvuyV3iH0cNtq2I8t5CLTvBJzAay5DglJA5gjFES4PYclEdmJu8Q4
         4ktg3FwBfCmd2KrMdxRHtIpHhayEFjmxZJEOMYUXr1Q/FaYKfX7/JbX/1moEsXF+OVp4
         6kXlHyH3sgfJjdZBpC50Zhc2X68HzisIEFCIab8gtPUBzUuUf+pb3VToucM6tsJt/G8X
         TaaOIu0fWNEGt4NnGNWSmlPf/NnENTbOTK0qgga5q6UlMxRn6bfwRZwc7nYpLBXSSTwD
         HKNQ==
X-Gm-Message-State: AOAM5319F7iyRpUquSesgaPP/PM3rSeqMutV0qOOW/rfZkN+PuptZ87r
        xubkqEcApzU7PhKoPJyxszwjAj8rINc=
X-Google-Smtp-Source: ABdhPJyufGD1fw1ILQdLpufn03hizjftv+0wT8jcWKdmzzIkKj4TB+WVRz8OumowaKnvwlN4srL3uQ==
X-Received: by 2002:a65:614c:: with SMTP id o12mr4477738pgv.223.1589569025052;
        Fri, 15 May 2020 11:57:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k10sm2571666pfa.163.2020.05.15.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:57:04 -0700 (PDT)
Message-ID: <5ebee600.1c69fb81.35065.805f@mx.google.com>
Date:   Fri, 15 May 2020 11:57:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-57-g8ef6544598d6
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 0 regressions (v5.7-rc5-57-g8ef6544598d6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (v5.7-rc5-57-g8ef6544598d6)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 4/4    =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc5-57-g8ef6544598d6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8ef6544598d61aab12b6b4613971bf53256b14eb =



Test Failures
-------------
  =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
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

      =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc5-57-g8ef654=
4598d6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
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
