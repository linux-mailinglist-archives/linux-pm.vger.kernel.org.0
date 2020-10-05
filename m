Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8328389C
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgJEO7h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgJEO7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 10:59:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43310C0613CE
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 07:59:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k8so7102412pfk.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RP19pXvaiPBDhpD4HTPNZp6Mf4qkPRu9S4Il2C06awc=;
        b=tc86AjmIruuh9Vria/XfNpcwoFZo/i09nzJHY0ybdBhyN++rqqkcQbZy5brzcz+s6x
         FG3PY/UKVGb65T01Iha3t7hxvs1HFAzZ3x6Vj7DJqmRAeY4NzwrqNjLJu7+mclGaOjiw
         CgXRjvadFfNe20jFEPScgARWoWQImsG58h32cRlidP1udpFpiQplNxGiyxyn0dk2nV+p
         BgDBDtGzeXwmPJYAnP+zSqUoBYuUw+MS3rspAcSHTFgR2aiIyIMBTX0N/XU2K4Zwi9wV
         H5Tuc9UaFM6XGOFzkI/n1NOKOOw8rt8n1Ng77wFqHITajtAJI/41v3UofzkkaW8Ft3Hd
         n8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RP19pXvaiPBDhpD4HTPNZp6Mf4qkPRu9S4Il2C06awc=;
        b=lUHQh8F03lmjyBzH3DTYdZtxyExez2FJNG0DhIxQDpthSnkJPE/CZVkHJK/gpq/PEQ
         8DlTVZmKpPg8em5BZ9IcQhopK5r7zjqxyPOUjCDRlYtFYQdJJWY4a6JfN+df9TUUkM2o
         T78bNc0JuhZAuzSMuPIMrV03p18f8hXAkPGu/11GUw3g3LGtV90RehWKpfVHmjLt7VbA
         Qu+eaRfaXEUCwWRvyiInjDUoz2iS+LVdPzy04SbsiBdgQd/WOYo93ReHjGKQWzcnd7rn
         0+7YGWOdoLfWRD/y949JD4/DsD2Qu4uIkk+JMY6iD/CB7vxmnaDXxaSCx6kdL7LAPb0+
         Avag==
X-Gm-Message-State: AOAM533xVNC+2GzLCEXsSkuy/XV5fnJ1a9cpXoUkpVH6Qte66nV4z0Q0
        zS8r42/ojJTR4E7pcI3ZnRaQnhXljiGd8g==
X-Google-Smtp-Source: ABdhPJy+iiQhoAOPQeoc8KBvp43TNiu3n+Q1V9z9wmE6VN1+ho8YWWEPu8Rw6TUzZYnic8ChU3kxMw==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr732094pgm.397.1601909976695;
        Mon, 05 Oct 2020 07:59:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t3sm11122944pgm.42.2020.10.05.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:59:35 -0700 (PDT)
Message-ID: <5f7b34d7.1c69fb81.6458.4fa2@mx.google.com>
Date:   Mon, 05 Oct 2020 07:59:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-85-g66bebc5f7cab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 35 runs,
 1 regressions (v5.9-rc8-85-g66bebc5f7cab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 35 runs, 1 regressions (v5.9-rc8-85-g66bebc5f7cab)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 3/4    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-85-g66bebc5f7cab/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-85-g66bebc5f7cab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      66bebc5f7cabaf1149f341fb7bc660d59fb99269 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 3/4    =


  Details:     https://kernelci.org/test/plan/id/5f7b26d69aa65499494ff3f7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-85-g66bebc=
5f7cab/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-85-g66bebc=
5f7cab/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f7b26d69aa65499=
494ff3fb
      new failure (last pass: v5.9-rc7-75-g027a0d093137)
      2 lines

    2020-10-05 13:57:21.411000  Connected to bcm2837-rpi-3-b console [chann=
el connected] (~$quit to exit)
    2020-10-05 13:57:21.411000  (user:khilman) is already connected
    2020-10-05 13:57:37.279000  =00
    2020-10-05 13:57:37.280000  =

    2020-10-05 13:57:37.280000  U-Boot 2018.11 (Dec 04 2018 - 10:54:32 -080=
0)
    2020-10-05 13:57:37.280000  =

    2020-10-05 13:57:37.280000  DRAM:  948 MiB
    2020-10-05 13:57:37.295000  RPI 3 Model B (0xa02082)
    2020-10-05 13:57:37.382000  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
    2020-10-05 13:57:37.415000  Loading Environment from FAT... *** Warning=
 - bad CRC, using default environment
    ... (382 line(s) more)
      =20
