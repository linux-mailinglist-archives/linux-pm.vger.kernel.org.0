Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626B845FC79
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 04:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352182AbhK0DyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 22:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352149AbhK0DwN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 22:52:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2FC0617A2
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 19:08:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so11005358pju.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 19:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZqxSNECv9GvJGh87p2TNP25ungPeKheAgF/DLuYmIfY=;
        b=4ViT3XZ+6RhuEAKhhMWT1r6434iMNFt3fmk9A4iQzI8oQ/Cqa2+Up3kH3ePNq+WhEa
         qGjJYbWL0LpIMIdeWti71Io31T1iAWTUPxp3PAJFsz6qT5FzApr3iooenk5RTDsfpE/k
         /9Q/oGo+yEWYuaODKxUy/WTaxlImIgyTe8o1HLGe7gBbEy941uKQbjadI6Y2z+LRe20t
         sRRPu9nF/BB6PJa1JmKViV6NHmRZ0bRnGlurhBHJk15PM+c0c95NXxkUHSXAZxlV9FoB
         Yaz8PQ7DllsP3Lju4O1MYrosQQ1AWYA1ZeJhOOOn9K5S6FsloaF1evepIM45XRt/8xGn
         qz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZqxSNECv9GvJGh87p2TNP25ungPeKheAgF/DLuYmIfY=;
        b=Sk/Ua8dGWiUlWCwcAefOGVC64l4sO6L+Dqfmup9SzgGM6FIX/wXxgBs46iT9h0SrZj
         AED035MMHrU5WLzxs4ejuE7iFnBJBTJarQt4UeAK58FoxXnDaRfLNtzYlw4lNd7JFp/+
         Lo1X0II32vPyOpjVN5BNX5LAyh9Sp8ytwU4kH0NZMkHuus6CKG0cda5HX0eCQn7aU7Ks
         qJZA2bngqoXwv1h6xQAbD5chw8cRMqFmAeNbS7CkDDwUckTVFTln5zxTq177C2GDEmC+
         PJR5eCRWcoIsd6x6mZtzT1uW5fiMkNpE6YzWZOADw/zLay1JxwgRmxuZo32bEEj7XtwJ
         2MKA==
X-Gm-Message-State: AOAM531BjZ4KO52WRyy8+M4dEjAa+O5IK3FcwEAlS/sd3A0mtg0jizaf
        5NPUlH+11Ci4EZAYf3BmMW17Lg==
X-Google-Smtp-Source: ABdhPJwSwSYRpQIydMJSWBoAMG6gERhz5UIdNc8KtKTlhK3l4PGRHPEJTk7ylStxLOEXnSDpkUUDCQ==
X-Received: by 2002:a17:902:e5d0:b0:141:cdfe:97d7 with SMTP id u16-20020a170902e5d000b00141cdfe97d7mr41786471plf.65.1637982497106;
        Fri, 26 Nov 2021 19:08:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mi18sm7275029pjb.13.2021.11.26.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 19:08:16 -0800 (PST)
Message-ID: <61a1a120.1c69fb81.93134.40c0@mx.google.com>
Date:   Fri, 26 Nov 2021 19:08:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.16-rc2-31-g7975c7f139bb6
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.16-rc2-31-g7975c7f139bb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.16-rc2-31-g7975c7f139bb6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
2-31-g7975c7f139bb6/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc2-31-g7975c7f139bb6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7975c7f139bb692861600c15d89034a24e467aa9 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61a198d3caa454891718f7dd

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc2-31-g7975c=
7f139bb6/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc2-31-g7975c=
7f139bb6/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
1118.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-6: https://kernelci.org/test/case/id/61a198d3caa45489=
1718f7e3
        new failure (last pass: v5.16-rc2-16-ga3f78507f993)

    2021-11-27T02:27:55.694694  rtcwake: assuming RTC uses UTC ...
    2021-11-27T02:27:55.700931  rtcwake: wakeup from \"mem\" using rtc0 at =
Sat Nov 27 02:26:36 2021
    2021-11-27T02:27:55.714883  <6>[   27.951892] PM: suspend entry (deep)
    2021-11-27T02:27:55.730857  <6>[   27.966850] Filesystems sync: 0.000 s=
econds
    2021-11-27T02:27:55.748280  <6>[   27.979623] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-11-27T02:27:55.758731  <6>[   27.996110] OOM killer disabled.
    2021-11-27T02:27:55.776370  <6>[   28.006141] Freezing remaining freeza=
ble tasks ... (elapsed 0.002 seconds) done.
    2021-11-27T02:27:55.790797  <6>[   28.023537] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2021-11-27T02:28:02.342857  =03=00=00<3>[   28.042879] mwifiex_pcie 000=
0:01:00.0: adapter is not valid
    2021-11-27T02:28:02.355403  <6>[   28.306936] Disabling non-boot CPUs .=
.. =

    ... (42 line(s) more)  =

 =20
