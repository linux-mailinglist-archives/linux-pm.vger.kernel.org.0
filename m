Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACA690DCF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjBIQD2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 11:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBIQD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 11:03:26 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFA64D83
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 08:03:23 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so1908615pgc.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8hbNuInS1cAuvAHslG3pc7g8PaYQVebtTQoATf9+UuQ=;
        b=iiyzKIJAYhUszGR1JVRHlbKwmvsyfSbgpJswysCnUGsz8wK8ko0N0PVy77odFg6LhH
         vRznyV7rS10R6fVxsFfJaOqs7u+ZTmnTagHkd6uwW2kyRHf8tv0Y6fN8lUVtHE6yRHUA
         ZPfwdCPE0t7OcO4OVzGMDnyxkvE0c5VtqmPQE+ANNI0AcB7pu33HnbKmzRXXMxmQId2c
         ZA2TPTbWI9ROd84RxFG5YPUE9WBEX3i7nt5NrpKGb1jRdmoUhz/ls3dgVYEsU9PFSIeO
         6paXqpDQun4TX5zTB04kIfmzv5vkQVSEnsjaoXf7ExCOgKFKXBHQtAWGdvP/BmdAVMm2
         XKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hbNuInS1cAuvAHslG3pc7g8PaYQVebtTQoATf9+UuQ=;
        b=AHHbnuedGK4VWgUY0JUL5HTtCG2SXZioEFNkDxU3Bdg+qsMu6AbFqqVeRmIzikhjg5
         tW/UH1+JKxER8k7iVtmcJ1pFFpV3bK2jOmN/kjHvfFV6i77lPh4xky+92O1MYxSGVw10
         dI8sD7NFhWEeWMhzt5n9hQJejYoOW/6wwg+JgspZAHWXbNQuzsG72zI2kpy9gOHvf2sP
         9f/wZpk1dkI0Gh73zyiLyhsqPC/NJX98t+ZCb9QLB9WzVIsPJTVvy5E12O0pMAeeof19
         E9HW6WkshyHZv942bpKKpHfzeugUukGRRtSZgQFIC7jpCcNHgxGhMalueG94zNvAMKLh
         kmCg==
X-Gm-Message-State: AO0yUKUZynYG3MRMqYW+8QqMJMaBibCLW4YuobLQz5cV7I5hjJqjrfTC
        0XjOFw9oO/g/JErttE6j/a4TRdrOEA8c/BqqvKBFuA==
X-Google-Smtp-Source: AK7set+ZyT0L84jdxGW3aZ0JR1XPF5UPCqrsU9j8yb4kYCxDTgZtBaKeijv81mYtq4/eV8bGJt6eHQ==
X-Received: by 2002:aa7:978c:0:b0:5a8:4ba7:5849 with SMTP id o12-20020aa7978c000000b005a84ba75849mr4586952pfp.28.1675958602758;
        Thu, 09 Feb 2023 08:03:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r25-20020a62e419000000b005a845490420sm1616106pfh.119.2023.02.09.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:03:22 -0800 (PST)
Message-ID: <63e5194a.620a0220.4b2d0.2a92@mx.google.com>
Date:   Thu, 09 Feb 2023 08:03:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-185-gbe3ba1769837
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 1 regressions (v6.2-rc7-185-gbe3ba1769837)
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

pm/testing baseline: 49 runs, 1 regressions (v6.2-rc7-185-gbe3ba1769837)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc7=
-185-gbe3ba1769837/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc7-185-gbe3ba1769837
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      be3ba1769837f7763b8d7019498af49f08aca3e1 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/63e50f2f186ccf6ed38c86b1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc7-185-gbe3ba=
1769837/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc7-185-gbe3ba=
1769837/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e50f2f186ccf6ed38c86ba
        failing since 12 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-09T15:19:53.847378  + set +x
    2023-02-09T15:19:53.847534  [   12.938108] <LAVA_SIGNAL_ENDRUN 0_dmesg =
901972_1.5.2.3.1>
    2023-02-09T15:19:53.955406  / # #
    2023-02-09T15:19:54.057131  export SHELL=3D/bin/sh
    2023-02-09T15:19:54.057542  #
    2023-02-09T15:19:54.158752  / # export SHELL=3D/bin/sh. /lava-901972/en=
vironment
    2023-02-09T15:19:54.159203  =

    2023-02-09T15:19:54.260386  / # . /lava-901972/environment/lava-901972/=
bin/lava-test-runner /lava-901972/1
    2023-02-09T15:19:54.260988  =

    2023-02-09T15:19:54.264021  / # /lava-901972/bin/lava-test-runner /lava=
-901972/1 =

    ... (12 line(s) more)  =

 =20
