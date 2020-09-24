Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCD277226
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgIXN20 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgIXN20 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 09:28:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB2C0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:28:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mm21so1699694pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VYhbgvl85Zs3EN025pTqLMvAcOSvaQeILqmmhpwbPXk=;
        b=ZpqE+XWuiaZtc7CuwfDkO4JPco8rrErwTH/aJgEX8lM7vXWbkbp5SamlYLZAL8VQMv
         QNmw9+Ok7UFZ0PDFs+srA/SuqY47fzLKD3wYZGsPRLML6/OtIf63N3I1JX5pGsVxfVKm
         0E38MmCzAifU5YVZbMneC8ep703aizLViXmDL0zNQ1nexBumMHCbxGe43BNqps6cx8oH
         Lm1ymSbF4uZCvr85oYlTLWVjxMUXPkWi3YMbOxdui+rmD6MwZubcTXCVNcpnjKRM6++g
         uFVgvf8el4NUreOXw6Wk8640OOEnO2ORicTlCJRVz7ddp2tYI6PxBSuj7kizPZpUDAA4
         gmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VYhbgvl85Zs3EN025pTqLMvAcOSvaQeILqmmhpwbPXk=;
        b=geoob3RMXuZlAwZokGmmSMqjd6RrTnDNGR59yhVolyrZg1ZPGyKDknjC3o0H7KN76d
         pFP6mXJ7ggV2KHgs/QeOhcOi8B6LakvrU39dg5Ot9mzYykM37lzUq9L7SQvPJurbkPaI
         DRtfeCZIOJWZ8mbVvRx2cgUVt6vcqqdSkNZHaEfMh0oJ2NXaQIPACLlQf76KfjCvKWnu
         LDRDQMCx5vSdrDDlp9D8sErfOzMqQA53ySRD2UaHC2soBAT6jL8lt2jmKQS++u33spS0
         1uwwXRxl9NgfOb1HIvsaX9uoJPtcKU7Y1+zvbb/5KZMdEmPuVSxELyVITixZBSUFHHXl
         h03Q==
X-Gm-Message-State: AOAM531FUqbVbAEnQHkZGxN1Ga1Og5APkmjJtqmOKsPWOuXfY2aSF/RK
        WrLQEaN4I0qYjWaLPfjVOkjPpg==
X-Google-Smtp-Source: ABdhPJwVzYL1UQPOH/4RSv5TmHfWB0asqQS0YhgzVMrD3TxBJm6Hk4t0oFwbvMggZ3JefG0eQK20dg==
X-Received: by 2002:a17:90b:883:: with SMTP id bj3mr3782396pjb.184.1600954105607;
        Thu, 24 Sep 2020 06:28:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d193sm2968491pfd.181.2020.09.24.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:28:24 -0700 (PDT)
Message-ID: <5f6c9ef8.1c69fb81.38df2.7938@mx.google.com>
Date:   Thu, 24 Sep 2020 06:28:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-37-ga31d518ec481
Subject: pm/testing baseline: 117 runs,
 2 regressions (v5.9-rc6-37-ga31d518ec481)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 117 runs, 2 regressions (v5.9-rc6-37-ga31d518ec481)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
82/88  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-37-ga31d518ec481/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-37-ga31d518ec481
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a31d518ec48107762495760932218e57b2038289 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =


  Details:     https://kernelci.org/test/plan/id/5f6c95d7fcb491cd43bf9ddf

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f6c95d7fcb491c=
d43bf9de5
      failing since 35 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-24 12:49:21.521000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-24 12:49:21.527000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-24 12:49:21.533000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-24 12:49:21.539000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-24 12:49:21.544000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-24 12:49:21.551000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-24 12:49:21.556000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-24 12:49:21.563000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-24 12:49:21.568000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-24 12:49:21.575000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
82/88  =


  Details:     https://kernelci.org/test/plan/id/5f6c9490ead7013653bf9dd7

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.bootrr.rockchip-dp-probed: https://kernelci.org/test/case/id/5=
f6c9490ead7013653bf9e06
      new failure (last pass: v5.9-rc6-35-g5dee22f9d504)

    2020-09-24 12:43:55.606000  /lava-2651837/1/../bin/lava-test-case
      =20
