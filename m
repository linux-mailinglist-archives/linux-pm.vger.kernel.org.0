Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10B3507A3E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbiDSTbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiDSTbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 15:31:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F140A1E
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 12:28:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2901153pjj.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iNAAdAA88li0fu8RNBeNfF7SajRxjd72QsbksjAx+8U=;
        b=cEeiUx7MS51FEN/2M8INyoJLR1SRpOP07nmZVct1nzVxm595Cu0IFyEMExdcDHKYo/
         n7Ujh8esbMgXj8CjRwIHJ1igkMONqDSCBwxDH/PsQQaVs0Y4aOXu0UXSFnnEDgCrHZOC
         WY4vOThaWa/rb0UQek6SY4VfGVj6+NWMl/KuIAXEdoSgCcglqXMv8PkUFUIWmj2VSAFU
         rSKKF/v+0GprmxcAMOjdONKEX+D/+mFV6Z9iKei438Td4gBKtYBxZrJJG2ScpvdS8OkH
         K5K8r3qo0sLs9O7j8ESf1gzSwtB2E4vpC3bCtFLZWNe6drCdbd/YZaH/vUk+uskB+YQE
         w4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iNAAdAA88li0fu8RNBeNfF7SajRxjd72QsbksjAx+8U=;
        b=VFk0HckiiIbsFhCTtS8CIrzjDJYBsJFuRehw4Fe6d8uRw90er6NSjQT2NYm6ByXPOX
         82jU1WSdyHolhBSQzddeNn06iMbI0n2PwqGKHp+jKnqBFNPZrGf+8tg2LOu2MbCbnPdB
         XcyefkXr3USDzuvP7ksvOvPBlfLlN3jKcSPLfjLJzaHq95PnOBqF0tzDiTc4QjViFvBu
         dmfSH+MMWP+uxLdDyhiT3MKwfCbEM1w6DEEx/0FHtVZefIBldLMzcSAyoN2Gwrt/8wUQ
         thQFrPJ4Njltcb0Wi0VQJGdVvR6WgJ2fNvW5rHi+pY0lWYeCUF38yOMAWb3URvgzufRn
         1y4g==
X-Gm-Message-State: AOAM530kOQvp36SsJkbXv0l1z9k+pWDRU4kxsd9QhiWBBchs6tMZJDOq
        BpM98up0XbSHmHfLy8Pnq0yNkw==
X-Google-Smtp-Source: ABdhPJyrOwfHREPazMknqj4Dd2EN/cNMlrcLmJ7pRgtcFQH9DO+TGLEE5X4Zdyi9oWaq0/LgHZM4DQ==
X-Received: by 2002:a17:902:c2d0:b0:15a:2344:f8a4 with SMTP id c16-20020a170902c2d000b0015a2344f8a4mr1413934pla.28.1650396514139;
        Tue, 19 Apr 2022 12:28:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78009000000b004fde2dd78b0sm16482344pfi.109.2022.04.19.12.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:28:33 -0700 (PDT)
Message-ID: <625f0d61.1c69fb81.e8813.7364@mx.google.com>
Date:   Tue, 19 Apr 2022 12:28:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc3-87-ga8a4f8e63bdfe
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 44 runs,
 3 regressions (v5.18-rc3-87-ga8a4f8e63bdfe)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 44 runs, 3 regressions (v5.18-rc3-87-ga8a4f8e63bdfe)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mn-ddr4-evk    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.18-rc=
3-87-ga8a4f8e63bdfe/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.18-rc3-87-ga8a4f8e63bdfe
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a8a4f8e63bdfeac9fafe43dcafabc27d8f2e8b8e =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mn-ddr4-evk    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/625f066117e6e90d52ae0693

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-baylibre/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/625f066117e6e90d52ae0=
694
        new failure (last pass: v5.18-rc2-76-g5675fd487f2b2) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/625f0498484b932346ae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/625f0498484b932346ae0=
682
        failing since 4 days (last pass: v5.18-rc2-13-g781d19cfe317e, first=
 fail: v5.18-rc2-76-g5675fd487f2b2) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/625f0463e52336d74fae068c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc3-87-ga8a4f=
8e63bdfe/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/625f0463e52336d74fae0=
68d
        failing since 4 days (last pass: v5.18-rc2-13-g781d19cfe317e, first=
 fail: v5.18-rc2-76-g5675fd487f2b2) =

 =20
