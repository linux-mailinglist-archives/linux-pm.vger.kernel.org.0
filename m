Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA735F968
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhDNRGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhDNRGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 13:06:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93877C061574
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 10:05:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b28so2733857pft.8
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ao8knGyoGgPTmQ9pzXZXnDwb8CRgIUxTNAvB2q5igdQ=;
        b=0wwMuOP0qUZ8HW7JZSni4MC1GucvPinnTkoiuL/YR2MGKac69qLwU/uXS/RVinGg1E
         HEBaaoYmaeRI9hk0I1ZUflYlPbSTB8Y5wTIMMOyV+KuIR+ptraMiO9yEmIwIxvuGgK8S
         099tbPMHu+N9SwuvjqatsVNzAjnCZHQHbUUSDbJBsb0opakR8hQ1gMwN0l/MmkvRGfLY
         ie2nUP0KG/qdWbsIYwUxzUcPvAAzQKDaxFYZRL9OWMqoRwnILVYXDVkHaMH9JKf71NEb
         sOPyWHNjSIrNPMOLWX73sIP8drSwqKgsVv+2Qp4Is3ni+aV1xduOkDJ6uVTEKmy9rFEm
         FY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ao8knGyoGgPTmQ9pzXZXnDwb8CRgIUxTNAvB2q5igdQ=;
        b=mQJeer+dQBluJ56t9QjfTB+Q2ZmHm72tWA1qUF0iojZwv1Ty5CqbJIuyBdFOdfAq7e
         o60Ap2xi1aUNyjuXoQAOB8AaDOjX9Xtw8XrUz+oa349j0odd+zanjW+3eHKY7FqgLaaT
         At1mKU4/xPrfW2zrVJxCpClQHap0/igEfM1hl6w+iVa4c6eRbpNSaqxt3AegAfKrQZOc
         lrlKv49tg3zTLIUdTW6/3U5/gZ3N0RsWmJAUvlnAbL0mGlMnEuxgIFENUnSnYRF/esbE
         /dfCbMv65nuLTb2Ure+jaUNLfJAL92L2ejcOv+8cfi4Eb4stvJz6IZgX+RtpW6Pw2DUt
         JkgQ==
X-Gm-Message-State: AOAM532AoeyFQ6tKpUZPW4+1U984cfMjPb+QR4QrM3Riuu97X5zy3C+3
        L6A6fnuuImOmCFRqeC2qkRBcSw==
X-Google-Smtp-Source: ABdhPJzodBNwWEDAMQuvVAemfm56IAvjC5SgacghSeqdP6jS9zX0TBHSJ6X/gjC8jsrRXh7O7n9jSQ==
X-Received: by 2002:a63:4c63:: with SMTP id m35mr37570551pgl.105.1618419948169;
        Wed, 14 Apr 2021 10:05:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r1sm24643pjo.26.2021.04.14.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:05:47 -0700 (PDT)
Message-ID: <607720eb.1c69fb81.99fbd.0198@mx.google.com>
Date:   Wed, 14 Apr 2021 10:05:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc7-162-ga5b1c231c4a84
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 95 runs,
 1 regressions (v5.12-rc7-162-ga5b1c231c4a84)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 95 runs, 1 regressions (v5.12-rc7-162-ga5b1c231c4a84)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
7-162-ga5b1c231c4a84/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc7-162-ga5b1c231c4a84
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a5b1c231c4a84cae19849db076b8a56ffbc8a079 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/607717faf1023be128dac72e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc7-162-ga5b1=
c231c4a84/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc7-162-ga5b1=
c231c4a84/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/607717faf1023be128dac=
72f
        failing since 13 days (last pass: v5.12-rc5-47-g506a524e05e2, first=
 fail: v5.12-rc5-47-g85f34ae663986) =

 =20
