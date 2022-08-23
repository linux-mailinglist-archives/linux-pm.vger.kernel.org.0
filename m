Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9A59EB20
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiHWSgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiHWSfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 14:35:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36D1C912
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 09:58:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r22so12797216pgm.5
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=D1JqdC//Serb/+q2ZC0Lc9nyEPPpJAz4Y0oLCkh+a+E=;
        b=1079pP/qi8/hFsdlxZoOswFi4M4s8Q7sD3MwRysTkASm6AxXBpzfaK7Sz2/SeGD0DT
         dWKch9y1KMi1FdEoGM4VuucOiwrSbgkoQYglrTyHuqBVXvsukmyxbtJ2CkqKhx1GHjFP
         fYXekF6cT2cdfXbLnWkQWkSUDSSTm5MMDdTT8CdqryxbdPVWOCeG5CnnbN8GmrOd69tC
         XNXNQrtyMhrQwa52iiqJsqU7ORq+xrxd9fxb2m2MErUZ7OZ62cDM7gTOD1qgbsr2icQ7
         KMPWMqDd+CTmKzorzroIfBMVvLDEkv1/IVkin0Yp6pY0BN0ZwfOkHC7JWrzskDhy7SiV
         KbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=D1JqdC//Serb/+q2ZC0Lc9nyEPPpJAz4Y0oLCkh+a+E=;
        b=GijlWhMDB6Dm5cIoWb9T2tt03RLnPSI6Rw6sBzAJixNvVaE8xgITVcRLXS+riwsRwv
         xW4tJL4q+Y6l/gp7EndFtfSOKeSH3MpnMRugYuFpfODVwArGYIt2dc6cbUudY3+PsdXY
         WR5EAJTUEtzY8VDrxYI4KrAeU8Fwc1Eyr/zPg8rcyPVg73df+mveQrvet1nrxUpMv2Wr
         NCo0WMbYi+gxQ18XcHVFLxxRShD6eX5NIp/10D3mZXfgoitSnJep2lc+vWVuLslZ2XpQ
         D7zgIMHZt/y50uT06lxIzWVYmXQ7WOVUCEioBV8z7z1GfXCwzC53AlwkKiPUB342z5vu
         J9ug==
X-Gm-Message-State: ACgBeo25WvJloWsjswd8TTbUZww3guu1INGlAsswJOmYhVoWHkoTzt4D
        frCJt6hlPKSfDFN4mIXpYWT7iWwtJ+pKy6qO
X-Google-Smtp-Source: AA6agR4VsmNHYEbOfYUNjqzhQJ5lPU3Yu+/mAnAOAB5nrTEiFHyeqj3ERjNSW+RwkjX1BegmBuHsCA==
X-Received: by 2002:a63:81c7:0:b0:42a:9b7a:1f95 with SMTP id t190-20020a6381c7000000b0042a9b7a1f95mr10544865pgd.401.1661273920737;
        Tue, 23 Aug 2022 09:58:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w128-20020a623086000000b00536463e3802sm7299261pfw.36.2022.08.23.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:58:40 -0700 (PDT)
Message-ID: <63050740.620a0220.e25fb.d28b@mx.google.com>
Date:   Tue, 23 Aug 2022 09:58:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc2-7-gce20aaef438b
Subject: pm/testing baseline: 75 runs, 3 regressions (v6.0-rc2-7-gce20aaef438b)
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

pm/testing baseline: 75 runs, 3 regressions (v6.0-rc2-7-gce20aaef438b)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =

kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc2=
-7-gce20aaef438b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc2-7-gce20aaef438b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ce20aaef438bb6033b9e42bdebdcbc2f854f1967 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6304fdcb6e5509994a35564d

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc2-7-gce20aae=
f438b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc2-7-gce20aae=
f438b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
04fdcb6e5509994a35565a
        failing since 77 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-08-23T16:18:11.554364  /lava-158610/1/../bin/lava-test-case
    2022-08-23T16:18:11.554782  <8>[   19.549301] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/6304fd663b66e4cc9e3556a6

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc2-7-gce20aae=
f438b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc2-7-gce20aae=
f438b/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.imx6q-pcie-pcie0-probed: https://kernelci.org/test/case=
/id/6304fd663b66e4cc9e3556b8
        failing since 0 day (last pass: v5.19-rc8-92-ge240a33f1bc48, first =
fail: v6.0-rc1-6-g977346c02019)

    2022-08-23T16:16:26.014861  /lava-158606/1/../bin/lava-test-case
    2022-08-23T16:16:26.015260  <8>[   19.420974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx6q-pcie-pcie0-probed RESULT=3Dfail>   =


  * baseline.bootrr.intel-igb-probed: https://kernelci.org/test/case/id/630=
4fd663b66e4cc9e3556ba
        failing since 0 day (last pass: v5.19-rc8-92-ge240a33f1bc48, first =
fail: v6.0-rc1-6-g977346c02019)

    2022-08-23T16:16:27.052376  /lava-158606/1/../bin/lava-test-case
    2022-08-23T16:16:27.052777  <8>[   20.465262] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dintel-igb-probed RESULT=3Dfail>   =

 =20
