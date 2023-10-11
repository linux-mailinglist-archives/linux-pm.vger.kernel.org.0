Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A697C586A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjJKPpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjJKPpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 11:45:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A11A4
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 08:45:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5859b2eaa67so4027697a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697039143; x=1697643943; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KoLPOYDDk+WhER1ypWeL23qfBeTqm3rE/CZCadFwDaY=;
        b=uJfgvGuKkLc3Au7lWoTw4L/c0PyziuvbV6PjR41JwcPlNfu19jkqP/RtlB/JLsIX73
         h9KPLPdwv7OT1bvkawdYv+DguMpXNmmKofrdCG7BtUKMimAJD+oZuxwrt75qyU0KY1v4
         F1BebCg+6jEaJHa0mVcESXShhLb5hemn7RRWp+eYRyAj3I2ZRJLEVvW5CADoN509vAyg
         aSHW/dNvj59QU9/s4H10Pxw54SHlltnS2fngFVcmQEV2zAE6MjxrUoUeW2TOI1vw6JZQ
         ELJW/YP5D5etto2COSmRYxF2h1WSmCqazFKcb1CNsR9kJO3375chrlW1iwoCE6Sm90lc
         6wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039143; x=1697643943;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoLPOYDDk+WhER1ypWeL23qfBeTqm3rE/CZCadFwDaY=;
        b=H8poW/RhmHtmLPscS49Qfu2Es8TzvexGvNdvBLIDV7UjWpWQY9Zt0Y1GymdKDCFe+J
         OeWjUgem3VaI+9BB2OMFBlGd8Vpa+rJicqEA3yACY54VvkTOvjqZAzE77/NkGoamgF7G
         i82h2YdSURW5u8+WQbLj+DxJyIzODbuZUbaoYi6KvWZddXpCRmwBxyZDI0101bE7IwDq
         x0ZgQkSuj5SkyJBMkFC5zzDZoDZkfsUBYHoj3cz1KfENvxVeDA4mhb4ymOT7Rj/73V2D
         W/Ff5p4ZaZnlR28PdaIbTr5HYgoRBZ+0eOiiC+XCLTdgH+i0YYP07Syjnhq9y7Vwi88D
         7jQQ==
X-Gm-Message-State: AOJu0Ywmzt5iJHNbiCiIZxptWTpsPxSeYZhRMHuWAmy4TBtGJqdxULbk
        2hqkxWjErx3Ch7LBTkbO64XIBQ==
X-Google-Smtp-Source: AGHT+IFex9Zu0SyzGKuGySdxGq7MkMV4k2y5R4HfLR+YaWTlEJxo4qZbxq4O8KGTm1Ij6r4UCCX7jg==
X-Received: by 2002:a05:6a20:da8a:b0:16c:d50:91b6 with SMTP id iy10-20020a056a20da8a00b0016c0d5091b6mr16549860pzb.5.1697039142147;
        Wed, 11 Oct 2023 08:45:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f30-20020a63381e000000b0059b782e8541sm22856pga.28.2023.10.11.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:45:41 -0700 (PDT)
Message-ID: <6526c325.630a0220.12850.0143@mx.google.com>
Date:   Wed, 11 Oct 2023 08:45:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-139-gc7234228d1fac
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.6-rc5-139-gc7234228d1fac)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 3 regressions (v6.6-rc5-139-gc7234228d1fac)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc5=
-139-gc7234228d1fac/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc5-139-gc7234228d1fac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c7234228d1fac8f498c5859aaa32f154619f3ce6 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526b9112ae6d45e7befcf0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526b9112ae6d45e7befcf15
        failing since 29 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-11T15:02:19.333372  + set<8>[   27.290100] <LAVA_SIGNAL_ENDRUN =
0_dmesg 164553_1.5.2.4.1>
    2023-10-11T15:02:19.334174   +x
    2023-10-11T15:02:19.443173  / # #
    2023-10-11T15:02:20.607413  export SHELL=3D/bin/sh
    2023-10-11T15:02:20.613344  #
    2023-10-11T15:02:22.109969  / # export SHELL=3D/bin/sh. /lava-164553/en=
vironment
    2023-10-11T15:02:22.115840  =

    2023-10-11T15:02:24.832685  / # . /lava-164553/environment/lava-164553/=
bin/lava-test-runner /lava-164553/1
    2023-10-11T15:02:24.838874  =

    2023-10-11T15:02:24.851656  / # /lava-164553/bin/lava-test-runner /lava=
-164553/1 =

    ... (12 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526b8f5eab45a502befcf91

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526b8f5eab45a502befcf9a
        failing since 83 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-11T15:06:18.799500  / # #

    2023-10-11T15:06:18.901422  export SHELL=3D/bin/sh

    2023-10-11T15:06:18.901622  #

    2023-10-11T15:06:19.002113  / # export SHELL=3D/bin/sh. /lava-11741196/=
environment

    2023-10-11T15:06:19.002223  =


    2023-10-11T15:06:19.102726  / # . /lava-11741196/environment/lava-11741=
196/bin/lava-test-runner /lava-11741196/1

    2023-10-11T15:06:19.102924  =


    2023-10-11T15:06:19.107783  / # /lava-11741196/bin/lava-test-runner /la=
va-11741196/1

    2023-10-11T15:06:19.168470  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T15:06:19.168544  + cd /lava-117411<8>[   20.441596] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11741196_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6526b912eab45a502befcfd7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-139-gc7234=
228d1fac/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6526b912eab45a502befcfe0
        failing since 83 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-11T15:02:33.354221  / # #

    2023-10-11T15:02:34.433934  export SHELL=3D/bin/sh

    2023-10-11T15:02:34.435684  #

    2023-10-11T15:02:35.925712  / # export SHELL=3D/bin/sh. /lava-11741200/=
environment

    2023-10-11T15:02:35.927471  =


    2023-10-11T15:02:38.650503  / # . /lava-11741200/environment/lava-11741=
200/bin/lava-test-runner /lava-11741200/1

    2023-10-11T15:02:38.652739  =


    2023-10-11T15:02:38.660952  / # /lava-11741200/bin/lava-test-runner /la=
va-11741200/1

    2023-10-11T15:02:38.722086  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-11T15:02:38.722582  + cd /lava-117412<8>[   28.510647] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11741200_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
