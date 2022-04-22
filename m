Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041150BFBB
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiDVSN1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiDVSKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 14:10:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9915BA0D
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 11:07:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h12so8844692plf.12
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=v6D+LKGKXmROl02G8faI8+bXj47LPV7H0RdgfZBfmbw=;
        b=ZT5Xk9LhAc2Uq7Vk59x1+acZ3WKJvh+wRb3p9bp/HWZ3r7FWllTmBXd3o9ooo2ETRJ
         l9ggVlgfY9tIwBCFzrhDu8OkPdeud/GIGbSPZeiRNMIsoGeUDwsqH9ptZs5aspQ/p4F7
         hRROT7VnWpC+ttiWN1LWFdxiBaunT9D3t2obmkT053HeqqqlBzmR3RJaRIKmhA9TcUZ8
         28+9/iXqAOFldesICOjCry6MmNZc46VS4Y0jOleBclaneksAAkW/XOKn8VeWGaxIvMng
         qgfUHIyepRgJgxWu+MFHWiL1a0JjzxthxE4wQ/MPARY/jdV6ypZUKVtT920MrVRn5W1/
         znWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=v6D+LKGKXmROl02G8faI8+bXj47LPV7H0RdgfZBfmbw=;
        b=QbecR5b/8M5CquZ9MXAg8OZ/J3Sk/f+J0bH7XmbUe5k9DZJ4+ivT5XTU6Sve6/v7PO
         bo5PU0aTGaNfL81PWyFyAr4EfKpNy0EVrBqO1Rdo7a1ebgfdhnfWBFlns+7Mmp+shKW0
         Fydd7QQWTwfw4gsY//IbIjctTfgRvQ72Eirx7ANZb08tBzx1/H+i06UpKm8MrPoP6yZD
         Qg3Ui/nfmFSwUJ6ajKmelmaDEfRdx0iltoWXKZMLdOO4WoRCUSTUswd+O9rIBwyeNHrQ
         RRSCDOfwhHV+mVpY09DUAtV+4kKHNf1mNWPwJviRezT4urG9HwUBbDlEJIgSa8Omc6d8
         e9hA==
X-Gm-Message-State: AOAM5324XnRzmFeLS2dLfAy3pMQGL3YdfaEUdxl0cdJMoLW8UfXhTXTM
        a1ja4+jd3OlaMuBRGPGuutmPUA==
X-Google-Smtp-Source: ABdhPJz8kMEcuD91N/RmYPFjUpMCb4z+0FjUChqudHAa54stueLwDNJPdCwnofxxLDGyXLDQ7MvXtw==
X-Received: by 2002:a17:902:9307:b0:154:78ba:ed40 with SMTP id bc7-20020a170902930700b0015478baed40mr5937095plb.92.1650650837210;
        Fri, 22 Apr 2022 11:07:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b004f7134a70cdsm3195731pfi.61.2022.04.22.11.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:07:16 -0700 (PDT)
Message-ID: <6262eed4.1c69fb81.d93e4.7c35@mx.google.com>
Date:   Fri, 22 Apr 2022 11:07:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-93-gc15e061fb0ab
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 18 runs,
 2 regressions (v5.18-rc3-93-gc15e061fb0ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 18 runs, 2 regressions (v5.18-rc3-93-gc15e061fb0ab)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.18-rc=
3-93-gc15e061fb0ab/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.18-rc3-93-gc15e061fb0ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c15e061fb0abc59bfd50b710deb61b4329392a3f =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6262e49fa468bd4929ff947d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc3-93-gc15e0=
61fb0ab/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc3-93-gc15e0=
61fb0ab/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6262e49fa468bd4929ff9=
47e
        failing since 7 days (last pass: v5.18-rc2-13-g781d19cfe317e, first=
 fail: v5.18-rc2-76-g5675fd487f2b2) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6262e49bba19860f4aff947d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc3-93-gc15e0=
61fb0ab/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc3-93-gc15e0=
61fb0ab/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6262e49bba19860f4aff9=
47e
        failing since 7 days (last pass: v5.18-rc2-13-g781d19cfe317e, first=
 fail: v5.18-rc2-76-g5675fd487f2b2) =

 =20
