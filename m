Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FE2B0D8E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgKLTMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 14:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 14:12:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EBC0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 11:12:00 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z24so5018421pgk.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 11:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+f+Qy7biJlL5KLWzH21bkbuSncnfAaE0yc6nSES3UJY=;
        b=Jdy/ztb++B0qXXZ1EZ+Xg9Tz1ZLdmGU0tRyxukUwIjl+OpPCb+zCL3cWqqCGV25jYx
         yP2eSWFgCbLtyn9HsIwwB+ZBfFDNv26B8JW3yFIr4FCEbuOxQ9mJPffVguczeUJOL6M+
         eIKlyRYBlyx8ou19u9ZeVuVlrhN10CETbaYPLkBMgq0nqduEpdL5DD7KNCI5uMTF2dPx
         eTQuMSpZZ97hODOL301abNXnq0vIAfXNEAYJKtvaeVEVphdsAKfMlaojpAmsaOb7Z9OE
         t/9De/v8JwNLhtwZ7nsay3tTfHORWyo6/zdc5FtRhMHqeFRaPecMlbkR+ak28kPejkVP
         Zcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+f+Qy7biJlL5KLWzH21bkbuSncnfAaE0yc6nSES3UJY=;
        b=bqjXZ14xjyAmUj/5wU6o6up6TSGZ1a0eY91i1F1jdz38eyRhfyQlWkcNoOznLllaFq
         Zio1ce+W10IQ1lOZKEr72Ids7N+SxyH4cgdRxPsxKSy+ABuqVaINvoUq882dU7jvoVK1
         JZ6FMZUl8OjpTlK0GuqrXZj+Cq5Nfp8lYnM32xYcx6ycSm9KUtOAGDnm+Ce6CxUXafdy
         aaw9aZAHSu5Xuol6mnPva5fLss/fA2tuuqC5mZhMcHcy4N4KFxUc4IV4SkvMlmZyoSOC
         wkjG0P7nb1gmAHBhccq6SY+aQi0n0BB+s3D6kLBimTXVPLxak9V1ulVhoavZz8EMyat/
         PlOw==
X-Gm-Message-State: AOAM5325s+2GA7+PCIxqFkeWtYn7pTynXOXm9yfA88QSWLi0LjE2vaYa
        W7azBDEeUpgAfYLfLUbnmqAs0w==
X-Google-Smtp-Source: ABdhPJyvr9tU71yRUiGhTVmui6+O3VqFCmEL/4redFq5xCVNqjmZGS2ocqwkdtvubeuJc5zZLHZpmg==
X-Received: by 2002:a17:90a:4814:: with SMTP id a20mr649178pjh.163.1605208320343;
        Thu, 12 Nov 2020 11:12:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r36sm6816986pgb.75.2020.11.12.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:11:59 -0800 (PST)
Message-ID: <5fad88ff.1c69fb81.5acbc.d6d8@mx.google.com>
Date:   Thu, 12 Nov 2020 11:11:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: pm-5.10-rc4-33-g52d108cd060d
Subject: pm/testing baseline: 121 runs,
 1 regressions (pm-5.10-rc4-33-g52d108cd060d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 121 runs, 1 regressions (pm-5.10-rc4-33-g52d108cd060d)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.10-=
rc4-33-g52d108cd060d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.10-rc4-33-g52d108cd060d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      52d108cd060dea3403c01d460c2ffbc7eaaf4a9c =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fad7a0015577aa849db8878

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc4-33-g52d=
108cd060d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc4-33-g52d=
108cd060d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5fad7a0015577aa8=
49db887b
        failing since 1 day (last pass: v5.10-rc3-14-g103ceda28388, first f=
ail: v5.10-rc3-25-gfc4b18739b23)
        1 lines

    2020-11-12 18:05:52.301000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-11-12 18:05:52.302000+00:00  (user:khilman) is already connected
    2020-11-12 18:06:08.387000+00:00  =00
    2020-11-12 18:06:08.388000+00:00  =

    2020-11-12 18:06:08.388000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-11-12 18:06:08.388000+00:00  =

    2020-11-12 18:06:08.388000+00:00  DRAM:  948 MiB
    2020-11-12 18:06:08.404000+00:00  RPI 3 Model B (0xa02082)
    2020-11-12 18:06:08.490000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-11-12 18:06:08.522000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (379 line(s) more)  =

 =20
