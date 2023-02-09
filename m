Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B741369136C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 23:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIWgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 17:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBIWgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 17:36:10 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B322686F
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 14:36:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso7282644pju.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 14:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nW8F4/u5sE7zORazvakgZeq2/WXHM9M+7hTPsGbASFE=;
        b=BmVKKXSYwYn0AK+65T1A7g/XGcJ7iJUpIxexSCWI+WkTwqFofkgDna2qsbCY5p7ErQ
         L8OPzHhx2O2Cai+zcQcvanAo95gxjSp6cct9pbfoO8S1bo+yEhOIPHflennPS0EzMFFG
         rAYfG+03oAHhX9xFyiBNh7aZlhkuvNo6ZrsOQiVQgCNPg4TSnnUR0Z3BHlurMW8yYeln
         M095EYF+caGCmhVdxrzfLCwS8vPAnydZJBrhEllkxjy0e3lEoDzlAWU6VQOc6UkSFaET
         QObx7YYCwxN8MxmPpiEo6FbJffQT24L5DRag9JF6CZ1yZJDo0aCBCpNqtScAe9u3bhlr
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW8F4/u5sE7zORazvakgZeq2/WXHM9M+7hTPsGbASFE=;
        b=jvNKlv0aCQKBCbN8f/xssGQ1h6sFu43LTr3F93xdJZ3iJGiFa1mhNElYtI4gRX4Cj+
         Ek48dbibUTYfB/LCURYktyaL9PeDMQgCRXYvTnBdABWkh46EW4B61UTlFVeQfgAwg9l2
         8E8e15oZuwJzz0BTD/rLqf4KRnhChX2Lxuh6hkCEEv5INLQlQ1K9/jFadzKUmlGyCa4r
         aeJepV20OmQZrGSbewctGJXg9ngM6V3jdn7uKDDnuk2PlH7cFfa0ICW1jjXF7ydbSuL/
         C5dY4iKT5BFr0tVbL2qeOmcFgJiIgbu7O0TAZFCv9DcyTPWVUM3j88uCCHbejucdKPvW
         myJg==
X-Gm-Message-State: AO0yUKVJkWab3cxCBfBn4p0MxqUxT8iysf7Ic3jvpUPRIFahOz9gWGbD
        V2InkO72toaNnZih9bfXrWBqsg==
X-Google-Smtp-Source: AK7set8nwyV2WGlcsFMEZBf4HBV58TJnDOB5cIzuGHYLVEI7PWWnOZUJpjx67VrRYaGuujLqHoSZ3g==
X-Received: by 2002:a17:902:e885:b0:199:15bb:8316 with SMTP id w5-20020a170902e88500b0019915bb8316mr15541366plg.68.1675982165538;
        Thu, 09 Feb 2023 14:36:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001948107490csm2021243plb.19.2023.02.09.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 14:36:05 -0800 (PST)
Message-ID: <63e57555.170a0220.82566.3e76@mx.google.com>
Date:   Thu, 09 Feb 2023 14:36:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-6.2-rc8-185-g61b7614c114c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 42 runs,
 1 regressions (pm-6.2-rc8-185-g61b7614c114c)
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

pm/testing baseline: 42 runs, 1 regressions (pm-6.2-rc8-185-g61b7614c114c)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.2-r=
c8-185-g61b7614c114c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.2-rc8-185-g61b7614c114c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      61b7614c114c817f9f326282c2f7a728bf0051a8 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/63e56995c71a68fbfb8c8677

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc8-185-g61b=
7614c114c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc8-185-g61b=
7614c114c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e56995c71a68fbfb8c8680
        failing since 13 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-09T21:45:40.443707  + set +x
    2023-02-09T21:45:40.443894  [   13.170292] <LAVA_SIGNAL_ENDRUN 0_dmesg =
902339_1.5.2.3.1>
    2023-02-09T21:45:40.550481  / # #
    2023-02-09T21:45:40.651848  export SHELL=3D/bin/sh
    2023-02-09T21:45:40.652177  #
    2023-02-09T21:45:40.753316  / # export SHELL=3D/bin/sh. /lava-902339/en=
vironment
    2023-02-09T21:45:40.753577  =

    2023-02-09T21:45:40.854699  / # . /lava-902339/environment/lava-902339/=
bin/lava-test-runner /lava-902339/1
    2023-02-09T21:45:40.855139  =

    2023-02-09T21:45:40.858185  / # /lava-902339/bin/lava-test-runner /lava=
-902339/1 =

    ... (12 line(s) more)  =

 =20
