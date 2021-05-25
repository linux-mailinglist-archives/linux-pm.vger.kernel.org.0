Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF763908F7
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEYSaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEYSaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 14:30:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4610C061574
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 11:28:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v14so20708302pgi.6
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=v8Vd/5uBP8UC1R4ke6EFDCxZMVk7ZFWjXagSa0T9dOU=;
        b=m394s7xEQ2hwVsRK9VMQiaJCc34ZN3OF2g9VcwIp2GTYQJOSo5TswoGjbCdOfcdm5A
         adsv+IarZBsNA2EuRV+rPJsuAKqnyHP1Cfvj4KmH7bNDXLqNcr3INUCGvwp7Tjz4YpWx
         xKibaEgwvSKxVszBjrutwaIVncxW2aCimfbAEzhC5P+y7I/ECc3AJzqwRjjjq9IfpyXu
         lVz9QBc1A001kKskUGaGOzAKojX2wC/X+E1GvoS2K78La7KiLdlLfEU5rlf6ir5Zs04d
         52mBTOzw+RaP00nY/S3E94cG0v+1UhmlrcO1oLXJB9hNtK9Vs7piDnCNugd7mPwcDbnL
         AoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=v8Vd/5uBP8UC1R4ke6EFDCxZMVk7ZFWjXagSa0T9dOU=;
        b=kV7mbNOfITJUAhwDiJQpkYRsmLJ4c10qJbsLQ3TzfHJW88UwBG++E7tIp8A+MnYyX5
         YdeF8tBSBF81Xe/PHJJkQETvzRXsRX6TYQB6DGbF0ZCUX7klt/Wd9RbLWnftAqjautkN
         aHszk/IJzvnJIEepIsKEijPrfp2myFYzG0BWF1Sex8pIDUDz5EopJoMwg/3sO+vb0CQT
         V8uOF4ntOUerImQDvDKS6jYZ+btUtPFGkFlEi/cWxuOi9TxhREPLJRQtYGZ4X6g1Zx2m
         5+9TZJ1tqBlQAQjOlhTT4k5wLqgQNrF+DsWwSJMHMiVaWqBmVmRVEcemkkL2kZlt72yv
         OSog==
X-Gm-Message-State: AOAM531PkLivVG+ZohZ1lgkMX4Kzi8g2WbFQw4Mqli/Y/ZdZSYPbe010
        ZxFTEPtq6lzdmLY4PZWJUBkBEpBVWykayF4U
X-Google-Smtp-Source: ABdhPJyZMy1VfFTRE2ZJ93JdATLapyBiagLx/ky1pqZW1rB5q3Qknzx3YfzyLASlJYqoynWl4mY2Ug==
X-Received: by 2002:a63:d245:: with SMTP id t5mr20215499pgi.172.1621967323205;
        Tue, 25 May 2021 11:28:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t22sm13799322pfl.50.2021.05.25.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:28:42 -0700 (PDT)
Message-ID: <60ad41da.1c69fb81.b18f4.d3b9@mx.google.com>
Date:   Tue, 25 May 2021 11:28:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-37-gbf15f94bdcd8
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.13-rc3-37-gbf15f94bdcd8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.13-rc3-37-gbf15f94bdcd8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-37-gbf15f94bdcd8/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-37-gbf15f94bdcd8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bf15f94bdcd8d77957c0649a2ea7e39705b699a1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60ad2dff13e27fcdf6b3afc2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-37-gbf15f=
94bdcd8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-37-gbf15f=
94bdcd8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60ad2dff13e27fcdf6b3afc3
        failing since 278 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
