Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE80937991E
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhEJV0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEJV0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:26:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D365BC061574
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 14:25:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u25so3667910pgl.9
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FHrSpIuySdofcAgpbiq/eC8Zst0trgBPbUF0zJfMRg0=;
        b=sSco2LzrWwVXvJzXUJlIeAZ+kQzA50SUr2MG5JLxP04iSWr85ja5Lc4ryRy4/4KNRs
         Aeb3tnhDNsOnPvPFyvAEeexA6GQSQJDM+VcsWkMk5p6XwS1KjfpN8MhV2iJhp7PjtXQU
         Iib8ieIGyDUhwyWdIj84lIIYiNzsTGi5JO2KDiNGEFF7u8MvJemtbBZd6kAE4PRclR29
         TAZCN2pTXVEDXwYYb+3PaRlateNCqiaqQtShwzOMNhnZm0a605Ime7hprTkJE6ZcRBCp
         b4Uk80QNTKwm7ud0xVU5tmacC79f8skAI8icC61PNwSljOv/Kvtvatt6SZGwocJfuQWY
         GipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FHrSpIuySdofcAgpbiq/eC8Zst0trgBPbUF0zJfMRg0=;
        b=J7Nc+KCXIHQ1aPIjscbaPV6bDI23W22w1e9IJNwBZGS/M5Ym4sti28vuzbGfC5qawL
         x+yvN4zchOYcJJdFdqXoMaagxZ4kCloiH8PeemFxdxafpbxGhpsaQK5BOrM8ZQtPFCsE
         vfpCQb9U9wyOdBBW2URgOhZ5bJiYjzNtSG8hp4zHSuEylegAcfm/1gpk+q57RAtqogIt
         uv1/iO32ZIAwcwd+asA/GrHgjT0AdO6EUOmAuYlcYRA3xX8MBy4iXQnk+1r3k67/+7cO
         +R33B/gyCS74E0KHV9WQ/4SjEa/NLm0TL1tNnCZqgpL6tD64I6JkSlGYrNk5YPoETyv2
         ZNkQ==
X-Gm-Message-State: AOAM533X8WcUwg5Qspg9r+Txbvw/UgczZq8MfeMvvf2JGK9OEyrJgX+g
        yNXiirCQNWmwbiPOMbBWX/3BRg==
X-Google-Smtp-Source: ABdhPJzZ7z6xfKukLaqAKOYIQjhn+puiGYlNMSU47MjTjfV5ob4dnsnpCB+ibAv1ihvbg3QZwW/SOA==
X-Received: by 2002:a63:8c52:: with SMTP id q18mr24606002pgn.356.1620681913383;
        Mon, 10 May 2021 14:25:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ca6sm323870pjb.48.2021.05.10.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:25:13 -0700 (PDT)
Message-ID: <6099a4b9.1c69fb81.bba13.1625@mx.google.com>
Date:   Mon, 10 May 2021 14:25:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc1-4-gdc9d574fa82fc
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 97 runs,
 2 regressions (v5.13-rc1-4-gdc9d574fa82fc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 97 runs, 2 regressions (v5.13-rc1-4-gdc9d574fa82fc)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
1-4-gdc9d574fa82fc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc1-4-gdc9d574fa82fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dc9d574fa82fc39db81cb09a99c09c865d03f98b =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/60999a73728f1e69276f5468

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-4-gdc9d57=
4fa82fc/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-4-gdc9d57=
4fa82fc/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/60999a73728f1e6=
9276f546c
        new failure (last pass: v5.12-rc8-168-g3c44d15e5ffdb)
        11 lines

    2021-05-10 20:41:01.687000+00:00  kern  :alert : Mem abort in[   21.694=
513] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines=
 MEASUREMENT=3D11>
    2021-05-10 20:41:01.688000+00:00  fo:
    2021-05-10 20:41:01.688000+00:00  kern  :alert :   ESR =3D 0x96000006
    2021-05-10 20:41:01.689000+00:00  kern  :alert :   EC =3D 0x25: DABT (c=
urrent EL), IL =3D 32 bits
    2021-05-10 20:41:01.690000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0=
   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/60999a73728f1e6=
9276f546d
        new failure (last pass: v5.12-rc8-168-g3c44d15e5ffdb)
        2 lines

    2021-05-10 20:41:01.695000+00:00  kern  :alert : Data abort info:
    2021-05-10 20:41:01.695000+00:00  kern  :alert :   ISV =3D 0, ISS =3D 0=
x00000006
    2021-05-10 20:41:01.738000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2021-05-10 20:41:01.739000+00:00  kern  :alert : user pgtable: 4k pages=
, 48-bit VAs, pgdp=3D000000003a9f9000
    2021-05-10 20:41:01.741000+00:00  kern  :aler[   21.735433] <LAVA_SIGNA=
L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2=
>   =

 =20
