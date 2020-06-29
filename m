Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6554920D46F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgF2TIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbgF2TCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:02:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FBC030F22
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 09:36:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d6so8252656pjs.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Myoo6ZszmB6Qkv8sLYHFDV565+xqDs7Rlyww/lkwQBA=;
        b=NIJX+MlmdfRd5dB7nB3OHbZhgQpco07ZwsCvKQ/tGnOuwEqG2JZ6LmCWCV+p97NJ+1
         toCcqed2xOu+l04ODK8vcdjs2xhX4ig17LH0vh5ECqC1VNEKT1jSDT6PJvCNzLJ2Sr++
         PmLSzY4IItUo5+0Mi6DsKQioikZSiQ6o71czweVQq1jPKYdMNNXTIC854u8+aTpYwB/p
         k9BiIvQOn4tmhuokW8wniWhDiheWd7dJ4M4iDh0bJkyWUg3y6e9vgxrI/rxyNoVteeMd
         IQQu3r5YcJc/1d0BP4MrQxS/P2ivLSKoYwqCja3BdxWi4SBKVEQyXO3UDZsd6BMlPlbf
         XG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Myoo6ZszmB6Qkv8sLYHFDV565+xqDs7Rlyww/lkwQBA=;
        b=gEQ2vW4fAmmGOFLBdTsnD9TwLmzepnwj7ulLUvKAnwMyygYHGNe3oeaqEjfbu7rWWE
         yi460Y7LYTo0qSKhe2Cttugcaw9U7irblNsOVKmgRdrlEixLzJzqrsS+Yfz7lAIg1YyB
         0R+2FIMwwgbi0BOXStHiE9Z3wdedNAqkV7QGIo2OO/T2RTimYXK+9DmY8r8GsPiq7wAa
         T2ZEL2DJyJpVkxNRUa5+hp69+m9UN2GAXE4Lmd2vUQSFI47B/g7/TFoHWWdDzoBpkcdC
         3n7IbKEEMQRIKh3zPJBhDPuyX0C1KsfhsBqiFVa1aY/BXfAnjhscloyE/7xhMEzMYfmE
         BjaA==
X-Gm-Message-State: AOAM530OdFSr8J94YMfxYz4f79lXpk4tEFxJ0k7kAYTSFwf+wZt8MVbB
        tpbG6BtDHXx26mDM5v+8TbW68lWy8OI=
X-Google-Smtp-Source: ABdhPJwt6HsLfBYhQ/zpXyHXnIxmX3sIs9AufEGI5xCKE2saOC3vefynplOUPL4+cb9MDyi1svAXVg==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr17453145pjn.95.1593448561930;
        Mon, 29 Jun 2020 09:36:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3sm99777pjt.19.2020.06.29.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:36:01 -0700 (PDT)
Message-ID: <5efa1871.1c69fb81.cc4c2.04b0@mx.google.com>
Date:   Mon, 29 Jun 2020 09:36:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-20-g4ebdb176f4ab
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 34 runs,
 1 regressions (v5.8-rc3-20-g4ebdb176f4ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 34 runs, 1 regressions (v5.8-rc3-20-g4ebdb176f4ab)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc3=
-20-g4ebdb176f4ab/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc3-20-g4ebdb176f4ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4ebdb176f4ab253a2f7eb2b924dd3dba9fa3bc1d =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5efa0d9f3f32f9016e85bb20

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc3-20-g4ebdb1=
76f4ab/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc3-20-g4ebdb1=
76f4ab/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5efa0d9f3f32f901=
6e85bb23
      new failure (last pass: v5.8-rc2-27-g3168a010c528)
      2 lines =20
