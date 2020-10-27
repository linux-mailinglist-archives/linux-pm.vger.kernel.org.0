Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BA29CACD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373449AbgJ0U5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:57:03 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42231 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373448AbgJ0U5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:57:02 -0400
Received: by mail-pl1-f169.google.com with SMTP id t22so1403447plr.9
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=itpcimRmJKRMZOn8SG7l1v6GPY+0t+qoFe2Yj0QZkAw=;
        b=w1fg81BI+9OHmnEN2m4DQ6vV8L7MxKo/6FA3S6eDhOwaEXRX1Vm7aVGeXlYbWQ2GIo
         YLHL9jhnKCSlAqRaXi73igW1cpdIH3p98CBGeScuNgjPuW+0BJVyXHfoFpnteBI0eyDA
         TM/LzYAVVGCG+iANKX4J9E6r9LgyZ0WkPQ8P9R455jhBl5SLlqR0OjzUZnbf8S/Tc99e
         P5l1Q2KVGk0xzVd6ZYKTIS+Vem46bw3wkQrjN+efFzWrpANGHzRIeK4+kGyMHNivJ4dB
         emoEn2+CRuNXPWENNK8GHKQjJfOd81W8deVobakipSUHdgWRTxFM7ZqKZ8Qdw4Azkk5d
         QZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=itpcimRmJKRMZOn8SG7l1v6GPY+0t+qoFe2Yj0QZkAw=;
        b=O7Z2pYeXEpnro84ue9RKrAt+EDU4OC3wnS6L2kXHPSJW2dN8zjl/cqv7KVj7Am+Bda
         mEj/iDI8IxZWMdLDmtQwaHwclyQEIzu21W7hne8zthsGwJQu+6cHv67bC2fOon92LzyS
         FayFzQRpJlrwiHsNjV+GUhhOFmtjAbqslFFHF0YGlVVtjfyj7CSknYeTZLX8gYge67P5
         QS2HREWEoqT/44YxVzAVMYurqYfkM+YPKuQeO5DhpUCc9qb3DtKDfEx5qWiQhY91LtLG
         RfppOkpwn8uJhJYjezes5cby9vwNxxJ0RMnyBC2GZQuopTYWyV3VnC4/AATcrC/UyAWi
         8qgQ==
X-Gm-Message-State: AOAM531W0LFtcC+wylIOgmdJb0+WYvkuuiziKola/bap1cGQu8Ld7DCz
        bqwLiQDkTsf1RxmSzPx6v9a3xw==
X-Google-Smtp-Source: ABdhPJxTvqvxosH5aON4IcSzRPcaDl/2UGNaPLjhPMdSRExsHB50hc8DUXxhCfM/8EVqeRF4QwL6sw==
X-Received: by 2002:a17:902:bc43:b029:d6:711c:1a77 with SMTP id t3-20020a170902bc43b02900d6711c1a77mr53860plz.43.1603832220616;
        Tue, 27 Oct 2020 13:57:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b17sm3076128pgb.94.2020.10.27.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:56:59 -0700 (PDT)
Message-ID: <5f98899b.1c69fb81.131f9.5b9c@mx.google.com>
Date:   Tue, 27 Oct 2020 13:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-4-ge213cd8f175c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs, 2 regressions (v5.10-rc1-4-ge213cd8f175c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 2 regressions (v5.10-rc1-4-ge213cd8f175c)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-4-ge213cd8f175c/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-4-ge213cd8f175c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e213cd8f175c811034bc766ac37bcb5b3cf83a22 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5f987d39a756a5a443381079

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5f987d39a756a5a44338107a
        failing since 69 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5f987def63c2fa2169381012

  Results:     11 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-6: https://kernelci.org/test/case/id/5f987def63c2fa21=
6938101a
        new failure (last pass: v5.9-rc8-160-g91e0225c546b)

    2020-10-27 20:02:36.483000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Tue Oct 27 18:47:28 2020
    2020-10-27 20:02:36.497000+00:00  <6>[   31.165207] PM: suspend entry (=
deep)
    2020-10-27 20:02:36.513000+00:00  <6>[   31.180048] Filesystems sync: 0=
.000 seconds
    2020-10-27 20:02:36.531000+00:00  <6>[   31.193679] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2020-10-27 20:02:36.541000+00:00  <6>[   31.209983] OOM killer disabled.
    2020-10-27 20:02:36.558000+00:00  <6>[   31.220157] Freezing remaining =
freezable tasks ... (elapsed 0.001 seconds) done.
    2020-10-27 20:02:36.572000+00:00  <6>[   31.236085] printk: Suspending =
console(s) (use no_console_suspend to debug)
    2020-10-27 20:02:43.108000+00:00  =EF=BF=BD=00=00<3>[   31.837416] mwif=
iex_pcie 0000:01:00.0: adapter is not valid
    2020-10-27 20:02:43.120000+00:00  <6>[   32.054180] Disabling non-boot =
CPUs ...
    2020-10-27 20:02:43.133000+00:00  <4>[   32.054630] IRQ 25: no longer a=
ffine to CPU1 =

    ... (63 line(s) more)  =

 =20
