Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07E662CB4E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Nov 2022 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKPUo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Nov 2022 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUo4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2022 15:44:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763440448
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 12:44:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n17so10216248pgh.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2022 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODP14gNUQsiRNTrsx3EZkpu6/AOjqqvFxW6DI8MWWyw=;
        b=L3g1hE83ib/E8eKoAu33dQpKdhg6Dxbf/O4NQCrSvdiqRfk0GvEFeAijmLi6ja9w4z
         6QQTiA3sebvof4cmu60Fve63DUKVVf97zxhvJBZqtXZcoDYSyJBt7nxCrbwcB6qVP4yD
         xkbanMZ7uhlwm/5iAlidU63zkIHGm2eKl1tLeLb4bgrenkd05I8uL1zfDMbA68+594WQ
         6+ArLMMXE1Sbd+f0OwNx+RX82694oo22B63M8bvpQgWjxdSFXINAhZpG3TDEqfKQ3pkK
         Lw1+/aTpcdsmaksWLoIdOsK9AZSXkvgxdhAB1m8Y2fxCnyySSj9a0OuMv7k3ceEo0UeZ
         kReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODP14gNUQsiRNTrsx3EZkpu6/AOjqqvFxW6DI8MWWyw=;
        b=rC2KvzzKbqBptUTNurVGqY5wz8bUGnGYFg8A2Z9hyWElboeQXf+5zeQNkMYcQPNua1
         chaq4BQLdiYc2fae/zkEMn0GnQ7c9nxu242j5EuJU5krqyFax3xlm2csYHcv5hn+DxOK
         jaI2UiFGaoU1tbf1uoqe9x713O+a9Py3OojTWem3/OqLVifA/sAYv1g4UJpyamGAy9Ym
         Ms0RO1mtQ8xnmTMB/Ij9NAOaC+oGu8SH97zFpdkCFKPLjTn3xwnIUxsghdm5qmPFEk/B
         kaTM2xk1Untc2zk0D25dG0c3PRWr6NBoeHtcGO2vDpn/vAlVOzZZ6wPXyecv2L4jrNiJ
         4BnQ==
X-Gm-Message-State: ANoB5plUNZZVquQQgSMMByCEvM4n41F5biu7pFtOR0DEAEmdLuylijSg
        +DUA74pJXNqMjxZA0p/NHaFgaw==
X-Google-Smtp-Source: AA0mqf53idl3tvjGm4pHKWINFoYDT1fYriDU7GWUh67ydkIJFetbCZB4GIuaYc1SEIRGt6muOANKQQ==
X-Received: by 2002:a63:4951:0:b0:476:a396:4908 with SMTP id y17-20020a634951000000b00476a3964908mr10765947pgk.444.1668631495288;
        Wed, 16 Nov 2022 12:44:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b0017c19d7c89bsm12636709plb.269.2022.11.16.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:44:55 -0800 (PST)
Message-ID: <63754bc7.170a0220.f8836.352e@mx.google.com>
Date:   Wed, 16 Nov 2022 12:44:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc5-65-g32e8e1c35ebb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 68 runs,
 1 regressions (v6.1-rc5-65-g32e8e1c35ebb)
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

pm/testing baseline: 68 runs, 1 regressions (v6.1-rc5-65-g32e8e1c35ebb)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc5=
-65-g32e8e1c35ebb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc5-65-g32e8e1c35ebb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      32e8e1c35ebbe0bb2853f5f8417e247abf87ad05 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/637542e6f81543f14d2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc5-65-g32e8e1=
c35ebb/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc5-65-g32e8e1=
c35ebb/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637542e6f81543f14d2ab=
cfb
        new failure (last pass: v6.1-rc5-55-g60453df62d30) =

 =20
