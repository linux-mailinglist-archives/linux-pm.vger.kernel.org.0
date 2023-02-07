Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683F68E329
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBGVwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 16:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGVvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 16:51:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E41027A
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 13:51:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso186703pjj.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 13:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GWRceperfJSlDwTVXFIGpxvJOb0bJ8uOkg59FzI9BZs=;
        b=My8htGmq/gW7oHIvrbySUJQVk6K0krv9So6hFIesQFTkIKsHDC2bncWGkcxFllAiUO
         264Z7XNix1TVS/gqj3wsh4l5aR5jY2eGkyOQuGE1cI195vKrfM+z11fT4nekFeO77beH
         C33ExPPSss3ypLi8iyOU2zGhDqUePfsVx+lrle3PSrhoQVocVkYh/9aaxjA0niyTo06Z
         c8k8JqCha0Tr2SPckkWMumHLYW2rAHHStjexjR3CHeDwQN/cWkkmsSD7gi+mazh6hOyV
         tB/fWqkI8elHhjdmDoUpWZIxZjxNctqszBjUZeNTy+RQKfgPlNcsiMCY61RpQz7/5SrB
         Zu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWRceperfJSlDwTVXFIGpxvJOb0bJ8uOkg59FzI9BZs=;
        b=XF6DjZGPhep+8nMV+fafmHSwaHwL4jWPhuStw2DOGwjuoEXS0nfyfXrmAwTc8BTh0A
         2F8/+dy8RiwkRIcw3+V0PON9EbvvkUwtFOEoDWif2hgy3SywtaTHaUaxw00kMwNgHtn3
         3c1J8kuTqsGo6JryCtNAtIclToi5L0ruw+9qOdSxC3yH5OtM9lV1Jr1wny/t+plEoShq
         NNOd7rHx5auzyYKBI+e8yUGiAtZxqgrn/toNYb8k3T73KZrGrS3sRUEl/7gkGKS59f4N
         vwD52R4SlknF7TToxQm+IVtAU5bQHAcZECnXAlt2XRM8Ymp2MAPjfvWvlJAuFEor816U
         qS8Q==
X-Gm-Message-State: AO0yUKWxofGInaNFNw2LmGUsPjPvcm5jjFzNDq4i1kkgwjM2Cn04hw34
        o3jJKr1nrLWGSz6MKhsxmj9jSg==
X-Google-Smtp-Source: AK7set8r/Qj29aUsFfO9SQY8WgDEdthCJMREJhOfJveMBz5HVnE25JmIZ9ctJaBKT626ovrNv/WHhQ==
X-Received: by 2002:a17:903:22c4:b0:199:11aa:50d8 with SMTP id y4-20020a17090322c400b0019911aa50d8mr5097893plg.33.1675806702745;
        Tue, 07 Feb 2023 13:51:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902ed8400b00192a04bc620sm9349282plj.295.2023.02.07.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:51:42 -0800 (PST)
Message-ID: <63e2c7ee.170a0220.f802d.fb3b@mx.google.com>
Date:   Tue, 07 Feb 2023 13:51:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-181-g1904ca445dbb
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 1 regressions (v6.2-rc7-181-g1904ca445dbb)
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

pm/testing baseline: 47 runs, 1 regressions (v6.2-rc7-181-g1904ca445dbb)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc7=
-181-g1904ca445dbb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc7-181-g1904ca445dbb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1904ca445dbb8585fc136e8c0bf2c3b0cbf2c64c =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/63e2b9ccf9599314688c866c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc7-181-g1904c=
a445dbb/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc7-181-g1904c=
a445dbb/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e2b9ccf9599314688c8675
        failing since 11 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-07T20:51:03.616314  + set +x
    2023-02-07T20:51:03.616475  [   12.960430] <LAVA_SIGNAL_ENDRUN 0_dmesg =
900610_1.5.2.3.1>
    2023-02-07T20:51:03.723081  / # #
    2023-02-07T20:51:03.824561  export SHELL=3D/bin/sh
    2023-02-07T20:51:03.824896  #
    2023-02-07T20:51:03.926059  / # export SHELL=3D/bin/sh. /lava-900610/en=
vironment
    2023-02-07T20:51:03.926412  =

    2023-02-07T20:51:04.027571  / # . /lava-900610/environment/lava-900610/=
bin/lava-test-runner /lava-900610/1
    2023-02-07T20:51:04.028087  =

    2023-02-07T20:51:04.031274  / # /lava-900610/bin/lava-test-runner /lava=
-900610/1 =

    ... (12 line(s) more)  =

 =20
