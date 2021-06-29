Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8173B7773
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 19:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhF2Rz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhF2Rz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 13:55:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C10C061760
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 10:53:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso2961335pjp.5
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=72g6i84FKU5lK4+DVkeMD7ESmekcbPRG75RlOvl1oag=;
        b=ZOgs7bfbrivIGX8kKjpfJca+uZp+qTJUmdmdXdQNBHzBms+/P+itIKoHaM7UdL6zLf
         2pRyfVqKci0jn6/rxT/eBWreaMe73IdpPZ9ZS7O1UcdTA2lsBhibW3AbUloG8bALRoJz
         zUuQ/FB20SDE0UaOniRmesjXykHqjqutekTNkKKvG+1xv0yLU8oh08QMj2X8aVVQflvk
         DKi9z7CLNKZJFqYTUFHBcxlmgMUDnYtoOeGS4LLmP6JVhmT2YOFaGPINA+EoPJu8EkTO
         6z3rNrTATatdKbmXQhkYiYG/isC0/iN9nec5f/YmI/UD/TJKh/Mj0yvoW/M+yVqKu1qZ
         /ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=72g6i84FKU5lK4+DVkeMD7ESmekcbPRG75RlOvl1oag=;
        b=EXOR/hx8uorIT2Xvmf1dUx89snQKgbzWJRqI6xqCukBiI1Zh5W39YXC1NKHPsMd4G+
         Nwl14ZEfi/+16tz0epyXJVSEZixrdyJSZ5jY9ZbC0LoDFVyul3ez325kbhSnTSPgOnOY
         eC4qM5ClLxBfm1wz4cOn8MrfyhqOETCn537H3+lzlEje4hinOUa90h09Duxb0F9fhxVO
         AKI01lTDyMBgvctkTfBKfZPknHeWNB71XhlwyxNP6DJjEvhnKSWPiuz02Z9r/qSsQfap
         z4chuDvYoJ3eZjOfQZwt+J/asLsj85ugnhm/ItkmVwqbAFXPsx1qLeN9JSLJ+0xI/gEh
         vYsA==
X-Gm-Message-State: AOAM5315LA/9Za/W+IttYwwel61eKclElaWLAsjv53v/PeHEXJrJXcGN
        4ayq0Rv9I70bDF0aT6lzWokRSA==
X-Google-Smtp-Source: ABdhPJzNV4HaEuaHTjaLi9LZ8aABR1MiOD9NW67hZ/mMf+tvXWQSol6cJM4UwQ41NXK+wEGstHkZvw==
X-Received: by 2002:a17:90a:ea88:: with SMTP id h8mr14210013pjz.147.1624989179716;
        Tue, 29 Jun 2021 10:52:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b9sm3892246pju.11.2021.06.29.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:52:59 -0700 (PDT)
Message-ID: <60db5dfb.1c69fb81.21bce.c19b@mx.google.com>
Date:   Tue, 29 Jun 2021 10:52:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: devprop-5.13-rc8-173-ge132b9a1079c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 86 runs,
 1 regressions (devprop-5.13-rc8-173-ge132b9a1079c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 86 runs, 1 regressions (devprop-5.13-rc8-173-ge132b9a1=
079c)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/devprop-=
5.13-rc8-173-ge132b9a1079c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: devprop-5.13-rc8-173-ge132b9a1079c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e132b9a1079c9a25ae896d443b0eca1b272b5f5b =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60db50d14e6bf2263a23bbdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-17=
3-ge132b9a1079c/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashe=
d-a00.txt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-17=
3-ge132b9a1079c/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashe=
d-a00.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60db50d14e6bf2263a23b=
be0
        failing since 214 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
