Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0968CF8B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 07:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBGGio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 01:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBGGin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 01:38:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD14222E7
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 22:38:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be8so14663325plb.7
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 22:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2mu62vG2NllEFCNGEfU/iqgVybeVzb5yzmVTqLaOf5Y=;
        b=Wdo8++bm/zlvtlCDEXv1yCsX+9wK1r02oRkKUL9t44rc/LJBE+xEU/P4TrhTGsPGi0
         dtozDodjWK0F3CRaU6/0WFkmUlpYJ2P3GNpoLKOs1drlVWc1upTdB46K74S2gOmmC0k4
         HfeVIhrqL/sOGAeO+cvQk61qj4mG4IPqu0P7Ht/UHjv9jHETOuQsKwq0m6yp2HC2fatS
         zenynPixdveVv6rbZtMxSw7YS4pbGILln/JtGSxGxmfWj7I8ZxlryJoOY9wm76zOz53Q
         +vO5xHmQNkt5dAeNRdKmNkoEC4DKUarehN6IQHBMZfBCTq5Q9NpMxz+rS1Z6QbSt9XRv
         bYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mu62vG2NllEFCNGEfU/iqgVybeVzb5yzmVTqLaOf5Y=;
        b=F474n8Kx/AuVUwt+cMvJfyTNo+O+3XSr+3bjbJftpcmAjQA0KgbeHFgKhUA+sV9ISO
         gI7KYQyNy9QQcA6sjfoeUVL8CoYgrLKzpqM4/XY1FKViuGShGKsRZlPJu6J1UigZSWwb
         61Ljlk8UtxgA8hMxL/fMffXrHENn2eGAg2CWqiPivf1I7Lv8o/ORZUxoXMVzHVeGHEqn
         RjZh6PMpgvLiFPVO/HkQ3pdaG/KBBd7iJ/QC4i8AdpQ5Y7WklUiEsipG9Rhh0ulzb8r2
         gbMlPdKFum8/kaM1Q6OKmJ/M/ML82tcuqOu8v6KAsNPvy5o5nVyoI+bFgP6Hso+mxBHK
         4o2Q==
X-Gm-Message-State: AO0yUKXAh0ITI83v07/9pDzLifBpiSnnrXsCBX0A1/2wbPLiMo89OTt5
        jI3AcfJXxW88p9CTQiZpqSBcBQ==
X-Google-Smtp-Source: AK7set9c8qjUq+e0QFijC+DSXCIyUE9nKq5K4ct63AeqhtRzqVF5As/EJwTgMkmWlc/3Mc9ObIaCvA==
X-Received: by 2002:a17:902:e411:b0:196:77c5:8e80 with SMTP id m17-20020a170902e41100b0019677c58e80mr1356025ple.63.1675751921890;
        Mon, 06 Feb 2023 22:38:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b00186b7443082sm8006172pli.195.2023.02.06.22.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 22:38:41 -0800 (PST)
Message-ID: <63e1f1f1.170a0220.3fca1.d56a@mx.google.com>
Date:   Mon, 06 Feb 2023 22:38:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-179-g929367dbdffe
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 1 regressions (v6.2-rc7-179-g929367dbdffe)
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

pm/testing baseline: 46 runs, 1 regressions (v6.2-rc7-179-g929367dbdffe)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc7=
-179-g929367dbdffe/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc7-179-g929367dbdffe
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      929367dbdffe4babaaa4710344c3988dd9e90e51 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/63e1e68814f9a84ff48c8631

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc7-179-g92936=
7dbdffe/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc7-179-g92936=
7dbdffe/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e1e68814f9a84ff48c863a
        failing since 10 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-07T05:49:39.378112  + set +x
    2023-02-07T05:49:39.378294  [   12.907167] <LAVA_SIGNAL_ENDRUN 0_dmesg =
899679_1.5.2.3.1>
    2023-02-07T05:49:39.486524  / # #
    2023-02-07T05:49:39.588155  export SHELL=3D/bin/sh
    2023-02-07T05:49:39.588522  #
    2023-02-07T05:49:39.689704  / # export SHELL=3D/bin/sh. /lava-899679/en=
vironment
    2023-02-07T05:49:39.690528  =

    2023-02-07T05:49:39.791976  / # . /lava-899679/environment/lava-899679/=
bin/lava-test-runner /lava-899679/1
    2023-02-07T05:49:39.792710  =

    2023-02-07T05:49:39.795996  / # /lava-899679/bin/lava-test-runner /lava=
-899679/1 =

    ... (12 line(s) more)  =

 =20
