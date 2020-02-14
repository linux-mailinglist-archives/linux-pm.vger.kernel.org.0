Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5915D2EE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNHhd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:37:33 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38283 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBNHhc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:37:32 -0500
Received: by mail-wm1-f54.google.com with SMTP id a9so9463731wmj.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 23:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2w3UaRY4tOJq3E4doSRjv1RzbI5MGYeTGPh7GmlOT1s=;
        b=D9IrKvwGgEicphChsMgpf/4o5TJHxH0Z9CN01skiE3zKdiNCW3zXBiDWl+61Cz1K0n
         Ev7AYj7d8oY8RU5llfs5DWdwC4dKk/sp+kKe7s+5hzoAWpzrkK2IVJOA7q49gFEQadvt
         FeQ1m6xkjQ8EDy2X2I9ErV6wgo2Vdx53+/36J2kMY6rXkDDOJY8XCXHrywcDO5ovYIsU
         Yx+zIdfi1wA+uWg1Dz4GNXpOGANPQSh1iVYaP1NS0Gr8BqCf0qJHOEEwRLvXOu8H5es4
         y/TvivhfuudNWxZqA8Ixq5QGFFbeEj9PI5ncJAe88YcIWHX3ideTVzxybGvGr8PvGyVU
         I9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2w3UaRY4tOJq3E4doSRjv1RzbI5MGYeTGPh7GmlOT1s=;
        b=tldLwVRdADyUdGENlxS2V88qmup3vjZaQzzQJSDq2RhOEOXmCEOqcodftAj3gTCUww
         wV0Xyi6AkiyuWSYnL5QQEkybpeopexHAdtXQBlLQ27KYTQeRfXhRAwrbf129KU/wop7+
         GutA9fsItd5zbIkwtFofyZsmSRUQxbhS75YcXlu77IFNZ878zSAA0brhZhRxA1UaDs0Q
         7qRgOVlQY91Fwmkf3Fe5VysAJit6CD3CjYJS6lDP2pbXgaLx2JP1muwcicMjC77OFvBo
         tCg66EJPd+6XkbTQx07k183NPpuWPhnIZI2qdGGziyNfbhqvw45uDHnx6Tqn3HQVgGa7
         g0QA==
X-Gm-Message-State: APjAAAVgVZXT19D/za6OV2+D+B2VpxArSwV46zpGioeJJpV6N+hCPA7N
        2FgingoWAyG4m/XaRr0Bu/RmqbiWkDwjdQ==
X-Google-Smtp-Source: APXvYqxREzdER4L+wJlDVO7np0N3EGPnInc6xERrVc+S2ih5ky6S+1oQjiWkGJ7ExaftkX58SqLQlA==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr3069024wma.171.1581665851110;
        Thu, 13 Feb 2020 23:37:31 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id k16sm6315217wru.0.2020.02.13.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:37:30 -0800 (PST)
Message-ID: <5e464e3a.1c69fb81.8c39c.af78@mx.google.com>
Date:   Thu, 13 Feb 2020 23:37:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc1-10-g55fe2ef33c65
Subject: pm/testing sleep: 5 runs, 0 regressions (v5.6-rc1-10-g55fe2ef33c65)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 0 regressions (v5.6-rc1-10-g55fe2ef33c65)

Test results summary
--------------------

run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =

2   | exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 21/21  =

3   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =

4   | rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 21/21  =

5   | tegra124-nyan-big    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc1-10-g55fe2ef33c65
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      55fe2ef33c658a1c0922ca161b136bb7171ac084 =



Test Failures
-------------
  =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0207.3/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
3   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc1-10-g55fe2e=
f33c65/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0207.3/armhf/rootfs.cpio.gz  =


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
