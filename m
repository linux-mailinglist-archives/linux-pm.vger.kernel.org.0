Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466DA205BCA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgFWTaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbgFWTaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 15:30:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A9C061573
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 12:30:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p3so15928pgh.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2020 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=An2GCL0W0GyW68DzsGiws/r+1TEGtw/wzHzCr8ezdkE=;
        b=g1FSJR+LYV7sCD9nvr+Xd2iQsHcoVy+mcdoi53fhQAfO7LZnbIIIaG6GGhr+qO+S5e
         rnasksoLpbFeeQgP+g4eqscvacgZTE0UtkCYv4LhrLJJCVPPfEY68ssqxXTIMsz25oRP
         m4ZPWNPTBzAlIpd3+LOTtA/ZdYnuZXsSTL6BKrObojQTcsV0ROGiKsJvS3vfZ/5cEAhZ
         vpuwVVLd38BpiQbVIVbqTmPU1PfLDEHnI+p1DiIyDCrYY8BzKtkpr/pVm3uf7G2TttN+
         NGqBPRgmAka5vi676gLsWvHX8oLP8MwY2GTU+anxqkFmID88cT8hSwtPWbMfNOuxn3sp
         jPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=An2GCL0W0GyW68DzsGiws/r+1TEGtw/wzHzCr8ezdkE=;
        b=rAG8sUcd5yCu1WQA0k1+KH1vQryw+H4zYMV3qRuOARCEVfyXa9qOI6tZ62Tyqt9rBt
         AukwgRR3mD3k3SJ+Pu32+OE04DlcSa5/OM06iQXC62rvSkRnuct9WJqjFXOKzrC4TS/t
         5ZEXRCi+64beKxIFlx31dSi1sI3Oc0RWo2l22t+u/rwV25L9ORiNkyo9XifF36tOKB5I
         6uAQQyGiCcC/UTQcajYt/wkXkLj0kuvoKNvqN2/kFd8FUWR4M3wa4oRfrev3zv94zFM8
         qmmC/RJ5KCMFyqA/rcKrDdXMHERnRXxQKuCumV+J/8i4c9+ji60lXOlXg/e6+pgP9YEe
         /fTg==
X-Gm-Message-State: AOAM532QAWbMAu3LHf+/D78rWpWAo4NtG/Q/nVsaNZk6l2FjoHWMH85R
        oCL557mkj5iHjvJoRp5w0KcqRb7IApo=
X-Google-Smtp-Source: ABdhPJzWxzRK5UbLTDiEfzzi1lJah/rkwCE6pACY3txg4/gpi/1jC6TL7NMRQ/+vHV6CejYJHDjIaw==
X-Received: by 2002:aa7:8298:: with SMTP id s24mr3974740pfm.21.1592940607616;
        Tue, 23 Jun 2020 12:30:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s30sm14643707pgn.34.2020.06.23.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:30:06 -0700 (PDT)
Message-ID: <5ef2583e.1c69fb81.6acae.b7b9@mx.google.com>
Date:   Tue, 23 Jun 2020 12:30:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.8-rc2-8-g43bad67922e1
Subject: pm/testing baseline: 43 runs, 1 regressions (v5.8-rc2-8-g43bad67922e1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 43 runs, 1 regressions (v5.8-rc2-8-g43bad67922e1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc2=
-8-g43bad67922e1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc2-8-g43bad67922e1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      43bad67922e11898a43e62c64775f2a8675039b0 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef24f50cd4ea9a17a97bf27

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2-8-g43bad67=
922e1/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretech=
-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2-8-g43bad67=
922e1/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretech=
-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ef24f50cd4ea9a=
17a97bf2c
      new failure (last pass: v5.8-rc2)
      2 lines =20
