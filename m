Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E678D422F69
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJERwk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJERwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 13:52:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19AAC061749
        for <linux-pm@vger.kernel.org>; Tue,  5 Oct 2021 10:50:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so2589894pjc.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E8uHwA0hz/k0kVOsz9enBfRw9nXS48SbrLMk1X8PbvY=;
        b=2mDR8MI8u3+QiGjxPMPnhghC9DVA72NHQmXhCU8gdr0dhP8F41Ho7cP/JIOrNjI5bc
         AZsH24g5juouDaQF/6iIKU+HzdO3FRI/AWAQ/BGWvBMceQW2f5Yq0l9FnfzL3fPVwg7p
         sPj3hGGtTrD1dM+kt5Cv4hv3J5DYFYUZf5SXSXtZb44hEegpuJiPo99WPruHC4rPLadQ
         fz58RGGDDetn8NbEWPJWLiQsEV6CeyQ1moLzCwiNODg5HGwkZwIFdmuipcVT3wzJGvPa
         hIJX5g3JBtMkyGeYVGFrJCma8nHAt54+o3JtURMxnNCIcFXyLB8nqkd6LesLXaIpmMWG
         1TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E8uHwA0hz/k0kVOsz9enBfRw9nXS48SbrLMk1X8PbvY=;
        b=R2JaTsJjfLDlPbwaHGdqZyh29d1FhfU2qORc5dDGHa3I4qYvIiJ1YVfO/ELOs+8yN3
         KCpVDOuYbA0gQhkDP7G+GQM2VN2FTrxciKkoovmEGo90lVYtQCyQ97wJEa1SAEkskEzT
         t4KgW/xJqha8RAgkMQvYpwQB9kmqjVOeIRE/rXJrfA1cWNE3YKIWOxlEja3wZd8O9vDo
         rinjHEfvBdM6TpIZvofSrNltFHvHWtEBPia5z45rESh6/Ad1fHBLmY287xLGVN3FRcGG
         VYLtJbGzNopR+00FCBTGRG6xN9lR5XUT3XmPbnTw4DZmueESYwkpxxOQKv3+LBHC4LqO
         Vrbg==
X-Gm-Message-State: AOAM533tRJQkTqD4WKSUEaxdd2IY2S4oXlK9dSuwawC1Lr02CouOyGdM
        fyfEqbN/H1e2zRNSpyq7/RWXpQ==
X-Google-Smtp-Source: ABdhPJw4qieoaLVJZERS3a38n8ZCcW0aw5Dyz/KuuREzCEg2W4/UtiZ3F3ZmrJAIjDlULJhG62SyBg==
X-Received: by 2002:a17:90b:1e47:: with SMTP id pi7mr2768980pjb.206.1633456249199;
        Tue, 05 Oct 2021 10:50:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v11sm2746942pjs.40.2021.10.05.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:50:48 -0700 (PDT)
Message-ID: <615c9078.1c69fb81.dd182.95f6@mx.google.com>
Date:   Tue, 05 Oct 2021 10:50:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-24-g8e0efc215fb1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 71 runs,
 3 regressions (v5.15-rc4-24-g8e0efc215fb1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 71 runs, 3 regressions (v5.15-rc4-24-g8e0efc215fb1)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
4-24-g8e0efc215fb1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc4-24-g8e0efc215fb1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8e0efc215fb15481ac2c12c7e11ce2d7d2803691 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/615c8d577ed2e2502099a2fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615c8d577ed2e2502099a=
2fd
        failing since 21 days (last pass: v5.14-rc7-64-g2a7254aa7491, first=
 fail: v5.15-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/615c8e5a96d62a483699a2db

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/615c8e5a96d62a483699a2e1
        failing since 84 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-10-05T17:41:35.206633  /lava-4653352/1/../bin/lava-test-case
    2021-10-05T17:41:35.217692  <8>[   25.334826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/615c8e5a96d62a483699a2e2
        failing since 84 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-10-05T17:41:33.149938  <8>[   23.266077] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>
    2021-10-05T17:41:34.171235  /lava-4653352/1/../bin/lava-test-case
    2021-10-05T17:41:34.182985  <8>[   24.300109] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
