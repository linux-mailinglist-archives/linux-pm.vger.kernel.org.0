Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88772FDCE5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbhATVZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436685AbhATVCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:02:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028EC061757
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 13:01:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i63so8210770pfg.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=REJMYy9834tYhSeEdTMN64eJIDaHuEK0d/R4CMs0wPw=;
        b=pgdRdQYfN8QLqiZ4byMOTuE40wjbaBg9KnMvcEr19bBTKex43pNdTR20KAT5BtWpYh
         1gx9iYb3uyJVjfbnW2imGtuEvnRtjX4hETbckLaNbA1XvHn85IeGCVxa6qeeoWR/PaVT
         xRjZKyxuTwIoaVjIwxSXzOdVrPv5GK7aLWISGbuwO8yZRJCL1KKPZaojiUkLV8zeeSOt
         E4Wnpuc1vgmt0t0r3aq/oCEm6fx8PIAwyIzxOfEhdy5OBoc2Uw+3lm/uEq81Av46V9CY
         SfAO4YBTAu4aPTuT4NtHS2JoDZpXCuj3gfT8NB58kX+PZJ3oqAhNmurR1Bqd8QZilbF4
         5giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=REJMYy9834tYhSeEdTMN64eJIDaHuEK0d/R4CMs0wPw=;
        b=TRpjo1nd5jfhbJCRddZSUbx+/JjkP45hU6HCrcp+0oq4Idzqy5yfYJf1Goh8GKWE2s
         /QiuNby+LFeudE7TBofenNXHxzMJB6Bb6oH7PIT17K/TuuaCInKxBeABLs6gxHUqgVQD
         aCKNsHQNrZYpfnITV5gdTcLzb8PYxM06W6KolL1i1lF2J7+6xYhhBIEwe3D9v4dPn6j9
         xPEI9VmGRJhzpgnREcoY8H1KlNqB3MZaOYCl58XXn0nncFkktHrUoNuEpqzr6dlbJBcy
         z3sfxbOxRWSv55c1aeQXb+3h6t/AQi+Aw3XiHhyx3oMBq+WUMWth9ADWh8r2cHIZ0PCI
         pb8w==
X-Gm-Message-State: AOAM531CldP1mnCQv7cPla4Ew0MCTKHdOKWQq6IKNhbSxmUmDMlhxusK
        A+wmBHObKHpDWdLbZpzQMxS8TQ==
X-Google-Smtp-Source: ABdhPJykYTSNWSTM/z7uHcc9UyfKLNn+62suzLXxPWSm+dxOHVAq52OCO/6S6EwnosFrUrIlRLjFtw==
X-Received: by 2002:a63:d903:: with SMTP id r3mr11132796pgg.445.1611176480915;
        Wed, 20 Jan 2021 13:01:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k11sm3133642pgt.83.2021.01.20.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:01:20 -0800 (PST)
Message-ID: <60089a20.1c69fb81.1ed02.78a8@mx.google.com>
Date:   Wed, 20 Jan 2021 13:01:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc4-28-ga31400ec480e
Subject: pm/testing baseline: 117 runs,
 1 regressions (v5.11-rc4-28-ga31400ec480e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 117 runs, 1 regressions (v5.11-rc4-28-ga31400ec480e)

Regressions Summary
-------------------

platform                   | arch  | lab         | compiler | defconfig | r=
egressions
---------------------------+-------+-------------+----------+-----------+--=
----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-8    | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
4-28-ga31400ec480e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc4-28-ga31400ec480e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a31400ec480e8a579467fbe36d7ea49c952109dc =



Test Regressions
---------------- =



platform                   | arch  | lab         | compiler | defconfig | r=
egressions
---------------------------+-------+-------------+----------+-----------+--=
----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-8    | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/60088d59b698163f93bb5d0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc4-28-ga3140=
0ec480e/arm64/defconfig/gcc-8/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc4-28-ga3140=
0ec480e/arm64/defconfig/gcc-8/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60088d59b698163f93bb5=
d0c
        new failure (last pass: v5.11-rc3-19-g9f0b1e583eac) =

 =20
