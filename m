Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F43629AA4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiKONgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 08:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiKONgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 08:36:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027BE88
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 05:36:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so14109445pfu.8
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 05:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qz9O5mclsQWUCa8h8Ls/80iLOSAtCwm8No11onRdE8=;
        b=xjqAeHkSin652jyUxBtTLjlhAbHxfGJDk/B0cGbsSHN3gLA3s3kAgyVNZ0ls0Bi+I1
         P6vuWiZw/wuTLtOTyhkwxakEDBYdp+AtF5M0UuD3hUpsVvJdDidpf4emu/ZCL6v+uvs7
         hOnoxpOa92BPa26+ev6AKp4gGE6wWboxYf7DOrwI9LpKvRi3SZ5/hL9cKdd6kMw3KFCS
         wq0hYOax2ZLH55A/vVOwpXOKeoRSDYVi/qsmaYpSWcMW7/e9E82lJ8+qW1bU2B0jQd5O
         maiXVBPsIMh9bldXslavWoC5GxDKrStVZBJCsewOq7k1fnOz9CcZSwF3AQXZpg332IXv
         qADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qz9O5mclsQWUCa8h8Ls/80iLOSAtCwm8No11onRdE8=;
        b=Lmpg8zxwp7rJyS5tFS/Yrynu4Xqjqn1woX849v9HuyefcDTQfT+2bXfs9H+tKrTXK+
         3vDyUDbaFmkUS8+fBn0shkaB88z4cJxENTt8FCG2++DFkMS5a4QQPXa7Q8kBMCCTI5pQ
         XpcDzaX93lmthea6KhHthywMww7y2acmBph1+ZEYNJfMDHyVZIByRZrgU7+XA9g8WpUZ
         GRN9om7JnVQt9yk5qAWYCGAafsgoWEbgOReOpLUy4PS1YvbzzytbNnXX2P7pIEkloITV
         kgszsamWxf4QSJNUV5N+TDLIMHofnOhpIcnakobCMLQYYWDb1WYuIm0a2OIgUEHIUiPi
         FWtg==
X-Gm-Message-State: ANoB5pniuDHbePzUKJM9ra5qA7MwQ7d+YuhH7+lh/5IMd9V1ZFB4XAlr
        UF2Bo/hKIneXtGmJxGfs37fPcA==
X-Google-Smtp-Source: AA0mqf70Xkcw4toYw9Qek6D/ZpzpD+6aSCGnPTK/HR8G20a2O1VzguMta/9Foen7jrUaVlGHGY3sPQ==
X-Received: by 2002:a63:f34b:0:b0:476:848e:8baa with SMTP id t11-20020a63f34b000000b00476848e8baamr8316851pgj.592.1668519406502;
        Tue, 15 Nov 2022 05:36:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c19-20020a621c13000000b0056cc538baf0sm8721113pfc.114.2022.11.15.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:36:46 -0800 (PST)
Message-ID: <637395ee.620a0220.e8f41.cafb@mx.google.com>
Date:   Tue, 15 Nov 2022 05:36:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc5-55-g60453df62d30
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 82 runs,
 2 regressions (v6.1-rc5-55-g60453df62d30)
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

pm/testing baseline: 82 runs, 2 regressions (v6.1-rc5-55-g60453df62d30)

Regressions Summary
-------------------

platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx6ul-pico-hobbit | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig=
 | 1          =

imx7ulp-evk        | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc5=
-55-g60453df62d30/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc5-55-g60453df62d30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      60453df62d306d285f98efa85de9871855a15233 =



Test Regressions
---------------- =



platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx6ul-pico-hobbit | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63738f496219120e61e7db9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc5-55-g60453d=
f62d30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc5-55-g60453d=
f62d30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63738f496219120e61e7d=
b9c
        failing since 109 days (last pass: v5.19-rc8-79-gb3f10ca8bf191, fir=
st fail: v5.19-rc8-92-ge240a33f1bc48) =

 =



platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx7ulp-evk        | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63738ccf473a5cb7aee7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc5-55-g60453d=
f62d30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc5-55-g60453d=
f62d30/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63738ccf473a5cb7aee7d=
b6e
        failing since 46 days (last pass: pm-6.0-rc7-143-g00674ddf1b594, fi=
rst fail: v6.0-rc7-186-gfa11712315997) =

 =20
