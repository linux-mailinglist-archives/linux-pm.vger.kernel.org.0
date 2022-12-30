Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6D659C48
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiL3Uq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Dec 2022 15:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiL3Uq2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2022 15:46:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB662DC7
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 12:46:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so14909944pjk.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2IN2tyA0GCGSmp7OBUNDR8qzWiVHgD2kB6CnfDb2e48=;
        b=YDudlnZyTFoEW0uINRsRY9Z7gxAGvQcPi8r4vAtRMuHkxlIrHurOoRZLg8P7ZVz6LZ
         lI6yhSe42vJCVhDh4dFpsPvZs5BehsWan56ckgGo6ZrRBod+h43hOghWeOhuQHJ43iFC
         rSw/46+YU0j8vhx705PyAn3H4RHPwkyrF3GoAdGPKsIvV5udcOx7UY7Lu8g1B93Hxb39
         0e92gzo9hDER4GPW1B9DEFiFCOoouAcYSYIXVO4kxfjTB3lCmQtR+VF+g+VSqDXoLsvR
         z53jF+P4kBJIu49fx118JGXWut0prJM40PPnlKZRaw029+qBCckLuZR2hVWsSNAUDOrv
         32ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IN2tyA0GCGSmp7OBUNDR8qzWiVHgD2kB6CnfDb2e48=;
        b=CH3/UdbgwtWamvR+9+pO39z7sPdxdJCf5bgAqzFV+vAeCA9BnZHgH2Bk5cMaHWreCX
         YyyPTyWVnMn+LAExdzRFhPCeUwKDsvjSG+pI6zqmIO0txuQ/zOO8641aBc8SIqOh5mAX
         tOgvf/r3wQ2HeoKwCOdULcwbOfcu7uSmyykBKK+BoFMOAIvvdpdABxWOWvtIvZy1WvvB
         MqiM2gaGUGb27xNcAVZZ61pTIGsAvc6B/GWDOlgoR8pT4zZHLP0ihSds5lTL/V4bzcZH
         2ks4jHI7IqgHz3fsJAkHtNcdJC1pJXB2oohARDRanN6i0ZA17/JHKF6p4KOemBqmFxSQ
         +TKg==
X-Gm-Message-State: AFqh2kpOHvM/kpX56C+1O4oQYuA/Wpud+huOVBgMdodKX7YH9xyQ8uoI
        w2bR52In0LCz7ieHy5S4Kjl0c+GMR59lguVeQGY=
X-Google-Smtp-Source: AMrXdXvNFCVwG5YipYgFeAF2lNdjMCy5GpgmRgvujbkNZZ1zK5QvqzSrBIACSZXGdIOWiLWgWunfqg==
X-Received: by 2002:a17:902:d508:b0:190:f82f:c932 with SMTP id b8-20020a170902d50800b00190f82fc932mr49409169plg.12.1672433184685;
        Fri, 30 Dec 2022 12:46:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902f61200b001783f964fe3sm15450980plg.113.2022.12.30.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:46:24 -0800 (PST)
Message-ID: <63af4e20.170a0220.3ab21.9bdd@mx.google.com>
Date:   Fri, 30 Dec 2022 12:46:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-10-gba02147ea7c73
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 63 runs,
 2 regressions (v6.2-rc1-10-gba02147ea7c73)
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

pm/testing baseline: 63 runs, 2 regressions (v6.2-rc1-10-gba02147ea7c73)

Regressions Summary
-------------------

platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc1=
-10-gba02147ea7c73/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc1-10-gba02147ea7c73
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ba02147ea7c73fe7728b71fd055c9446021910e9 =



Test Regressions
---------------- =



platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/63af4314ed3a3c8fd84eee20

  Results:     2 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc1-10-gba0214=
7ea7c73/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotb=
oard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc1-10-gba0214=
7ea7c73/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotb=
oard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221216.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/63af4314ed3a3c8=
fd84eee23
        new failure (last pass: v6.1-rc8-224-g02f29b079520)
        32 lines

    2022-12-30T19:59:05.726893  kern  :alert : Register r0 information: sla=
b kmalloc-1k start c23a8800 pointer offset 0 size 1024
    2022-12-30T19:59:05.735892  kern  :alert : Register r1 information: non=
-paged memory
    2022-12-30T19:59:05.736054  kern  :alert : Register r2 information: non=
-paged memory
    2022-12-30T19:59:05.744815  kern  :alert : Register r3 information: non=
-paged memory
    2022-12-30T19:59:05.744980  kern  :alert : Register r4 information: NUL=
L pointer
    2022-12-30T19:59:05.754024  kern  :alert : Register r5 information: non=
-slab/vmalloc memory
    2022-12-30T19:59:05.762950  kern  :alert : Registe[   41.512212] <LAVA_=
SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMEN=
T=3D32>   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/63af4314ed3a3c8=
fd84eee24
        new failure (last pass: v6.1-rc8-224-g02f29b079520)
        16 lines

    2022-12-30T19:59:05.699865  kern  :alert : 8<--- cut here ---
    2022-12-30T19:59:05.708786  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000004e0 when read
    2022-12-30T19:59:05.717878  kern  :alert : [000[   41.465053] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D16>
    2022-12-30T19:59:05.718032  004e0] *pgd=3D4b246831   =

 =20
