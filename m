Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381FD7AA48A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 00:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjIUWMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjIUWLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 18:11:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3448E6C
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 15:10:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-274b01849c4so1059220a91.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695334213; x=1695939013; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rONXwfMYlYFNk8bki17YMHK1M2SXsv5Xgdjb4bmYFko=;
        b=B3LCxs6DLPDFmqJuvXqGL7wb+5cW2loRoFqR+L149KHl5MOVPYIIQRQb5OcgRD/YmY
         CM8CWYqmFpXljW6F3647sb2MeSV2aOFIZA2VyrWz/fqINnJqWVqNJQbNjWX2SGUkOw20
         I2c1FeknOunH0KQLZdO/82+TRP4vHsf+9aKXgGoNWA8eMQwB5DIqPHxbs7bDbt+iJ0Ih
         6ZzXVfJ0ZYEDKENkCxnQI+YNEC6M3LQFoi3nol/III8SZOs6Qj9/vmhGxQ7WowyCke0G
         keh35bGqrWB3KBsRpIyVYUa8oqksdJn8bC81OJP/J6WTv/r6GE3jhtKE+zgC29NRWJeC
         1s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695334213; x=1695939013;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rONXwfMYlYFNk8bki17YMHK1M2SXsv5Xgdjb4bmYFko=;
        b=YaBdsbqO+ol3wwMk3AWbO6r7ee8irKUG4ErsmOyJIfbcFJahKuHf4xe7ZjwJhp39nk
         h3hbSRLMoA0h3mXPzgz0zfPFloUkYOpUO/Cj0MZLC4XRu68aRoTNjOor7sdfz7Xt1oqo
         KQsX0FfZxf5ntxi0Mf6Eq74yi0WOXUdrQVB8lvIPrfaiav1LBPKM1asVRdweKIoPZfBf
         qKYD2VS0MK2xGMSDmZBPYczmCYODafvFPIY60qynO23yrTxnb8M9VffNccv281EnBlz2
         9+lilCTnTwxZ9AkwHdBwlRvTWMdJVcTTn9DWESnYRFP407FzeOIyaVOyr1hErvoMuFFz
         1dbg==
X-Gm-Message-State: AOJu0Ywp1B/AnmvqbT2fecGVzYU8hrr0i+r15p3US2u1QtuRsPU4y+I6
        jhpJFc2FpmvVW0/YugQLoMP3Xw==
X-Google-Smtp-Source: AGHT+IH91/ZBsehnEEKWsGyHj50U56u6X8rgLgbgMFiAheTk0ID/MIumQvNsf43HCYx2aKumZMer5Q==
X-Received: by 2002:a17:90a:9f46:b0:263:41d2:4e2 with SMTP id q6-20020a17090a9f4600b0026341d204e2mr7350038pjv.32.1695334213123;
        Thu, 21 Sep 2023 15:10:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090adc0600b00273744e6eccsm1951175pjv.12.2023.09.21.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 15:10:12 -0700 (PDT)
Message-ID: <650cbf44.170a0220.afdf4.a624@mx.google.com>
Date:   Thu, 21 Sep 2023 15:10:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-36-g57594c77e5b2
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 2 regressions (v6.6-rc2-36-g57594c77e5b2)
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

pm/testing baseline: 46 runs, 2 regressions (v6.6-rc2-36-g57594c77e5b2)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
imx8mp-evk         | arm64 | lab-broonie | gcc-10   | defconfig | 1        =
  =

kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc2=
-36-g57594c77e5b2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc2-36-g57594c77e5b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      57594c77e5b24fac60e3171dd6fe1199c18323fd =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
imx8mp-evk         | arm64 | lab-broonie | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/650cb11f37c09776db8a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-36-g57594c=
77e5b2/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-36-g57594c=
77e5b2/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650cb11f37c09776db8a0a59
        failing since 9 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, firs=
t fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-21T21:09:33.314092  + set<8>[   27.767247] <LAVA_SIGNAL_ENDRUN =
0_dmesg 123935_1.5.2.4.1>
    2023-09-21T21:09:33.314230   +x
    2023-09-21T21:09:33.420682  / # #
    2023-09-21T21:09:34.580160  export SHELL=3D/bin/sh
    2023-09-21T21:09:34.585933  #
    2023-09-21T21:09:36.080291  / # export SHELL=3D/bin/sh. /lava-123935/en=
vironment
    2023-09-21T21:09:36.085816  =

    2023-09-21T21:09:38.800984  / # . /lava-123935/environment/lava-123935/=
bin/lava-test-runner /lava-123935/1
    2023-09-21T21:09:38.807673  =

    2023-09-21T21:09:38.819439  / # /lava-123935/bin/lava-test-runner /lava=
-123935/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/650cb2c46ad14c450c8a0a58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-36-g57594c=
77e5b2/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-36-g57594c=
77e5b2/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650cb2c46ad14c450c8a0=
a59
        new failure (last pass: v6.6-rc2-21-g23aa512f7cfb) =

 =20
