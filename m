Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD222794CB
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgIYXaq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 19:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgIYXaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 19:30:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB2C0613CE
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 16:30:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z19so4704712pfn.8
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 16:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+vdsyTGEOe10E9kE60xr6VWh+xGZnOJle9tbQ7mY544=;
        b=CCnTQ8O9G4U6S1Lnv+I3DPY4RPwmLrB6dCGJJhC/uxryWSJs/X7fMRXclYAe3nvCTd
         hscTTpRf4ExWKercnYn+TyxKQJcf+qaMdeeVqINcPQuTVxmnFU/uapdyPPZwCHUs2dXv
         Jwt3sPXNCPXKuOOUnRd76td85LqAwp95C2YbKNKChbI7O22XC9hjfhvFXu2SBaViQuti
         nx7tLRGju7bgAtYqFe33ZJIY+AHdAi3GnGux687YSFNf8kbsxgHWpQwBNXTvmqy2PibJ
         DdDeLH6WGRlbDpaYYSk80V4hYIsQk7rL4Tn5SzElhmA6q29i8KjLU+AY7VnEMRUwqpzl
         7f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+vdsyTGEOe10E9kE60xr6VWh+xGZnOJle9tbQ7mY544=;
        b=fcMgmtAreppJ7HRBYfh7xNnHpFMDpubkY0ugEK/o80+vzt6Af6lN0S4ZYYuhJSDh6H
         eJzZDUa/L+aobFW6TBXRi7VCBavXkRw9VmMd+a7rFggSzpRfW9kBigJgipVzLcYSJ+VA
         BoX+lbuCB4OHqT6d/dBPeeBOObxuW1ywhvVQqaKlqAOYQPI6SGyj+FOSkpg+JdTZj1J8
         dkyGctTj21OgeGmvXS+BHd5FGjY66oyRg+ZoxBU/DnT3bVaF4G5S2IScGu5hnqWqh9t0
         QSwdXYe/PqBMjLIUi1xVIjJRdfgCUA2/E2AZOMOZUhsccjbY3YLoMlAbzjJr5/P8rQgJ
         USpQ==
X-Gm-Message-State: AOAM531NjrY+HKCIy4KztFvcK6++bJgWcvRK4ZNdoJNZTubg1MjMacfU
        EQ00yC/0WXG38fo+EZsJvbSVXIVGCeg6Og==
X-Google-Smtp-Source: ABdhPJzlgzflz5hbVPFmadGfo8EjYPPIuCVZURDYbqoLU4clZwbVUumBc9v7+V7FfWI9AeJaGb584g==
X-Received: by 2002:a17:902:b287:b029:d2:635f:65ba with SMTP id u7-20020a170902b287b02900d2635f65bamr1742402plr.44.1601076645915;
        Fri, 25 Sep 2020 16:30:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e207sm3958484pfh.171.2020.09.25.16.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:30:45 -0700 (PDT)
Message-ID: <5f6e7da5.1c69fb81.6a2e0.b0dd@mx.google.com>
Date:   Fri, 25 Sep 2020 16:30:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-48-g537658447367
Subject: pm/testing baseline: 103 runs,
 1 regressions (v5.9-rc6-48-g537658447367)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 103 runs, 1 regressions (v5.9-rc6-48-g537658447367)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-48-g537658447367/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-48-g537658447367
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      537658447367fc0c4c1edf81958e10e7c63fceac =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f6e7388e0cadc93a8bf9e1d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-48-g537658=
447367/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-48-g537658=
447367/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f6e7388e0cadc9=
3a8bf9e23
      failing since 37 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-25 22:47:30.341000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-25 22:47:30.347000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-25 22:47:30.353000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-25 22:47:30.359000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-25 22:47:30.365000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-25 22:47:30.371000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-25 22:47:30.377000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-25 22:47:30.383000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-25 22:47:30.389000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-25 22:47:30.395000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
