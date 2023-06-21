Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E227390A6
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjFUUTJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFUUTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 16:19:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBE199A
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 13:19:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25ee8d84b4fso3456620a91.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687378747; x=1689970747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bahcFXqG5EiQtXHJsxeaCuzq2dj1PjiPrx6gMOtGMcY=;
        b=JmXYq71AMhGCkg7hF8lKp2vopBB0QN+c9Blg073E3DLzdh5ekKTG7KG9ufRPi560qe
         6avFbcGRR42cuBHfmxFVE+6fpKzGIm1QFr8BcGmjqx8Ydf85XPge5NWx+aVNhKBdWwWq
         iSxCH1ZeF1ZqKP3MCaZTTViRZKNulTcZ3/A2QuJhnEmgfXEcdBpzMOz5m2pcsYECg9UT
         q5M3ZRn8hIMqE98TwITjqGk8WXUecov9/Cuk2QFC1JGahhusvDblnVuiszIu28d/+VY4
         ZH8cPIAj51cTw3RK1CaSYnkTb4zQBZQ4kMuFIMn0FaxNm4y3mu3F4Au4ZGTepmYTCDRt
         TU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378747; x=1689970747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bahcFXqG5EiQtXHJsxeaCuzq2dj1PjiPrx6gMOtGMcY=;
        b=Z2wQqnkWsGJJ86swNr8CeQmJxdxWDp6IOwH58c8TJh9SwzBKRUKgl4bpevk/3djH2V
         nXWqcgxzbVI41TdWw91roq5sqNbVhYj9Pv26/OUOmcCdq1ZqG5SEywdzdzoUPWmo3F5u
         ofmETeOUjh9NagtkZaocRL1KQQAHIyRBFwRDX3LFU7eHYBRLyDVHNxtQ+WoqUZ+TxJZS
         kq6NeDgpBnFOhqX7g/3mxaV/KKuQI42z3gCx+dTOIxzsbPIGWitqZOuC5LngZ9O/n8gP
         Kne622ijS1umxdnenA4R3xlvd25XEaJwz0d4i9Pun0qIoBohhnmb+whuSo6EjF65Of0T
         /DBQ==
X-Gm-Message-State: AC+VfDwwbWxCIibxYqyibbROrO+0R5VSjFZkFMVjQ2SllRmKnEueYqzF
        xLrdLCV3UKCYA75s8qT8o89xwA==
X-Google-Smtp-Source: ACHHUZ5XypydbL6F6dF+ztiroWhLUgqFoLf+bjjbisWKmQmjsMXFPBnOa0ES+yfJ+S3RPKcNk+SfJw==
X-Received: by 2002:a17:90a:199:b0:25b:d8fe:2c92 with SMTP id 25-20020a17090a019900b0025bd8fe2c92mr14606569pjc.48.1687378746778;
        Wed, 21 Jun 2023 13:19:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id em18-20020a17090b015200b0025c07d07e54sm3547795pjb.50.2023.06.21.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:19:06 -0700 (PDT)
Message-ID: <64935b3a.170a0220.f76c.83b1@mx.google.com>
Date:   Wed, 21 Jun 2023 13:19:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc7-121-g3eb3368746ef
Subject: pm/testing baseline: 53 runs,
 2 regressions (v6.4-rc7-121-g3eb3368746ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 53 runs, 2 regressions (v6.4-rc7-121-g3eb3368746ef)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc7=
-121-g3eb3368746ef/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc7-121-g3eb3368746ef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3eb3368746efcbc37e43c73415d2ba4634d9ce87 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64934f81c5e621c689306178

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-121-g3eb33=
68746ef/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-121-g3eb33=
68746ef/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64934f81c5e621c689306181
        failing since 145 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-21T19:28:42.226410  + set +x
    2023-06-21T19:28:42.226803  [   13.228451] <LAVA_SIGNAL_ENDRUN 0_dmesg =
984517_1.5.2.3.1>
    2023-06-21T19:28:42.333905  / # #
    2023-06-21T19:28:42.435572  export SHELL=3D/bin/sh
    2023-06-21T19:28:42.435955  #
    2023-06-21T19:28:42.537133  / # export SHELL=3D/bin/sh. /lava-984517/en=
vironment
    2023-06-21T19:28:42.537553  =

    2023-06-21T19:28:42.638731  / # . /lava-984517/environment/lava-984517/=
bin/lava-test-runner /lava-984517/1
    2023-06-21T19:28:42.639391  =

    2023-06-21T19:28:42.642518  / # /lava-984517/bin/lava-test-runner /lava=
-984517/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64935220d5da0b89fd30619f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-121-g3eb33=
68746ef/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-121-g3eb33=
68746ef/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64935220d5da0b89fd306=
1a0
        failing since 64 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
