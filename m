Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2005A1620DC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 07:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgBRG3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 01:29:41 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33708 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRG3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 01:29:40 -0500
Received: by mail-wm1-f54.google.com with SMTP id m10so1431891wmc.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 22:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=J/Hqskr9uyz0hFmSE27FhMqBK5iUjQ8LW2sBeyMtaC0=;
        b=tkUr0NGzVba8JYNsYS+D84K13UAeNBkE3rjenZ2Z5Nj5zpe7t74/WVnDoyPnY6Imp1
         94eq0g5kKqg8zY0q+xmvnzRFMs5TqCsdd9bDl2opPutSMK8zO+gmetKdH+cQ36efOacN
         7Phb4G/J4Ha9gNmAjtIp4+1cGx/gl/r6ZvpKaEGckW/Ov7VRouNNqyk4m4JNWYLP0dUY
         REC4EDUt3gXDqobYoT6OFWh0wRh0AZaMvjrTms7oVAsCh+is1cau00nxpb5PBZPWpolW
         kBxcXJO8mRwTwkvmM5PQQNWABbhXQdhAakm94A1qeTfaifXswHahNRWfdcLHHmhPmBw+
         H8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=J/Hqskr9uyz0hFmSE27FhMqBK5iUjQ8LW2sBeyMtaC0=;
        b=fW+CO1MJjYdExHXxVcBt38OimdCgpYEdxD8HlqSpjaon03RTJhb7HutT9q7XYKq5LD
         H3RVeLrJpYJdCMlnsJ4Y5yY1zisPF2hwqksofnoFrGKRR8OxlEGejMFSPIDeUzAFOgcx
         ySnbLUzr4fpsF8dICX4zv24okP6bD8oM4kX+8IpQYVH5xwmqyt6705NRVOFGXgPm5AEY
         idr4fBKjLneWJ0y8iNKt3G+glyMYtLZRwMUbz6UOfBOwWW/tJWJQMe/1/w+yp/8v8u3v
         5pRbgKY+UzZgupTgFTy5NqU500+Vz9+2jYP4xeWXlfNm0F7rotnASncvLV8CNTWYk7F1
         hLuw==
X-Gm-Message-State: APjAAAUkYo5KOauPR1LRgFHGnvuyKRvb26pIesJMrMAV7yMCT3dWGWOB
        eTzIuj7AdLQqHjO5aCne7RG2rQ==
X-Google-Smtp-Source: APXvYqy5CM4tnUz5qYymJniNdh3ntCERwi6cvtfr6RiFUADL1J8yxcbow3MZzvPKNC9unzoZf2FS8A==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr1122983wmm.180.1582007378313;
        Mon, 17 Feb 2020 22:29:38 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t10sm2244390wmi.40.2020.02.17.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 22:29:37 -0800 (PST)
Message-ID: <5e4b8451.1c69fb81.f061.872c@mx.google.com>
Date:   Mon, 17 Feb 2020 22:29:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc2-146-g00b838d60ec4
Subject: pm/testing sleep: 6 runs, 0 regressions (pm-5.6-rc2-146-g00b838d60ec4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 0 regressions (pm-5.6-rc2-146-g00b838d60ec4)

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

3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

5   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 7/11   =

6   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.6-rc2-146-g00b838d60ec4
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      00b838d60ec480d931f6209868e69e0d251000c2 =



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
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0207.3/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.html
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

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
5   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 7/11   =


  Results:     7 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.6-rc2-146-g00b=
838d60ec4/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0207.3/arm64/rootfs.cpio.gz  =


  11 tests: 7 PASS, 4 FAIL, 0 SKIP
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed   =

        =20
